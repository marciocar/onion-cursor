# 🔗 Guia de Integração ClickUp MCP

Este guia documenta como o sistema `.cursor/` integra com ClickUp MCP (Managed Cloud Provider) para gerenciamento automático de projetos e tasks.

## 📋 Índice

- [🏗️ Estrutura Hierárquica](#️-estrutura-hierárquica)
- [🔄 Mapeamento de Estados](#-mapeamento-de-estados)
- [📊 Comandos e Integrações](#-comandos-e-integrações)
- [🎯 Configuração e Setup](#-configuração-e-setup)
- [💡 Exemplos Práticos](#-exemplos-práticos)
- [🛠️ Troubleshooting](#️-troubleshooting)

---

## 🏗️ Estrutura Hierárquica

### **Hierarquia ClickUp Utilizada**

```
📊 Workspace: OnionLabs (ID: 90131664218)
└── 📁 Space: "Grana.ai" (ID: 90136982915)
    └── 📋 List: "Tarefas" (ID: 901314121395)
        ├── 📝 Task: Feature A
        ├── 📝 Task: Bug B  
        └── 📝 Task: Refactoring C
```

### **Mapeamento de Conceitos**

| Conceito Sistema | ClickUp Equivalent | ID/Referência |
|------------------|-------------------|---------------|
| **Projeto** | Space | `90136982915` |
| **Categoria** | List | `901314121395` |
| **Funcionalidade** | Task | Gerado automaticamente |
| **Subtarefa** | Subtask | Vinculada à Task pai |
| **Milestone** | Folder (opcional) | Conforme necessário |

---

## 🔄 Mapeamento de Estados

### **Estados ClickUp Disponíveis**

| Estado ClickUp | Descrição | Quando Usar |
|----------------|-----------|-------------|
| `backlog` | Ideias não priorizadas | Items coletados mas não planejados |
| `to do` | Pronto para desenvolvimento | Tasks definidas e priorizadas |
| `in progress` | Em desenvolvimento ativo | Durante implementação |
| `done` | Completado e entregue | Após merge e deploy |
| `closed` | Finalizado ou cancelado | Tasks arquivadas |

### **Tags Especiais para Workflow**

| Tag | Propósito | Comandos que Usam |
|-----|-----------|------------------|
| `under-review` | PR criado, aguardando review | `/engineer/pr` |
| `blocked` | Impedimento identificado | Manual ou automático |
| `urgent` | Prioridade crítica | `/product/collect` (hotfixes) |
| `feature` | Nova funcionalidade | `/product/task` |
| `bug` | Correção necessária | `/product/collect` |
| `refactor` | Melhoria técnica | `/product/task` |
| `docs` | Documentação | `/docs/*` |

---

## 📊 Comandos e Integrações

### **Comandos de Produto**

#### `/product/task` → `create_task`
```bash
# Exemplo de uso
/product/task "Implementar autenticação OAuth2 com Google e GitHub"
```

**ClickUp MCP Actions**:
1. `create_task` no List "Tarefas"
2. Popula campos:
   - **name**: "🔐 Implementar autenticação OAuth2 com Google e GitHub"
   - **description**: Descrição detalhada em markdown
   - **tags**: `["feature", "auth", "oauth2"]`
   - **priority**: Baseado na análise (1=urgent, 4=low)
   - **status**: `"to do"`

**Resultado**:
```
✅ Task criada: AUTH-456
📋 Título: 🔐 Implementar autenticação OAuth2 com Google e GitHub
🏷️ Tags: feature, auth, oauth2
📊 Status: to do
🎯 Prioridade: 2 (high)
```

#### `/product/collect` → `create_task`
```bash
# Exemplo de uso  
/product/collect "Usuários reportam lentidão no dashboard após últimas atualizações"
```

**ClickUp MCP Actions**:
1. Classificação automática (bug vs feature)
2. `create_task` com:
   - **tags**: `["bug", "performance", "dashboard"]`
   - **priority**: Baseado na urgência relatada
   - **status**: `"backlog"` (para triagem posterior)

#### `/product/refine` → `update_task`
```bash
# Trabalhando com task existente
/product/refine
```

**ClickUp MCP Actions**:
1. `get_task` para buscar details atuais
2. `update_task` com refinamentos:
   - **description**: Versão expandida
   - **custom_fields**: Critérios de aceitação
   - **time_estimate**: Estimativa refinada

### **Comandos de Engenharia**

#### `/engineer/start` → `get_task` + `update_task`
```bash
# Input necessário: ID da task
/engineer/start  
# → Sistema solicita: "Qual task ClickUp? (ex: AUTH-456)"
```

**ClickUp MCP Actions**:
1. `get_task` by ID para buscar detalhes completos
2. `update_task`:
   - **status**: `"to do"` → `"in progress"`
   - **assignees**: Adiciona desenvolvedor atual
   - **tags**: Adiciona `"development"`

**Análise Realizada**:
- 📋 Extrai requisitos da description
- 🏷️ Analisa tags para entender contexto  
- 👥 Identifica assignees e reviewers
- ⏱️ Revisa time_estimate vs time_tracked

#### `/engineer/pr` → `update_task` + `create_task_comment`
```bash
# Após implementação completa
/engineer/pr
```

**ClickUp MCP Actions**:
1. `update_task`:
   - **status**: `"in progress"` (mantém)
   - **tags**: Adiciona `"under-review"`
   - **custom_fields**: Link do PR

2. `create_task_comment`:
```markdown
🔍 Pull Request Criado

**Branch**: feature/auth-oauth2
**PR Link**: https://github.com/org/repo/pull/123
**Arquivos**: 12 modificados (+245 -67 linhas)

**Checklist**:
- ✅ Todos os testes passando
- ✅ Cobertura > 80%
- ✅ Linting sem erros
- ✅ Documentação atualizada

Pronto para review! 🚀
```

#### Após Merge → `update_task`
```bash
# Executado automaticamente via webhook ou manualmente
```

**ClickUp MCP Actions**:
1. `update_task`:
   - **status**: `"done"`
   - **tags**: Remove `"under-review"`, adiciona `"completed"`
   
2. `create_task_comment`:
```markdown
✅ Feature Entregue

**Merged**: feature/auth-oauth2 → main
**Deploy**: Realizado com sucesso
**Tempo Total**: 8.5 horas (estimate: 10h)

Funcionalidade disponível em produção! 🎉
```

### **Comandos de Documentação**

#### `/docs/build-tech-docs` → `create_task`
```bash
/docs/build-tech-docs
```

**ClickUp MCP Actions**:
1. `create_task` para documentação:
   - **name**: "📚 Atualizar documentação técnica - [Projeto]"
   - **tags**: `["docs", "technical"]`
   - **status**: `"in progress"`

2. Após conclusão, `update_task`:
   - **status**: `"done"`
   - **attachments**: Links para arquivos de documentação gerados

---

## 🎯 Configuração e Setup

### **Pré-requisitos**
- ✅ ClickUp MCP instalado e configurado
- ✅ Access token com permissões adequadas
- ✅ Workspace ID e Space ID identificados

### **Variáveis de Ambiente Necessárias**
```bash
# ClickUp Configuration
CLICKUP_WORKSPACE_ID="90131664218"
CLICKUP_SPACE_ID="90136982915"  
CLICKUP_LIST_ID="901314121395"
CLICKUP_API_TOKEN="pk_xxxxx"
```

### **Validação da Configuração**
```bash
# Teste de conectividade
/all-tools  # Deve mostrar ClickUp MCP tools disponíveis
```

**Ferramentas esperadas**:
- `mcp_clickup-mcp-server_create_task`
- `mcp_clickup-mcp-server_update_task`
- `mcp_clickup-mcp-server_get_task`
- `mcp_clickup-mcp-server_create_task_comment`
- `mcp_clickup-mcp-server_get_workspace_hierarchy`

---

## 💡 Exemplos Práticos

### **Exemplo 1: Ciclo Completo de Feature**

```bash
# 1. Criar nova feature
/product/task "Sistema de notificações push para mobile"
# → ClickUp: Task NOTIF-789 criada com status "to do"

# 2. Iniciar desenvolvimento  
/engineer/start
# Input: NOTIF-789
# → ClickUp: Status "to do" → "in progress" + tag "development"

# 3. Desenvolver funcionalidade
/engineer/work .cursor/sessions/push-notifications/
# → Desenvolvimento iterativo, progresso atualizado no ClickUp

# 4. Criar PR
/engineer/pr  
# → ClickUp: Adiciona tag "under-review" + comentário com link PR

# 5. Após approval e merge
# → ClickUp: Status "done" + comentário de conclusão
```

### **Exemplo 2: Correção de Bug Urgente**

```bash
# 1. Reportar bug crítico
/product/collect "CRÍTICO: Sistema de pagamento rejeitando cartões válidos"
# → ClickUp: Task BUG-101 com priority=1, tags=["bug", "urgent", "payment"]

# 2. Fix imediato
/engineer/start  
# Input: BUG-101
# → Branch hotfix/payment-validation criada automaticamente

# 3. Implementar correção
/engineer/work "correção validação cartões"
# → Fix específico, testes de regressão

# 4. Deploy emergencial  
/engineer/pr
# → PR marcado como hotfix, processo acelerado
```

### **Exemplo 3: Documentação de Projeto**

```bash
# 1. Gerar documentação técnica
/docs/build-tech-docs
# → ClickUp: Task DOC-55 para rastrear progresso da documentação

# 2. Resultado
# → Arquivos gerados: project_charter.md, CURSOR.meta.md, etc.
# → ClickUp: Task atualizada com links para documentação
```

---

## 🛠️ Troubleshooting

### **Problemas Comuns**

#### **1. Task não encontrada**
```
❌ Error: Task ID "AUTH-123" not found
```

**Soluções**:
- ✅ Verificar se ID está correto (formato: PREFIX-NUMBER)
- ✅ Confirmar se task está no List correto
- ✅ Verificar permissões de acesso

#### **2. Status inválido** 
```
❌ Error: Status "in review" does not exist
```

**Causa**: Status "in review" não existe na List "Tarefas"

**Solução aplicada**: Sistema usa `"in progress" + tag "under-review"`

#### **3. Tag não existe**
```
❌ Error: Tag "under-review" does not exist in space
```

**Soluções**:
- ✅ Criar tag manualmente no ClickUp Space
- ✅ Usar tag existente temporariamente
- ✅ Configurar auto-criação de tags

#### **4. Permissões insuficientes**
```
❌ Error: Insufficient permissions to update task
```

**Soluções**:
- ✅ Verificar scopes do API token
- ✅ Confirmar membership no Workspace
- ✅ Solicitar permissões de admin se necessário

### **Comandos de Diagnóstico**

#### **Verificar Hierarquia**
```bash
# Ver estrutura completa do workspace
mcp_clickup-mcp-server_get_workspace_hierarchy
```

#### **Testar Conectividade**
```bash
# Buscar task específica
mcp_clickup-mcp-server_get_task --taskId "AUTH-123"
```

#### **Listar Tags Disponíveis**
```bash
# Ver tags no space atual
mcp_clickup-mcp-server_get_space_tags --spaceId "90136982915"
```

### **Logs e Debugging**

#### **Habilitar Logs Detalhados**
```bash
# Ver requisições ClickUp MCP
export DEBUG_CLICKUP_MCP=true
```

#### **Validar Configuração**
```bash
# Testar todas as integrações
/warm-up  # Valida conectividade ClickUp
```

---

## 📊 Métricas e Monitoramento

### **KPIs Rastreados Automaticamente**
- ⏱️ **Cycle Time**: `to do` → `done`
- 🔄 **Lead Time**: Criação → Entrega  
- 📈 **Throughput**: Tasks completadas/semana
- 🐛 **Bug Rate**: % de bugs vs features
- ⚡ **Review Time**: `under-review` → `done`

### **Dashboards Recomendados**
1. **Active Development**: Tasks `in progress` + tempo decorrido
2. **Review Queue**: Tasks com tag `under-review`
3. **Bug Tracking**: Tasks com tag `bug` por prioridade
4. **Team Velocity**: Story points/sprint completed

### **Alertas Configurados**
- 🚨 **Task Blocked** > 24h
- ⏰ **PR Review** > 48h  
- 🔥 **Urgent Bug** criado
- 📊 **Sprint Goals** em risco

---

## 🔄 Workflows Automáticos

### **Triggers ClickUp → Sistema**
- **Task Status Changed** → Notify assignee
- **New Comment Added** → Update local session
- **Due Date Approaching** → Send reminder
- **Task Completed** → Archive session folder

### **Triggers Sistema → ClickUp**  
- **Branch Created** → Update task with branch link
- **PR Merged** → Move task to done
- **Tests Failed** → Add comment with failure details
- **Deploy Completed** → Add success notification

---

## 🎯 Próximos Passos

### **Melhorias Planejadas**
1. 🤖 **Auto-assignment** baseado em expertise
2. 📊 **Estimativas automáticas** via machine learning
3. 🔄 **Sync bidirecional** com Git commits
4. 📱 **Notificações mobile** personalizadas
5. 🎯 **Dashboards customizados** por papel

### **Integrações Futuras**
- 📧 **Email notifications** com templates
- 💬 **Slack integration** para updates
- 📈 **Time tracking** automático
- 🔍 **Advanced analytics** e reporting

---

**Próximo**: [Exemplos Práticos →](practical-examples.md)
