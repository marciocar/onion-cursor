# Comando Criar Agente

Você tem a tarefa de criar um novo sub-agente do Cursor baseado nos requisitos do usuário. Siga esta abordagem sistemática para construir um agente bem estruturado.

## Requisitos do Usuário
<requirements>
#$ARGUMENTS
</requirements>

## Processo

### 1. Entender o Propósito do Agente
Primeiro, analise o que o usuário quer que este agente faça:
- Qual é a responsabilidade principal do agente?
- Que tarefas ele executará?
- O que torna este agente especializado?

### 2. Definir Configuração do Agente
Com base nos requisitos, determine:
- **Nome**: Crie um identificador em minúsculas, separado por hífens
- **Descrição**: Escreva uma descrição especializada clara e concisa do propósito do agente
- **Categoria**: Identifique a categoria funcional (Development, Testing, Review, Research, Architecture, Documentation, Product)
- **Modelo**: Selecione `sonnet` (eficiência) ou `opus` (análise complexa)
- **Cor**: Atribua cor baseada na categoria funcional
- **Priority**: Defina prioridade (alta, media, baixa)
- **Ferramentas**: Selecione ferramentas especializadas por categoria
- **Expertise**: Defina tags de especialidade técnica

### 3. Seleção de Ferramentas Especializadas por Categoria

**🔵 DEVELOPMENT AGENTS (blue):**
```yaml
tools: read_file, write, search_replace, MultiEdit, run_terminal_cmd, read_lints, todo_write, codebase_search
```
*Para*: python-developer, react-developer, etc.

**🔷 TESTING AGENTS (cyan):**
```yaml
tools: read_file, write, MultiEdit, run_terminal_cmd, grep, codebase_search, read_lints, list_dir
```
*Para*: test-engineer, test-planner, branch-test-planner

**🟢 REVIEW AGENTS (green):**
```yaml
tools: read_file, codebase_search, grep, read_lints, MultiEdit, todo_write, run_terminal_cmd
```
*Para*: code-reviewer, branch-code-reviewer

**🟣 RESEARCH AGENTS (purple):**
```yaml
tools: read_file, codebase_search, web_search, grep, list_dir, mcp_context7-mcp_resolve-library-id, mcp_context7-mcp_get-library-docs, MultiEdit, todo_write
```
*Para*: research-agent

**🔴 ARCHITECTURE AGENTS (red):**
```yaml
tools: read_file, codebase_search, grep, MultiEdit, todo_write, web_search, list_dir
```
*Para*: metaspec-gate-keeper, branch-metaspec-checker

**🟠 DOCUMENTATION AGENTS (orange):**
```yaml
tools: read_file, write, search_replace, MultiEdit, codebase_search, web_search, grep, list_dir
```
*Para*: documentation-writer

**🟡 PRODUCT AGENTS (yellow):**
```yaml
tools: read_file, write, codebase_search, web_search, todo_write, mcp_clickup-mcp-server_create_task, mcp_clickup-mcp-server_update_task, mcp_clickup-mcp-server_get_task, mcp_clickup-mcp-server_create_task_comment
```
*Para*: product-agent

**Outras ferramentas disponíveis:**
- **Notebooks**: edit_notebook, read_file (para .ipynb)
- **Terminal**: run_terminal_cmd
- **Web**: web_search
- **File operations**: delete_file, glob_file_search
- **MCP Tools**: Várias ferramentas mcp_* para integrações específicas

Selecione o conjunto de ferramentas baseado na categoria funcional do agente. Use acesso mínimo às ferramentas por segurança.

### 4. Projetar o Prompt do Sistema
Crie um prompt do sistema detalhado que:
- Define claramente o papel e expertise do agente
- Fornece instruções passo a passo para completar suas tarefas
- Inclui qualquer restrição ou diretriz
- Especifica requisitos de formato de saída
- Contém exemplos se úteis

### 5. Criar o Arquivo do Agente
Gere o arquivo .md com header YAML padronizado:
```markdown
---
name: [nome-do-agente]
description: [descrição especializada clara e específica do propósito do agente]
model: [sonnet|opus - baseado na complexidade da tarefa]
tools: [ferramentas especializadas por categoria, separadas por vírgulas]
color: [cor baseada na categoria funcional]
priority: [alta|media|baixa - baseado na criticidade]
expertise: ["tag1", "tag2", "tag3"] # Array de especialidades técnicas
---

[Prompt do sistema detalhado com instruções claras]
```

**Template de Header Otimizado:**
```yaml
---
name: example-agent
description: Especialista em [área] que [ação principal]. Use para [casos de uso específicos].
model: sonnet  # ou opus para análise complexa
tools: read_file, write, codebase_search, todo_write  # ferramentas especializadas
color: blue    # baseado na categoria (blue|cyan|green|purple|red|orange|yellow)
priority: alta  # alta|media|baixa
expertise: ["specialty1", "specialty2", "specialty3"]
---
```

IMPORTANTE: a extensão do arquivo deve ser .md, não .yaml

### 6. Implementação
- Crie o arquivo em `.cursor/agents/[nome-do-agente].md`
- Torne o prompt do sistema abrangente mas focado

### 7. Confirmar Criação
Após criar o agente, confirme que o arquivo foi criado com sucesso

## Melhores Práticas Otimizadas

### **📋 Header YAML:**
- **Headers padronizados**: Sempre incluir todos os campos (name, description, model, tools, color, priority, expertise)
- **Descriptions específicas**: Seja claro sobre quando usar o agente
- **Model selection**: `sonnet` para eficiência, `opus` para análise complexa

### **🎨 Categorização:**
- **Sistema de cores lógico**: Use cores baseadas na função (Development=blue, Testing=cyan, etc.)
- **Priority apropriada**: `alta` para agentes críticos, `media`/`baixa` para suporte
- **Expertise tags**: Array de especialidades técnicas para descoberta

### **🛠️ Ferramentas:**
- **Especializadas por categoria**: Use ferramentas apropriadas para o tipo de agente
- **Acesso mínimo**: Apenas ferramentas necessárias por segurança
- **MCP integration**: Inclua ferramentas MCP quando relevante (ClickUp, Context7, etc.)

### **✍️ Prompt do Sistema:**
- **Agentes focados**: Uma responsabilidade principal clara
- **Prompts acionáveis**: Instruções passo-a-passo específicas
- **Exemplos práticos**: Inclua para tarefas complexas
- **Tratamento de erro**: Considere casos extremos
- **Formatos explícitos**: Especifique outputs esperados

### **🔍 Validação:**
- **Teste funcionalidade**: Verifique que o agente funciona como esperado
- **Linting**: Garanta que não há erros no arquivo markdown
- **Consistency**: Mantenha padrão com outros agentes da categoria

Agora, analise os requisitos e comece a criar o agente seguindo este processo.