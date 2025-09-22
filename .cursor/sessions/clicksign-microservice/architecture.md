# 🏗️ Arquitetura - Microsserviço ClickSign

**Task**: 86abzwx0w - Microsserviço ClickSign - Integração Completa  
**Branch**: feature/clicksign-microservice  
**Objetivo**: MVP/PoC para validação da integração ClickSign

---

## 🎯 **Visão Geral da Arquitetura**

### **Arquitetura MVP Simplificada:**
```mermaid
graph TB
    subgraph "Aplicações Cliente"
        A1[App 1] 
        A2[App 2]
        A3[App N]
    end
    
    subgraph "Microsserviço ClickSign"
        API[Fastify API Server]
        BL[Business Logic]
        DB[(PostgreSQL)]
        QUEUE[Redis Queue]
    end
    
    subgraph "ClickSign Platform"
        CS_API[ClickSign API v1.0]
        CS_WH[ClickSign Webhooks]
    end
    
    A1 --> API
    A2 --> API
    A3 --> API
    
    API --> BL
    BL --> DB
    BL --> QUEUE
    BL --> CS_API
    CS_WH --> API
    
    API --> A1
    API --> A2
    API --> A3
```

---

## 🔧 **Stack Tecnológico Definido**

### **Core Stack (Confirmado):**
- **Runtime**: Node.js 18+ LTS
- **Language**: TypeScript 5.x
- **Framework**: Fastify 4.x (performance superior ao Express)
- **Database**: PostgreSQL 15+ (persistência)
- **Queue**: Redis 7+ (processamento assíncrono)
- **Deployment**: Docker + Docker Compose (on-premise)

### **Principais Dependências:**
```json
{
  "dependencies": {
    "fastify": "^4.25.0",
    "@fastify/cors": "^9.0.0",
    "@fastify/helmet": "^11.0.0",
    "@fastify/rate-limit": "^9.0.0",
    "prisma": "^5.7.0",
    "@prisma/client": "^5.7.0",
    "axios": "^1.6.0",
    "ioredis": "^5.3.0",
    "bull": "^4.12.0",
    "joi": "^17.11.0",
    "dotenv": "^16.3.0"
  },
  "devDependencies": {
    "typescript": "^5.3.0",
    "@types/node": "^20.10.0",
    "ts-node": "^10.9.0",
    "nodemon": "^3.0.0",
    "jest": "^29.7.0",
    "@types/jest": "^29.5.0"
  }
}
```

---

## 🗂️ **Estrutura do Projeto**

### **Organização de Pastas:**
```
clicksign-microservice/
├── src/
│   ├── controllers/          # Controladores da API REST
│   │   ├── documents.controller.ts
│   │   ├── signers.controller.ts
│   │   └── webhooks.controller.ts
│   ├── services/             # Lógica de negócio
│   │   ├── clicksign.service.ts
│   │   ├── documents.service.ts
│   │   └── queue.service.ts
│   ├── models/               # Types e interfaces
│   │   ├── document.model.ts
│   │   ├── signer.model.ts
│   │   └── webhook.model.ts
│   ├── routes/               # Definição de rotas
│   │   ├── api.routes.ts
│   │   └── webhooks.routes.ts
│   ├── middleware/           # Middlewares customizados
│   │   ├── auth.middleware.ts
│   │   └── validation.middleware.ts
│   ├── config/              # Configurações
│   │   ├── database.ts
│   │   ├── redis.ts
│   │   └── clicksign.ts
│   ├── utils/               # Utilitários
│   │   ├── logger.ts
│   │   └── crypto.ts
│   └── app.ts              # Configuração principal do Fastify
├── prisma/
│   ├── schema.prisma       # Schema do banco
│   └── migrations/         # Migrações
├── docker/
│   ├── Dockerfile
│   ├── docker-compose.yml
│   └── nginx.conf          # Se necessário
├── tests/
│   ├── integration/
│   └── unit/
├── docs/
│   └── api/                # Documentação OpenAPI
├── .env.example
├── package.json
├── tsconfig.json
├── jest.config.js
└── README.md
```

---

## 📊 **Schema de Banco de Dados (MVP)**

### **Tabelas Principais (Prisma Schema):**
```prisma
// prisma/schema.prisma
generator client {
  provider = "prisma-client-js"
}

datasource db {
  provider = "postgresql"
  url      = env("DATABASE_URL")
}

model Document {
  id                  String   @id @default(uuid())
  clicksignId         String?  @unique
  filename            String
  originalFilename    String
  status              DocumentStatus @default(PENDING)
  uploadedAt          DateTime @default(now())
  updatedAt           DateTime @updatedAt
  
  // Metadados
  clientId            String   // Multi-tenant
  templateId          String?
  
  // Signers relacionados
  signers             Signer[]
  
  // Audit trail
  events              DocumentEvent[]
  
  @@map("documents")
}

model Signer {
  id          String @id @default(uuid())
  email       String
  name        String
  phoneNumber String?
  
  // Relacionamentos
  documentId  String
  document    Document @relation(fields: [documentId], references: [id])
  
  // Status da assinatura
  status      SignerStatus @default(PENDING)
  signedAt    DateTime?
  
  @@map("signers")
}

model DocumentEvent {
  id          String @id @default(uuid())
  documentId  String
  document    Document @relation(fields: [documentId], references: [id])
  
  eventType   String   // webhook event type
  payload     Json
  createdAt   DateTime @default(now())
  
  @@map("document_events")
}

enum DocumentStatus {
  PENDING
  UPLOADED
  SENT
  SIGNED
  COMPLETED
  CANCELLED
  ERROR
}

enum SignerStatus {
  PENDING
  SENT
  VIEWED
  SIGNED
  DECLINED
}
```

---

## 🔌 **Integração ClickSign API**

### **Client ClickSign (src/services/clicksign.service.ts):**
```typescript
import axios, { AxiosInstance } from 'axios';

export class ClickSignService {
  private client: AxiosInstance;
  
  constructor() {
    this.client = axios.create({
      baseURL: process.env.CLICKSIGN_BASE_URL || 'https://sandbox.clicksign.com/api/v1',
      headers: {
        'Authorization': `Bearer ${process.env.CLICKSIGN_API_TOKEN}`,
        'Content-Type': 'application/json'
      },
      timeout: 30000
    });
  }

  // Upload documento para ClickSign
  async uploadDocument(file: Buffer, filename: string): Promise<ClickSignDocument> {
    const formData = new FormData();
    formData.append('document[archive]', file, filename);
    
    const response = await this.client.post('/documents', formData, {
      headers: { 'Content-Type': 'multipart/form-data' }
    });
    
    return response.data.document;
  }

  // Criar lista de signatários
  async createSignersList(documentKey: string, signers: SignerData[]): Promise<void> {
    await this.client.post(`/documents/${documentKey}/list`, {
      list: { signers }
    });
  }

  // Enviar documento para assinatura
  async sendDocument(documentKey: string): Promise<void> {
    await this.client.patch(`/documents/${documentKey}`, {
      document: { status: 'running' }
    });
  }

  // Download documento assinado
  async downloadDocument(documentKey: string): Promise<Buffer> {
    const response = await this.client.get(`/documents/${documentKey}/download`, {
      responseType: 'arraybuffer'
    });
    
    return Buffer.from(response.data);
  }

  // Consultar status do documento
  async getDocumentStatus(documentKey: string): Promise<ClickSignDocument> {
    const response = await this.client.get(`/documents/${documentKey}`);
    return response.data.document;
  }
}
```

---

## 🚀 **API REST Endpoints (MVP)**

### **Endpoints Core:**
```typescript
// src/routes/api.routes.ts
import { FastifyInstance } from 'fastify';

export async function apiRoutes(fastify: FastifyInstance) {
  
  // Healthcheck
  fastify.get('/health', async () => ({ status: 'ok', timestamp: new Date() }));
  
  // Upload e envio de documento
  fastify.post('/documents', {
    schema: {
      consumes: ['multipart/form-data'],
      body: {
        type: 'object',
        properties: {
          file: { isFile: true },
          signers: { 
            type: 'array',
            items: {
              type: 'object',
              properties: {
                email: { type: 'string', format: 'email' },
                name: { type: 'string' },
                phoneNumber: { type: 'string' }
              },
              required: ['email', 'name']
            }
          },
          clientId: { type: 'string' }
        },
        required: ['file', 'signers', 'clientId']
      }
    }
  }, documentsController.uploadAndSend);

  // Status do documento
  fastify.get('/documents/:id/status', {
    schema: {
      params: {
        type: 'object',
        properties: { id: { type: 'string' } },
        required: ['id']
      }
    }
  }, documentsController.getStatus);

  // Download documento assinado
  fastify.get('/documents/:id/download', {
    schema: {
      params: {
        type: 'object', 
        properties: { id: { type: 'string' } },
        required: ['id']
      }
    }
  }, documentsController.download);

  // Listar documentos de um cliente
  fastify.get('/documents', {
    schema: {
      querystring: {
        type: 'object',
        properties: {
          clientId: { type: 'string' },
          status: { type: 'string' },
          page: { type: 'number', default: 1 },
          limit: { type: 'number', default: 10 }
        },
        required: ['clientId']
      }
    }
  }, documentsController.list);
}
```

### **Webhooks Endpoints:**
```typescript
// src/routes/webhooks.routes.ts
export async function webhooksRoutes(fastify: FastifyInstance) {
  
  // Receber webhooks do ClickSign
  fastify.post('/webhooks/clicksign', {
    schema: {
      body: {
        type: 'object',
        properties: {
          event: { type: 'string' },
          document: { type: 'object' },
          signer: { type: 'object' }
        }
      }
    }
  }, webhooksController.handleClickSignEvent);
}
```

---

## 🔄 **Sistema de Eventos e Queue**

### **Processamento Assíncrono (Bull Queue):**
```typescript
// src/services/queue.service.ts
import Queue from 'bull';
import Redis from 'ioredis';

const redis = new Redis(process.env.REDIS_URL || 'redis://localhost:6379');

export const documentQueue = new Queue('document processing', {
  redis: {
    port: 6379,
    host: 'localhost'
  }
});

// Processar eventos de webhook
documentQueue.process('webhook-event', async (job) => {
  const { eventType, documentKey, payload } = job.data;
  
  switch (eventType) {
    case 'document.signed':
      await handleDocumentSigned(documentKey, payload);
      break;
    case 'document.finished':
      await handleDocumentFinished(documentKey, payload);
      break;
    default:
      console.log(`Unhandled event: ${eventType}`);
  }
});

async function handleDocumentSigned(documentKey: string, payload: any) {
  // Atualizar status no banco
  // Notificar aplicação cliente (se configurado)
}

async function handleDocumentFinished(documentKey: string, payload: any) {
  // Fazer download do documento assinado
  // Armazenar localmente ou em S3
  // Notificar aplicação cliente
}
```

---

## 🐳 **Containerização Docker**

### **Dockerfile:**
```dockerfile
# docker/Dockerfile
FROM node:18-alpine AS builder

WORKDIR /app
COPY package*.json ./
RUN npm ci --only=production

FROM node:18-alpine AS runtime

RUN addgroup -g 1001 -S nodejs
RUN adduser -S microservice -u 1001

WORKDIR /app
COPY --from=builder /app/node_modules ./node_modules
COPY --chown=microservice:nodejs . .

USER microservice

EXPOSE 3000

CMD ["npm", "start"]
```

### **Docker Compose (MVP):**
```yaml
# docker/docker-compose.yml
version: '3.8'

services:
  app:
    build: 
      context: ..
      dockerfile: docker/Dockerfile
    ports:
      - "3000:3000"
    environment:
      - NODE_ENV=production
      - DATABASE_URL=postgresql://user:password@postgres:5432/clicksign_db
      - REDIS_URL=redis://redis:6379
      - CLICKSIGN_API_TOKEN=${CLICKSIGN_API_TOKEN}
      - CLICKSIGN_BASE_URL=https://sandbox.clicksign.com/api/v1
    depends_on:
      - postgres
      - redis
    restart: unless-stopped

  postgres:
    image: postgres:15-alpine
    environment:
      POSTGRES_DB: clicksign_db
      POSTGRES_USER: user
      POSTGRES_PASSWORD: password
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    restart: unless-stopped

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    restart: unless-stopped

volumes:
  postgres_data:
```

---

## 📋 **Plano de Implementação por Fases**

### **Fase 1: Setup & Base (Subtask 86abzwx6q)**
**Timeline**: 3-5 dias
- ✅ Inicializar projeto TypeScript + Fastify
- ✅ Configurar Docker + Docker Compose
- ✅ Setup PostgreSQL + Prisma
- ✅ Setup Redis + Bull Queue
- ✅ Estrutura de pastas profissional
- ✅ CI/CD básico (GitHub Actions ou similar)

### **Fase 2: Integração ClickSign (Subtask 86abzwx9d) - PRIORITÁRIO**
**Timeline**: 5-7 dias
- ✅ Implementar ClickSignService completo
- ✅ Testes com ClickSign Sandbox
- ✅ Upload de documentos (multipart)
- ✅ Gestão de signatários
- ✅ Envio para assinatura
- ✅ Consulta de status
- ✅ Download de documentos assinados

### **Fase 3: Webhooks & Events (Subtask 86abzwxt2)**
**Timeline**: 4-6 dias
- ✅ Endpoint para receber webhooks ClickSign
- ✅ Validação de assinatura dos webhooks
- ✅ Sistema de filas para processamento assíncrono
- ✅ Event streaming e audit trail
- ✅ Retry logic para eventos falhados

### **Fase 4: API Production Ready (Subtask 86abzwxhe)**
**Timeline**: 5-7 dias
- ✅ API REST completa com validação
- ✅ Authentication básica (API Keys)
- ✅ Rate limiting
- ✅ Error handling padronizado
- ✅ Logging estruturado
- ✅ Health checks
- ✅ Documentação OpenAPI/Swagger
- ✅ Testes automatizados

---

## 🎯 **Decisões Arquiteturais MVP**

### **Simplificações para PoC:**
1. **Authentication**: API Keys simples (não JWT complexo)
2. **Storage**: Armazenamento local temporário (não S3)
3. **Monitoring**: Logs básicos (não Prometheus)
4. **Multi-tenant**: Isolamento por `clientId` (não RBAC complexo)
5. **Encryption**: HTTPS básico (não encryption avançado)

### **Não incluído no MVP:**
- ❌ Templates de documentos
- ❌ Workflows complexos de aprovação
- ❌ Notificações por email/SMS
- ❌ Dashboard administrativo
- ❌ Metrics avançados
- ❌ Backup automático
- ❌ Load balancing

---

## ⚠️ **Pontos de Atenção**

### **Limitações ClickSign Sandbox:**
- Rate limiting mais restritivo
- Dados não persistem permanentemente
- Algumas funcionalidades podem ser limitadas

### **Segurança Básica:**
- Validação de input em todos endpoints
- CORS configurado adequadamente  
- Rate limiting por IP
- Headers de segurança (Helmet)

### **Performance:**
- Pool de conexões PostgreSQL
- Cache Redis para consultas frequentes
- Compressão de responses
- Timeouts adequados

---

## 🚀 **Próximos Passos**

1. **Revisar e aprovar** esta arquitetura
2. **Iniciar Fase 1** (Setup & Base) - Subtask 86abzwx6q
3. **Configurar ClickSign Sandbox** - obter API keys
4. **Implementar MVP iterativamente** seguindo as fases
5. **Testes contínuos** durante desenvolvimento

**A arquitetura está aprovada para implementação? 🎯**
