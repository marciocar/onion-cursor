# Contexto: Migração Linear → ClickUp MCP

## Visão Geral
Migrar todas as referências do sistema Linear para ClickUp MCP no sistema .cursor/, mantendo funcionalidade equivalente ou superior.

## Objetivos
- **Primário**: Substituir todas as referências e integrações do Linear pelo ClickUp MCP
- **Secundário**: Aproveitar funcionalidades superiores do ClickUp (hierarquia, automação, etc.)
- **Qualidade**: Manter 100% da funcionalidade existente

## Análise do Sistema Atual

### Arquivos com Referências ao Linear (8 arquivos identificados):

#### 1. **Commands - Engineer (2 arquivos)**
- `.cursor/commands/engineer/start.md` → Recebe cards do Linear para trabalhar
- `.cursor/commands/engineer/pr.md` → Move cards Linear para "In Review"

#### 2. **Commands - Product (4 arquivos)**  
- `.cursor/commands/product/task.md` → Cria issues no Linear
- `.cursor/commands/product/collect.md` → Salva issues no Linear
- `.cursor/commands/product/refine.md` → Atualiza issues Linear
- `.cursor/commands/product/light-arch.md` → Edita cards Linear

#### 3. **Commands - Docs (1 arquivo)**
- `.cursor/commands/docs/build-index.md` → IDs de projeto e time Linear

#### 4. **Agents (1 arquivo)**
- `.cursor/agents/product-agent.md` → Configuração completa do Linear (hierarchy, IDs, etc.)

## Funcionalidades do Linear Utilizadas

### **Gestão de Tarefas**
- Criação de issues/cards
- Movimentação de status (ex: "In Review")  
- Edição e comentários em cards
- Associação com projects e teams

### **Estrutura Hierárquica**
- Projects (projetos dos clientes)
- Milestones (entregas importantes)
- Tasks/Issues (tarefas individuais)
- Team ID: `ecc554d0-1394-4a56-b524-ac4c1b36c5f4`

### **Integração com Desenvolvimento**
- Branches por feature associadas a tarefas
- Workflow PR + Linear card status
- Documentação de arquitetura em cards

## ClickUp MCP - Funcionalidades Equivalentes

### **Vantagens do ClickUp sobre Linear**
1. **Hierarquia mais rica**: Workspace → Space → Folder → List → Task → Subtask
2. **Automação avançada**: Triggers e templates
3. **Custom fields**: Metadados flexíveis
4. **Time tracking**: Integrado nativamente
5. **Views múltiplas**: Board, List, Gantt, etc.

### **Mapeamento Linear → ClickUp**
- **Linear Projects** → **ClickUp Spaces**
- **Linear Milestones** → **ClickUp Folders/Lists**  
- **Linear Tasks** → **ClickUp Tasks**
- **Linear Team** → **ClickUp Workspace**
- **Linear Status** → **ClickUp Status**

## Restrições
- **Manter compatibilidade**: Comandos devem funcionar igual ou melhor
- **Preservar workflow**: Engineer start → work → pr deve funcionar
- **Documentação**: Todas as mudanças devem ser documentadas

## Dependências Técnicas
- ClickUp MCP deve estar instalado e configurado
- Necessário workspace/space/list IDs do ClickUp
- API tokens e permissões configuradas
- Testes de todos os comandos após migração

## Critérios de Sucesso
1. **Funcionalidade**: Todos os comandos funcionam com ClickUp
2. **Performance**: Igual ou superior ao Linear
3. **UX**: Interface intuitiva para desenvolvedores  
4. **Documentação**: Sistema bem documentado
5. **Testes**: Validação completa do fluxo de trabalho
