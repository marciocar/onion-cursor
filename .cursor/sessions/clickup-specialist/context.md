# Context: ClickUp Specialist Agent

## 🎯 **Por que isso está sendo construído (Contexto)**

### Problema Identificado
O Sistema Onion atual possui **12 agentes especializados** que cobrem desenvolvimento, testes, review, pesquisa, arquitetura, documentação e produto. No entanto, existe uma lacuna crítica na **especialização técnica em ClickUp MCP**.

### Gap Atual
- **product-agent** (Opus): Focado em gestão estratégica de produto e coordenação de equipes
- **Ferramentas ClickUp limitadas**: Apenas básicas (create_task, update_task, get_task, create_task_comment)
- **Falta especialista técnico**: Configurações avançadas, automações, webhooks, otimização de performance

### Justificativa
Sistema Onion está **100% integrado com ClickUp** como core do workflow. Um especialista técnico específico para ClickUp MCP irá:
1. **Complementar o product-agent** com foco técnico vs estratégico
2. **Especializar-se em automações** e configurações avançadas
3. **Otimizar performance** das integrações ClickUp API
4. **Gerenciar webhooks** e notificações complexas

## 🎯 **Resultado Esperado (Objetivo)**

### Agente Especializado
Criar **ClickUp Specialist Agent** com as seguintes características:

**Arquivo Principal**: `.cursor/agents/development/clickup-specialist.md`

**Especialidades Técnicas**:
- Configuração avançada de ClickUp MCP
- Automações de workflow complexas
- Gerenciamento de campos customizados e templates
- Configuração de webhooks e notificações
- Otimização de performance de queries ClickUp API

**Integração com Sistema Onion**:
- **Complementa** product-agent (não compete)
- **Integra** com comandos `/product/*` existentes
- **Suporta** automações dos comandos `/engineer/*`

### Deliverables Específicos
1. **Arquivo do agente**: `.cursor/agents/development/clickup-specialist.md`
2. **Documentação atualizada**: Seção em `docs/onion/agents-reference.md`
3. **Exemplos práticos**: Automações e configurações
4. **Integração funcional**: Delegação automática baseada em contexto

## 🛠️ **Como deve ser construído (Abordagem)**

### Padrão Identificado dos Agentes Existentes

**Estrutura YAML Header**:
```yaml
---
name: clickup-specialist
description: [descrição clara da especialidade]
model: sonnet  # Eficiência para operações ClickUp
tools: [lista de ferramentas específicas]
color: [cor única]
priority: alta
expertise: [array de especialidades técnicas]
---
```

**Conteúdo Markdown**:
1. **Filosofia/Abordagem**: Como o agente pensa
2. **Áreas de Foco**: Especialidades técnicas específicas
3. **Metodologia**: Como executa as tarefas
4. **Ferramentas/Comandos**: Integração com ClickUp MCP
5. **Padrões de Qualidade**: Standards e melhores práticas

### Modelo de Referência
- **python-developer**: Estrutura técnica clara, ferramentas específicas
- **research-agent**: Metodologia detalhada, filosofia bem definida
- **product-agent**: Integração ClickUp, responsabilidades claras

## 🔗 **APIs e Ferramentas Necessárias**

### ClickUp MCP Tools (Confirmadas)
```
mcp_clickup-mcp-server_create_task
mcp_clickup-mcp-server_update_task  
mcp_clickup-mcp-server_get_task
mcp_clickup-mcp-server_create_task_comment
mcp_clickup-mcp-server_get_workspace_hierarchy
mcp_clickup-mcp-server_get_space_tags
mcp_clickup-mcp-server_add_tag_to_task
mcp_clickup-mcp-server_remove_tag_from_task
mcp_clickup-mcp-server_move_task
mcp_clickup-mcp-server_duplicate_task
mcp_clickup-mcp-server_delete_task
```

### Ferramentas Base do Sistema
```
read_file, write, MultiEdit, run_terminal_cmd
codebase_search, web_search, todo_write
```

### ClickUp API v2 (Conhecimento)
- Rate limits e otimização
- Webhooks configuration
- Custom fields management
- Automation triggers
- Bulk operations

## 🧪 **Como deve ser testado**

### Testes de Integração
1. **Delegação automática**: Comandos `/product/*` devem identificar e usar o agente
2. **Não conflito**: Deve complementar product-agent, não competir
3. **Ferramentas ClickUp**: Todas as tools ClickUp MCP devem funcionar
4. **Performance**: Queries otimizadas não devem impactar tempo de resposta

### Testes Funcionais
1. **Automações**: Criar workflows complexos funcionais
2. **Webhooks**: Configurar notificações personalizadas
3. **Campos customizados**: Gerenciar templates e configurações
4. **Bulk operations**: Otimizar operações em lote

### Validação de Qualidade
1. **Documentação**: Exemplos práticos e casos de uso
2. **Integração**: Funciona dentro do fluxo atual do Sistema Onion
3. **Especializacao**: Nicho bem definido sem overlap

## 🔄 **Dependências**

### Técnicas
- **ClickUp MCP configurado** e funcionando
- **Sistema Onion atual** operacional
- **Variáveis de ambiente** ClickUp configuradas
- **Ferramentas ClickUp MCP** acessíveis

### De Processo
- **Padrão de agentes** do Sistema Onion seguido
- **Documentação principal** atualizada
- **Integração com comandos** existentes
- **Testes de validação** executados

## ⚠️ **Restrições**

### Arquiteturais
- **Deve seguir padrão** dos agentes existentes (YAML + Markdown)
- **Não pode duplicar** funcionalidades do product-agent
- **Deve ser complementar**, não competitivo
- **Performance** não pode ser impactada

### De Integração
- **Comandos existentes** devem continuar funcionando
- **Delegação automática** deve reconhecer o novo agente
- **ClickUp MCP** deve permanecer funcional
- **Workflow atual** não pode ser quebrado

## 🚀 **Impacto Esperado**

### Imediato
- **Especialização técnica** em ClickUp MCP
- **Automações avançadas** disponíveis
- **Performance otimizada** das integrações
- **Configurações complexas** simplificadas

### Longo Prazo
- **Sistema Onion mais robusto** com especialização completa
- **Produtividade aumentada** com automações
- **Manutenção simplificada** de integrações ClickUp
- **Base sólida** para expansões futuras do sistema

---

## 📝 **Confirmações Necessárias**

1. **Estrutura do agente** segue o padrão correto identificado?
2. **Complementaridade** com product-agent está clara?
3. **Ferramentas ClickUp MCP** são suficientes?
4. **Integração com comandos** `/product/*` está bem definida?
5. **Testes de validação** cobrem todos os casos críticos?
