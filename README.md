# 🧅 Sistema Onion

[![Versão](https://img.shields.io/badge/Versão-3.0.0-purple)](CHANGELOG-ONION-V3.md) [![Comandos](https://img.shields.io/badge/Comandos-56-blue)](docs/onion/commands-guide.md) [![Agentes](https://img.shields.io/badge/Agentes-38-green)](docs/onion/agents-reference.md) [![ClickUp](https://img.shields.io/badge/ClickUp-Integrado-orange)](docs/onion/clickup-integration.md)

## 🎯 Visão Geral

Bem-vindo ao **Sistema Onion v3.0**! Framework avançado de comandos `.cursor/` que revoluciona o desenvolvimento com:

- 🤖 **57 comandos especializados** organizados em 8 categorias
- 🎯 **38 agentes de IA especializados** em 9 categorias
- 📚 **5 Knowledge Bases** estruturadas para IA
- 📋 **4 regras** de padronização e validação
- 🧅 **Comando `/onion`** - ponto de entrada inteligente para o sistema
- 🧅 **Agente `@onion`** - orquestrador master que conhece todo o sistema
- 🔗 **Task Manager Abstraction** para ClickUp, Asana e Linear (via adapter pattern)
- ⚡ **Workflows automatizados** do planejamento ao deploy

### 🆕 Novidades v3.0

- **Headers YAML padronizados** em todos os comandos e agentes
- **Prompts modulares** em `common/prompts/` (redução de 66% em tokens)
- **Validações automatizadas** nos geradores (`/meta/create-*`)
- **Sessions estruturadas** em `.cursor/sessions/<feature>/`
- **Gestão de .env** com `/meta/setup-integration`
- **🆕 Task Manager Abstraction** - suporte a ClickUp, Asana, Linear via adapter pattern
- **🎲 Integração Automática de Story Points** - estimativas automáticas em todas as tasks criadas
- **📊 Framework de Story Points** - agente especializado e comando dedicado para estimativas
- **✅ Validação de Estimativas** - validação automática antes de iniciar desenvolvimento

📋 **[Ver CHANGELOG completo](CHANGELOG-ONION-V3.md)**

Documentação completa disponível em [`docs/onion/`](docs/onion/) para dominar todos os comandos, agentes e fluxos de trabalho.

## 🧅 **Comece com `/onion`**

**Novo no sistema?** Use o comando `/onion` - seu guia inteligente para navegar, aprender e executar:

```bash
# Primeira vez?
/onion "Sou novo aqui, me ajude a começar"

# Precisa criar uma task?
/onion "Criar task para implementar autenticação"

# Quer desenvolver uma feature?
/onion "Desenvolver feature completa do zero"

# Tem dúvidas?
/onion "Qual comando usar para X?"
```

O comando `/onion` invoca automaticamente o agente `@onion` com contexto otimizado, analisando sua solicitação e orquestrando a melhor solução - seja um comando específico, um agente especializado ou um workflow completo.

## ⚡ **Como Funcionam os Comandos**

### 🎮 **Cursor Commands - Interface Natural**
Todos os comandos do Sistema Onion são **[Cursor Commands](https://cursor.com/pt-BR/docs/agent/chat/commands)** executados diretamente no **chat da Cursor**:

```markdown
# ✅ CORRETO - No chat da Cursor:
/git/init
/git/feature/start "user-auth"  
/engineer/work "implement login"
/product/task "add user dashboard"

# ❌ INCORRETO - NÃO são comandos bash/terminal:
$ /git/init                    # Não funciona no terminal
$ /engineer/work               # Não é comando shell
```

### 🧠 **Arquitetura Inteligente**
| Camada | Tecnologia | Função |
|--------|------------|--------|
| **Interface** | Cursor Commands | Usuário digita `/comando` no chat |
| **Definição** | Markdown Files | `.cursor/commands/` define workflows |
| **Execução** | Cursor AI | Interpreta e executa inteligentemente |
| **Implementação** | Scripts | Bash/Python dentro dos workflows |

### 🎯 **Vantagens dos Cursor Commands**
- ✅ **Context-Aware**: Cursor entende o projeto e arquivos abertos
- ✅ **AI-Powered**: Execução inteligente e adaptativa
- ✅ **Educational**: Interface rica e educativa no chat
- ✅ **Universal**: Funciona em qualquer projeto, qualquer pasta

## 📖 Guias Disponíveis

### 🎯 Guias Principais
- **[Guia de Comandos](docs/onion/commands-guide.md)** - Documentação completa de todos os comandos disponíveis
- **[Fluxos de Engenharia](docs/onion/engineering-flows.md)** - Workflows detalhados para desenvolvimento
- **[Integração ClickUp](docs/onion/clickup-integration.md)** - Como integrar comandos com ClickUp MCP

### 🛠️ Referências Técnicas
- **[Agentes Disponíveis](docs/onion/agents-reference.md)** - Lista e descrição de todos os agentes especializados
- **[Exemplos Práticos](docs/onion/practical-examples.md)** - Casos de uso reais com exemplos
- **[Knowledge Bases](docs/knowbase/)** - Documentação estruturada para IA

### 🚀 Início Rápido
- **[Configuração Inicial](.cursor/docs/onion/getting-started.md)** - Como configurar e começar a usar o sistema

## 📁 Estrutura de Documentação

### 🧅 Sistema Onion (`.cursor/docs/onion/`)
Documentação do **framework de comandos e agentes**:
- 📖 Guias de uso de comandos
- 🔄 Workflows de desenvolvimento
- 🤖 Referências de agentes
- 💡 Exemplos práticos
- ⚙️ Configuração e troubleshooting

**Localização:** `.cursor/docs/onion/`  
**Propósito:** Documentar o Sistema Onion em si

### 📚 Projeto (`docs/`)
Documentação **específica do seu projeto**:
- 🎯 Contexto de negócio
- 🏗️ Arquitetura técnica
- 📋 Meta-especificações (PRDs)
- 🧠 ADRs (Architecture Decision Records)
- 📊 Análises e relatórios

**Localização:** `docs/`  
**Propósito:** Documentar o projeto que você está desenvolvendo

### 💡 Por Que Separar?
- ✅ **Clareza**: Sistema vs Projeto bem definidos
- ✅ **Portabilidade**: `.cursor/` é autocontido
- ✅ **Organização**: Cada tipo de doc no lugar certo
- ✅ **Manutenibilidade**: Atualizações independentes

## 🎯 Navegação Rápida

### 📂 Por Categoria de Comando
- **🔧 Engenharia**: `engineer/start`, `engineer/work`, `engineer/pr`, `engineer/pre-pr`, `engineer/plan`, `engineer/docs`
- **📋 Produto**: `product/task`, `product/spec`, `product/collect`, `product/refine`, `product/estimate`, `product/light-arch`, `product/task-check`  
- **📚 Documentação**: `docs/build-tech-docs`, `docs/build-business-docs`, `docs/build-index`
- **🌿 Git**: `git/sync`
- **⚙️ Meta**: `meta/all-tools`, `meta/create-agent`
- **🚀 Utilitários**: `warm-up`, `engineer/warm-up`, `product/warm-up`

### 🔄 Por Fluxo de Trabalho
1. **Planejamento** → `/product/task` (com estimativas automáticas) → `/product/spec` → `/product/estimate`
2. **Desenvolvimento** → `/engineer/start` (valida story points) → `/engineer/work` → `/engineer/pr`
3. **Refinamento** → `/product/refine` (recalcula estimativas automaticamente)
4. **Sincronização** → `/git/sync`
5. **Documentação** → `/docs/build-*`

## 🚀 Início Rápido

### 🎯 Primeiro Uso - Workflow Completo
```bash
# 1. Criar nova task com especificações e estimativas automáticas
/product/task "Implementar autenticação de usuário"
# → Cria task + subtasks com story points calculados automaticamente

# 2. Estimar manualmente (opcional)
/product/estimate "Implementar autenticação OAuth2" --assignee_level=senior

# 3. Iniciar desenvolvimento (valida story points, cria branch, sessão)
/engineer/start
# → Valida se task tem estimativa, alerta se necessário

# 4. Trabalhar na funcionalidade (development loop)
/engineer/work

# 5. Refinar requisitos (recalcula estimativas automaticamente)
/product/refine [task-id]

# 6. Criar Pull Request (testes, build, PR)  
/engineer/pr

# 7. Sincronizar após merge (cleanup, atualiza gerenciador)
/git/sync
```

### 🔧 Comandos Essenciais
- **`/meta/all-tools`** - Lista todos os comandos disponíveis
- **`@agent-name`** - Invoca agente especializado específico
- **`/product/task`** - Gerencia tasks com estimativas automáticas de story points
- **`/product/estimate`** - Estima story points para tarefas
- **`/engineer/*`** - Workflows de desenvolvimento com validação de estimativas

## 🔗 Integração com Gerenciadores de Tarefas

O Sistema Onion oferece **integração nativa e bidirecional** com múltiplos gerenciadores através do **Task Manager Abstraction**:

### 🎯 Gerenciadores Suportados
- **ClickUp** - Via ClickUp MCP
- **Asana** - Via Asana MCP
- **Linear** - Via Linear API
- **Modo Local** - Funciona sem gerenciador configurado

### ⚡ Automações Principais
- **🎯 Gestão Inteligente de Tasks**: Criação, atualização e sincronização automática
- **🎲 Estimativas Automáticas**: Story points calculados automaticamente em todas as tasks criadas
- **📊 Status em Tempo Real**: Atualizações automáticas baseadas no progresso do desenvolvimento
- **💬 Comentários Contextuais**: Formatação Unicode padronizada para máxima clareza
- **🏷️ Tag Management**: Aplicação automática de tags baseada no estágio do desenvolvimento
- **👥 Assignment**: Gerenciamento inteligente de assignees e responsáveis
- **📈 Histórico de Estimativas**: Tracking completo de mudanças em story points

### 🛠️ Recursos Técnicos
- **Task Manager Abstraction**: Interface unificada para múltiplos provedores
- **Bulk Operations**: Otimização para operações em massa
- **Real-time Sync**: Sincronização bidirecional instantânea
- **Conflict Resolution**: Tratamento inteligente de conflitos de dados
- **Fallback Gracioso**: Funcionamento garantido mesmo com falhas de rede
- **Validação de Estimativas**: Verificação automática antes de iniciar desenvolvimento

## 🤖 Agentes Especializados

O Sistema Onion inclui **38 agentes de IA especializados** que podem ser invocados diretamente:

### 🎯 Agentes Principais
- **`@product-agent`** - Gestão estratégica de produto e coordenação de projetos
- **`@gitflow-specialist`** - Expert em workflows Git e branching strategies  
- **`@clickup-specialist`** - Otimizações técnicas do ClickUp MCP
- **`@cursor-specialist`** - Configuração e troubleshooting do Cursor IDE
- **`@story-points-framework-specialist`** - Especialista em estimativas ágeis e story points

### 🔧 Agentes de Desenvolvimento
- **`@python-developer`** - Especialista em desenvolvimento Python
- **`@react-developer`** - Expert em React e TypeScript
- **`@test-engineer`** - Automação e estratégias de teste
- **`@code-reviewer`** - Análise e review de código

**[Ver lista completa →](.cursor/docs/onion/agents-reference.md)**

## 📞 Suporte e Recursos

### 🆘 Resolução de Problemas
1. **Comandos**: Consulte [`.cursor/docs/onion/commands-guide.md`](.cursor/docs/onion/commands-guide.md)
2. **Exemplos**: Veja casos práticos em [`.cursor/docs/onion/practical-examples.md`](.cursor/docs/onion/practical-examples.md)
3. **ClickUp**: Verifique [`.cursor/docs/onion/clickup-integration.md`](.cursor/docs/onion/clickup-integration.md)
4. **Configuração**: Siga [`.cursor/docs/onion/getting-started.md`](.cursor/docs/onion/getting-started.md)

### 🔧 Comandos de Debug
```bash
/meta/all-tools                           # Lista todos os comandos
@cursor-specialist "ajuda"                # Troubleshooting do IDE  
/product/task-check [ID]                  # Verifica status de task
/product/estimate "descrição da tarefa"   # Estimar story points
@story-points-framework-specialist        # Especialista em estimativas
```

## 🎲 Story Points e Estimativas

O Sistema Onion inclui **integração completa de Story Points** para melhorar planejamento e tracking:

### ⚡ Funcionalidades
- **Estimativas Automáticas**: Todas as tasks criadas recebem story points automaticamente
- **Framework Completo**: Baseado em Fibonacci (1, 13) com checklists detalhados
- **Validação Automática**: `/engineer/start` valida estimativas antes de iniciar
- **Histórico Completo**: Tracking de mudanças em estimativas durante refinamento
- **Detecção de Épicos**: Alerta automático para tasks > 13 pontos

### 📊 Comandos Relacionados
- **`/product/estimate`** - Estimar story points manualmente
- **`/product/task`** - Cria tasks com estimativas automáticas
- **`/product/refine`** - Recalcula estimativas após refinamento
- **`@story-points-framework-specialist`** - Agente especializado em estimativas

### 📚 Documentação
- **[Framework de Story Points](docs/knowbase/frameworks/framework_story_points.md)** - Guia completo
- **[Integração de Story Points](.cursor/docs/product/story-points-integration.md)** - Como funciona
- **[Validação de Estimativas](.cursor/docs/product/story-points-validation.md)** - Validação no start

---

**Sistema Onion v3.0** - Comandos inteligentes para desenvolvimento ágil com IA 🧅
