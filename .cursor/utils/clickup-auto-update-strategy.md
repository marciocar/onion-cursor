# 🔄 Estratégia de Auto-Update ClickUp

Este documento define quando e como os comandos do Sistema Onion devem **automaticamente atualizar** tasks no ClickUp vs quando devem **pedir confirmação** do usuário.

## 🎯 **Princípios Fundamentais**

### **✅ Atualização AUTOMÁTICA quando:**
- ✅ **Baixo risco** - mudança é informativa/progress tracking
- ✅ **Esperado pelo usuário** - parte natural do comando
- ✅ **Reversível** - pode ser desfeito facilmente
- ✅ **Status tracking** - progresso natural do workflow

### **⚠️ Confirmação NECESSÁRIA quando:**
- ⚠️ **Alto impacto** - mudança afeta timeline/priority/assignees
- ⚠️ **Irreversível** - não pode ser facilmente desfeito
- ⚠️ **Decisão de negócio** - requer aprovação stakeholder
- ⚠️ **Múltiplas opções** - várias alternativas possíveis

## 📊 **Matriz de Decisão por Comando**

| Comando | Auto-Update | Confirmação | Detalhes |
|---------|-------------|-------------|----------|
| **`/product/task`** | ✅ Status → "To Do" | - | Task criada em estado inicial |
| **`/engineer/start`** | ✅ Status → "In Progress" | - | Início natural do desenvolvimento |
| **`/engineer/work`** | ✅ Comments de progresso | - | Updates de atividade |
| **`/engineer/pre-pr`** | ✅ Comments de checklist | - | Preparação para PR |
| **`/engineer/pr`** | ✅ Status → "In Progress"<br>✅ Tag "under-review"<br>✅ Comment PR details | - | **JÁ IMPLEMENTADO** |
| **`/product/task-check`** | ✅ Comments de verificação | ⚠️ Status change | Verificação é tracking, mas status requer decisão |
| **`/product/validate-task`** | ✅ Comments de análise | ⚠️ Priority/Status changes | Análise é tracking, mudanças estruturais requerem aprovação |
| **`/engineer/bump`** | ✅ Comments de versioning | - | Tracking de releases |
| **`/engineer/docs`** | ✅ Comments de documentação | - | Updates de docs |

## 🔧 **Implementação por Comando**

### **1. `/product/task-check <task-id>`**

#### **Auto-Update SEMPRE:**
```javascript
// Comentário automático com resultados
create_task_comment({
  taskId: taskId,
  commentText: `🔍 VERIFICAÇÃO DE IMPLEMENTAÇÃO

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 RESULTADO DA VERIFICAÇÃO:
   ∟ Status: ${verificationStatus}
   ∟ Completude: ${completionPercentage}%
   ∟ Arquivos verificados: ${filesChecked}

✅ IMPLEMENTADO:
   ∟ ${implementedFeatures.join('\n   ∟ ')}

⚠️ PENDENTE:
   ∟ ${pendingItems.join('\n   ∟ ')}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Verificado: ${timestamp} | 🎯 Próximo: ${nextAction}`
})
```

#### **Confirmação SE necessário:**
```javascript
if (verificationStatus === 'COMPLETE' && currentStatus !== 'Done') {
  // Perguntar se deve mover para Done
  const userConfirm = await askUser("Task verificada como completa. Mover status para 'Done'?")
  if (userConfirm) {
    update_task({ taskId, status: 'Done' })
  }
}
```

### **2. `/product/validate-task <task-id>`**

#### **Auto-Update SEMPRE:**
```javascript
create_task_comment({
  taskId: taskId,
  commentText: `📊 VALIDAÇÃO ESTRATÉGICA

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 ANÁLISE EXECUTIVA:
   ∟ Viabilidade: ${viabilityScore}/10
   ∟ Alinhamento: ${alignmentScore}/10
   ∟ Complexidade: ${complexityLevel}

✅ PONTOS FORTES:
   ∟ ${strongPoints.join('\n   ∟ ')}

⚠️ RISCOS IDENTIFICADOS:
   ∟ ${risks.join('\n   ∟ ')}

💡 RECOMENDAÇÕES:
   ∟ ${recommendations.join('\n   ∟ ')}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Validado: ${timestamp} | 🎯 Status: ${validationResult}`
})
```

#### **Confirmação PARA mudanças estruturais:**
```javascript
if (recommendations.includes('PRIORITY_CHANGE')) {
  const newPriority = await askUser(`Recomendo mudar prioridade para ${suggestedPriority}. Confirmar?`)
}

if (recommendations.includes('SCOPE_REDUCTION')) {
  const confirmed = await askUser(`Task muito complexa. Quebrar em subtasks?`)
}
```

### **3. `/engineer/work` (quando em sessão ativa)**

#### **Auto-Update SEMPRE:**
```javascript
// A cada fase completada no plan.md
create_task_comment({
  taskId: sessionTaskId,
  commentText: `🔧 PROGRESSO DE DESENVOLVIMENTO

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 FASE COMPLETADA:
   ▶ ${completedPhase}
   ▶ Arquivos modificados: ${modifiedFiles.length}
   ▶ Testes adicionados: ${testsAdded}

🚀 PRÓXIMA FASE:
   ▶ ${nextPhase}
   ▶ Estimativa: ${nextPhaseEstimate}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Atualização: ${timestamp}`
})
```

### **4. `/engineer/start <slug>` (quando sessão tem task-id)**

#### **Auto-Update SEMPRE:**
```javascript
update_task({
  taskId: sessionTaskId,
  status: 'In Progress'
})

create_task_comment({
  taskId: sessionTaskId,
  commentText: `🚀 DESENVOLVIMENTO INICIADO

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🏗️ SESSÃO ATIVADA:
   ▶ Branch: ${featureBranch}
   ▶ Sessão: .cursor/sessions/${slug}/
   ▶ Arquitetura: Definida e aprovada

📋 PLANO DE IMPLEMENTAÇÃO:
   ∟ ${phases.join('\n   ∟ ')}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Iniciado: ${timestamp} | 🎯 Próximo: Implementar Fase 1`
})
```

## ⚙️ **Configuração por Comando**

### **Pattern de Implementação:**

```typescript
interface AutoUpdateConfig {
  command: string
  autoUpdates: {
    status?: string
    tags?: string[]
    comments: boolean
    properties?: Record<string, any>
  }
  confirmationRequired: {
    statusChanges?: string[]
    priorityChanges?: boolean
    assigneeChanges?: boolean
    scopeChanges?: boolean
  }
}

const commandConfigs: AutoUpdateConfig[] = [
  {
    command: '/product/task-check',
    autoUpdates: {
      comments: true, // Sempre
      tags: ['verified'] // Se verificação passou
    },
    confirmationRequired: {
      statusChanges: ['Done', 'Closed'], // Só com confirmação
      priorityChanges: true
    }
  },
  {
    command: '/engineer/pr',
    autoUpdates: {
      status: 'In Progress', // Automático
      tags: ['under-review'], // Automático
      comments: true // Automático
    },
    confirmationRequired: {} // Nenhuma confirmação necessária
  }
  // ... outros comandos
]
```

## 🎯 **Casos Especiais**

### **1. Task não encontrada na sessão atual**
```javascript
// Se comando é executado mas não há task-id na sessão
if (!currentSessionTaskId && taskIdFromArgs) {
  // Usar task-id fornecido pelo usuário
  // Auto-update OK
} else if (!currentSessionTaskId && !taskIdFromArgs) {
  // Perguntar qual task atualizar
  const taskId = await askUser("Qual task ID devo atualizar?")
}
```

### **2. Múltiplas tasks em sessão**
```javascript
// Se sessão tem task pai + subtasks
if (sessionHasMultipleTasks) {
  // Sempre atualizar task principal
  // Subtasks só com confirmação
}
```

### **3. Task já finalizada**
```javascript
if (taskStatus === 'Done' || taskStatus === 'Closed') {
  const confirm = await askUser("Task já está finalizada. Ainda assim atualizar?")
  if (!confirm) return
}
```

## 📝 **Implementação nos Comandos**

Cada comando deve incluir esta seção antes dos argumentos:

```markdown
## 🔄 **Auto-Update ClickUp**

Este comando **automaticamente atualiza** a task ClickUp quando:
- ✅ Adiciona comentário com resultados da verificação
- ✅ Aplica tag 'verified' se verificação passou

Este comando **pede confirmação** para:
- ⚠️ Mudança de status para 'Done' 
- ⚠️ Alteração de prioridade baseada na análise
- ⚠️ Quebra da task em subtasks

### **📋 Identificação da Task:**
1. **Sessão ativa**: Usa task-id do arquivo `context.md`
2. **Argumento fornecido**: Usa task-id passado pelo usuário
3. **Não identificada**: Pergunta ao usuário qual task atualizar
```

---

**Esta estratégia garante produtividade máxima com controle adequado sobre mudanças críticas! 🚀**
