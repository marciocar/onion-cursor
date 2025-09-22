# 📋 Comandos Product - Workflow Completo

Este documento descreve o workflow completo dos comandos de produto no Sistema Onion.

## 🔄 **Fluxo de Trabalho Ideal**

```mermaid
graph TD
    A[📝 Ideia/Requisito] --> B[/product/task]
    B --> C[✅ Task ClickUp Criada]
    B --> D[🌿 Feature Branch]
    B --> E[📁 Sessão .cursor/sessions/]
    
    E --> F[/engineer/start]
    F --> G[🏗️ Desenvolvimento]
    
    G --> H[/product/task-check]
    H --> I{Implementação OK?}
    
    I -->|✅ Sim| J[🚀 Próxima Fase]
    I -->|❌ Não| K[🔧 Correções]
    K --> H
    
    J --> L[/product/validate-task]
    L --> M[📊 Análise Estratégica]
```

## 🛠️ **Comandos Disponíveis**

### 1. **`/product/task <description>`** 🚀
**Objetivo**: Criar task no ClickUp + Setup completo para desenvolvimento

**O que faz**:
- ✅ Cria task estruturada no ClickUp
- ✅ Cria feature branch `feature/<slug>`
- ✅ Inicializa sessão em `.cursor/sessions/<slug>/`
- ✅ Cria arquivos: `context.md`, `plan.md`, `notes.md`

**Quando usar**: Início de qualquer nova funcionalidade

### 2. **`/product/task-check <task-id>`** 🔍
**Objetivo**: Verificar se task foi realmente implementada

**O que faz**:
- ✅ Carrega task do ClickUp
- ✅ Audita projeto atual buscando implementação
- ✅ Compara requisitos vs código real
- ✅ Determina se pode avançar para próxima fase

**Quando usar**: Após desenvolvimento, antes de fechar task

### 3. **`/product/validate-task <task-id>`** 📊
**Objetivo**: Análise estratégica e alinhamento com projeto

**O que faz**:
- ✅ Valida alinhamento com arquitetura
- ✅ Analisa viabilidade técnica
- ✅ Sugere melhorias nos requisitos
- ✅ Fornece recomendações estratégicas

**Quando usar**: Análise de requisitos, tasks problemáticas

### 4. **Outros comandos complementares**:
- **`/product/check`**: Verificação contra meta-specs
- **`/product/spec`**: Criação de especificações
- **`/product/collect`**: Coleta de informações
- **`/product/refine`**: Refinamento de requisitos

## 🔄 **Sistema de Auto-Update ClickUp**

Todos os comandos seguem uma **estratégia consistente de atualização automática** do ClickUp:

### **✅ Updates Automáticos (Sem Confirmação)**
- **Comments informativos** com progresso e resultados
- **Tags de status** (verified, in-development, ready-for-pr)
- **Tracking de atividade** com timestamps
- **Progress updates** baseados em fases

### **⚠️ Confirmação Necessária (Alto Impacto)**
- **Mudanças de status** críticas (To Do → Done)
- **Alterações de prioridade** baseadas em análise
- **Quebra em subtasks** quando escopo é complexo
- **Reatribuição** quando detecta skill mismatch

### **📋 Identificação Inteligente de Tasks**
1. **Sessão ativa**: Usa task-id do `context.md` da sessão atual
2. **Argumento fornecido**: Usa task-id passado pelo usuário
3. **Não identificada**: Pergunta qual task atualizar

## 🎯 **Cenários de Uso**

### **Cenário 1: Nova Feature Completa**
```bash
# 1. Criar task + setup completo
/product/task "Sistema de notificações push"
# ↳ AUTO: Cria task + comment setup + tags

# 2. Iniciar desenvolvimento  
/engineer/start notificacoes-push
# ↳ AUTO: Status → "In Progress" + comment início

# 3. Desenvolver com tracking automático
/engineer/work notificacoes-push
# ↳ AUTO: Comments de progresso a cada fase

# 4. Preparar para PR
/engineer/pre-pr
# ↳ AUTO: Comment checklist + tag "ready-for-pr"

# 5. Criar PR
/engineer/pr
# ↳ AUTO: Status ajustado + tag "under-review"

# 6. Verificar implementação final
/product/task-check 86abzwx0w
# ↳ AUTO: Comment verificação + PERGUNTA: mover para Done?

# 7. Análise estratégica final
/product/validate-task 86abzwx0w
# ↳ AUTO: Comment validação + tag "validated"
```

### **Cenário 2: Task Problemática**
```bash
# 1. Analisar task existente
/product/validate-task 86abzwx0w
# ↳ AUTO: Comment análise + PERGUNTA: mudar prioridade?

# 2. Verificar o que foi implementado
/product/task-check 86abzwx0w
# ↳ AUTO: Comment verificação + tag "needs-work"

# 3. Refinar requisitos se necessário
/product/refine <task-description>
```

### **Cenário 3: Auditoria de Qualidade**
```bash
# 1. Verificar múltiplas tasks com tracking automático
/product/task-check 86abzwx0w
/product/task-check 86abzwx1x  
/product/task-check 86abzwx2y
# ↳ AUTO: Cada comando adiciona comment de verificação

# 2. Validar alinhamento estratégico
/product/validate-task 86abzwx0w
# ↳ AUTO: Comment validação + decisões estratégicas
```

## 📁 **Estrutura da Sessão**

Quando você usa `/product/task`, é criada esta estrutura:

```
.cursor/sessions/<task-slug>/
├── context.md          # Contexto e objetivos
├── architecture.md     # Arquitetura técnica (criado por /engineer/start)
├── plan.md            # Plano de implementação por fases
└── notes.md           # Notas e decisões
```

### **Integração com Comandos**:
- **`/engineer/start <slug>`**: Usa e expande a sessão
- **`/product/task-check`**: Lê context.md para entender escopo
- **`/product/validate-task`**: Considera arquitetura da sessão

## 🚀 **Próximos Passos Recomendados**

Depois de criar uma task com `/product/task`:

1. **Revisar** os arquivos criados em `.cursor/sessions/<slug>/`
2. **Executar** `/engineer/start <slug>` para iniciar desenvolvimento
3. **Usar** `/product/task-check` periodicamente durante desenvolvimento
4. **Finalizar** com `/product/validate-task` para análise completa

## 📊 **Matriz de Auto-Updates por Comando**

| Comando | Auto-Update | Confirmação | Tags Automáticas |
|---------|-------------|-------------|------------------|
| `/product/task` | ✅ Comment setup | - | feature/bug/improvement |
| `/engineer/start` | ✅ Status → "In Progress"<br>✅ Comment início | - | in-development |
| `/engineer/work` | ✅ Comments progresso | - | - |
| `/engineer/pre-pr` | ✅ Comment checklist | - | ready-for-pr/needs-fixes |
| `/engineer/pr` | ✅ Status ajuste<br>✅ Comment PR | - | under-review |
| `/product/task-check` | ✅ Comment verificação | ⚠️ Status → Done | verified/needs-work |
| `/product/validate-task` | ✅ Comment validação | ⚠️ Prioridade/Escopo | validated/needs-refinement |

## 💡 **Benefícios da Estratégia**

1. **Rastreabilidade Total**: Cada ação gera histórico automático no ClickUp
2. **Produtividade Máxima**: Elimina atualizações manuais repetitivas  
3. **Controle Inteligente**: Confirma apenas mudanças críticas
4. **Sincronização**: Sessões locais sempre sincronizadas com ClickUp
5. **Visibilidade**: Stakeholders veem progresso em tempo real

---

**Sistema completamente integrado! Auto-updates inteligentes em todos os comandos! 🚀🧅**
