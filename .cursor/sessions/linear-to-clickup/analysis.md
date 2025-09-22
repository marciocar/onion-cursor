# Análise Detalhada: Comandos Linear → ClickUp MCP

## Mapeamento Linear → ClickUp por Comando

### 1. **engineer/start.md** - Recepção de Cards para Desenvolvimento

#### **Funcionalidade Linear Atual:**
- Recebe "um ou mais cards do Linear para trabalhar" (linha 10)
- Analisa cards, pais e filhos se necessário 
- Edita cards Linear quando há mudanças nos requisitos (linha 33)

#### **Equivalente ClickUp MCP:**
- **Recepção**: `get_task` por taskId ou taskName
- **Análise hierárquica**: ClickUp suporta subtasks nativamente
- **Edição**: `update_task` para modificar name/description

#### **Melhoria ClickUp:**
- ✅ **Hierarquia mais rica**: Task → Subtask (vs Linear cards simples)
- ✅ **Custom fields**: Metadados adicionais se necessário
- ✅ **Comentários estruturados**: `create_task_comment`

---

### 2. **engineer/pr.md** - Movimentação de Status para PR

#### **Funcionalidade Linear Atual:**
- Move "card do Linear associado com esta tarefa para o status 'In Review'" (linha 7)
- Template de conclusão menciona "[INSERT CARD ID] movido para 'In Review'" (linha 32)

#### **Equivalente ClickUp MCP:**
- **Movimentação**: `update_task` com parâmetro `status: "In Review"`
- **Template**: Usar taskId do ClickUp no lugar do CARD ID

#### **Status Mapeados:**
- Linear "In Review" → ClickUp "in review" ou equivalente

---

### 3. **product/task.md** - Criação de Issues

#### **Funcionalidade Linear Atual:**
- "criar issues bem estruturadas no Linear" (linha 2)
- Cria issue com descrição funcional, arquitetura técnica, bibliotecas sugeridas (linhas 22-24)

#### **Equivalente ClickUp MCP:**
- **Criação**: `create_task` com name, description, custom_fields
- **Estruturação**: Usar markdown_description para formatação rica

#### **Melhoria ClickUp:**
- ✅ **Markdown nativo**: Suporte a formatação rica
- ✅ **Time tracking**: Estimativas integradas com `time_estimate`
- ✅ **Assignees**: Atribuição direta na criação

---

### 4. **product/collect.md** - Coleta e Salvamento

#### **Funcionalidade Linear Atual:**
- "Salvar a issue no projeto Linear correspondente" (linha 26)
- Processo de coleta → aprovação → salvamento

#### **Equivalente ClickUp MCP:**
- **Salvamento**: `create_task` com listId específico
- **Processo**: Manter workflow de aprovação antes da criação

#### **Melhoria ClickUp:**
- ✅ **Lists organizadas**: Melhor categorização que projetos Linear
- ✅ **Templates**: Padronização de issues por tipo

---

### 5. **product/refine.md** - Refinamento de Requisitos

#### **Funcionalidade Linear Atual:**
- "Se foi feita baseada em uma issue do Linear, então atualize a issue" (linha 21)

#### **Equivalente ClickUp MCP:**
- **Atualização**: `update_task` com novos dados
- **Versioning**: ClickUp mantém histórico automaticamente

---

### 6. **product/light-arch.md** - Arquitetura Leve com Comentários

#### **Funcionalidade Linear Atual:**
- "salvando os detalhes da arquitetura no card do linear como um comentário" (linha 65)
- Processo iterativo com aprovação humana

#### **Equivalente ClickUp MCP:**
- **Comentários**: `create_task_comment` com detalhes da arquitetura
- **Workflow**: Manter processo de aprovação

#### **Melhoria ClickUp:**
- ✅ **Comentários ricos**: Markdown e formatação
- ✅ **Threading**: Discussões organizadas
- ✅ **Notifications**: Alertas automáticos

---

### 7. **docs/build-index.md** - IDs de Projeto

#### **Funcionalidade Linear Atual:**
- "id do projeto linear" e "id do time linear" (linhas 16-17)

#### **Equivalente ClickUp MCP:**
- **ID projeto**: Space ID (`90136982915`)  
- **ID time**: Workspace ID (`90131664218`)

---

### 8. **agents/product-agent.md** - Configuração Hierárquica

#### **Funcionalidade Linear Atual:**
- "Projects: Projetos dos Clientes" (linha 66)
- "Issues: Tarefas individuais" (linha 68)  
- Team ID específico mencionado

#### **Equivalente ClickUp MCP:**
- **Projects**: ClickUp Spaces
- **Issues**: ClickUp Tasks
- **Team**: ClickUp Workspace
- **Milestones**: ClickUp Folders ou Goals

---

## Status Mapping - Linear → ClickUp

| Linear Status | ClickUp Equivalent | Disponível? |
|---------------|-------------------|-------------|
| "To Do"       | "to do"          | ✅ Testado  |
| "In Progress" | "in progress"    | ✅ Testado  |
| "In Review"   | "in review"      | ⏳ A validar|
| "Done"        | "complete"       | ⏳ A validar|

## IDs de Referência - ClickUp

### **Ambiente Atual (Grana.ai):**
- **Workspace**: `90131664218`
- **Space "Grana.ai"**: `90136982915`  
- **List "Tarefas"**: `901314121395`

### **Custom Fields Disponíveis:**
- "Tarefas" (checkbox): `da8c38f6-87d9-4953-bff6-2618908bf36f`

## Comandos MCP Necessários por Funcionalidade

### **Core Commands (Testados ✅):**
- `create_task` - Criação de tasks
- `update_task` - Atualização de status/conteúdo
- `create_task_comment` - Comentários
- `delete_task` - Limpeza/testes
- `get_task` - Recuperação de tasks

### **Commands Adicionais (A Testar):**
- `get_workspace_hierarchy` ✅ - Mapeamento de estrutura
- `move_task` - Mover entre lists se necessário
- `get_task_comments` - Recuperar discussões
- `update_task` com custom_fields - Metadados específicos

## Melhorias Possíveis com ClickUp

### **Funcionalidades Superior ao Linear:**
1. **Hierarquia Complexa**: Task → Subtask → Sub-subtask
2. **Time Tracking Integrado**: Estimativas e tracking automático  
3. **Views Múltiplas**: Board, List, Gantt, Calendar
4. **Automações**: Triggers baseados em status/assignee
5. **Custom Fields Ricos**: Dropdowns, datas, números, etc.
6. **Attachments**: Arquivos diretamente nas tasks
7. **Dependencies**: Relações entre tasks
8. **Goals & Milestones**: Acompanhamento de objetivos

### **Manter Compatibilidade:**
- Todos os workflows atuais devem funcionar identicamente
- IDs devem ser transparentemente substituídos
- Status mapping deve ser perfeito
- Performance deve ser igual ou superior
