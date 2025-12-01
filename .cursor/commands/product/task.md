---
name: task
description: |
  Criação de tasks com decomposição hierárquica inteligente.
  Use para criar tasks estruturadas com subtasks e action items.
  Suporta: ClickUp, Asana, Linear (via TASK_MANAGER_PROVIDER).
model: sonnet

parameters:
  - name: description
    description: Descrição da task
    required: true
  - name: project_name
    description: Nome do projeto/lista (opcional)
    required: false

category: product
tags:
  - task
  - task-manager
  - decomposition

version: "3.0.0"
updated: "2025-11-24"

related_commands:
  - /product/spec
  - /engineer/start

related_agents:
  - task-specialist
  - product-agent
---

# 🚀 Criação de Task com Decomposição

Criar tasks estruturadas no gerenciador de tarefas configurado.

## 🔧 Pré-requisito: Verificar Provedor

```markdown
Antes de criar tasks, verificar configuração:
1. Ler `.env` para TASK_MANAGER_PROVIDER
2. Se não configurado ou "none":
   - Avisar: "⚠️ Nenhum gerenciador configurado. Execute /meta/setup-integration"
   - Continuar com estrutura local (sem sincronização)
3. Se configurado:
   - Usar adapter correspondente de `.cursor/utils/task-manager/adapters/`
```

## 🎯 Objetivo

Estabelecer base sólida para desenvolvimento com decomposição Task → Subtask → Action Item.

## ⚡ Fluxo de Execução

### Passo 1: Detectar Provedor

```typescript
// Consultar .cursor/utils/task-manager/detector.md
const provider = detectProvider();

if (!provider.isConfigured) {
  console.warn('⚠️ Modo offline - tasks não serão sincronizadas');
  console.warn('💡 Execute /meta/setup-integration para configurar');
}
```

### Passo 2: Análise de Contexto

```bash
# Revisar documentação do projeto
read_file README.md
ls docs/*.md

# Entender estrutura existente
list_dir src/
```

### Passo 3: Compreender Tarefa

1. **Ler descrição**: `{{description}}`
2. **Identificar complexidade**:
   - Simples (1-3 dias): 2-3 subtasks
   - Média (4-7 dias): 3-4 subtasks
   - Complexa (1-2 sem): 4-6 subtasks
   - Épico (>2 sem): Quebrar em múltiplas tasks

3. **Confirmar com usuário** antes de criar

### Passo 4: Decompor Hierarquicamente

Consultar @task-specialist para estrutura:

```
📋 TASK (Objetivo de Alto Nível)
├── 🔧 Subtask 1 (Componente Funcional)  
│   ├── ✅ Action Item 1.1 (1-4h)
│   ├── ✅ Action Item 1.2 (1-4h)
│   └── ✅ Action Item 1.3 (1-4h)
└── 🔧 Subtask 2 (Componente Funcional)
    ├── ✅ Action Item 2.1 (1-4h)
    └── ✅ Action Item 2.2 (1-4h)
```

### Passo 5: Criar no Gerenciador

Via abstração (consultar adapter do provedor configurado):

1. **Criar Task Principal**
   ```typescript
   // Usar interface ITaskManager
   const taskManager = getTaskManager();
   
   const task = await taskManager.createTask({
     name: "{{description}}",
     projectId: resolveProjectId(project_name),
     markdownDescription: `
       ## 🎯 Objetivo
       [extraído da análise]
       
       ## ✅ Critérios de Aceite
       - [ ] Critério 1
       - [ ] Critério 2
     `,
     priority: 'high',
     tags: ['feature']
   });
   ```

2. **Criar Subtasks**
   ```typescript
   for (const subtask of decomposition.subtasks) {
     await taskManager.createSubtask(task.id, {
       name: subtask.name,
       description: subtask.description
     });
   }
   ```

3. **Adicionar Comentário Inicial**
   ```typescript
   await taskManager.addComment(task.id, 
     '🚀 Task criada via /product/task\n' +
     `📊 Complexidade: ${complexity}\n` +
     `📈 Estimativa: ${estimate}`
   );
```

### Passo 6: Apresentar Resultado

## 📤 Output Esperado

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ TASK CRIADA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Task: {{description}}
🔗 URL: [url do provedor]
📊 Provedor: [clickup/asana/linear/local]
📈 Complexidade: [simples/média/complexa]

🔧 Estrutura:
├── Subtask 1: [nome]
│   ├── ✅ Item 1.1
│   └── ✅ Item 1.2
└── Subtask 2: [nome]
    └── ✅ Item 2.1

📈 Estimativa: [X dias]

🚀 Próximo: /engineer/start [feature-slug]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## 📏 Regras de Decomposição

| Tipo | Duração | Subtasks | Action Items/Subtask |
|------|---------|----------|---------------------|
| Simples | 1-3d | 2-3 | 2-3 |
| Média | 4-7d | 3-4 | 3-4 |
| Complexa | 1-2sem | 4-6 | 3-5 |
| Épico | >2sem | Quebrar | - |

## 🔗 Referências

- Abstração: `.cursor/utils/task-manager/`
- Decomposição: @task-specialist
- Padrões: `common/prompts/clickup-patterns.md`

## ⚠️ Notas

- SEMPRE confirmar com usuário antes de criar
- Action items: máximo 4h cada
- Se épico: sugerir quebrar em múltiplas tasks
- Se provedor não configurado: funciona em modo local
