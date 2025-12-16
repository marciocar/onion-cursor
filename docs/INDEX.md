# 📚 Índice Central de Documentação

> **Última atualização**: 2025-12-02 | **Gerado por**: `/docs/build-index`

Bem-vindo ao índice central de documentação do projeto. Este documento serve como hub de navegação para toda a documentação disponível.

---

## 🎯 Visão Geral

Este projeto utiliza o **Sistema Onion v3.0** - um framework avançado de comandos `.cursor/` que revoluciona o desenvolvimento com:

- 🤖 **90 comandos especializados** organizados em categorias funcionais
- 🎯 **46 agentes de IA especializados** em múltiplos domínios
- 📚 **Knowledge Bases estruturadas** para consumo por IA
- 🧅 **Comando `/onion`** - ponto de entrada inteligente
- 🔗 **Task Manager Abstraction** para ClickUp, Asana e Linear

---

## 📊 Estatísticas da Documentação

### Documentação Principal
- **33 arquivos markdown** em `docs/` (incluindo este índice)
- **12 arquivos** em `docs/onion/` (Sistema Onion)
- **17 arquivos** em `docs/knowbase/` (Knowledge Bases)
  - 12 arquivos em `concepts/` (Conceitos fundamentais)
  - 2 arquivos em `frameworks/` (Frameworks e metodologias)
  - 1 arquivo em `platforms/` (Plataformas)
  - 2 arquivos em `tools/` (Ferramentas) ✨ NOVO
- **1 arquivo** em `docs/meta-specs/` (Meta Especificações)
- **1 arquivo** em `docs/analysis/` (Análises)
- **1 arquivo** em `docs/plans/` (Planos de execução)

### Sistema Onion
- **90 comandos Cursor** em `.cursor/commands/`
  - 21 comandos em `product/` (Gestão de produto) ✨ NOVO
  - 13 comandos em `git/` (GitFlow e operações Git)
  - 11 comandos em `engineer/` (Fluxos de desenvolvimento)
  - 11 comandos em `docs/` (Documentação) ✨ NOVO
  - 9 comandos em `meta/` (Meta-comandos e criadores)
  - 6 comandos em `validate/` (Validações e testes)
  - 3 comandos em `test/` (Testes unitários, integração, E2E)
  - 1 comando em `quick/` (Ações rápidas)
  - 2 comandos globais (`onion.md`, `warm-up.md`)
- **46 agentes IA** em `.cursor/agents/`
  - 18 agentes em `development/` (Desenvolvimento especializado) ✨ NOVO
  - 8 agentes em `product/` (Produto e negócio)
  - 5 agentes em `compliance/` (Compliance e regulatório)
  - 4 agentes em `git/` (Git e branches)
  - 4 agentes em `meta/` (Meta e orquestração)
  - 3 agentes em `testing/` (Testes e QA)
  - 2 agentes em `review/` (Code review)
  - 1 agente em `research/` (Pesquisa)
  - 1 agente em `deployment/` (Deployment)
- **12 documentos** de referência em `docs/onion/`

### Total
- **33 arquivos** de documentação markdown
- **90 comandos** disponíveis
- **46 agentes** especializados

---

## 📁 Estrutura de Documentação

```
docs/
├── INDEX.md                    # Este arquivo (hub central)
│
├── onion/                      # Sistema Onion (12 arquivos)
│   ├── commands-guide.md       # Guia completo de comandos
│   ├── agents-reference.md     # Referência de agentes
│   ├── engineering-flows.md   # Fluxos de engenharia
│   ├── clickup-integration.md  # Integração ClickUp MCP
│   ├── practical-examples.md   # Exemplos práticos
│   ├── getting-started.md      # Configuração inicial
│   ├── testing-validation-system.md  # Sistema de testes e validação ✨ NOVO
│   ├── tools-reference.md      # Referência de ferramentas
│   ├── cursor-commands-architecture.md  # Arquitetura de comandos
│   ├── consolidated-project-documentation.md  # Documentação consolidada
│   ├── end-to-end-validation-tests.md  # Testes de validação E2E
│   ├── sistema-engenharia-reversa-guia-uso.md  # Engenharia reversa
│   └── phase-subtask-sync-fix.md  # Documentação técnica
│
├── knowbase/                   # Knowledge Bases (17 arquivos) ✨ NOVO
│   ├── concepts/               # Conceitos fundamentais (12 arquivos)
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
│   │   ├── specification-driven-ai-abstraction-layer.md
│   │   └── task-manager-abstraction.md
│   ├── frameworks/             # Frameworks e metodologias (2 arquivos)
│   │   ├── framework_story_points.md
│   │   └── framework_testes.md
│   ├── platforms/              # Plataformas e tecnologias (1 arquivo)
│   │   └── runflow.md
│   └── tools/                  # Ferramentas e recursos (2 arquivos) ✨ NOVO
│       ├── cursor-commands-best-practices-2025.md
│       └── whisper.md          # Knowledge base do Whisper ✨ NOVO
│
├── meta-specs/                 # Meta Especificações (1 arquivo)
│   └── index.md                # Índice de meta specs
│
├── analysis/                   # Análises (1 arquivo)
│   └── unleash-alternatives-analysis.md
│
└── plans/                      # Planos de execução (1 arquivo)
    └── flagsmith-poc-execution-plan.md
```

---

## 🧅 Sistema Onion

### 📖 Documentação Principal

#### Guias Essenciais
- **[Guia de Comandos](onion/commands-guide.md)** - Documentação completa de todos os 90 comandos disponíveis
- **[Referência de Agentes](onion/agents-reference.md)** - Lista e descrição de todos os 46 agentes especializados
- **[Fluxos de Engenharia](onion/engineering-flows.md)** - Workflows detalhados para desenvolvimento
- **[Sistema de Testes e Validação](onion/testing-validation-system.md)** - Framework completo de testes e validação ✨ NOVO

#### Integrações e Configuração
- **[Integração ClickUp](onion/clickup-integration.md)** - Configuração avançada do ClickUp MCP
- **[Configuração Inicial](onion/getting-started.md)** - Setup completo do sistema

#### Referências Técnicas
- **[Exemplos Práticos](onion/practical-examples.md)** - Casos de uso reais com exemplos
- **[Referência de Ferramentas](onion/tools-reference.md)** - Todas as ferramentas disponíveis
- **[Arquitetura de Comandos](onion/cursor-commands-architecture.md)** - Estrutura interna dos comandos

#### Documentação Avançada
- **[Documentação Consolidada](onion/consolidated-project-documentation.md)** - Visão consolidada do projeto
- **[Testes de Validação E2E](onion/end-to-end-validation-tests.md)** - Testes end-to-end do sistema
- **[Guia de Engenharia Reversa](onion/sistema-engenharia-reversa-guia-uso.md)** - Engenharia reversa de projetos

### 🚀 Início Rápido

**Novo no sistema?** Comece aqui:

1. **[Configuração Inicial](onion/getting-started.md)** - Setup do ambiente
2. **[Guia de Comandos](onion/commands-guide.md)** - Aprenda os comandos principais
3. **[Exemplos Práticos](onion/practical-examples.md)** - Veja casos de uso reais

**Comando de entrada:**
```bash
/onion "Sou novo aqui, me ajude a começar"
```

---

## 📚 Knowledge Bases

Knowledge Bases estruturadas para consumo por IA e referência técnica:

### Conceitos Fundamentais (12 arquivos)
- **Task Manager Abstraction** - Abstração de gerenciadores de tarefas
- **Framework de Story Points** - Sistema de estimativas ágeis
- **Framework de Testes** - Metodologias de teste completas
- **Spec-as-Code Strategy** - Estratégia de especificações como código
- **AI Agent Design Patterns** - Padrões de design para agentes IA
- **Abstraction Patterns Catalog** - Catálogo de padrões de abstração
- **Context Window Optimization** - Otimização de contexto para IA
- **Configuration Management** - Gestão de configurações
- **Branding e Posicionamento** - Estratégias de marca
- **Identificar e Precificar Dor do Cliente** - Metodologias de produto
- **Meeting Transcription to Knowledge Base** - Processamento de reuniões
- **Specification-Driven AI Abstraction Layer** - Camada de abstração orientada a especificações

### Frameworks e Metodologias (2 arquivos)
- **Framework de Story Points** - Estimativas ágeis
- **Framework de Testes** - White-box, Grey-box, Black-box

### Plataformas e Tecnologias (1 arquivo)
- **Runflow** - Documentação da plataforma

### Ferramentas (2 arquivos) ✨ NOVO
- **Cursor Commands Best Practices 2025** - Boas práticas de comandos Cursor
- **Whisper** - Sistema de transcrição de áudio (OpenAI) ✨ NOVO

**Localização:** `docs/knowbase/`

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
- **[Plano de Execução Flagsmith POC](plans/flagsmith-poc-execution-plan.md)** - Plano de prova de conceito

---

## 🧭 Navegação por Perfil

### 👨‍💻 Para Desenvolvedores

**Comece com:**
1. [Configuração Inicial](onion/getting-started.md)
2. [Guia de Comandos](onion/commands-guide.md) - Seção "Comandos de Engenharia"
3. [Fluxos de Engenharia](onion/engineering-flows.md)
4. [Sistema de Testes e Validação](onion/testing-validation-system.md)

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
- `@whisper-specialist` - Transcrição de áudio com Whisper ✨ NOVO

### 📋 Para Product Owners

**Comece com:**
1. [Guia de Comandos](onion/commands-guide.md) - Seção "Comandos de Produto"
2. [Exemplos Práticos](onion/practical-examples.md)
3. [Knowledge Base - Story Points](knowbase/frameworks/framework_story_points.md)

**Comandos essenciais:**
- `/product/task` - Criar tasks estruturadas
- `/product/spec` - Especificações técnicas
- `/product/estimate` - Estimar story points
- `/product/extract-meeting` - Extrair insights de reuniões
- `/product/consolidate-meetings` - Consolidação de múltiplas reuniões
- `/product/convert-to-tasks` - Converter documentos consolidados em tasks ✨ NOVO
- `/product/whisper` - Facilitador para uso do Whisper ✨ NOVO
- `/docs/consolidate-documents` - Consolidar múltiplos documentos ✨ NOVO
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
1. [Sistema de Testes e Validação](onion/testing-validation-system.md) ✨ NOVO
2. [Framework de Testes](knowbase/frameworks/framework_testes.md)
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
1. [Arquitetura de Comandos](onion/cursor-commands-architecture.md)
2. [Documentação Consolidada](onion/consolidated-project-documentation.md)
3. [Meta Especificações](meta-specs/index.md)

**Recursos:**
- Agentes de arquitetura: `@c4-architecture-specialist`, `@mermaid-specialist`
- Comandos de documentação: `/docs/build-tech-docs`, `/docs/reverse-consolidate`

### 🔧 Para Administradores do Sistema

**Comece com:**
1. [Configuração Inicial](onion/getting-started.md)
2. [Integração ClickUp](onion/clickup-integration.md)
3. [Referência de Ferramentas](onion/tools-reference.md)

**Comandos essenciais:**
- `/meta/setup-integration` - Configurar integrações
- `/meta/all-tools` - Listar todas as ferramentas
- `/docs/build-index` - Reconstruir índices

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
| 📚 **Knowledge Bases** | `docs/knowbase/` | Conhecimento estruturado para IA |
| 🏗️ **Meta Specs** | `docs/meta-specs/` | Especificações de alto nível |
| 📊 **Análises** | `docs/analysis/` | Análises e estudos |
| 📋 **Planos** | `docs/plans/` | Planos de execução |

### Por Categoria de Comando

| Categoria | Comandos | Documentação |
|-----------|---------|--------------|
| 🔧 **Engenharia** | `/engineer/*` (11) | [Guia de Comandos](onion/commands-guide.md#-comandos-de-engenharia) |
| 📋 **Produto** | `/product/*` (21) | [Guia de Comandos](onion/commands-guide.md#-comandos-de-produto) |
| 🧪 **Testes** | `/test/*` (3) | [Sistema de Testes](onion/testing-validation-system.md) |
| ✅ **Validação** | `/validate/*` (6) | [Sistema de Testes](onion/testing-validation-system.md) |
| 📚 **Documentação** | `/docs/*` (11) | [Guia de Comandos](onion/commands-guide.md#-comandos-de-documentação) |
| 🌿 **Git** | `/git/*` (13) | [Guia de Comandos](onion/commands-guide.md#-comandos-git) |
| ⚙️ **Meta** | `/meta/*` (9) | [Guia de Comandos](onion/commands-guide.md#-comandos-meta) |
| ⚡ **Quick** | `/quick/*` (1) | [Guia de Comandos](onion/commands-guide.md) |

### Por Categoria de Agente

| Categoria | Agentes | Documentação |
|-----------|---------|--------------|
| 🔵 **Desenvolvimento** | `development/` (18) | [Referência de Agentes](onion/agents-reference.md#-agentes-de-desenvolvimento) |
| 🟡 **Produto** | `product/` (8) | [Referência de Agentes](onion/agents-reference.md#-agentes-de-produto) |
| 🛡️ **Compliance** | `compliance/` (5) | [Referência de Agentes](onion/agents-reference.md#️-agentes-de-compliance) |
| 🌲 **Git** | `git/` (4) | [Referência de Agentes](onion/agents-reference.md#-agentes-git) |
| 🔴 **Meta** | `meta/` (4) | [Referência de Agentes](onion/agents-reference.md#-agentes-meta) |
| 🧪 **Testes** | `testing/` (3) | [Referência de Agentes](onion/agents-reference.md#-agentes-de-testes) |
| 🟢 **Review** | `review/` (2) | [Referência de Agentes](onion/agents-reference.md#-agentes-de-review) |
| 🟣 **Pesquisa** | `research/` (1) | [Referência de Agentes](onion/agents-reference.md#-agentes-de-pesquisa) |
| ⚙️ **Deployment** | `deployment/` (1) | [Referência de Agentes](onion/agents-reference.md) |

---

## 🔗 Links Rápidos

### Documentação Essencial
- [README Principal](../../README.md) - Visão geral do Sistema Onion
- [Guia de Comandos](onion/commands-guide.md) - Todos os comandos
- [Referência de Agentes](onion/agents-reference.md) - Todos os agentes
- [Sistema de Testes e Validação](onion/testing-validation-system.md) - Framework completo ✨ NOVO

### Knowledge Bases
- [Task Manager Abstraction](knowbase/concepts/task-manager-abstraction.md)
- [Framework de Story Points](knowbase/frameworks/framework_story_points.md)
- [Framework de Testes](knowbase/frameworks/framework_testes.md)
- [AI Agent Design Patterns](knowbase/concepts/ai-agent-design-patterns.md)
- [Spec-as-Code Strategy](knowbase/concepts/spec-as-code-strategy.md)
- [Whisper](knowbase/tools/whisper.md) - Transcrição de áudio ✨ NOVO

### Configuração
- [Configuração Inicial](onion/getting-started.md)
- [Integração ClickUp](onion/clickup-integration.md)

---

## 🆕 Novidades

### ✨ Documentação Adicionada Recentemente

- **[Sistema de Testes e Validação](onion/testing-validation-system.md)** (2025-12-02)
  - Framework completo de testes e validação
  - 4 camadas integradas (Knowledge Base, Agentes, Comandos de Teste, Comandos de Validação)
  - Guia completo para desenvolvedores, QA e times cross-funcionais

- **Comandos de Produto Expandidos** (2025-12-02)
  - `/product/extract-meeting` - Extração inteligente de insights de reuniões
  - `/product/consolidate-meetings` - Consolidação de múltiplas reuniões
  - `/product/convert-to-tasks` - Converter documentos consolidados em tasks ✨ NOVO
  - `/product/whisper` - Facilitador para uso do Whisper ✨ NOVO
  - `/docs/consolidate-documents` - Consolidar múltiplos documentos ✨ NOVO
  - Agente `@meeting-consolidator` - Consolidação avançada de reuniões
  - Agente `@whisper-specialist` - Especialista em transcrição de áudio ✨ NOVO
  - Knowledge Base Whisper - Documentação completa do Whisper ✨ NOVO

---

## 📞 Suporte e Recursos

### 🆘 Resolução de Problemas

1. **Comandos**: Consulte [Guia de Comandos](onion/commands-guide.md)
2. **Exemplos**: Veja casos práticos em [Exemplos Práticos](onion/practical-examples.md)
3. **Configuração**: Siga [Configuração Inicial](onion/getting-started.md)
4. **Testes**: Consulte [Sistema de Testes e Validação](onion/testing-validation-system.md)

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

**Última atualização:** 2025-12-02  
**Versão:** 3.0.0  
**Mantido por:** Sistema Onion

---

**Sistema Onion v3.0** - Framework avançado de comandos e agentes para desenvolvimento ágil com IA 🧅
