# 🧅 Sistema Onion

[![Comandos](https://img.shields.io/badge/Comandos-28-blue)](docs/onion/commands-guide.md) [![Agentes](https://img.shields.io/badge/Agentes-17-green)](docs/onion/agents-reference.md) [![ClickUp](https://img.shields.io/badge/ClickUp-Integrado-orange)](docs/onion/clickup-integration.md)

## 🎯 Visão Geral

Bem-vindo ao **Sistema Onion**! Framework avançado de comandos `.cursor/` que revoluciona o desenvolvimento com:

- 🤖 **28 comandos especializados** organizados por categoria
- 🎯 **17 agentes de IA especializados** para tarefas específicas  
- 🔗 **Integração completa com ClickUp MCP** para gestão automática de projetos
- ⚡ **Workflows automatizados** do planejamento ao deploy

Documentação completa disponível em [`docs/onion/`](docs/onion/) para dominar todos os comandos, agentes e fluxos de trabalho.

## 📖 Guias Disponíveis

### 🎯 Guias Principais
- **[Guia de Comandos](docs/onion/commands-guide.md)** - Documentação completa de todos os comandos disponíveis
- **[Fluxos de Engenharia](docs/onion/engineering-flows.md)** - Workflows detalhados para desenvolvimento
- **[Integração ClickUp](docs/onion/clickup-integration.md)** - Como integrar comandos com ClickUp MCP

### 🛠️ Referências Técnicas
- **[Agentes Disponíveis](docs/onion/agents-reference.md)** - Lista e descrição de todos os agentes especializados
- **[Exemplos Práticos](docs/onion/practical-examples.md)** - Casos de uso reais com exemplos

### 🚀 Início Rápido
- **[Configuração Inicial](docs/onion/getting-started.md)** - Como configurar e começar a usar o sistema

## 🎯 Navegação Rápida

### 📂 Por Categoria de Comando
- **🔧 Engenharia**: `engineer/start`, `engineer/work`, `engineer/pr`, `engineer/pre-pr`, `engineer/plan`, `engineer/docs`
- **📋 Produto**: `product/task`, `product/spec`, `product/collect`, `product/refine`, `product/light-arch`, `product/task-check`  
- **📚 Documentação**: `docs/build-tech-docs`, `docs/build-business-docs`, `docs/build-index`
- **🌿 Git**: `git/sync`
- **⚙️ Meta**: `meta/all-tools`, `meta/create-agent`
- **🚀 Utilitários**: `warm-up`, `engineer/warm-up`, `product/warm-up`

### 🔄 Por Fluxo de Trabalho
1. **Planejamento** → `/product/task` → `/product/spec`
2. **Desenvolvimento** → `/engineer/start` → `/engineer/work` → `/engineer/pr`
3. **Sincronização** → `/git/sync`
4. **Documentação** → `/docs/build-*`

## 🚀 Início Rápido

### 🎯 Primeiro Uso - Workflow Completo
```bash
# 1. Criar nova task com especificações
/product/task "Implementar autenticação de usuário"

# 2. Iniciar desenvolvimento (cria branch, sessão)
/engineer/start

# 3. Trabalhar na funcionalidade (development loop)
/engineer/work

# 4. Criar Pull Request (testes, build, PR)  
/engineer/pr

# 5. Sincronizar após merge (cleanup, ClickUp update)
/git/sync
```

### 🔧 Comandos Essenciais
- **`/meta/all-tools`** - Lista todos os comandos disponíveis
- **`@agent-name`** - Invoca agente especializado específico
- **`/product/task`** - Gerencia tasks e planejamento
- **`/engineer/*`** - Workflows de desenvolvimento

## 🔗 Integração ClickUp

O Sistema Onion oferece **integração nativa e bidirecional** com ClickUp através do ClickUp MCP:

### ⚡ Automações Principais
- **🎯 Gestão Inteligente de Tasks**: Criação, atualização e sincronização automática
- **📊 Status em Tempo Real**: Atualizações automáticas baseadas no progresso do desenvolvimento
- **💬 Comentários Contextuais**: Formatação Unicode padronizada para máxima clareza
- **🏷️ Tag Management**: Aplicação automática de tags baseada no estágio do desenvolvimento
- **👥 Assignment**: Gerenciamento inteligente de assignees e responsáveis

### 🛠️ Recursos Técnicos
- **Bulk Operations**: Otimização para operações em massa
- **Real-time Sync**: Sincronização bidirecional instantânea
- **Conflict Resolution**: Tratamento inteligente de conflitos de dados
- **Fallback Gracioso**: Funcionamento garantido mesmo com falhas de rede

## 🤖 Agentes Especializados

O Sistema Onion inclui **17 agentes de IA especializados** que podem ser invocados diretamente:

### 🎯 Agentes Principais
- **`@product-agent`** - Gestão estratégica de produto e coordenação de projetos
- **`@gitflow-specialist`** - Expert em workflows Git e branching strategies  
- **`@clickup-specialist`** - Otimizações técnicas do ClickUp MCP
- **`@cursor-specialist`** - Configuração e troubleshooting do Cursor IDE

### 🔧 Agentes de Desenvolvimento
- **`@python-developer`** - Especialista em desenvolvimento Python
- **`@react-developer`** - Expert em React e TypeScript
- **`@test-engineer`** - Automação e estratégias de teste
- **`@code-reviewer`** - Análise e review de código

**[Ver lista completa →](docs/onion/agents-reference.md)**

## 📞 Suporte e Recursos

### 🆘 Resolução de Problemas
1. **Comandos**: Consulte [`docs/onion/commands-guide.md`](docs/onion/commands-guide.md)
2. **Exemplos**: Veja casos práticos em [`docs/onion/practical-examples.md`](docs/onion/practical-examples.md)
3. **ClickUp**: Verifique [`docs/onion/clickup-integration.md`](docs/onion/clickup-integration.md)
4. **Configuração**: Siga [`docs/onion/getting-started.md`](docs/onion/getting-started.md)

### 🔧 Comandos de Debug
```bash
/meta/all-tools              # Lista todos os comandos
@cursor-specialist "ajuda"   # Troubleshooting do IDE  
/product/task-check [ID]     # Verifica status de task
```

---

**Sistema Onion v2.0** - Comandos inteligentes para desenvolvimento ágil com IA 🧅
