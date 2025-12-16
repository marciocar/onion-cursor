# 🧅 Sistema Onion

[![Versão](https://img.shields.io/badge/Versão-3.0.0-purple)](CHANGELOG-ONION-V3.md) [![Comandos](https://img.shields.io/badge/Comandos-90-blue)](docs/onion/commands-guide.md) [![Agentes](https://img.shields.io/badge/Agentes-46-green)](docs/onion/agents-reference.md) [![Task Manager](https://img.shields.io/badge/Task%20Manager-Abstraction-orange)](docs/knowbase/concepts/task-manager-abstraction.md)

## 🎯 Visão Geral

Bem-vindo ao **Sistema Onion v3.0**! Framework avançado de comandos `.cursor/` que revoluciona o desenvolvimento com:

- 🤖 **90 comandos especializados** organizados em 8 categorias
- 🎯 **46 agentes de IA especializados** em 9 categorias
- 📚 **Knowledge Bases** estruturadas para IA
- 📋 **4 regras** de padronização e validação
- 🧅 **Comando `/onion`** - ponto de entrada inteligente para o sistema
- 🧅 **Agente `@onion`** - orquestrador master que conhece todo o sistema
- 🔗 **Task Manager Abstraction** para ClickUp, Asana e Linear (via adapter pattern)
- ⚡ **Workflows automatizados** do planejamento ao deploy
- 📋 **Extração e Consolidação de Reuniões** - Framework EXTRACT para transformar transcrições em conhecimento estruturado

## 🌟 O Que o Onion Realmente Entrega

**O Onion não é apenas uma ferramenta — é uma mudança de paradigma.**

O Sistema Onion realmente entrega é uma transformação fundamental: ele não apenas acelera o que você faz, mas transforma quem você é como desenvolvedor. Ao combinar agentes inteligentes, workflows gamificados e uma experiência contínua de autonomia e maestria, o sistema cria um ambiente onde performance deixa de ser esforço e passa a ser consequência natural.

O Onion eleva o padrão operacional, reorganiza a rotina em torno do que realmente importa e converte complexidade em clareza — tornando impossível voltar ao modelo tradicional depois de experimentar seu verdadeiro poder.

**Transformação, não apenas aceleração:**
- 🎯 **Autonomia**: Decisões inteligentes guiadas por agentes especializados
- 🏆 **Maestria**: Aprendizado contínuo através de workflows estruturados
- ⚡ **Performance Natural**: Resultados superiores sem esforço adicional
- 🧠 **Clareza**: Complexidade convertida em processos claros e acionáveis
- 🔄 **Evolução Contínua**: Sistema que cresce e se adapta com você

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
- **📋 Extração e Consolidação de Reuniões** - Framework EXTRACT para transformar transcrições em conhecimento estruturado
- **🎤 Whisper Integration** - Transcrição de áudio com OpenAI Whisper e conversão em tasks ✨ NOVO

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
- **[Task Manager Abstraction](docs/knowbase/concepts/task-manager-abstraction.md)** - Como funciona a abstração de gerenciadores
- **[Integração ClickUp](docs/onion/clickup-integration.md)** - Configuração avançada do ClickUp (se usar)

### 🛠️ Referências Técnicas
- **[Agentes Disponíveis](docs/onion/agents-reference.md)** - Lista e descrição de todos os agentes especializados
- **[Exemplos Práticos](docs/onion/practical-examples.md)** - Casos de uso reais com exemplos
- **[Sistema de Testes e Validação](docs/onion/testing-validation-system.md)** - Framework completo de testes e validação
- **[Knowledge Bases](docs/knowbase/)** - Documentação estruturada para IA

### 🚀 Início Rápido
- **[Configuração Inicial](docs/onion/getting-started.md)** - Como configurar e começar a usar o sistema

## 📁 Estrutura de Documentação

### 🧅 Sistema Onion (`docs/onion/`)
Documentação do **framework de comandos e agentes**:
- 📖 Guias de uso de comandos
- 🔄 Workflows de desenvolvimento
- 🤖 Referências de agentes
- 💡 Exemplos práticos
- ⚙️ Configuração e troubleshooting

**Localização:** `docs/onion/`  
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
- **📋 Produto**: `product/task`, `product/spec`, `product/collect`, `product/refine`, `product/estimate`, `product/light-arch`, `product/task-check`, `product/extract-meeting`, `product/consolidate-meetings`, `product/convert-to-tasks`, `product/whisper` ✨ NOVO
- **📚 Documentação**: `docs/build-tech-docs`, `docs/build-business-docs`, `docs/build-index`, `docs/consolidate-documents` ✨ NOVO
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

### ⚙️ Configuração de Integrações

**Antes de usar comandos que criam tasks**, configure seu gerenciador de tarefas:

```bash
# Configurar integrações (Task Manager, Gamma, etc)
/meta/setup-integration

# Ou especificar integração diretamente
/meta/setup-integration task-manager
/meta/setup-integration clickup
```

**O que o comando faz:**
- ✅ Guia configuração de `TASK_MANAGER_PROVIDER` (ClickUp, Asana, Linear ou None)
- ✅ Configura variáveis de ambiente necessárias no `.env`
- ✅ Valida segurança (`.gitignore`, proteção de credenciais)
- ✅ Testa conectividade (quando aplicável)

**Integrações suportadas:**
- **Task Managers**: ClickUp, Asana, Linear (via Task Manager Abstraction)
- **Gamma.App**: API para apresentações
- **PostgreSQL**: Banco de dados

> **💡 Dica:** Execute `/meta/setup-integration` logo após clonar o projeto para configurar seu ambiente rapidamente.

## 🔗 Integração com Gerenciadores de Tarefas

O Sistema Onion oferece **integração nativa e bidirecional** com múltiplos gerenciadores através do **Task Manager Abstraction** - uma camada de abstração que permite trocar de provedor sem modificar comandos ou workflows.

### 🎯 Gerenciadores Suportados

| Provedor | Status | Tecnologia | Configuração |
|----------|--------|------------|--------------|
| **ClickUp** | ✅ Completo | ClickUp MCP | `TASK_MANAGER_PROVIDER=clickup` |
| **Asana** | ✅ Completo | Asana MCP | `TASK_MANAGER_PROVIDER=asana` |
| **Linear** | 📝 Stub | Linear API | `TASK_MANAGER_PROVIDER=linear` |
| **Modo Local** | ✅ Offline | Sem sincronização | `TASK_MANAGER_PROVIDER=none` |

**Vantagens da abstração:**
- 🎯 **Flexibilidade**: Escolha o gerenciador que sua equipe já usa
- 🔄 **Portabilidade**: Troque de provedor sem refatorar código
- 🛡️ **Resiliência**: Funciona mesmo se o gerenciador estiver offline
- 🚀 **Consistência**: Mesmos comandos, mesma experiência, qualquer provedor

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

## 🏗️ SDAAL - Specification-Driven AI Abstraction Layer

O Sistema Onion utiliza o padrão **SDAAL** (Specification-Driven AI Abstraction Layer) - uma metodologia inovadora onde **documentação Markdown substitui código executável**, permitindo que LLMs "executem" abstrações complexas baseadas em especificações estruturadas.

### 🎯 Princípio Central

**LLMs não executam código diretamente, mas podem simular comportamentos complexos quando as especificações são precisas, tipadas e bem estruturadas.**

### ⚡ Como Funciona

O SDAAL combina três elementos fundamentais:

1. **📝 Markdown Estruturado** - Especificações detalhadas e tipadas
2. **🔷 Interfaces TypeScript** - Contratos claros e validáveis
3. **📚 Documentação Executável** - Comportamentos documentados que LLMs seguem

```
SDAAL = Markdown Estruturado + Interfaces TypeScript + Documentação Executável
```

### 🔄 Aplicação Prática

O **Task Manager Abstraction** é uma implementação de referência do padrão SDAAL:

- ✅ **Abstração Completa**: ClickUp, Asana, Linear com mesma interface
- ✅ **Sem Código Executável**: Toda lógica em Markdown estruturado
- ✅ **LLM-Driven**: Agentes IA interpretam e executam as especificações
- ✅ **Type-Safe**: Interfaces TypeScript garantem consistência
- ✅ **Portabilidade Total**: Troque provedores sem modificar código

### 📚 Documentação Completa

- **[Documentação SDAAL](docs/sdaal/index.html)** - Guia completo do padrão (HTML interativo)
- **[Knowledge Base SDAAL](docs/knowbase/concepts/specification-driven-ai-abstraction-layer.md)** - Referência técnica
- **[Task Manager Abstraction](docs/knowbase/concepts/task-manager-abstraction.md)** - Implementação de referência
- **[Comando /meta/create-abstraction](.cursor/commands/meta/create-abstraction.md)** - Gerador automático de abstrações SDAAL
- **[Template de Abstração](.cursor/commands/common/templates/abstraction-template.md)** - Template base para novas abstrações

### 🛠️ Recursos Relacionados

**Comandos:**
- `/meta/create-abstraction` - Gera abstrações SDAAL automaticamente

**Implementações:**
- `.cursor/utils/task-manager/` - Task Manager Abstraction (exemplo completo)

**Padrões de Design:**
- [Adapter Pattern](https://refactoring.guru/design-patterns/adapter) - GoF
- [Factory Method](https://refactoring.guru/design-patterns/factory-method) - GoF
- [Null Object Pattern](https://refactoring.guru/design-patterns/null-object)
- [Strategy Pattern](https://refactoring.guru/design-patterns/strategy)

**Metodologias Relacionadas:**
- [Behavior Driven Development (BDD)](https://cucumber.io/docs/bdd/)
- [Specification by Example](https://specificationbyexample.com)
- [Living Documentation](https://leanpub.com/livingdocumentation)
- [Docs as Code](https://www.writethedocs.org/guide/docs-as-code/)

**Frameworks de Agentes IA:**
- [LangChain Agents](https://python.langchain.com/docs/modules/agents/) - Framework para construção de agentes
- [CrewAI](https://www.crewai.com/) - Framework multi-agente colaborativo
- [AutoGen](https://microsoft.github.io/autogen/) - Framework multi-agente da Microsoft
- [Anthropic Claude Agent Patterns](https://docs.anthropic.com/) - Padrões de agentes Claude
- [Anthropic Prompt Engineering Guide](https://docs.anthropic.com/claude/docs/prompt-engineering) - Guia de prompt engineering
- [OpenAI Best Practices](https://platform.openai.com/docs/guides/prompt-engineering) - Boas práticas de prompt engineering

### 💡 Benefícios

- ✅ **Flexibilidade**: Troque implementações sem refatorar código
- ✅ **Manutenibilidade**: Documentação sempre sincronizada com comportamento
- ✅ **Testabilidade**: Especificações servem como testes de comportamento
- ✅ **Portabilidade**: Mesma abstração funciona em múltiplos contextos
- ✅ **IA-Friendly**: LLMs interpretam e executam naturalmente

## 🤖 Agentes Especializados

O Sistema Onion inclui **46 agentes de IA especializados** que podem ser invocados diretamente:

### 🎯 Agentes Principais
- **`@product-agent`** - Gestão estratégica de produto e coordenação de projetos
- **`@gitflow-specialist`** - Expert em workflows Git e branching strategies  
- **`@clickup-specialist`** - Otimizações técnicas do ClickUp MCP
- **`@cursor-specialist`** - Configuração e troubleshooting do Cursor IDE
- **`@story-points-framework-specialist`** - Especialista em estimativas ágeis e story points
- **`@extract-meeting-specialist`** - Extração estruturada de conhecimento de reuniões usando Framework EXTRACT
- **`@meeting-consolidator`** - Consolidação de múltiplas reuniões com análise de divergências e convergências
- **`@whisper-specialist`** - Especialista em transcrição de áudio com Whisper (OpenAI) ✨ NOVO

### 🔧 Agentes de Desenvolvimento
- **`@python-developer`** - Especialista em desenvolvimento Python
- **`@react-developer`** - Expert em React e TypeScript
- **`@test-engineer`** - Automação e estratégias de teste
- **`@code-reviewer`** - Análise e review de código

**[Ver lista completa →](docs/onion/agents-reference.md)**

## 📞 Suporte e Recursos

### 🆘 Resolução de Problemas
1. **Comandos**: Consulte [docs/onion/commands-guide.md](docs/onion/commands-guide.md)
2. **Exemplos**: Veja casos práticos em [docs/onion/practical-examples.md](docs/onion/practical-examples.md)
3. **Task Manager**: Verifique [Task Manager Abstraction](docs/knowbase/concepts/task-manager-abstraction.md)
4. **Configuração**: Siga [docs/onion/getting-started.md](docs/onion/getting-started.md)

### 🔧 Comandos de Debug
```bash
/meta/all-tools                           # Lista todos os comandos
/meta/setup-integration                   # Configurar Task Manager (ClickUp, Asana, etc)
@cursor-specialist "ajuda"                # Troubleshooting do IDE  
@clickup-specialist "ajuda"               # Problemas específicos do ClickUp
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

## 📋 Extração, Consolidação e Conversão em Tasks

O Sistema Onion inclui **workflow completo** para transformar áudio de reuniões em tasks acionáveis, desde a transcrição até a criação de tasks no Task Manager:

### 🎤 Whisper - Transcrição de Áudio

**Whisper** (OpenAI) é integrado ao Sistema Onion para transcrição de alta qualidade em português.

#### `/product/whisper`
Facilita o uso do Whisper com detecção automática de necessidade e integração com workflows.

**Uso:**
```bash
# Instalação (detecta plataforma automaticamente)
/product/whisper "Como instalar Whisper?" platform=linux

# Transcrição simples
/product/whisper audio_file=reuniao.mp3

# Troubleshooting
/product/whisper "FFmpeg não encontrado" platform=windows
```

**Recursos:**
- Instalação multi-plataforma (Windows, Linux Ubuntu, macOS)
- Detecção automática de GPU (CUDA/MPS)
- Otimização para português
- Integração automática com workflow do Sistema Onion

**Agente Especializado:**
- `@whisper-specialist` - Especialista completo em Whisper com knowledge base integrada

**Knowledge Base:**
- `docs/knowbase/tools/whisper.md` - Documentação completa do Whisper

### 🎯 Framework EXTRACT - Extração de Conhecimento

Metodologia em **7 dimensões** para máxima extração de valor de reuniões:

```
E - Essência      → Resumo executivo (3 linhas máximo)
X - eXpectativas  → Objetivos da reunião + Status (atingido/parcial/não)
T - Tarefas       → Ações com Owner + Deadline + Prioridade
R - Resoluções    → Decisões tomadas + Rationale + Confiança
A - Ambiguidades  → Gaps, contradições, pontos não resolvidos
C - Conexões      → Dependências, stakeholders, documentos relacionados
T - Timeline      → Datas, marcos, deadlines mencionados
```

### ⚡ Comandos Disponíveis

#### `/product/extract-meeting`
Extrai conhecimento estruturado de transcrições de reuniões usando o Framework EXTRACT.

**Uso:**
```bash
# Extrair reunião específica (nível executivo default)
/product/extract-meeting source=reuniao-28-nov.txt

# Nível completo com YAML estruturado
/product/extract-meeting source=reuniao.txt level=complete

# Foco apenas em decisões
/product/extract-meeting source=reuniao.txt focus=decisions

# Processar pasta de contexto
/product/extract-meeting source=contextos/projeto-x/

# Gerar grafo para sistemas
/product/extract-meeting source=reuniao.txt level=graph
```

**Níveis de Output:**
- `compact` - Resumo ultra-compacto (30 segundos de leitura)
- `executive` - Nível executivo (2 minutos de leitura) - **padrão**
- `complete` - YAML completo estruturado
- `graph` - JSON com entidades e relacionamentos para sistemas

**Focos Disponíveis:**
- `all` - Todas as dimensões (padrão)
- `decisions` - Apenas decisões
- `tasks` - Apenas tarefas
- `gaps` - Apenas ambiguidades e gaps

#### `/product/consolidate-meetings`
Consolida múltiplas reuniões identificando divergências, convergências e insights estratégicos.

**Uso:**
```bash
# Consolidar todas as reuniões de uma pasta
/product/consolidate-meetings source=docs/meet/gamification-meetings/

# Consolidar arquivos específicos
/product/consolidate-meetings source=docs/meet/meeting-1.md docs/meet/meeting-2.md

# Foco em divergências
/product/consolidate-meetings source=docs/meet/meetings/ --focus=divergences

# Foco em insights estratégicos
/product/consolidate-meetings source=docs/meet/strategic-planning/ --focus=insights

# Foco em pontos não ditos/compreendidos
/product/consolidate-meetings source=docs/meet/meetings/ --focus=gaps
```

**Focos Disponíveis:**
- `all` - Consolidação completa (padrão)
- `divergences` - Apenas divergências e conflitos
- `convergences` - Apenas convergências e alinhamentos
- `insights` - Apenas insights estratégicos
- `gaps` - Apenas pontos não ditos/compreendidos

#### `/docs/consolidate-documents`
Consolida múltiplos documentos relacionados identificando padrões, divergências e insights estratégicos. ✨ NOVO

**Uso:**
```bash
# Consolidar documentos de uma pasta
/docs/consolidate-documents source=docs/business-context/

# Consolidar arquivos específicos
/docs/consolidate-documents source=doc1.md doc2.md doc3.md

# Foco em divergências
/docs/consolidate-documents source=docs/ --focus=divergences

# Foco em insights estratégicos
/docs/consolidate-documents source=docs/ --focus=insights
```

**Focos Disponíveis:**
- `all` - Consolidação completa (padrão)
- `divergences` - Conflitos e desalinhamentos
- `convergences` - Pontos de alinhamento
- `insights` - Insights estratégicos
- `gaps` - Informações faltantes
- `structure` - Estrutura otimizada

#### `/product/convert-to-tasks`
Converte documentos consolidados (reuniões ou documentos) em tasks e subtasks organizadas hierarquicamente. ✨ NOVO

**Uso:**
```bash
# Converter consolidação de reuniões em tasks
/product/convert-to-tasks source=docs/meet/consolidation-*.md

# Converter consolidação de documentos em tasks
/product/convert-to-tasks source=docs/consolidated/business-context/

# Com detecção inteligente de arquivos relevantes
/product/convert-to-tasks source=docs/meet/sprint-planning/
```

**Recursos:**
- Detecção inteligente de arquivos consolidados (não depende de padrões de nome)
- Evita duplicatas automaticamente
- Inclui arquivos relacionados (análises, evoluções, contexto)
- Delega para comandos existentes (`/product/task`, `/product/collect`)
- Preserva contexto e rastreabilidade

### 🤖 Agentes Especializados

#### `@extract-meeting-specialist`
Especialista em aplicar o Framework EXTRACT para transformar transcrições em conhecimento estruturado.

**Capacidades:**
- Extração sistemática das 7 dimensões EXTRACT
- Validação de consistência interna
- Indicação de níveis de confiança
- Geração de outputs em múltiplos formatos
- Detecção de sobreposições e contradições

**Uso:**
```bash
@extract-meeting-specialist "Processar transcrição: [ARQUIVO]"
@extract-meeting-specialist "Extrair nível executivo: [ARQUIVO]"
@extract-meeting-specialist "Identificar gaps e ambiguidades: [ARQUIVO]"
```

#### `@meeting-consolidator`
Especialista em consolidar múltiplas reuniões com análise profunda.

**Capacidades:**
- Classificação e categorização por tema
- Identificação de divergências entre participantes/reuniões
- Identificação de convergências e pontos de alinhamento
- Geração de insights estratégicos não explícitos
- Identificação de pontos não ditos ou não compreendidos
- Recomendações estratégicas acionáveis

**Uso:**
```bash
@meeting-consolidator "Consolidar reuniões: [ARQUIVO1] [ARQUIVO2] [ARQUIVO3]"
@meeting-consolidator "Identificar divergências entre: [ARQUIVO1] [ARQUIVO2]"
@meeting-consolidator "Gerar insights estratégicos de: [ARQUIVO]"
```

### 📚 Knowledge Base

- **[Meeting Transcription to Knowledge Base](docs/knowbase/concepts/meeting-transcription-to-knowledge-base.md)** - Metodologia completa e templates estruturados

### 🎯 Casos de Uso

**Workflow Completo: Áudio → Tasks**

```bash
# 1. Transcrever reunião com Whisper
/product/whisper audio_file=reuniao-28-nov.m4a
# → Gera: reuniao-28-nov.txt

# 2. Extrair conhecimento estruturado (Framework EXTRACT)
/product/extract-meeting source=reuniao-28-nov.txt level=executive
# → Gera: conhecimento estruturado em 7 dimensões

# 3. Consolidar múltiplas reuniões relacionadas
/product/consolidate-meetings source=docs/meet/sprint-planning/
# → Gera: documento consolidado com divergências, convergências e insights

# 4. Converter conhecimento consolidado em tasks
/product/convert-to-tasks source=docs/meet/consolidation-*.md
# → Cria: tasks e subtasks no Task Manager configurado

# 5. (Opcional) Consolidar documentos relacionados
/docs/consolidate-documents source=docs/business-context/
# → Gera: conhecimento consolidado de documentos
```

**Workflow Alternativo: Documentos → Tasks**

```bash
# 1. Consolidar múltiplos documentos
/docs/consolidate-documents source=docs/business-context/

# 2. Converter em tasks
/product/convert-to-tasks source=docs/consolidated/business-context/
# → Cria: tasks baseadas em conhecimento consolidado
```

**Análise Focada:**

```bash
# Identificar divergências críticas
/product/consolidate-meetings source=docs/meet/ --focus=divergences

# Gerar insights estratégicos
/product/consolidate-meetings source=docs/meet/ --focus=insights

# Extrair apenas decisões
/product/extract-meeting source=reuniao.txt focus=decisions
```

**Benefícios:**
- ✅ **Conhecimento Estruturado**: Transforma diálogos em artefatos acionáveis
- ✅ **Rastreabilidade**: Decisões e tarefas com owners e deadlines claros
- ✅ **Gap Detection**: Identifica o que não foi decidido (tão importante quanto o que foi)
- ✅ **Análise Estratégica**: Revela padrões e insights não explícitos
- ✅ **Interoperabilidade**: Outputs em formatos consumíveis por sistemas
- ✅ **Workflow Completo**: Do áudio até tasks no Task Manager em poucos comandos
- ✅ **Multi-Plataforma**: Whisper funciona em Windows, Linux e macOS
- ✅ **Detecção Inteligente**: Identifica arquivos relevantes automaticamente sem padrões fixos

---

**Sistema Onion v3.0** - Comandos inteligentes para desenvolvimento ágil com IA 🧅
