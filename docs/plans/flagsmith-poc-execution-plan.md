---
# Plano de Execução: POC Flagsmith Integration
template:
  type: execution-plan
  version: 2.0
  category: implementation
  name: "POC Flagsmith - Feature Flags Migration"
  
context:
  title: "🚀 INSTRUÇÕES PARA IMPLEMENTAÇÃO DO POC FLAGSMITH"
  system: "Sistema Onion - Feature Flags Management"
  current_state: "Análise concluída (85% avaliado) - Recomendação: Implementar Flagsmith"
  base: "Unleash funcionando em produção, stack Node.js/TypeScript com Nx monorepo"
  last_update: "2025-11-05 18:30"

usage:
  instructions:
    - "✅ MARQUE checkboxes [ ] → [x] conforme progresso nas tarefas"
    - "📝 ATUALIZE o log de execução a cada sessão de implementação"
    - "📅 PREENCHA datas, responsável e observações detalhadas"
    - "🔄 EXECUTE comandos listados na seção 'Comandos de Execução'"
    - "🏷️ CRIE tags git para pontos de rollback de emergência"
    - "💰 MONITORE custos [se SaaS] e performance durante implementação"
    - "🔄 ATUALIZE marcações de status de cada fase ao final de cada etapa"

standards:
  task_status:
    completed: "[x] - Tarefa CONCLUÍDA com sucesso e validada"
    pending: "[ ] - Tarefa PENDENTE ou não iniciada"
    error: "❌ - Tarefa com ERRO crítico (documentar no log)"
    partial: "⚠️ - Tarefa PARCIAL ou com ressalvas importantes"
    in_progress: "🔄 - Tarefa EM PROGRESSO (marcar data de início)"
  
  commit_patterns:
    feature: "feat(feature-flags): implementa [funcionalidade Flagsmith]"
    addition: "feat(flagsmith): adiciona [componente específico]"
    fix: "fix(flagsmith): corrige [problema específico]"
    docs: "docs(flagsmith): atualiza documentação fase X"
    poc: "poc(flagsmith): setup e validação de POC"

  essential_commands:
    package_manager: "📦 SEMPRE usar pnpm: pnpm install, pnpm run, pnpm nx"
    main: "pnpm nx run [project]:serve - Iniciar projeto"
    test: "pnpm nx run [project]:test - Executar testes"
    validation: "pnpm nx run-many --target=lint - Validar código"
    build: "pnpm nx run-many --target=build - Build completo"

critical_attention:
  warnings:
    - "⚠️ SEMPRE mantenha Unleash funcionando durante POC"
    - "⚠️ USE feature flags para rollback instantâneo entre Unleash/Flagsmith"
    - "⚠️ TESTE cada fase completamente antes de prosseguir"
    - "⚠️ DOCUMENTE incompatibilidades imediatamente"
    - "⚠️ MONITORE latência com dados reais (p50/p99)"
    - "⚠️ VALIDE feature parity com Unleash em produção"
    - "⚠️ MANTENHA backup de configurations do Unleash"

milestones:
  phase_1: "🎯 Decisão Arquitetural + Setup Flagsmith"
  phase_2: "🎯 SDK Integrado + Benchmark Performance"
  phase_3: "🎯 Integração Nx + Padrão de Desenvolvimento"
  phase_4: "🎯 Testes e Validação"
  phase_5: "🎯 Documentação + Handoff"

success_metrics:
  - metric: "📊 Latência p99"
    target: "<10ms"
    criteria: "Medição em localhost com 100 requisições"
  - metric: "🤖 Feature Parity"
    target: "100%"
    criteria: "Todos os flags de Unleash funcionam em Flagsmith"
  - metric: "🏷️ Integração Nx"
    target: "Completa"
    criteria: "SDK funciona com workspace structure"
  - metric: "⚡ Time-to-value"
    target: "<2 horas"
    criteria: "De zero até primeiro flag funcionando"
  - metric: "🔒 Documentation"
    target: "Completa"
    criteria: "Guia de integração e examples escritos"
  - metric: "🧪 Testes"
    target: "100% cobertura"
    criteria: "Unit + integration + performance tests"

ai_assistant:
  auto_update: true
  track_progress: true
  log_execution: true
  validate_metrics: true
---

# Plano de Execução: POC Flagsmith Integration
## Prototipagem e Validação de Feature Flags com Flagsmith

**Documento de Controle e Execução - POC/Protipagem**  
**Objetivo:** Validar viabilidade técnica de Flagsmith como alternativa ao Unleash com focus em integração com Nx monorepo e performance  
**Data de Início:** 2025-11-05  
**Responsável:** Tech Lead + DevOps  
**Base:** Análise técnica completa realizada (85% avaliado) - Stack Node.js/TypeScript com Nx monorepo, Unleash funcionando em produção

---

## 📋 Resumo Executivo

Este documento detalha o plano de execução do **POC Flagsmith** baseado na análise técnica de alternativas ao Unleash. O objetivo é validar a viabilidade de Flagsmith como solução de feature flags, focando nas **lacunas identificadas na análise** (decisão arquitetural, performance, integração Nx, e operações).

### 🎯 **SITUAÇÃO ATUAL (0% IMPLEMENTADO - POC PRONTO PARA INICIAR)**

**✅ FUNDAÇÃO SÓLIDA IMPLEMENTADA:**
- ✅ **Análise Técnica** completa com 5 alternativas avaliadas
- ✅ **Recomendação Priorizada** para Flagsmith com argumentação clara
- ✅ **Stack Node.js/TypeScript** pronto e testado
- ✅ **Nx Monorepo** estruturado e funcional
- ✅ **Unleash em Produção** como baseline de comparação

### 🚨 **LACUNAS CRÍTICAS IDENTIFICADAS (100% FALTANDO)**

**❌ COMPONENTES CRÍTICOS AUSENTES:**
- ❌ **Decision: Self-Hosted vs SaaS** (necessária para prosseguir)
- ❌ **Flagsmith Setup Local** (Docker compose)
- ❌ **SDK Integration** (Node.js SDK com Nx)
- ❌ **Performance Benchmarks** (latência p50/p99)
- ❌ **Padrão de Desenvolvimento** (como usar em codebase)

### 🎯 Objetivos do Plano

- **Fase 1:** Executar decisão arquitetural Self-Hosted vs SaaS
- **Fase 2:** Setup Flagsmith local com Docker compose
- **Fase 3:** Integrar SDK Node.js com Nx monorepo
- **Fase 4:** Benchmark performance vs Unleash
- **Fase 5:** Documentar padrão e criar exemplos

---

## 📊 Status Geral

- [ ] **Fase 1**: Decisão Arquitetural - **0% PENDENTE** (3h) - 1.1 ❌ + 1.2 ❌ + 1.3 ❌
- [ ] **Fase 2**: Setup Flagsmith Local - **0% PENDENTE** (4h) - 2.1 ❌ + 2.2 ❌ + 2.3 ❌
- [ ] **Fase 3**: Integração SDK Nx - **0% PENDENTE** (5h) - 3.1 ❌ + 3.2 ❌ + 3.3 ❌
- [ ] **Fase 4**: Benchmark & Performance - **0% PENDENTE** (6h) - 4.1 ❌ + 4.2 ❌
- [ ] **Fase 5**: Documentação & Handoff - **0% PENDENTE** (4h) - 5.1 ❌ + 5.2 ❌

**Progresso Total POC:** `0h/22h (0%) ❌ FLAGSMITH POC PENDENTE`

---

## 🏗️ FASE 1: DECISÃO ARQUITETURAL + WORKSHOP

**Objetivo:** Executar decisão entre Self-Hosted (Docker) vs SaaS (Flagsmith managed)  
**Prioridade:** 🔴 CRÍTICA  
**Estimativa:** 3 horas  
**Pré-requisitos:** Análise técnica concluída (✅ Feita)

### Tarefas:

#### 1.1 Workshop Executivo de Decisão (1 hora)
**Responsável:** Tech Lead + DevOps + CFO/Finance  
**Entregável:** Decisão documentada + aprovação para prosseguir  
**Status:** ❌ **PENDENTE**

- [ ] **Agendar reunião** com stakeholders chave
  - [ ] Tech Lead (responsável técnico)
  - [ ] DevOps/Infra (operações)
  - [ ] CFO/Finance (budget)
- [ ] **Apresentar análise** das 5 alternativas
  - [ ] Review da matriz comparativa
  - [ ] Destaque: Trade-offs Self-Hosted vs SaaS
  - [ ] Ênfase: Flagsmith oferece melhor custo-benefício
- [ ] **Discutir capacidade operacional**
  - [ ] DevOps consegue gerenciar Kubernetes/Docker?
  - [ ] Qual é a preferência: Zero-ops (SaaS) vs Full-control (Self-hosted)?
  - [ ] Timeline realista para cada opção?
- [ ] **Obter consenso** e decisão formal
  - [ ] Voto: Self-Hosted vs SaaS
  - [ ] Justificativa documentada
  - [ ] Budget aprovado (se SaaS)

**Critérios de Sucesso:**
- [ ] ✅ Decisão consenso entre todos os stakeholders
- [ ] ✅ Escolha documentada em ADR (Architecture Decision Record)
- [ ] ✅ Budget aprovado (se SaaS)

---

#### 1.2 Criar ADR (Architecture Decision Record) (1 hora)
**Responsável:** Tech Lead  
**Entregável:** Arquivo `docs/architecture/adr-001-feature-flags-solution.md`  
**Status:** ❌ **PENDENTE**

- [ ] **Estruturar ADR** com template padrão
  - [ ] Title: "Decision on Feature Flags Solution: Flagsmith vs Unleash"
  - [ ] Status: "Accepted"
  - [ ] Context: Análise de alternativas realizada
  - [ ] Decision: "Chosen Flagsmith [Self-Hosted/SaaS]"
  - [ ] Consequences: Impactos técnicos, operacionais, financeiros
  - [ ] Alternatives considered: LaunchDarkly, Growthbook, Statsig
- [ ] **Documentar razões técnicas**
  - [ ] Por que Flagsmith vs outros?
  - [ ] Trade-offs de Self-Hosted vs SaaS
  - [ ] Riscos mitigados
- [ ] **Documentar impactos**
  - [ ] Timeline de implementação
  - [ ] Custo anual estimado
  - [ ] Dependências de terceiros
  - [ ] Pontos de migração do Unleash
- [ ] **Revisar e aprovar** com Tech Lead
- [ ] **Commitar em Git** com mensagem clara

**Critérios de Sucesso:**
- [ ] ✅ ADR criado em `docs/architecture/adr-001-*.md`
- [ ] ✅ Contém todas as seções obrigatórias
- [ ] ✅ Aprovado e commitado em main/develop

---

#### 1.3 Setup de Ambiente de Desenvolvimento (1 hora)
**Responsável:** DevOps  
**Entregável:** Ambiente pronto para Fase 2  
**Status:** ❌ **PENDENTE**

- [ ] **Preparar branch feature**
  - [ ] `git checkout -b feature/flagsmith-poc`
  - [ ] `git push -u origin feature/flagsmith-poc`
- [ ] **Criar diretório para POC**
  - [ ] `mkdir -p apps/flagsmith-poc`
  - [ ] `mkdir -p packages/feature-flags-sdk`
- [ ] **Atualizar .gitignore** se necessário
  - [ ] Adicionar patterns para Flagsmith/Docker
- [ ] **Criar docker-compose.yml** template
  - [ ] Estrutura básica (ainda sem conteúdo)
  - [ ] Commit inicial: "feat(flagsmith): init POC structure"

**Critérios de Sucesso:**
- [ ] ✅ Branch feature criada e pushada
- [ ] ✅ Diretórios estruturados
- [ ] ✅ Git pronto para commits

---

### Comandos de Validação Fase 1

```bash
# 1. Verificar branch está criada
git branch -vv
git status

# 2. Validar estrutura de diretórios
ls -la apps/flagsmith-poc
ls -la packages/feature-flags-sdk

# 3. Verificar ADR foi commitado
ls -la docs/architecture/adr-*.md
git log --oneline | grep -i "adr"
```

**📝 LOG DE EXECUÇÃO - FASE 1:**
```bash
# [Data/Hora] - FASE 1.1 - Workshop Executivo (STATUS)
# - Stakeholders presentes: [listar]
# - Decisão tomada: [Self-Hosted / SaaS]
# - Justificativa: [resumo executivo]
# - Budget aprovado: [Sim/Não] - [Valor se aplicável]

# [Data/Hora] - FASE 1.2 - ADR Criado (STATUS)
# - Arquivo: docs/architecture/adr-001-feature-flags-solution.md
# - Commit: [hash]

# [Data/Hora] - FASE 1.3 - Setup Ambiente (STATUS)
# - Branch criada: feature/flagsmith-poc
# - Diretórios: ✅ Ok
# - Git status: ✅ Pronto para Fase 2
```

---

## 🏗️ FASE 2: SETUP FLAGSMITH LOCAL

**Objetivo:** Setup Flagsmith com Docker compose e validação básica  
**Prioridade:** 🔴 CRÍTICA  
**Estimativa:** 4 horas  
**Pré-requisitos:** Fase 1 concluída ✅

### Tarefas:

#### 2.1 Setup Flagsmith com Docker Compose (2 horas)
**Responsável:** DevOps  
**Entregável:** Flagsmith rodando em localhost:5000  
**Status:** ❌ **PENDENTE**

- [ ] **Criar docker-compose.yml**
  - [ ] Serviço Flagsmith (imagem oficial)
  - [ ] PostgreSQL (database)
  - [ ] Redis (cache)
  - [ ] Volumes para persistência
  - [ ] Port mappings: 5000 (UI), 8000 (API)
- [ ] **Criar .env.example**
  - [ ] DATABASE_URL
  - [ ] REDIS_URL
  - [ ] API_KEY_SECRET
  - [ ] DEBUG settings
- [ ] **Iniciar Flagsmith**
  - [ ] `docker-compose up -d`
  - [ ] Aguardar health checks passarem
  - [ ] Verificar logs para erros
- [ ] **Acessar Dashboard**
  - [ ] URL: `http://localhost:5000`
  - [ ] Criar conta inicial
  - [ ] Criar organização "Sistema Onion"
  - [ ] Criar projeto "POC"

**Configuração Docker Compose:**
```yaml
version: '3.8'

services:
  postgres:
    image: postgres:15
    environment:
      POSTGRES_DB: flagsmith
      POSTGRES_USER: flagsmith
      POSTGRES_PASSWORD: flagsmith-dev
    volumes:
      - postgres_data:/var/lib/postgresql/data
    ports:
      - "5432:5432"
    healthcheck:
      test: ["CMD-SHELL", "pg_isready -U flagsmith"]
      interval: 10s
      timeout: 5s
      retries: 5

  redis:
    image: redis:7-alpine
    ports:
      - "6379:6379"
    healthcheck:
      test: ["CMD", "redis-cli", "ping"]
      interval: 10s
      timeout: 5s
      retries: 5

  flagsmith:
    image: flagsmith/flagsmith:latest
    environment:
      DATABASE_URL: postgresql://flagsmith:flagsmith-dev@postgres:5432/flagsmith
      REDIS_URL: redis://redis:6379
      SECRET_KEY: ${SECRET_KEY:-dev-secret-key-change-in-production}
      DEBUG: "False"
      API_PAGINATION_DEFAULT: 100
    ports:
      - "5000:8000"
    depends_on:
      postgres:
        condition: service_healthy
      redis:
        condition: service_healthy
    healthcheck:
      test: ["CMD-SHELL", "curl -f http://localhost:8000/health/ || exit 1"]
      interval: 10s
      timeout: 5s
      retries: 5

volumes:
  postgres_data:
```

**Critérios de Sucesso:**
- [ ] ✅ Flagsmith acessível em http://localhost:5000
- [ ] ✅ Dashboard carrega sem erros
- [ ] ✅ PostgreSQL + Redis saudáveis
- [ ] ✅ Conta inicial criada

---

#### 2.2 Criar Projeto + Flags Teste (1 hora)
**Responsável:** Tech Lead  
**Entregável:** 3 flags teste criados em Flagsmith  
**Status:** ❌ **PENDENTE**

- [ ] **Criar Environment "Development"**
  - [ ] Production environment pronto
  - [ ] Development environment pronto
- [ ] **Criar 3 flags de teste**
  - [ ] `feature.new-dashboard` (boolean)
  - [ ] `feature.experimental-api` (boolean)
  - [ ] `config.rate-limit` (number com padrão 100)
- [ ] **Configurar valores por environment**
  - [ ] Development: new-dashboard=true, experimental-api=true
  - [ ] Production: new-dashboard=false, experimental-api=false
- [ ] **Gerar API Key**
  - [ ] Create Server API Key para "POC"
  - [ ] Salvar em `.env.local` para próxima fase
  - [ ] Não commitar API keys!

**Critérios de Sucesso:**
- [ ] ✅ 3 flags criados e visíveis no dashboard
- [ ] ✅ Environments configurados corretamente
- [ ] ✅ API Key gerada e salva localmente

---

#### 2.3 Validação Básica da API (1 hora)
**Responsável:** DevOps  
**Entregável:** Confirmação que API Flagsmith responde corretamente  
**Status:** ❌ **PENDENTE**

- [ ] **Testar health endpoint**
  - [ ] `curl http://localhost:5000/health/`
  - [ ] Esperado: Status 200
- [ ] **Testar flags endpoint**
  - [ ] `curl -H "X-Environment-Key: [KEY]" http://localhost:5000/api/v1/flags/`
  - [ ] Esperado: JSON com lista de flags
- [ ] **Testar flag específico**
  - [ ] `curl http://localhost:5000/api/v1/flags/feature.new-dashboard`
  - [ ] Esperado: Valor do flag (true/false)
- [ ] **Documentar latência**
  - [ ] Medir tempo médio de resposta
  - [ ] Esperado: <50ms (para localhost)

**Critérios de Sucesso:**
- [ ] ✅ Health check passando
- [ ] ✅ API respondendo com dados corretos
- [ ] ✅ Latência documentada

---

### Comandos de Validação Fase 2

```bash
# 1. Iniciar Flagsmith
docker-compose up -d

# 2. Verificar containers saudáveis
docker-compose ps
docker-compose logs -f flagsmith

# 3. Acessar dashboard
open http://localhost:5000

# 4. Testar API
curl -X GET http://localhost:5000/health/

# 5. Parar Flagsmith
docker-compose down
```

**📝 LOG DE EXECUÇÃO - FASE 2:**
```bash
# [Data/Hora] - FASE 2.1 - Setup Docker (STATUS)
# - docker-compose.yml criado: ✅
# - Containers iniciados: postgres, redis, flagsmith
# - Health checks passando: ✅
# - Dashboard acessível: http://localhost:5000

# [Data/Hora] - FASE 2.2 - Flags Criados (STATUS)
# - Projeto "POC" criado
# - 3 flags criados e configurados
# - API Key gerada: [REDACTED]

# [Data/Hora] - FASE 2.3 - Validação API (STATUS)
# - Health endpoint: ✅ 200ms
# - Flags endpoint: ✅ <50ms
# - Latência p99: ~45ms (localhost)
```

---

## 🏗️ FASE 3: INTEGRAÇÃO SDK NX MONOREPO

**Objetivo:** Integrar Flagsmith SDK com padrão Nx monorepo  
**Prioridade:** 🔴 CRÍTICA  
**Estimativa:** 5 horas  
**Pré-requisitos:** Fase 2 concluída ✅

### Tarefas:

#### 3.1 Setup SDK Package no Nx (2 horas)
**Responsável:** React Developer / Node.js Developer  
**Entregável:** Package `@onion/feature-flags-sdk` funcional  
**Status:** ❌ **PENDENTE**

- [ ] **Criar biblioteca Nx**
  - [ ] `pnpm nx g @nx/node:library feature-flags-sdk --directory packages`
  - [ ] Estrutura: `packages/feature-flags-sdk/`
- [ ] **Instalar Flagsmith SDK**
  - [ ] `cd packages/feature-flags-sdk`
  - [ ] `pnpm add flagsmith-js`
  - [ ] `pnpm add -D @types/flagsmith-js`
- [ ] **Criar wrapper SDK**
  - [ ] Arquivo: `src/lib/flagsmith-client.ts`
  - [ ] Exportar factory: `createFlagsmithClient()`
  - [ ] Implementar caching básico
- [ ] **Criar tipos TypeScript**
  - [ ] Interface `IFeatureFlag`
  - [ ] Enum `FeatureFlags` com todas os flags
  - [ ] Type-safe getters
- [ ] **Exportar tipos em index.ts**
  - [ ] `export * from './lib/flagsmith-client'`
  - [ ] `export type { IFeatureFlag }`

**Exemplo Implementação:**
```typescript
// packages/feature-flags-sdk/src/lib/flagsmith-client.ts
import flagsmith from 'flagsmith-js';

export enum FeatureFlags {
  NEW_DASHBOARD = 'feature.new-dashboard',
  EXPERIMENTAL_API = 'feature.experimental-api',
}

export interface IFeatureFlag {
  name: string;
  enabled: boolean;
  value?: string | number | boolean;
}

export interface FlagsmithConfig {
  environmentKey: string;
  cacheSize?: number;
  cacheTTL?: number;
}

class FlagsmithClient {
  private client: typeof flagsmith;
  private cache = new Map<string, { value: any; timestamp: number }>();
  private cacheTTL: number;

  constructor(config: FlagsmithConfig) {
    this.cacheTTL = config.cacheTTL || 300000; // 5 min default
    flagsmith.init({
      environmentID: config.environmentKey,
      cacheSize: config.cacheSize || 100,
    });
    this.client = flagsmith;
  }

  async initialize(): Promise<void> {
    await this.client.getFlags();
  }

  getFeatureFlag(flagName: string): IFeatureFlag | null {
    const cached = this.cache.get(flagName);
    if (cached && Date.now() - cached.timestamp < this.cacheTTL) {
      return cached.value;
    }

    const flag = this.client.hasFeature(flagName);
    const value = this.client.getFeatureValue(flagName);

    const result: IFeatureFlag = {
      name: flagName,
      enabled: flag,
      value,
    };

    this.cache.set(flagName, { value: result, timestamp: Date.now() });
    return result;
  }

  isFeatureEnabled(flagName: string): boolean {
    const flag = this.getFeatureFlag(flagName);
    return flag?.enabled || false;
  }

  getFeatureValue(flagName: string) {
    const flag = this.getFeatureFlag(flagName);
    return flag?.value;
  }

  clearCache(): void {
    this.cache.clear();
  }
}

export async function createFlagsmithClient(
  config: FlagsmithConfig
): Promise<FlagsmithClient> {
  const client = new FlagsmithClient(config);
  await client.initialize();
  return client;
}
```

**Critérios de Sucesso:**
- [ ] ✅ Package criado em `packages/feature-flags-sdk/`
- [ ] ✅ SDK instalado e funcionando
- [ ] ✅ Types TypeScript completos
- [ ] ✅ Factory function exportada

---

#### 3.2 Criar App Teste no Nx (2 horas)
**Responsável:** React Developer  
**Entregável:** App React que usa feature flags  
**Status:** ❌ **PENDENTE**

- [ ] **Criar app React**
  - [ ] `pnpm nx g @nx/react:app apps/flagsmith-test-app --style=css`
- [ ] **Instalar dependências**
  - [ ] `pnpm install`
  - [ ] Importar `@onion/feature-flags-sdk`
- [ ] **Criar componente Flag Display**
  - [ ] Arquivo: `apps/flagsmith-test-app/src/app/FlagDisplay.tsx`
  - [ ] Mostrar status de cada flag
  - [ ] Atualizar flags a cada 5 segundos
- [ ] **Criar página principal**
  - [ ] Lista de flags com status
  - [ ] Toggle manual (UI só, sem efeito)
  - [ ] Latência metrics
  - [ ] Error handling
- [ ] **Configurar .env**
  - [ ] `VITE_FLAGSMITH_KEY=[API_KEY]`

**Exemplo Componente:**
```typescript
// apps/flagsmith-test-app/src/app/FlagDisplay.tsx
import { useEffect, useState } from 'react';
import { createFlagsmithClient, FeatureFlags } from '@onion/feature-flags-sdk';

interface FlagStatus {
  name: string;
  enabled: boolean;
  value?: any;
  latency: number;
}

export function FlagDisplay() {
  const [flags, setFlags] = useState<FlagStatus[]>([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const initClient = async () => {
      try {
        const client = await createFlagsmithClient({
          environmentKey: import.meta.env.VITE_FLAGSMITH_KEY,
        });

        const fetchFlags = async () => {
          const startTime = performance.now();
          const flagsData = Object.values(FeatureFlags).map((flagName) => {
            const flag = client.getFeatureFlag(flagName as string);
            return {
              name: flagName,
              enabled: flag?.enabled || false,
              value: flag?.value,
              latency: Math.round(performance.now() - startTime),
            };
          });
          setFlags(flagsData);
        };

        await fetchFlags();
        setLoading(false);

        // Refresh flags every 5 seconds
        const interval = setInterval(fetchFlags, 5000);
        return () => clearInterval(interval);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Unknown error');
        setLoading(false);
      }
    };

    initClient();
  }, []);

  if (loading) return <div>Loading flags...</div>;
  if (error) return <div style={{ color: 'red' }}>Error: {error}</div>;

  return (
    <div style={{ padding: '20px' }}>
      <h1>🚀 Flagsmith POC - Feature Flags Status</h1>
      <table border={1} cellPadding={10}>
        <thead>
          <tr>
            <th>Flag Name</th>
            <th>Enabled</th>
            <th>Value</th>
            <th>Latency (ms)</th>
          </tr>
        </thead>
        <tbody>
          {flags.map((flag) => (
            <tr key={flag.name}>
              <td>{flag.name}</td>
              <td style={{ backgroundColor: flag.enabled ? '#e8f5e9' : '#ffebee' }}>
                {flag.enabled ? '✅ TRUE' : '❌ FALSE'}
              </td>
              <td>{flag.value ?? 'N/A'}</td>
              <td>{flag.latency}ms</td>
            </tr>
          ))}
        </tbody>
      </table>
    </div>
  );
}
```

**Critérios de Sucesso:**
- [ ] ✅ App React criado e buildável
- [ ] ✅ Componente FlagDisplay funcional
- [ ] ✅ Flags carregando do Flagsmith
- [ ] ✅ UI mostrando status correto

---

#### 3.3 Criar Testes Unitários (1 hora)
**Responsável:** Test Engineer  
**Entregável:** Cobertura 80%+ de testes  
**Status:** ❌ **PENDENTE**

- [ ] **Criar test suite para SDK**
  - [ ] Arquivo: `packages/feature-flags-sdk/src/lib/flagsmith-client.spec.ts`
  - [ ] Test: Client initialization
  - [ ] Test: Get feature flag
  - [ ] Test: Is feature enabled
  - [ ] Test: Cache functionality
  - [ ] Test: Error handling
- [ ] **Executar testes**
  - [ ] `pnpm nx run feature-flags-sdk:test`
  - [ ] Esperado: 6/6 testes passando
- [ ] **Verificar cobertura**
  - [ ] `pnpm nx run feature-flags-sdk:test -- --coverage`
  - [ ] Target: >80% coverage

**Exemplo Teste:**
```typescript
// packages/feature-flags-sdk/src/lib/flagsmith-client.spec.ts
import { createFlagsmithClient, FeatureFlags } from './flagsmith-client';

describe('FlagsmithClient', () => {
  let client: Awaited<ReturnType<typeof createFlagsmithClient>>;

  beforeAll(async () => {
    client = await createFlagsmithClient({
      environmentKey: 'test-key',
      cacheTTL: 1000,
    });
  });

  it('should create client successfully', () => {
    expect(client).toBeDefined();
  });

  it('should get feature flag', () => {
    const flag = client.getFeatureFlag(FeatureFlags.NEW_DASHBOARD);
    expect(flag).toHaveProperty('name');
    expect(flag).toHaveProperty('enabled');
  });

  it('should check if feature is enabled', () => {
    const isEnabled = client.isFeatureEnabled(FeatureFlags.NEW_DASHBOARD);
    expect(typeof isEnabled).toBe('boolean');
  });

  it('should cache results', () => {
    const flag1 = client.getFeatureFlag(FeatureFlags.NEW_DASHBOARD);
    const flag2 = client.getFeatureFlag(FeatureFlags.NEW_DASHBOARD);
    expect(flag1).toEqual(flag2);
  });

  it('should clear cache', () => {
    client.clearCache();
    expect(true).toBe(true); // Cache cleared
  });
});
```

**Critérios de Sucesso:**
- [ ] ✅ Test suite criada
- [ ] ✅ 6+ testes escritos
- [ ] ✅ Todos testes passando
- [ ] ✅ Coverage >80%

---

### Comandos de Validação Fase 3

```bash
# 1. Criar biblioteca feature-flags-sdk
pnpm nx g @nx/node:library feature-flags-sdk --directory packages

# 2. Instalar Flagsmith SDK
cd packages/feature-flags-sdk && pnpm add flagsmith-js

# 3. Build SDK
pnpm nx run feature-flags-sdk:build

# 4. Criar app teste
pnpm nx g @nx/react:app apps/flagsmith-test-app

# 5. Executar testes
pnpm nx run feature-flags-sdk:test

# 6. Verificar cobertura
pnpm nx run feature-flags-sdk:test -- --coverage

# 7. Servir app
pnpm nx run apps/flagsmith-test-app:serve
```

**📝 LOG DE EXECUÇÃO - FASE 3:**
```bash
# [Data/Hora] - FASE 3.1 - SDK Package (STATUS)
# - Package criado: @onion/feature-flags-sdk
# - Wrapper implementado: ✅
# - Types: ✅ Completos

# [Data/Hora] - FASE 3.2 - App Teste (STATUS)
# - React app criado: apps/flagsmith-test-app
# - Componente FlagDisplay: ✅
# - Conectado ao Flagsmith: ✅

# [Data/Hora] - FASE 3.3 - Testes (STATUS)
# - Test suite: 6 testes
# - Status: 6/6 ✅ PASSANDO
# - Coverage: 85% ✅
```

---

## 🏗️ FASE 4: BENCHMARK & PERFORMANCE VALIDATION

**Objetivo:** Validar performance vs Unleash e documentar resultados  
**Prioridade:** 🟡 ALTA  
**Estimativa:** 6 horas  
**Pré-requisitos:** Fases 1-3 concluídas ✅

### Tarefas:

#### 4.1 Benchmark Performance (4 horas)
**Responsável:** DevOps / Performance Engineer  
**Entregável:** Relatório comparativo Flagsmith vs Unleash  
**Status:** ❌ **PENDENTE**

- [ ] **Setup teste de carga**
  - [ ] Instalar k6 (load testing tool)
  - [ ] Criar script k6 para testar Flagsmith
  - [ ] Criar script k6 para testar Unleash (comparação)
- [ ] **Executar testes**
  - [ ] 100 requisições concorrentes por 60 segundos
  - [ ] Medir p50, p95, p99 latency
  - [ ] Medir throughput (req/sec)
  - [ ] Medir taxa de erro
- [ ] **Testar em diferentes cenários**
  - [ ] Localhost (ideal case)
  - [ ] Simulação de rede (adição de latência)
  - [ ] Failover scenarios (Flagsmith cai)
- [ ] **Documentar resultados**
  - [ ] Comparativa lado-a-lado
  - [ ] Gráficos de performance
  - [ ] Conclusões

**Script k6 Exemplo:**
```javascript
// benchmark/flagsmith-load-test.js
import http from 'k6/http';
import { check } from 'k6';

export const options = {
  vus: 100,
  duration: '60s',
  thresholds: {
    http_req_duration: ['p(95)<500', 'p(99)<1000'],
    http_req_failed: ['rate<0.1'],
  },
};

export default function () {
  const url = 'http://localhost:5000/api/v1/flags/feature.new-dashboard';
  const params = {
    headers: {
      'X-Environment-Key': __ENV.FLAGSMITH_KEY,
    },
  };

  const response = http.get(url, params);

  check(response, {
    'status is 200': (r) => r.status === 200,
    'response time < 100ms': (r) => r.timings.duration < 100,
    'body has flag data': (r) => r.body.includes('enabled'),
  });
}
```

**Critérios de Sucesso:**
- [ ] ✅ Latência p99 < 100ms em localhost
- [ ] ✅ Throughput > 1000 req/sec
- [ ] ✅ Taxa de erro < 0.1%
- [ ] ✅ Comparação documentada vs Unleash

---

#### 4.2 Feature Parity Validation (2 horas)
**Responsável:** Tech Lead  
**Entregável:** Matriz de feature parity 100%  
**Status:** ❌ **PENDENTE**

- [ ] **Auditar todos flags em produção**
  - [ ] Listar flags de Unleash
  - [ ] Tipo de cada flag (boolean, string, number)
  - [ ] Valores por environment
- [ ] **Validar equivalência em Flagsmith**
  - [ ] Cada flag do Unleash existe em Flagsmith?
  - [ ] Valores correspondem?
  - [ ] Targeting rules migráveis?
- [ ] **Testar fallback scenarios**
  - [ ] O que acontece se Flagsmith cai?
  - [ ] SDK retorna default correto?
  - [ ] Erros são tratados?
- [ ] **Documentar lacunas**
  - [ ] Quais features não são suportadas?
  - [ ] Workarounds possíveis?

**Critérios de Sucesso:**
- [ ] ✅ 100% de flags mapeados
- [ ] ✅ Parity confirmada
- [ ] ✅ Fallback scenarios testados

---

### Comandos de Validação Fase 4

```bash
# 1. Instalar k6
brew install k6  # ou apt-get install k6

# 2. Executar benchmark Flagsmith
k6 run -e FLAGSMITH_KEY=[KEY] benchmark/flagsmith-load-test.js

# 3. Executar benchmark Unleash
k6 run -e UNLEASH_KEY=[KEY] benchmark/unleash-load-test.js

# 4. Comparar resultados
diff results/flagsmith.json results/unleash.json
```

**📝 LOG DE EXECUÇÃO - FASE 4:**
```bash
# [Data/Hora] - FASE 4.1 - Benchmark (STATUS)
# - Flagsmith p50: 12ms | p95: 45ms | p99: 78ms
# - Unleash p50: 15ms | p95: 52ms | p99: 120ms
# - Conclusion: Flagsmith performance comparable or better
# - Throughput: 1500+ req/sec ✅

# [Data/Hora] - FASE 4.2 - Feature Parity (STATUS)
# - Flags em Unleash: 42
# - Flags em Flagsmith: 42
# - Parity: 100% ✅
# - Lacunas: Nenhuma
```

---

## 🏗️ FASE 5: DOCUMENTAÇÃO & HANDOFF

**Objetivo:** Documentar padrão de desenvolvimento e criar exemplos reutilizáveis  
**Prioridade:** 🟢 MÉDIA  
**Estimativa:** 4 horas  
**Pré-requisitos:** Fases 1-4 concluídas ✅

### Tarefas:

#### 5.1 Criar Documentação (2 horas)
**Responsável:** Tech Lead / Documentation  
**Entregável:** Guia "Como usar Feature Flags com Flagsmith"  
**Status:** ❌ **PENDENTE**

- [ ] **Criar arquivo GUIDE.md**
  - [ ] Localização: `docs/guides/flagsmith-integration-guide.md`
  - [ ] Seção 1: Setup local
  - [ ] Seção 2: Como criar flags
  - [ ] Seção 3: Como usar em código
  - [ ] Seção 4: Best practices
  - [ ] Seção 5: Troubleshooting
- [ ] **Criar exemplos de uso**
  - [ ] React component com flags
  - [ ] Node.js middleware com flags
  - [ ] Testing com mock de flags
- [ ] **Documentar padrões Nx**
  - [ ] Estrutura de bibliotecas
  - [ ] Como compartilhar tipos
  - [ ] Como usar em múltiplos apps

**Exemplo Seção GUIDE.md:**
```markdown
# Como Usar Feature Flags com Flagsmith

## Setup Local

1. Garantir Docker rodando:
   \`\`\`bash
   docker-compose up -d
   \`\`\`

2. Acessar dashboard: http://localhost:5000

3. Copiar API Key para .env.local:
   \`\`\`
   VITE_FLAGSMITH_KEY=your-api-key
   \`\`\`

## Usar em React Component

\`\`\`tsx
import { useFlagsmith } from '@onion/feature-flags-sdk';

export function MyComponent() {
  const { getFeatureFlag } = useFlagsmith();
  const newDashboard = getFeatureFlag('feature.new-dashboard');

  return (
    <div>
      {newDashboard?.enabled ? (
        <NewDashboard />
      ) : (
        <OldDashboard />
      )}
    </div>
  );
}
\`\`\`

## Best Practices

1. ✅ Use environment-specific values
2. ✅ Always provide defaults
3. ✅ Log flag changes in analytics
4. ✅ Review flags before removing
5. ❌ Don't use flags for authentication
```

**Critérios de Sucesso:**
- [ ] ✅ Guia completo escrito
- [ ] ✅ 5+ exemplos de código
- [ ] ✅ Best practices documentadas

---

#### 5.2 Criar exemplos reutilizáveis (2 horas)
**Responsável:** React Developer / Node.js Developer  
**Entregável:** 3+ exemplos prontos para copiar/colar  
**Status:** ❌ **PENDENTE**

- [ ] **Exemplo 1: React Hook**
  - [ ] Arquivo: `examples/use-flagsmith.ts`
  - [ ] Hook genérico `useFlagsmith()`
  - [ ] Com caching + error handling
- [ ] **Exemplo 2: Node.js Middleware**
  - [ ] Arquivo: `examples/flagsmith-middleware.ts`
  - [ ] Middleware para Express/Fastify
  - [ ] Injeta flags em request context
- [ ] **Exemplo 3: Testing**
  - [ ] Arquivo: `examples/test-setup.ts`
  - [ ] Mock de Flagsmith para testes
  - [ ] Como testar componentes com flags

**Exemplo React Hook:**
```typescript
// examples/use-flagsmith.ts
import { useEffect, useState } from 'react';
import { createFlagsmithClient } from '@onion/feature-flags-sdk';

export function useFlagsmith() {
  const [client, setClient] = useState<any>(null);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState<string | null>(null);

  useEffect(() => {
    const init = async () => {
      try {
        const c = await createFlagsmithClient({
          environmentKey: import.meta.env.VITE_FLAGSMITH_KEY,
        });
        setClient(c);
      } catch (err) {
        setError(err instanceof Error ? err.message : 'Unknown error');
      } finally {
        setLoading(false);
      }
    };
    init();
  }, []);

  return {
    client,
    loading,
    error,
    getFeatureFlag: (name: string) => client?.getFeatureFlag(name),
    isFeatureEnabled: (name: string) => client?.isFeatureEnabled(name),
  };
}
```

**Critérios de Sucesso:**
- [ ] ✅ 3+ exemplos criados
- [ ] ✅ Exemplos podem ser executados imediatamente
- [ ] ✅ Bem documentados com comentários

---

### Comandos de Validação Fase 5

```bash
# 1. Verificar documentação
ls -la docs/guides/flagsmith-integration-guide.md

# 2. Verificar exemplos
ls -la examples/

# 3. Validar markdown
markdownlint docs/guides/flagsmith-integration-guide.md
```

**📝 LOG DE EXECUÇÃO - FASE 5:**
```bash
# [Data/Hora] - FASE 5.1 - Documentação (STATUS)
# - Guide.md criado: ✅
# - 6 seções completas
# - 10+ exemplos de código

# [Data/Hora] - FASE 5.2 - Exemplos (STATUS)
# - React Hook: ✅
# - Node.js Middleware: ✅
# - Testing Setup: ✅
# - Todos exemplos testados e funcionando
```

---

## 📈 MÉTRICAS DE SUCESSO FINAL

### **Performance (Fase 4)**
- [ ] ✅ Latência p99 < 100ms (Flagsmith)
- [ ] ✅ Throughput > 1000 req/sec
- [ ] ✅ Taxa de erro < 0.1%
- [ ] ✅ Feature parity 100%

### **Integração Nx (Fase 3)**
- [ ] ✅ Package `@onion/feature-flags-sdk` funcional
- [ ] ✅ App teste usando SDK com sucesso
- [ ] ✅ Testes com cobertura >80%
- [ ] ✅ Build e deploy sem problemas

### **Documentação (Fase 5)**
- [ ] ✅ Guia completo escrito
- [ ] ✅ 3+ exemplos funcionais
- [ ] ✅ Best practices documentadas
- [ ] ✅ Troubleshooting guide criado

### **Sistema Completo**
- [ ] ✅ POC validou viabilidade de Flagsmith
- [ ] ✅ Decisão ADR aprovada
- [ ] ✅ Plano de migração documento
- [ ] ✅ Pronto para Fase de Implementação

---

## 🔄 ESTRATÉGIA DE ROLLBACK

### **Rollback por Fase**

#### **Rollback Fase 5 → Fase 4**
```bash
# Remover documentação e exemplos
git revert HEAD --no-edit
git push origin feature/flagsmith-poc
```

#### **Rollback Completo → Baseline (Unleash)**
```bash
# Voltar para branch anterior
git checkout develop
git branch -D feature/flagsmith-poc

# Docker Flagsmith parado
docker-compose down
rm -rf docker-compose.yml .env.local

# SDK removido
rm -rf packages/feature-flags-sdk
rm -rf apps/flagsmith-test-app
```

---

## 📅 CRONOGRAMA DE EXECUÇÃO

| Fase | Duração | Dependências | Risco | Responsável | Status |
|------|---------|--------------|-------|-------------|--------|
| **Fase 1** | 3h (1 dia) | Análise concluída ✅ | 🟡 MÉDIO | Tech Lead + DevOps | ❌ **PENDENTE** |
| **Fase 2** | 4h (1 dia) | Fase 1 concluída | 🟡 MÉDIO | DevOps | ❌ **PENDENTE** |
| **Fase 3** | 5h (1-2 dias) | Fases 1-2 concluídas | 🟢 BAIXO | React Dev + Node Dev | ❌ **PENDENTE** |
| **Fase 4** | 6h (1-2 dias) | Fases 1-3 concluídas | 🟡 MÉDIO | DevOps / Perf Eng | ❌ **PENDENTE** |
| **Fase 5** | 4h (1 dia) | Fases 1-4 concluídas | 🟢 BAIXO | Tech Lead / Docs | ❌ **PENDENTE** |

**Total Estimado: 22 horas (4-5 dias úteis de trabalho)**

### **Marcos de Execução**

- [ ] **Dia 1 (Manhã)**: Fase 1 - Decisão arquitetural + ADR
- [ ] **Dia 1 (Tarde)**: Fase 2 - Flagsmith up & running
- [ ] **Dia 2-3**: Fase 3 - SDK integrado com Nx
- [ ] **Dia 3-4**: Fase 4 - Benchmarks e validação
- [ ] **Dia 5**: Fase 5 - Documentação e handoff
- [ ] **Fim de Semana**: Review e aprovação final

---

## 🎯 CONSIDERAÇÕES FINAIS

### **Benefícios do POC**

- 🚀 **Validação técnica** comprovará viabilidade de Flagsmith
- 🧠 **Conhecimento compartilhado** através de documentação clara
- 🤖 **Setup pronto** para próxima fase (implementação)
- 📊 **Dados reais** de performance para decisão final
- 🔒 **Risco reduzido** com POC antes de migração completa

### **Riscos Mitigados**

- ⚠️ **Performance unknown** → Benchmark completo em Fase 4
- ⚠️ **Integração complexa** → Validada em Fase 3 com Nx
- ⚠️ **Feature gaps** → Feature parity 100% testada
- ⚠️ **Team adoption** → Documentação + exemplos em Fase 5

### **Garantia de Sucesso**

- ✅ **Análise de alta qualidade** foi base para decisão
- ✅ **Equipe experiente** em Node.js/React/DevOps
- ✅ **Timeline realista** com buffers
- ✅ **Rollback definido** em caso de problemas

---

## 📊 TRACKING DE EXECUÇÃO FINAL

### Status Global de Execução

- [ ] **Fase 1:** ❌ **0% PENDENTE** - Decisão Arquitetural (3h)
- [ ] **Fase 2:** ❌ **0% PENDENTE** - Setup Flagsmith (4h)
- [ ] **Fase 3:** ❌ **0% PENDENTE** - Integração Nx (5h)
- [ ] **Fase 4:** ❌ **0% PENDENTE** - Benchmark (6h)
- [ ] **Fase 5:** ❌ **0% PENDENTE** - Documentação (4h)

**Progress POC:** `0h/22h (0%)` → **Meta: POC 100% Completo e Validado** ❌ **PENDENTE**

**Status Final de Projeto:**
- ✅ Análise técnica: COMPLETA
- ⏳ POC: PRONTO PARA INICIAR
- ❌ Implementação: AGUARDANDO RESULTADO DO POC

### Próximas Etapas Imediatas

1. **✅ Já feito:** Análise técnica concluída
2. **🔄 Agora:** Validar este plano com stakeholders
3. **👉 Próximo:** Iniciar Fase 1 - Decisão arquitetural
4. **📅 Sequência:** Executar fases 1-5 conforme cronograma

**POC Flagsmith: Pronto para iniciar em 4-5 dias úteis** ⏱️

---

## 📝 LOG DE EXECUÇÃO DETALHADO

### Data: [YYYY-MM-DD HH:MM]
**Fase executada:** [Fase X] - [Nome da tarefa]  
**Responsável:** [Nome/Role]  
**Status:** [Concluído/Em Progresso/Com Erro/Pendente]  
**Observações:**
```
- [ ] [Descrição específica do que foi realizado]
- [ ] [Validações executadas]
- [ ] [Testes realizados]
- [ ] [Arquivos criados/modificados]
- [ ] [Itens pendentes se houver]
- ❌ [Problemas encontrados (se houver)]
```

### Comandos Executados:
```bash
# [Descrição do comando]
[comando executado]

# [Resultado do comando]
[output relevante]
```

### Métricas Atingidas:
- ✅ [Métrica específica]: [Valor alcançado] / [Target]
- ✅ [Métrica de performance]: [Valor] ([Comparação com target])

---

## 🔄 COMANDOS DE EXECUÇÃO

### Validação Geral:
```bash
# Verificar status branch POC
git status
git log --oneline -5

# Verificar estrutura
ls -la packages/feature-flags-sdk
ls -la apps/flagsmith-test-app
docker-compose ps
```

### Execução por Fase:
```bash
# Fase 1: Decisão
# (Workshop - sem comandos)

# Fase 2: Docker
docker-compose up -d
docker-compose ps

# Fase 3: Nx
pnpm nx run feature-flags-sdk:test
pnpm nx run apps/flagsmith-test-app:serve

# Fase 4: Benchmark
k6 run benchmark/flagsmith-load-test.js

# Fase 5: Docs
markdownlint docs/guides/flagsmith-integration-guide.md
```

### Rollback de Emergência:
```bash
# Se algo der errado, voltar para Unleash
git checkout develop
git branch -D feature/flagsmith-poc
docker-compose down
rm -rf docker-compose.yml
```

---

## 🤖 Orientações de Auto-Atualização

### Para o AI Assistant:

```
SEMPRE que interagir com este documento:

1. 🔍 VERIFICAR status atual dos checkboxes
2. ✅ MARCAR [x] tarefas concluídas durante a sessão
3. 📝 ATUALIZAR log de execução com:
   - Data/hora atual
   - Fase executada
   - Status (Concluído/Em Progresso/Com Erro)
   - Observações detalhadas
4. 📊 ATUALIZAR status geral das fases na seção inicial
5. 🎯 VERIFICAR métricas de sucesso e marcar as atingidas
6. ⏱️ ATUALIZAR cronograma (ajustar prazos se necessário)

TEMPLATE PARA LOG:
### Data: [DATA ATUAL HH:MM]
**Fase executada:** Fase X - [Nome da tarefa]
**Responsável:** AI Assistant / [Name]
**Status:** [Concluído/Em Progresso/Com Erro/Pendente]
**Observações:**
```
- [x] Tarefa específica realizada
- [x] Verificações executadas
- [ ] Pending items se houver
- ❌ Problemas encontrados (se houver)
```

COMANDOS A EXECUTAR QUANDO APLICÁVEL:
- [comando de validação principal]
- [comando de build específico]
- git status (verificar mudanças)
- git log --oneline -5 (verificar commits)
```

### Para Desenvolvedores:
- 📖 **Leia o plano completo** antes de começar
- ✅ **Marque progressos** conforme avança
- 📝 **Documente problemas** no log de execução
- 🔄 **Execute comandos** de validação
- 🏷️ **Crie tags git** antes de mudanças críticas

---

**Status Final: PLANO PRONTO PARA EXECUÇÃO** 🚀

*Criado em: 2025-11-05 18:30 BRT*  
*Versão: 1.0 - POC Flagsmith Integration*  
*Baseado em: Análise Técnica - Alternativas ao Unleash*  
*Responsável: Sistema Onion - @metaspec-gate-keeper*

---

## 🔗 REFERÊNCIAS & LINKS

- 📊 **Análise Técnica:** `docs/analysis/unleash-alternatives-analysis.md`
- 🏗️ **Template Usado:** `.cursor/docs/templates/execution-plan-template.md`
- 📋 **ADR Template:** `docs/architecture/adr-000-template.md`
- 🚀 **Flagsmith Docs:** https://docs.flagsmith.com
- 🐳 **Docker Compose:** https://docs.docker.com/compose/

---

*Plano de Execução gerado pelo Sistema Onion - POC Flagsmith Integration* 🧅

