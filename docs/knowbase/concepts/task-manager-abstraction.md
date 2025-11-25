# Task Manager Abstraction

## 📋 Metadados

| Campo | Valor |
|-------|-------|
| **Versão** | 1.0.0 |
| **Criado** | 2025-11-24 |
| **Categoria** | Architecture |
| **Tags** | `task-manager`, `adapter-pattern`, `abstraction` |

---

## 🎯 Visão Geral

O **Task Manager Abstraction** é uma camada de abstração que permite ao Sistema Onion funcionar com diferentes gerenciadores de tarefas (ClickUp, Asana, Linear) sem modificar comandos ou agentes.

### Problema Resolvido

Antes da abstração, comandos como `/product/task` e `/engineer/start` tinham chamadas diretas ao ClickUp MCP, criando:
- **Acoplamento forte** a um provedor específico
- **Impossibilidade de trocar** de gerenciador sem refatoração
- **Código duplicado** em múltiplos comandos

### Solução

Uma camada de abstração baseada no **Adapter Pattern** que:
- Define interface comum (`ITaskManager`)
- Implementa adapters específicos por provedor
- Detecta provedor via variável de ambiente
- Oferece fallback gracioso quando não configurado

---

## 🏗️ Arquitetura

```
┌─────────────────────────────────────────────────────────────┐
│                    COMANDOS ONION                           │
│  /product/task  │  /engineer/start  │  /engineer/work       │
└────────────────────────┬────────────────────────────────────┘
                         │
                         ▼
┌─────────────────────────────────────────────────────────────┐
│                    ABSTRACTION LAYER                        │
│  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐          │
│  │   Factory   │→ │  Detector   │→ │  Interface  │          │
│  └─────────────┘  └─────────────┘  └─────────────┘          │
└────────────────────────┬────────────────────────────────────┘
                         │
         ┌───────────────┼───────────────┬───────────────┐
         ▼               ▼               ▼               ▼
┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│   ClickUp   │  │   Asana     │  │   Linear    │  │    None     │
│   Adapter   │  │   Adapter   │  │   (Stub)    │  │   Adapter   │
└─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘
         │               │               │               │
         ▼               ▼               ▼               ▼
┌─────────────┐  ┌─────────────┐  ┌─────────────┐  ┌─────────────┐
│  ClickUp    │  │   Asana     │  │   Linear    │  │    Local    │
│    MCP      │  │    MCP      │  │    API      │  │   (Offline) │
└─────────────┘  └─────────────┘  └─────────────┘  └─────────────┘
```

---

## 📁 Estrutura de Arquivos

```
.cursor/utils/task-manager/
├── README.md           # Visão geral da abstração
├── interface.md        # Interface ITaskManager
├── types.md            # Tipos compartilhados
├── detector.md         # Detecta provedor via .env
├── factory.md          # Cria instância do adapter
└── adapters/
    ├── clickup.md      # Adapter ClickUp (completo)
    ├── asana.md        # Adapter Asana (completo)
    └── linear.md       # Adapter Linear (stub)
```

---

## 🔧 Interface ITaskManager

```typescript
interface ITaskManager {
  // Identificação
  readonly provider: 'clickup' | 'asana' | 'linear' | 'none';
  readonly isConfigured: boolean;

  // CRUD de Tasks
  createTask(input: CreateTaskInput): Promise<TaskOutput>;
  getTask(taskId: string): Promise<TaskOutput>;
  updateTask(taskId: string, updates: UpdateTaskInput): Promise<TaskOutput>;
  deleteTask(taskId: string): Promise<void>;

  // Subtasks
  createSubtask(parentId: string, input: CreateTaskInput): Promise<TaskOutput>;
  getSubtasks(parentId: string): Promise<TaskOutput[]>;

  // Comentários
  addComment(taskId: string, comment: string): Promise<CommentOutput>;
  getComments(taskId: string): Promise<CommentOutput[]>;

  // Status
  updateStatus(taskId: string, status: NormalizedTaskStatus): Promise<TaskOutput>;

  // Busca
  searchTasks(query: SearchQuery): Promise<TaskOutput[]>;

  // Projetos
  getProjectList(): Promise<ProjectOutput[]>;
  getProject(projectId: string): Promise<ProjectOutput>;

  // Validação
  validateTaskId(taskId: string): boolean;
  getProviderFromTaskId(taskId: string): Provider;
}
```

---

## ⚙️ Configuração

### Variáveis de Ambiente

```bash
# .env
TASK_MANAGER_PROVIDER=clickup  # clickup | asana | linear | none

# ClickUp
CLICKUP_API_TOKEN=pk_xxxxx
CLICKUP_DEFAULT_WORKSPACE=90131664218
CLICKUP_DEFAULT_LIST=901314121395

# Asana
ASANA_ACCESS_TOKEN=1/xxxxx
ASANA_DEFAULT_WORKSPACE=1234567890
ASANA_DEFAULT_PROJECT=0987654321

# Linear (futuro)
LINEAR_API_KEY=lin_api_xxxxx
LINEAR_DEFAULT_TEAM=abc123
```

### Detecção Automática

```typescript
// O detector identifica o provedor via .env
const config = detectProvider();
// { provider: 'clickup', isConfigured: true }

// A factory cria o adapter correto
const taskManager = getTaskManager();
// ClickUpAdapter instance
```

---

## 🔄 Status Normalizados

A abstração usa 7 status genéricos que são mapeados para cada provedor:

| Status Normalizado | ClickUp | Asana | Linear |
|--------------------|---------|-------|--------|
| `backlog` | Open | - | Backlog |
| `todo` | To Do | - | Todo |
| `in_progress` | In Progress | In Progress | In Progress |
| `in_review` | In Review | - | In Review |
| `done` | Done/Complete | Completed | Done |
| `cancelled` | Closed | - | Cancelled |
| `blocked` | Blocked | On Hold | - |

---

## 📝 Como Usar nos Comandos

### Exemplo: Criar Task

```typescript
// 1. Obter task manager
const taskManager = getTaskManager();

// 2. Verificar se está configurado
if (!taskManager.isConfigured) {
  console.warn('⚠️ Nenhum gerenciador configurado');
  console.warn('💡 Execute /meta/setup-integration');
  return; // Modo offline
}

// 3. Criar task
const task = await taskManager.createTask({
  name: 'Nova Feature',
  markdownDescription: '## Objetivo\nImplementar X...',
  priority: 'high',
  tags: ['feature']
});

console.log(`✅ Task criada: ${task.url}`);
```

### Exemplo: Atualizar Progresso

```typescript
// Atualizar status
await taskManager.updateStatus(taskId, 'in_progress');

// Adicionar comentário
await taskManager.addComment(taskId, `
🚀 Desenvolvimento iniciado
━━━━━━━━━━━━━━
📁 Branch: feature/nova-feature
⏰ ${new Date().toISOString()}
`);
```

---

## 🆕 Como Adicionar Novo Provedor

### 1. Criar Adapter

Crie um novo arquivo em `.cursor/utils/task-manager/adapters/`:

```markdown
# Nome do Provedor Adapter

## Configuração
- Variável: `PROVIDER_API_KEY`
- Workspace: `PROVIDER_WORKSPACE_ID`

## Mapeamento de Status
| Normalizado | Provider Status |
|-------------|-----------------|
| backlog | ... |
| todo | ... |

## Métodos

### createTask
\`\`\`typescript
await mcp_provider_create_task({...});
\`\`\`

// ... implementar todos os métodos da interface
```

### 2. Atualizar Detector

Adicione o novo provedor em `detector.md`:

```typescript
const PROVIDER_PATTERNS = {
  clickup: /^[a-z0-9]{9}$/,
  asana: /^[0-9]{16}$/,
  linear: /^[A-Z]+-[0-9]+$/,
  novo_provider: /^SEU_PATTERN$/  // ← Adicionar
};
```

### 3. Atualizar Factory

Adicione a instanciação em `factory.md`:

```typescript
switch (provider) {
  case 'clickup': return new ClickUpAdapter();
  case 'asana': return new AsanaAdapter();
  case 'novo_provider': return new NovoProviderAdapter();  // ← Adicionar
  default: return new NoProviderAdapter();
}
```

### 4. Atualizar .env.example

```bash
# Novo Provider
NOVO_PROVIDER_API_KEY=
NOVO_PROVIDER_WORKSPACE=
```

---

## 🔍 Validação de IDs

O sistema detecta automaticamente o provedor pelo padrão do ID:

| Provedor | Padrão | Exemplo |
|----------|--------|---------|
| ClickUp | `^[a-z0-9]{9}$` | `86adfe9eb` |
| Asana | `^[0-9]{16}$` | `1234567890123456` |
| Linear | `^[A-Z]+-[0-9]+$` | `ENG-123` |

### Detecção de Incompatibilidade

```
⚠️ INCOMPATIBILIDADE DETECTADA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
Task ID: "1234567890123456"
Provedor detectado: asana
Provedor configurado: clickup

💡 Ações sugeridas:
   1. Altere TASK_MANAGER_PROVIDER no .env
   2. Ou crie nova task no provedor atual
```

---

## 📊 Cobertura de Métodos

| Método | ClickUp | Asana | Linear |
|--------|---------|-------|--------|
| `createTask` | ✅ | ✅ | 📝 |
| `getTask` | ✅ | ✅ | 📝 |
| `updateTask` | ✅ | ✅ | 📝 |
| `deleteTask` | ✅ | ✅ | 📝 |
| `createSubtask` | ✅ | ✅ | 📝 |
| `getSubtasks` | ✅ | ✅ | 📝 |
| `addComment` | ✅ | ✅ | 📝 |
| `getComments` | ✅ | ✅ | 📝 |
| `updateStatus` | ✅ | ✅ | 📝 |
| `searchTasks` | ✅ | ✅ | 📝 |

✅ Implementado | 📝 Stub (documentado)

---

## 🔗 Referências

- Interface: `.cursor/utils/task-manager/interface.md`
- Factory: `.cursor/utils/task-manager/factory.md`
- Adapters: `.cursor/utils/task-manager/adapters/`
- Comando de setup: `/meta/setup-integration`

---

## 📚 Relacionados

- [AI Agent Design Patterns](ai-agent-design-patterns.md)
- [Configuration Management](configuration-management.md)
- [Cursor Commands Best Practices](../tools/cursor-commands-best-practices-2025.md)

