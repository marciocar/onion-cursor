# 📚 Índice Central de Documentação

> **Última atualização**: 2025-12-20 | **Gerado por**: `/docs/build-index`

Bem-vindo ao índice central de documentação do projeto. Este documento serve como hub de navegação para toda a documentação disponível.

---

## 🎯 Visão Geral

Este projeto utiliza o **Sistema Onion v4.0 Beta** - um framework avançado de comandos `.claude/` que revoluciona o desenvolvimento com:

- 🤖 **Comandos especializados** organizados em categorias funcionais
- 🎯 **Agentes de IA especializados** em múltiplos domínios
- 📚 **Knowledge Bases estruturadas** para consumo por IA
- 🧅 **Comando `/onion`** - ponto de entrada inteligente
- 🔗 **Task Manager Abstraction** para ClickUp, Asana e Linear
- 🏗️ **Arquitetura Multi-Context** - Separação clara entre business e technical

---

## 📊 Estatísticas da Documentação

### Documentação Principal
- **69 arquivos markdown** em `docs/` (incluindo este índice, excluindo draft/)
- **28 arquivos** em `docs/onion/` (Sistema Onion)
- **24 arquivos** em `docs/knowledge-base/` (Knowledge Bases)
  - 13 arquivos em `concepts/` (Conceitos fundamentais)
  - 7 arquivos em `frameworks/` (Frameworks e metodologias)
  - 2 arquivos em `tools/` (Ferramentas)
  - 1 arquivo em `platforms/` (Plataformas)
  - 1 arquivo em `providers/` (Provedores de serviços)
- **1 arquivo** em `docs/meta-specs/` (Meta Especificações)
- **Arquivos adicionais** em `docs/analysis/`, `docs/plans/`, `docs/sdaal/`, `docs/tools/`

### Sistema Onion
- **35 comandos Claude Code** em `.claude/commands/`
  - 12 arquivos em `common/` (Templates e prompts compartilhados)
  - 9 comandos em `meta/` (Meta-comandos e criadores)
  - 6 comandos em `validate/` (Validações e testes)
  - 2 comandos globais (`onion.md`, `warm-up.md`)
  - 1 comando em `product/` (Gestão de produto)
  - 1 comando em `docs/` (Documentação)
  - 1 comando em `git/` (GitFlow)
  - 1 comando em `development/` (Desenvolvimento)
  - 1 comando em `onion/` (Sistema Onion)
  - 1 comando em `quick/` (Ações rápidas)
- **12 agentes IA** em `.claude/agents/`
  - 5 agentes em `compliance/` (Compliance e regulatório)
  - 4 agentes em `meta/` (Meta e orquestração)
  - 1 agente em `deployment/` (Deployment)
  - 1 agente em `research/` (Pesquisa)
  - 1 agente em `review/` (Code review)
- **28 documentos** de referência em `docs/onion/`

### Total
- **69 arquivos** de documentação markdown
- **35 comandos** disponíveis em múltiplas categorias
- **12 agentes** especializados em múltiplos domínios

---

## 📁 Estrutura de Documentação

```
docs/
├── INDEX.md                    # Este arquivo (hub central)
│
├── onion/                      # Sistema Onion (28 arquivos)
│   ├── commands-guide.md       # Guia completo de comandos
│   ├── agents-reference.md     # Referência de agentes
│   ├── engineering-flows.md   # Fluxos de engenharia
│   ├── clickup-integration.md  # Integração ClickUp MCP
│   ├── practical-examples.md   # Exemplos práticos
│   ├── getting-started.md      # Configuração inicial
│   ├── testing-validation-system.md  # Sistema de testes e validação
│   ├── tools-reference.md      # Referência de ferramentas
│   ├── claude-code-commands-architecture.md  # Arquitetura de comandos
│   ├── consolidated-project-documentation.md  # Documentação consolidada
│   ├── end-to-end-validation-tests.md  # Testes de validação E2E
│   ├── sistema-engenharia-reversa-guia-uso.md  # Engenharia reversa
│   ├── levels-system.md        # Sistema de níveis progressivos
│   ├── INSTALLATION.md         # Guia de instalação
│   ├── RELEASE-NOTES-v4.0-beta.md  # Notas de release v4.0
│   └── [outros arquivos de release e implementação]
│
├── knowledge-base/                   # Knowledge Bases (24 arquivos)
│   ├── concepts/               # Conceitos fundamentais (13 arquivos)
│   │   ├── abstraction-patterns-catalog.md
│   │   ├── ai-agent-design-patterns.md
│   │   ├── branding-posicionamento-marca.md
│   │   ├── configuration-management.md
│   │   ├── context-window-optimization.md
│   │   ├── framework_story_points.md
│   │   ├── framework_testes.md
│   │   ├── identificar-precificar-dor-cliente.md
│   │   ├── meeting-transcription-to-knowledge-base.md
│   │   ├── spec-as-code-strategy.md
│   │   ├── spec-driven-development.md  # ✨ NOVO
│   │   ├── specification-driven-ai-abstraction-layer.md
│   │   └── task-manager-abstraction.md
│   ├── frameworks/             # Frameworks e metodologias (7 arquivos)
│   │   ├── framework_story_points.md
│   │   ├── framework_testes.md
│   │   ├── onion-complete-cycle-understanding.md
│   │   ├── onion-ide-integration-strategy.md
│   │   ├── onion-multi-context-orchestrator-vision.md
│   │   ├── onion-system-critical-analysis-2025.md
│   │   └── spec-driven-development-tools-2025.md
│   ├── platforms/              # Plataformas e tecnologias (1 arquivo)
│   │   └── runflow.md
│   ├── providers/              # Provedores de serviços (1 arquivo)
│   │   └── microsoft-graph-teams-api-guia-completo.md
│   └── tools/                  # Ferramentas e recursos (2 arquivos)
│       ├── claude-code-commands-best-practices-2025.md
│       └── whisper.md          # Knowledge base do Whisper
│
├── meta-specs/                 # Meta Especificações (1 arquivo)
│   └── index.md                # Índice de meta specs
│
├── analysis/                   # Análises
│   └── unleash-alternatives-analysis.md
│
├── plans/                      # Planos de execução
│   └── [arquivos de planejamento]
│
├── sdaal/                      # Specification-Driven AI Abstraction Layer
│   └── [documentação SDAAL]
│
└── tools/                      # Ferramentas e recursos
    └── [documentação de ferramentas]
```

---

## 🧅 Sistema Onion

### 📖 Documentação Principal

#### Guias Essenciais
- **[Guia de Comandos](onion/commands-guide.md)** - Documentação completa de todos os comandos disponíveis
- **[Referência de Agentes](onion/agents-reference.md)** - Lista e descrição de todos os agentes especializados
- **[Fluxos de Engenharia](onion/engineering-flows.md)** - Workflows detalhados para desenvolvimento
- **[Sistema de Testes e Validação](onion/testing-validation-system.md)** - Framework completo de testes e validação
- **[Sistema de Níveis](onion/levels-system.md)** - Descoberta progressiva de comandos (v4.0) ✨ NOVO

#### Integrações e Configuração
- **[Integração ClickUp](onion/clickup-integration.md)** - Configuração avançada do ClickUp MCP
- **[Configuração Inicial](onion/getting-started.md)** - Setup completo do sistema
- **[Instalação](onion/INSTALLATION.md)** - Guia de instalação do Sistema Onion

#### Referências Técnicas
- **[Exemplos Práticos](onion/practical-examples.md)** - Casos de uso reais com exemplos
- **[Referência de Ferramentas](onion/tools-reference.md)** - Todas as ferramentas disponíveis
- **[Arquitetura de Comandos](onion/claude-code-commands-architecture.md)** - Estrutura interna dos comandos

#### Documentação Avançada
- **[Documentação Consolidada](onion/consolidated-project-documentation.md)** - Visão consolidada do projeto
- **[Testes de Validação E2E](onion/end-to-end-validation-tests.md)** - Testes end-to-end do sistema
- **[Guia de Engenharia Reversa](onion/sistema-engenharia-reversa-guia-uso.md)** - Engenharia reversa de projetos

#### Release Notes e Anúncios
- **[Release Notes v4.0 Beta](onion/RELEASE-NOTES-v4.0-beta.md)** - Novidades da versão 4.0 ✨ NOVO
- **[Anúncio v4.0 Beta.1](onion/ANNOUNCEMENT-v4.0-beta.1-docs.md)** - Anúncio da versão beta

### 🚀 Início Rápido

**Novo no sistema?** Comece aqui:

1. **[Configuração Inicial](onion/getting-started.md)** - Setup do ambiente
2. **[Guia de Comandos](onion/commands-guide.md)** - Aprenda os comandos principais
3. **[Exemplos Práticos](onion/practical-examples.md)** - Veja casos de uso reais
4. **[Sistema de Níveis](onion/levels-system.md)** - Entenda a descoberta progressiva (v4.0) ✨ NOVO

**Comando de entrada:**
```bash
/onion "Sou novo aqui, me ajude a começar"
```

---

## 📚 Knowledge Bases

Knowledge Bases estruturadas para consumo por IA e referência técnica:

### Conceitos Fundamentais (13 arquivos)
- **Task Manager Abstraction** - Abstração de gerenciadores de tarefas
- **Framework de Story Points** - Sistema de estimativas ágeis
- **Framework de Testes** - Metodologias de teste completas
- **Spec-as-Code Strategy** - Estratégia de especificações como código
- **Spec-Driven Development** - Metodologia emergente de desenvolvimento com IA ✨ NOVO
- **AI Agent Design Patterns** - Padrões de design para agentes IA
- **Abstraction Patterns Catalog** - Catálogo de padrões de abstração
- **Context Window Optimization** - Otimização de contexto para IA
- **Configuration Management** - Gestão de configurações
- **Branding e Posicionamento** - Estratégias de marca
- **Identificar e Precificar Dor do Cliente** - Metodologias de produto
- **Meeting Transcription to Knowledge Base** - Processamento de reuniões
- **Specification-Driven AI Abstraction Layer** - Camada de abstração orientada a especificações

### Frameworks e Metodologias (7 arquivos)
- **Framework de Story Points** - Estimativas ágeis
- **Framework de Testes** - White-box, Grey-box, Black-box
- **Onion Complete Cycle Understanding** - Sistema completo de 5 camadas
- **Onion IDE Integration Strategy** - Estratégia multi-IDE
- **Onion Multi-Context Orchestrator Vision** - Visão arquitetural
- **Onion System Critical Analysis 2025** - Análise crítica do sistema
- **Spec-Driven Development Tools 2025** - Ferramentas e análise

### Plataformas e Tecnologias (1 arquivo)
- **Runflow** - Documentação da plataforma

### Provedores de Serviços (1 arquivo)
- **Microsoft Graph Teams API** - Guia completo de integração

### Ferramentas (2 arquivos)
- **Claude Code Commands Best Practices 2025** - Boas práticas de comandos Claude Code
- **Whisper** - Sistema de transcrição de áudio (OpenAI)

**Localização:** `docs/knowledge-base/`

---

## 🏗️ Meta Especificações

Especificações de nível mais alto que servem como "constituição" do Sistema Onion:

- **[Índice de Meta Specs](meta-specs/index.md)** - Visão geral das meta especificações

**Propósito:**
- Definir princípios arquiteturais
- Estabelecer padrões de código
- Convenções de nomenclatura
- Regras de integração

**Localização:** `docs/meta-specs/`

---

## 📊 Análises e Planos

### Análises
- **[Análise de Alternativas Unleash](analysis/unleash-alternatives-analysis.md)** - Análise comparativa

### Planos de Execução
- Arquivos de planejamento em `docs/plans/`

---

## 🧭 Navegação por Perfil

### 👨‍💻 Para Desenvolvedores

**Comece com:**
1. [Configuração Inicial](onion/getting-started.md)
2. [Guia de Comandos](onion/commands-guide.md) - Seção "Comandos de Engenharia"
3. [Fluxos de Engenharia](onion/engineering-flows.md)
4. [Sistema de Testes e Validação](onion/testing-validation-system.md)
5. [Sistema de Níveis](onion/levels-system.md) - Descoberta progressiva ✨ NOVO

**Comandos essenciais:**
- `/engineer/start` - Iniciar desenvolvimento
- `/engineer/work` - Trabalhar em feature
- `/engineer/pr` - Criar Pull Request
- `/test/unit` - Testes unitários
- `/test/integration` - Testes de integração

**Agentes especializados:**
- `@react-developer` - Desenvolvimento React
- `@nodejs-specialist` - Backend Node.js
- `@nx-monorepo-specialist` - Monorepos NX
- `@c4-architecture-specialist` - Arquitetura C4
- `@whisper-specialist` - Transcrição de áudio com Whisper

### 📋 Para Product Owners

**Comece com:**
1. [Guia de Comandos](onion/commands-guide.md) - Seção "Comandos de Produto"
2. [Exemplos Práticos](onion/practical-examples.md)
3. [Knowledge Base - Story Points](knowledge-base/frameworks/framework_story_points.md)
4. [Knowledge Base - Spec-Driven Development](knowledge-base/concepts/spec-driven-development.md) ✨ NOVO

**Comandos essenciais:**
- `/product/task` - Criar tasks estruturadas
- `/product/spec` - Especificações técnicas
- `/product/estimate` - Estimar story points
- `/product/extract-meeting` - Extrair insights de reuniões
- `/product/consolidate-meetings` - Consolidação de múltiplas reuniões
- `/product/convert-to-tasks` - Converter documentos consolidados em tasks
- `/product/whisper` - Facilitador para uso do Whisper
- `/docs/consolidate-documents` - Consolidar múltiplos documentos
- `/validate/collab/three-amigos` - Sessões colaborativas

**Agentes especializados:**
- `@product-agent` - Orquestração de produto
- `@story-points-framework-specialist` - Estimativas ágeis
- `@storytelling-business-specialist` - Narrativas de negócio
- `@branding-positioning-specialist` - Branding e posicionamento
- `@extract-meeting-specialist` - Extração de reuniões
- `@meeting-consolidator` - Consolidação de reuniões

### 🧪 Para QA/Test Engineers

**Comece com:**
1. [Sistema de Testes e Validação](onion/testing-validation-system.md)
2. [Framework de Testes](knowledge-base/frameworks/framework_testes.md)
3. [Guia de Comandos](onion/commands-guide.md) - Seção "Comandos de Validação"

**Comandos essenciais:**
- `/test/unit` - Testes unitários (White-box)
- `/test/integration` - Testes de integração (Grey-box)
- `/test/e2e` - Testes end-to-end (Black-box)
- `/validate/test-strategy/create` - Criar estratégias de teste
- `/validate/qa-points/estimate` - Estimar QA points
- `/validate/collab/pair-testing` - Teste em par

**Agentes especializados:**
- `@test-agent` - Estratégias completas de teste
- `@test-engineer` - Implementação prática
- `@test-planner` - Planejamento e cobertura

### 🏗️ Para Arquitetos

**Comece com:**
1. [Arquitetura de Comandos](onion/claude-code-commands-architecture.md)
2. [Documentação Consolidada](onion/consolidated-project-documentation.md)
3. [Meta Especificações](meta-specs/index.md)
4. [Release Notes v4.0](onion/RELEASE-NOTES-v4.0-beta.md) - Arquitetura Multi-Context ✨ NOVO

**Recursos:**
- Agentes de arquitetura: `@c4-architecture-specialist`, `@mermaid-specialist`
- Comandos de documentação: `/docs/build-tech-docs`, `/docs/reverse-consolidate`
- Knowledge Bases: [SDAAL](knowledge-base/concepts/specification-driven-ai-abstraction-layer.md), [Spec-Driven Development](knowledge-base/concepts/spec-driven-development.md) ✨ NOVO

### 🔧 Para Administradores do Sistema

**Comece com:**
1. [Configuração Inicial](onion/getting-started.md)
2. [Instalação](onion/INSTALLATION.md) ✨ NOVO
3. [Integração ClickUp](onion/clickup-integration.md)
4. [Referência de Ferramentas](onion/tools-reference.md)

**Comandos essenciais:**
- `/meta/setup-integration` - Configurar integrações
- `/meta/all-tools` - Listar todas as ferramentas
- `/docs/build-index` - Reconstruir índices
- `/onion/setup` - Setup do Sistema Onion ✨ NOVO

### 🛡️ Para Compliance/Security

**Comece com:**
1. [Agentes de Compliance](onion/agents-reference.md#️-agentes-de-compliance)
2. [Comandos de Validação](onion/commands-guide.md#-comandos-de-validação)

**Agentes especializados:**
- `@iso-27001-specialist` - ISO 27001:2022
- `@iso-22301-specialist` - ISO 22301:2019
- `@soc2-specialist` - SOC2 Type II
- `@security-information-master` - Segurança da informação
- `@corporate-compliance-specialist` - Compliance corporativo

---

## 🗺️ Mapa de Navegação Rápida

### Por Tipo de Documento

| Tipo | Localização | Descrição |
|------|-------------|-----------|
| 📖 **Guias** | `docs/onion/` | Guias de uso e referência |
| 📚 **Knowledge Bases** | `docs/knowledge-base/` | Conhecimento estruturado para IA |
| 🏗️ **Meta Specs** | `docs/meta-specs/` | Especificações de alto nível |
| 📊 **Análises** | `docs/analysis/` | Análises e estudos |
| 📋 **Planos** | `docs/plans/` | Planos de execução |
| 🔧 **SDAAL** | `docs/sdaal/` | Specification-Driven AI Abstraction Layer |

### Por Categoria de Comando

| Categoria | Comandos | Documentação |
|-----------|---------|--------------|
| 🔧 **Engenharia** | `/engineer/*` | [Guia de Comandos](onion/commands-guide.md#-comandos-de-engenharia) |
| 📋 **Produto** | `/product/*` | [Guia de Comandos](onion/commands-guide.md#-comandos-de-produto) |
| 🧪 **Testes** | `/test/*` | [Sistema de Testes](onion/testing-validation-system.md) |
| ✅ **Validação** | `/validate/*` | [Sistema de Testes](onion/testing-validation-system.md) |
| 📚 **Documentação** | `/docs/*` | [Guia de Comandos](onion/commands-guide.md#-comandos-de-documentação) |
| 🌿 **Git** | `/git/*` | [Guia de Comandos](onion/commands-guide.md#-comandos-git) |
| ⚙️ **Meta** | `/meta/*` | [Guia de Comandos](onion/commands-guide.md#-comandos-meta) |
| 🧅 **Onion** | `/onion/*` | [Sistema Onion](onion/) |
| ⚡ **Quick** | `/quick/*` | [Guia de Comandos](onion/commands-guide.md) |

### Por Categoria de Agente

| Categoria | Agentes | Documentação |
|-----------|---------|--------------|
| 🛡️ **Compliance** | `compliance/` (5) | [Referência de Agentes](onion/agents-reference.md#️-agentes-de-compliance) |
| 🔴 **Meta** | `meta/` (4) | [Referência de Agentes](onion/agents-reference.md#-agentes-meta) |
| ⚙️ **Deployment** | `deployment/` (1) | [Referência de Agentes](onion/agents-reference.md) |
| 🟣 **Pesquisa** | `research/` (1) | [Referência de Agentes](onion/agents-reference.md#-agentes-de-pesquisa) |
| 🟢 **Review** | `review/` (1) | [Referência de Agentes](onion/agents-reference.md#-agentes-de-review) |

---

## 🔗 Links Rápidos

### Documentação Essencial
- [README Principal](../../README.md) - Visão geral do Sistema Onion v4.0 Beta
- [Guia de Comandos](onion/commands-guide.md) - Todos os comandos
- [Referência de Agentes](onion/agents-reference.md) - Todos os agentes
- [Sistema de Testes e Validação](onion/testing-validation-system.md) - Framework completo
- [Sistema de Níveis](onion/levels-system.md) - Descoberta progressiva ✨ NOVO
- [Release Notes v4.0](onion/RELEASE-NOTES-v4.0-beta.md) - Novidades da versão ✨ NOVO

### Knowledge Bases
- [Task Manager Abstraction](knowledge-base/concepts/task-manager-abstraction.md)
- [Framework de Story Points](knowledge-base/frameworks/framework_story_points.md)
- [Framework de Testes](knowledge-base/frameworks/framework_testes.md)
- [AI Agent Design Patterns](knowledge-base/concepts/ai-agent-design-patterns.md)
- [Spec-as-Code Strategy](knowledge-base/concepts/spec-as-code-strategy.md)
- [Spec-Driven Development](knowledge-base/concepts/spec-driven-development.md) ✨ NOVO
- [Whisper](knowledge-base/tools/whisper.md) - Transcrição de áudio

### Configuração
- [Configuração Inicial](onion/getting-started.md)
- [Instalação](onion/INSTALLATION.md) ✨ NOVO
- [Integração ClickUp](onion/clickup-integration.md)

---

## 🆕 Novidades

### ✨ Documentação Adicionada Recentemente

- **[Spec-Driven Development](knowledge-base/concepts/spec-driven-development.md)** (2025-12-02)
  - Knowledge base completa sobre metodologia emergente
  - Análise de ferramentas (Kiro, Spec-Kit, Tessl)
  - Níveis de implementação (Spec-First, Spec-Anchored, Spec-as-Source)
  - Comparação com TDD, BDD, MDD
  - Benefícios e desafios

- **[Sistema de Testes e Validação](onion/testing-validation-system.md)** (2025-12-02)
  - Framework completo de testes e validação
  - 4 camadas integradas (Knowledge Base, Agentes, Comandos de Teste, Comandos de Validação)
  - Guia completo para desenvolvedores, QA e times cross-funcionais

- **[Sistema de Níveis](onion/levels-system.md)** (v4.0)
  - Descoberta progressiva de comandos
  - Organização por níveis (starter, intermediate, advanced)
  - Redução de 90% no tempo de onboarding

- **[Release Notes v4.0 Beta](onion/RELEASE-NOTES-v4.0-beta.md)**
  - Arquitetura Multi-Context
  - Melhorias significativas em onboarding e organização
  - Suporte multi-IDE

- **Comandos de Produto Expandidos**
  - `/product/extract-meeting` - Extração inteligente de insights de reuniões
  - `/product/consolidate-meetings` - Consolidação de múltiplas reuniões
  - `/product/convert-to-tasks` - Converter documentos consolidados em tasks
  - `/product/whisper` - Facilitador para uso do Whisper
  - `/docs/consolidate-documents` - Consolidar múltiplos documentos
  - Agente `@meeting-consolidator` - Consolidação avançada de reuniões
  - Agente `@whisper-specialist` - Especialista em transcrição de áudio
  - Knowledge Base Whisper - Documentação completa do Whisper

---

## 📞 Suporte e Recursos

### 🆘 Resolução de Problemas

1. **Comandos**: Consulte [Guia de Comandos](onion/commands-guide.md)
2. **Exemplos**: Veja casos práticos em [Exemplos Práticos](onion/practical-examples.md)
3. **Configuração**: Siga [Configuração Inicial](onion/getting-started.md)
4. **Instalação**: Consulte [Instalação](onion/INSTALLATION.md) ✨ NOVO
5. **Testes**: Consulte [Sistema de Testes e Validação](onion/testing-validation-system.md)

### 🔧 Comandos de Debug

```bash
/onion "ajuda"                  # Ponto de entrada inteligente
/meta/all-tools                 # Lista todos os comandos
/docs/build-index               # Reconstruir este índice
@onion "sua pergunta"           # Agente orquestrador master
```

---

## 🔄 Manutenção

Este índice é gerado automaticamente pelo comando `/docs/build-index`.

**Para atualizar:**
```bash
/docs/build-index              # Reconstruir índice principal
/docs/build-index onion        # Reconstruir índice da seção onion
```

**Última atualização:** 2025-12-20  
**Versão:** 4.1.0-beta.1  
**Mantido por:** Sistema Onion

---

**Sistema Onion v4.0 Beta** - Multi-Context Development Orchestrator 🧅
