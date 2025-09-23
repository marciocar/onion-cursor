# 🤖 Referência de Agentes

Este guia documenta todos os agentes especializados disponíveis no sistema `.cursor/`, suas capacidades e quando utilizá-los.

## 📋 Índice de Agentes

- [🔵 Agentes de Desenvolvimento](#-agentes-de-desenvolvimento)
- [🔷 Agentes de Testes](#-agentes-de-testes)
- [🟢 Agentes de Review](#-agentes-de-review)
- [🟣 Agentes de Pesquisa](#-agentes-de-pesquisa)
- [🔴 Agentes de Arquitetura](#-agentes-de-arquitetura)
- [🟠 Agentes de Documentação](#-agentes-de-documentação)
- [🟡 Agentes de Produto](#-agentes-de-produto)
- [⚙️ Como Escolher o Agente Certo](#️-como-escolher-o-agente-certo)

---

## 🔵 Agentes de Desenvolvimento

### **python-developer**
**Modelo**: Sonnet | **Prioridade**: Alta | **Cor**: Blue

**Especialidades**: Python idiomático, AI/ML, backend, performance, type hints

**Quando usar**:
- ✅ Desenvolvimento Python backend
- ✅ APIs REST/GraphQL em Python
- ✅ Projetos de Machine Learning
- ✅ Scripts e automações Python

**Ferramentas disponíveis**: `read_file`, `write`, `search_replace`, `MultiEdit`, `run_terminal_cmd`, `read_lints`, `todo_write`, `codebase_search`

> 📚 **Referência Completa**: Veja todas as ferramentas em detalhes em [tools-reference.md](tools-reference.md)

**Exemplo de uso**:
```bash
# Para desenvolver API Python
@python-developer "Implementar endpoint de autenticação com JWT"

# Para análise de dados
@python-developer "Criar pipeline de análise para dados de vendas"

# Para otimização
@python-developer "Otimizar consultas do banco de dados na função get_users"
```

**Principais recursos**:
- 🐍 Python idiomático e PEP-8 compliant
- 🧪 Testes com pytest e coverage
- 📊 Type hints para melhor IDE support
- ⚡ Performance optimization patterns
- 🤖 AI/ML com bibliotecas populares
- 📦 Gerenciamento com `uv` (package manager moderno)

### **react-developer**
**Modelo**: Sonnet | **Prioridade**: Alta | **Cor**: Blue

**Especialidades**: React moderno, shadcn/ui, TypeScript, acessibilidade, performance

**Quando usar**:
- ✅ Componentes React/Next.js
- ✅ Frontend TypeScript
- ✅ Design systems com shadcn/ui
- ✅ Otimização de performance frontend

**Principais recursos**:
- ⚛️ React hooks e patterns modernos
- 🎨 shadcn/ui component library
- 📝 TypeScript com tipagem estrita
- ♿ Acessibilidade (a11y) built-in
- ⚡ Performance optimization
- 🧪 Testing com React Testing Library

### **clickup-specialist**
**Modelo**: Sonnet | **Prioridade**: Alta | **Cor**: Orange

**Especialidades**: ClickUp MCP técnico, automações avançadas, performance, workflows

**Quando usar**:
- ✅ Otimizações técnicas do ClickUp
- ✅ Automações de workflow complexas
- ✅ Bulk operations e performance
- ✅ Configurações avançadas (webhooks, custom fields)
- ✅ Time tracking e análise de produtividade

**Ferramentas disponíveis**: `read_file`, `write`, `MultiEdit`, `run_terminal_cmd`, `codebase_search`, `web_search`, **todas as 15+ ferramentas ClickUp MCP** (bulk operations, webhooks, time tracking, etc.)

**Exemplo de uso**:
```bash
# Para automações de workflow
@clickup-specialist "Configurar automação: task 'in progress' → start time tracking + add tag 'development'"

# Para operações em bulk
@clickup-specialist "Criar 20 tasks de feature seguindo template padrão com bulk operations"

# Para configurações avançadas
@clickup-specialist "Setup webhook para sync status ClickUp → GitHub quando PR é criado"
```

**Principais recursos**:
- 🚀 **Performance First**: Bulk operations para eficiência máxima
- 🤖 **Workflow Automation**: Automações baseadas em triggers inteligentes
- ⚡ **Rate Limit Management**: Otimização respeitando limites da API
- 🔧 **Advanced Configuration**: Custom fields, templates, webhooks
- 📊 **Time Tracking Integration**: Automação de tracking e análise de produtividade
- 🎯 **Complementa product-agent**: Foco técnico vs estratégico

**Complementaridade**:
- **product-agent**: Estratégia, coordenação, especificação (O QUE fazer)
- **clickup-specialist**: Implementação técnica, automação, performance (COMO otimizar)

---

## 🔷 Agentes de Testes

### **test-engineer**
**Modelo**: Sonnet | **Prioridade**: Média | **Cor**: Cyan

**Especialidades**: Unit testing com Jest/Vitest, behavior verification, qualidade

**Quando usar**:
- ✅ Escrever testes unitários
- ✅ Verificar comportamento de código
- ✅ Identificar gaps de cobertura
- ✅ Validar funcionalidade sem modificar implementação

**Ferramentas disponíveis**: `read_file`, `write`, `MultiEdit`, `run_terminal_cmd`, `grep`, `codebase_search`, `read_lints`, `todo_write`

**Exemplo de uso**:
```bash
@test-engineer "Criar testes para a função de validação de email"
@test-engineer "Verificar cobertura dos endpoints de autenticação"
```

**Características únicas**:
- 🧪 Testes práticos focados em comportamento
- 🚫 **NÃO modifica implementação** - apenas testa
- 📊 Identifica gaps e os reporta ao agente principal
- ⚡ Jest/Vitest com mocks apropriados
- 💡 Sugestões para melhorar testabilidade

### **test-planner**
**Modelo**: Sonnet | **Prioridade**: Média | **Cor**: Cyan

**Especialidades**: Planejamento de testes, análise de cobertura, estratégia de testes

**Quando usar**:
- ✅ Planejar estratégia de testes para projeto
- ✅ Análise de cobertura de teste existente
- ✅ Identificar áreas críticas para teste
- ✅ Criar planos de teste abrangentes

---

## 🟢 Agentes de Review

### **code-reviewer**
**Modelo**: Opus | **Prioridade**: Alta | **Cor**: Green

**Especialidades**: Code review, melhores práticas, detecção de bugs, manutenibilidade

**Quando usar**:
- ✅ Review de código antes de PR
- ✅ Análise de qualidade geral
- ✅ Identificação de padrões problemáticos
- ✅ Sugestões de melhoria

**Ferramentas disponíveis**: `read_file`, `codebase_search`, `grep`, `read_lints`, `MultiEdit`, `todo_write`, `run_terminal_cmd`

**Exemplo de uso**:
```bash
@code-reviewer "Revisar implementação do sistema de cache"
@code-reviewer "Analisar security patterns no módulo de auth"
```

**Prioridades de review**:
1. 🎯 **Correção** - Funciona para o caso de uso?
2. 🔒 **Segurança** - Vulnerabilidades óbvias?
3. ⚡ **Performance** - Gargalos evidentes?
4. 🔧 **Manutenibilidade** - Fácil de entender/modificar?
5. 📖 **Clareza** - Bem documentado?

---

## 🟣 Agentes de Pesquisa

### **research-agent**
**Modelo**: Sonnet | **Prioridade**: Alta | **Cor**: Purple

**Especialidades**: Pesquisa multi-fonte, web search, Context7, análise semântica

**Quando usar**:
- ✅ Pesquisar tecnologias e bibliotecas
- ✅ Investigar melhores práticas
- ✅ Análise de concorrentes
- ✅ Documentação de bibliotecas específicas

**Ferramentas disponíveis**: `read_file`, `codebase_search`, `web_search`, `grep`, `list_dir`, `mcp_context7-mcp_resolve-library-id`, `mcp_context7-mcp_get-library-docs`, `MultiEdit`, `todo_write`

**Exemplo de uso**:
```bash
@research-agent "Pesquisar melhores práticas para autenticação OAuth2 em 2024"
@research-agent "Comparar React Query vs SWR para data fetching"
@research-agent "Encontrar documentação atualizada para biblioteca X"
```

**Metodologia única**:
- 🔍 **Busca multi-fonte**: Web + Context7 + análise semântica
- 📊 **Insights acionáveis**: Não apenas informação, mas recomendações
- 🎯 **Evidência-baseada**: Toda claim apoiada por fontes
- 🔄 **Múltiplas perspectivas**: Considera diferentes abordagens

---

## 🔴 Agentes de Arquitetura

### **metaspec-gate-keeper**
**Modelo**: Opus | **Prioridade**: Alta | **Cor**: Red

**Especialidades**: Integridade arquitetural, metaspecs, design principles, validação

**Quando usar**:
- ✅ Validar alinhamento com metaspecs
- ✅ Review de decisões arquiteturais
- ✅ Garantir consistência de design
- ✅ Aprovação/rejeição de mudanças estruturais

**Ferramentas disponíveis**: `read_file`, `codebase_search`, `grep`, `MultiEdit`, `todo_write`, `web_search`

**Exemplo de uso**:
```bash
@metaspec-gate-keeper "Validar se nova arquitetura de microsserviços alinha com metaspecs"
@metaspec-gate-keeper "Revisar decisão de usar GraphQL vs REST"
```

**Responsabilidades**:
- 📋 Interpreta metaspecs do projeto
- ✅ Valida alinhamento de propostas
- 🚨 Identifica desvios críticos
- 💡 Orienta decisões arquiteturais
- 📝 Propõe atualizações de metaspecs

---

## 🟠 Agentes de Documentação

### **documentation-writer**
**Modelo**: Sonnet | **Prioridade**: Média | **Cor**: Orange

**Especialidades**: Documentação técnica, análise de mudanças, sincronização docs-código

**Quando usar**:
- ✅ Atualizar docs após mudanças de código
- ✅ Criar documentação nova
- ✅ Sincronizar docs com estado atual
- ✅ Análise de gaps de documentação

**Ferramentas disponíveis**: `read_file`, `write`, `search_replace`, `MultiEdit`, `codebase_search`, `web_search`, `grep`, `list_dir`

**Exemplo de uso**:
```bash
@documentation-writer "Atualizar docs após mudanças na API de usuários"
@documentation-writer "Criar guia de setup para novo desenvolvedor"
```

---

## 🟡 Agentes de Produto

### **product-agent**
**Modelo**: Opus | **Prioridade**: Alta | **Cor**: Yellow

**Especialidades**: Gestão de produto, ClickUp integration, estratégia, coordenação

**Quando usar**:
- ✅ Criação e refinamento de tasks
- ✅ Coordenação com ClickUp
- ✅ Análise de requisitos
- ✅ Gestão de roadmap

**Ferramentas disponíveis**: `read_file`, `write`, `codebase_search`, `web_search`, `todo_write`, `mcp_clickup-mcp-server_create_task`, `mcp_clickup-mcp-server_update_task`, `mcp_clickup-mcp-server_get_task`, `mcp_clickup-mcp-server_create_task_comment`

**Integração ClickUp**:
- ✅ Cria tasks estruturadas
- ✅ Atualiza status e progresso  
- ✅ Adiciona comentários contextuais
- ✅ Gerencia tags e prioridades

### **clickup-specialist**
**Modelo**: Sonnet | **Prioridade**: Alta | **Cor**: Orange

**Especialidades**: ClickUp MCP técnico, automações avançadas, performance, workflows

**Quando usar**:
- ✅ Otimizações técnicas do ClickUp (bulk operations, rate limiting)
- ✅ Automações de workflow complexas (triggers, status changes)
- ✅ Performance optimization (batching, caching, query optimization)
- ✅ Configurações avançadas (webhooks, custom fields, templates)
- ✅ Time tracking automation e análise de produtividade
- ✅ Integração com comandos `/engineer/*` para automação

**Ferramentas disponíveis**: `read_file`, `write`, `MultiEdit`, `run_terminal_cmd`, `codebase_search`, `web_search`, **todas as 15+ ferramentas ClickUp MCP**

**Exemplo de uso**:
```bash
# Automações de workflow
@clickup-specialist "Configurar automação: task 'in progress' → start time tracking + add tag 'development'"

# Operações em bulk
@clickup-specialist "Criar 20 tasks em lote com template feature e assignees automáticos"

# Performance optimization  
@clickup-specialist "Otimizar queries ClickUp usando filtros server-side e batching"
```

**Características únicas**:
- 🚀 **Complementa product-agent**: Técnico vs Estratégico
- ⚡ **Performance first**: Bulk operations, rate limiting, query optimization
- 🔧 **Automação avançada**: Workflows inteligentes, triggers, status automation
- 📊 **15+ ferramentas ClickUp MCP**: Cobertura completa da API ClickUp
- 🎯 **7 especialidades técnicas**: workflow-automation, performance-optimization, webhooks

### **cursor-specialist**
**Modelo**: Sonnet | **Prioridade**: Alta | **Cor**: Light Blue

**Especialidades**: Otimização Cursor IDE, configuração workspace, troubleshooting, produtividade

**Quando usar**:
- ✅ Resolver problemas de performance do Cursor IDE
- ✅ Configurar ambiente para novos projetos
- ✅ Otimizar settings para workflows específicos
- ✅ Troubleshoot extension conflicts ou API connectivity
- ✅ Criar `.cursorrules` e `.cursorignore` templates
- ✅ Setup automation para comandos `/engineer/*`

**Ferramentas disponíveis**: `read_file`, `write`, `MultiEdit`, `run_terminal_cmd`, `codebase_search`, `list_dir`, `glob_file_search`, `web_search`, `read_lints`, `todo_write`

**Exemplo de uso**:
```bash
# Configuração de projeto novo
@cursor-specialist "Setup otimizado para projeto React TypeScript com foco em AI development"

# Troubleshooting
@cursor-specialist "Resolver erro 'HTTP/2 blocked by proxy' e otimizar connectivity"

# Performance Issues
@cursor-specialist "Cursor está lento, analisar memory usage e otimizar configurations"
```

**Características únicas**:
- 🎯 **7 especialidades técnicas**: configuration, workspace, extensions, API, performance, productivity, troubleshooting
- 🚀 **Integração automática**: Chamado automaticamente por outros agentes quando há problemas de IDE
- 🔧 **Criação de artefatos**: `.cursorrules`, `.cursorignore`, workspace settings otimizados
- ⚡ **Performance focus**: Memory optimization, startup time, context caching
- 🔗 **Delegation automática**: Integração com comandos `/engineer/*` para setup de ambiente

### **gitflow-specialist**
**Modelo**: Sonnet | **Prioridade**: Alta | **Cor**: Light Green

**Especialidades**: GitFlow workflows, branch management, release processes, team collaboration, semantic versioning

**Quando usar**:
- ✅ Setup inicial de repositórios GitFlow
- ✅ Guidance para workflows de feature development
- ✅ Processos de release estruturados
- ✅ Emergency hotfix workflows
- ✅ Migração master → main em projetos GitFlow
- ✅ Resolução de conflitos GitFlow complexos
- ✅ Onboarding de equipes em GitFlow
- ✅ Otimização de workflows colaborativos

**Ferramentas disponíveis**: `read_file`, `write`, `MultiEdit`, `run_terminal_cmd`, `codebase_search`, `grep`, `web_search`, `todo_write`

**Exemplo de uso**:
```bash
# Para setup inicial
@gitflow-specialist "Configurar GitFlow em repositório novo com detecção automática master/main"

# Para workflows
@gitflow-specialist "Orientar equipe no processo de release v2.1.0 com semantic versioning"

# Para emergências
@gitflow-specialist "Hotfix crítico em produção - orientar processo completo"

# Para migração
@gitflow-specialist "Migrar repositório de master para main mantendo GitFlow ativo"
```

**Características únicas**:
- 🌿 **Flexibilidade master/main**: Detecção automática e suporte a ambas convenções
- 🎯 **Guidance-focused**: Ensina e orienta ao invés de automatizar
- 📚 **6 Templates completos**: Setup, feature, release, hotfix, migration, conflicts
- 🧠 **Semantic versioning**: Conventional commits + análise automática de versioning
- 👥 **Team enablement**: Onboarding em 3 níveis (iniciante, intermediário, avançado)
- 📊 **Analytics integration**: Métricas de equipe e health checks
- 🔗 **Complementaridade**: Integração perfeita com @mermaid-specialist (workflows vs diagramas)

### **nodejs-specialist**
**Modelo**: Sonnet | **Prioridade**: Alta | **Cor**: Teal

**Especialidades**: Backend JavaScript/TypeScript, Node.js runtime, PNPM ecosystem, performance optimization

**Quando usar**:
- ✅ APIs REST/GraphQL complexas com Node.js
- ✅ Configurações TypeScript para backend
- ✅ Performance optimization Node.js (memory, clustering, profiling)
- ✅ Migração/configuração PNPM ecosystem
- ✅ Implementação de security best practices
- ✅ Testing strategies (Jest/Vitest, integration, E2E)
- ✅ Microserviços e arquiteturas escaláveis

**Ferramentas disponíveis**: `read_file`, `write`, `MultiEdit`, `run_terminal_cmd`, `codebase_search`, `read_lints`, `todo_write`, `web_search`

**Exemplo de uso**:
```bash
# Para APIs performantes
@nodejs-specialist "Criar API Fastify com autenticação JWT, rate limiting e TypeScript strict"

# Para otimização de performance  
@nodejs-specialist "API com latência >500ms - analisar bottlenecks e otimizar com profiling"

# Para configuração PNPM
@nodejs-specialist "Migrar projeto de NPM para PNPM com workspace configuration"
```

**Características únicas**:
- 🟢 **Stack JavaScript completa**: Complementa react-developer para full-stack JS/TS
- ⚡ **Performance-first**: Fastify, clustering, caching, connection pooling  
- 📦 **PNPM expertise**: Modern package management, workspaces, overrides
- 🔒 **Security by design**: JWT, rate limiting, input validation, helmet.js
- 🧪 **Modern testing**: Vitest preferred, supertest integration, coverage thresholds
- 🔍 **Profiling tools**: clinic.js, memory leak detection, event loop monitoring
- 🏗️ **Architecture patterns**: Layered design, dependency injection, microservices

### **gitflow-specialist**
**Modelo**: Sonnet | **Prioridade**: Alta | **Cor**: Light Green

**Especialidades**: GitFlow workflows, branch management, release processes, team collaboration, semantic versioning

**Quando usar**:
- ✅ Setup inicial de repositórios GitFlow
- ✅ Guidance para workflows de feature development
- ✅ Processos de release estruturados
- ✅ Emergency hotfix workflows
- ✅ Migração master → main em projetos GitFlow
- ✅ Resolução de conflitos GitFlow complexos
- ✅ Onboarding de equipes em GitFlow
- ✅ Otimização de workflows colaborativos

**Ferramentas disponíveis**: `read_file`, `write`, `MultiEdit`, `run_terminal_cmd`, `codebase_search`, `grep`, `web_search`, `todo_write`

**Exemplo de uso**:
```bash
# Para setup inicial
@gitflow-specialist "Configurar GitFlow em repositório novo com detecção automática master/main"

# Para workflows
@gitflow-specialist "Orientar equipe no processo de release v2.1.0 com semantic versioning"

# Para emergências
@gitflow-specialist "Hotfix crítico em produção - orientar processo completo"

# Para migração
@gitflow-specialist "Migrar repositório de master para main mantendo GitFlow ativo"
```

**Características únicas**:
- 🌿 **Flexibilidade master/main**: Detecção automática e suporte a ambas convenções
- 🎯 **Guidance-focused**: Ensina e orienta ao invés de automatizar
- 📚 **6 Templates completos**: Setup, feature, release, hotfix, migration, conflicts
- 🧠 **Semantic versioning**: Conventional commits + análise automática de versioning
- 👥 **Team enablement**: Onboarding em 3 níveis (iniciante, intermediário, avançado)
- 📊 **Analytics integration**: Métricas de equipe e health checks
- 🔗 **Complementaridade**: Integração perfeita com @mermaid-specialist (workflows vs diagramas)

---

## ⚙️ Como Escolher o Agente Certo

### **Por Tipo de Tarefa**

#### **🔧 Desenvolvimento**
```bash
# Python backend
@python-developer "implementar API REST"

# Frontend React
@react-developer "criar componente de dashboard"

# Full-stack (coordenação automática)
/engineer/work "sistema completo de notificações"
```

#### **🧪 Testes**
```bash
# Testes específicos
@test-engineer "testar função de validação de CPF"

# Estratégia de testes
@test-planner "planejar cobertura de testes para módulo auth"
```

#### **🔍 Review**
```bash
# Code review geral
@code-reviewer "revisar implementação de cache Redis"

# Validação arquitetural  
@metaspec-gate-keeper "validar uso de microservices"
```

#### **📚 Pesquisa & Docs**
```bash
# Pesquisa tecnológica
@research-agent "comparar Next.js vs Remix para SSR"

# Documentação
@documentation-writer "atualizar docs da API v2"
```

#### **📋 Produto**
```bash
# Gestão de produto
@product-agent "refinar requisitos da feature de chat"
```

### **Por Complexidade**

#### **🟢 Tarefa Simples** (1 agente)
```bash
@test-engineer "adicionar testes para função validateEmail"
```

#### **🟡 Tarefa Média** (2-3 agentes sequenciais)
```bash
# Sequência típica:
@research-agent "pesquisar padrões OAuth2" 
→ @python-developer "implementar OAuth2"
→ @test-engineer "testar fluxo OAuth2"
```

#### **🔴 Tarefa Complexa** (múltiplos agentes paralelos)
```bash
/engineer/work "sistema completo de e-commerce"
# → Coordenação automática de múltiplos agentes
```

### **Por Prioridade do Modelo**

#### **🚀 Sonnet (Eficiência)**
- `python-developer`, `react-developer`, `test-engineer`, `research-agent`
- ✅ Tarefas de implementação diretas
- ✅ Testes e validações
- ✅ Pesquisa e documentação

#### **🎯 Opus (Análise Complexa)**
- `code-reviewer`, `metaspec-gate-keeper`, `product-agent`
- ✅ Decisões arquiteturais críticas
- ✅ Reviews complexos
- ✅ Coordenação de produto

### **Padrões de Delegação Automática**

O sistema escolhe agentes automaticamente baseado em:

#### **Análise de Contexto**
```python
# Exemplo interno (não visível ao usuário)
if task.contains("test") or task.contains("spec"):
    delegate_to("test-engineer")
elif task.contains("react") or task.contains("frontend"):  
    delegate_to("react-developer")
elif task.contains("review") or task.contains("quality"):
    delegate_to("code-reviewer")
```

#### **Coordenação Multi-Agente**
```mermaid
graph TD
    A[Task Complexa] --> B[Análise de Requisitos]
    B --> C{Múltiplos Domínios?}
    C -->|Sim| D[Coordenador Principal]
    C -->|Não| E[Agente Especializado]
    D --> F[python-developer]
    D --> G[react-developer]  
    D --> H[test-engineer]
    F --> I[Sincronização]
    G --> I
    H --> I
    I --> J[Resultado Final]
```

---

## 📊 Métricas dos Agentes

### **Performance por Agente**
| Agente | Tempo Médio | Taxa Sucesso | Uso Frequente |
|---------|-------------|--------------|---------------|
| `python-developer` | 45min | 94% | 35% |
| `react-developer` | 52min | 91% | 28% |
| `test-engineer` | 28min | 96% | 15% |
| `code-reviewer` | 15min | 89% | 12% |
| `research-agent` | 22min | 92% | 8% |
| `product-agent` | 35min | 87% | 2% |

### **Combinações Eficazes**
1. **Feature Development**: `product-agent` → `python-developer` → `test-engineer` → `code-reviewer`
2. **Bug Fix**: `research-agent` → `python-developer` → `test-engineer`  
3. **Refactoring**: `code-reviewer` → `metaspec-gate-keeper` → `python-developer`

### **Especialização vs Generalização**

#### **🎯 Alta Especialização**
- `test-engineer`: Foco exclusivo em testes
- `metaspec-gate-keeper`: Validação arquitetural apenas
- `documentation-writer`: Só documentação

#### **🔄 Especialização Média**
- `python-developer`: Python + relacionados (APIs, ML)
- `react-developer`: React + ecosistema frontend
- `research-agent`: Pesquisa + análise

#### **🌐 Mais Generalista**
- `code-reviewer`: Qualquer linguagem/framework
- `product-agent`: Gestão geral de produto

---

## 💡 Melhores Práticas

### **Para Máxima Eficiência**
1. ✅ **Use agentes específicos** para tarefas claras
2. ✅ **Deixe o sistema coordenar** tarefas complexas
3. ✅ **Combine sequencialmente** para workflows
4. ✅ **Monitore resultados** para ajustar delegação

### **Para Qualidade**
1. 🔍 **Sempre use code-reviewer** antes de PRs importantes
2. 🏗️ **Valide com metaspec-gate-keeper** mudanças arquiteturais
3. 🧪 **Inclua test-engineer** em features críticas
4. 📚 **Use documentation-writer** para manter docs sincronizados

### **Para Produtividade**
1. ⚡ **Delegação automática** para workflows conhecidos
2. 🎯 **Agentes especializados** para tarefas específicas
3. 🔄 **Reutilize padrões** de combinação que funcionam
4. 📊 **Monitore métricas** para otimização contínua

---

**Próximo**: [Getting Started →](getting-started.md)
