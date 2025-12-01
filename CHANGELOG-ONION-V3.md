# 🧅 Changelog - Sistema Onion v3.0.0

> **Data de Release**: 2025-11-24
> **Versão Anterior**: v2.x (não versionado formalmente)

## 📊 Resumo Executivo

| Métrica | Antes | Depois | Mudança |
|---------|-------|--------|---------|
| Comandos | ~60 | 56 | Consolidados |
| Agentes | ~35 | 38 | +3 reorganizados |
| Regras | 2 | 4 | +2 novas |
| Knowledge Bases | 0 | 5 | +5 novas |
| Linhas médias/comando | ~400+ | 136 | **-66%** |
| Comandos >400 linhas | 18 | 0 | **-100%** |

---

## 🆕 Novidades

### Knowledge Bases (5 novas)

Criadas em `docs/knowbase/`:

| KB | Descrição |
|----|-----------|
| `cursor-commands-best-practices-2025.md` | Padrões atualizados de comandos Cursor |
| `spec-as-code-strategy.md` | Estratégia de especificações como código |
| `ai-agent-design-patterns.md` | Padrões de design para agentes IA |
| `context-window-optimization.md` | Otimização de contexto e tokens |
| `configuration-management.md` | Gestão de configurações e .env |

### Novas Regras

| Regra | Descrição |
|-------|-----------|
| `onion-patterns.mdc` | Padrões de nomenclatura, sessions, convenções |
| `validation-rules.mdc` | Regras de validação para agentes e comandos |

### Novos Comandos

| Comando | Descrição |
|---------|-----------|
| `/meta/setup-integration` | Configuração guiada de integrações e .env |

### Prompts Modulares

Criados em `.cursor/commands/common/prompts/`:

- `clickup-patterns.md` - Padrões de formatação ClickUp
- `validation-rules.md` - Regras de validação reutilizáveis
- `output-formats.md` - Formatos de saída padrão
- `code-review-checklist.md` - Checklist de code review
- `git-workflow-patterns.md` - Padrões de Git workflow

---

## 🔄 Mudanças Estruturais

### Reorganização de Agentes

**11 agentes movidos da raiz para subpastas:**

| Agente | De | Para |
|--------|----|----|
| `product-agent.md` | `.cursor/agents/` | `product/` |
| `code-reviewer.md` | `.cursor/agents/` | `review/` |
| `test-engineer.md` | `.cursor/agents/` | `testing/` (nova) |
| `test-planner.md` | `.cursor/agents/` | `testing/` (nova) |
| `research-agent.md` | `.cursor/agents/` | `research/` (nova) |
| `branch-code-reviewer.md` | `.cursor/agents/` | `git/` (nova) |
| `branch-documentation-writer.md` | `.cursor/agents/` | `git/` |
| `branch-metaspec-checker.md` | `.cursor/agents/` | `git/` |
| `branch-test-planner.md` | `.cursor/agents/` | `git/` |
| `react-developer.md` | `.cursor/agents/` | `development/` |
| `metaspec-gate-keeper.md` | `.cursor/agents/` | `meta/` |

**1 agente movido entre pastas:**

| Agente | De | Para |
|--------|----|----|
| `postgres-specialist.md` | `data/` | `development/` |

**Pasta removida:** `.cursor/agents/data/` (vazia após movimentação)

### Novas Pastas de Agentes

- `.cursor/agents/testing/` - Agentes de testes
- `.cursor/agents/research/` - Agentes de pesquisa
- `.cursor/agents/git/` - Agentes de Git/branch

### Estrutura de Sessions

Padronizada em `.cursor/sessions/<feature-slug>/`:
```
.cursor/sessions/<feature-slug>/
├── context.md        # Contexto e IDs ClickUp
├── architecture.md   # Decisões arquiteturais
├── plan.md           # Plano de fases
└── notes.md          # Notas de desenvolvimento
```

---

## 📝 Padronizações

### Headers YAML

**Todos os 56 comandos** agora incluem:
```yaml
---
name: nome-comando
description: Descrição clara
model: sonnet
category: categoria
tags: [tag1, tag2]
version: "3.0.0"
updated: "2025-11-24"
---
```

**Todos os 38 agentes** agora incluem:
```yaml
---
name: nome-agente
description: Especialização
model: sonnet
category: categoria
expertise: [area1, area2, area3]
version: "3.0.0"
updated: "2025-11-24"
---
```

### Regras Atualizadas

| Regra | Mudança |
|-------|---------|
| `language-and-documentation.mdc` | Atualizado para v3.0.0, seção .env, referência às KBs |
| `nx-rules.mdc` | Mantido (auto-gerado pelo Nx Console) |

---

## ⚡ Otimizações

### Redução de Linhas por Comando

| Comando | Antes | Depois | Redução |
|---------|-------|--------|---------|
| `git/code-review.md` | 1941 | 210 | **-89%** |
| `git/sync.md` | 1247 | 200 | **-84%** |
| `product/presentation.md` | 990 | 180 | **-82%** |
| `docs/reverse-consolidate.md` | 949 | 180 | **-81%** |
| `meta/analyze-complex-problem.md` | 906 | 200 | **-78%** |
| `onion.md` | 803 | 150 | **-81%** |
| `meta/create-agent.md` | 718 | 200 | **-72%** |
| `engineer/hotfix.md` | 694 | 200 | **-71%** |

### Validações nos Geradores

**/meta/create-agent** agora valida:
- Duplicação de nome
- Categoria válida (8 opções)
- Expertise (3-5 áreas)

**/meta/create-command** agora valida:
- Duplicação de nome
- Formato kebab-case
- Categoria válida (8 opções)
- Limite de 400 linhas

---

## 🔧 Agentes Agnósticos

**Remoção de MCPs de agentes genéricos:**
- Agentes de desenvolvimento agora são portáteis
- MCPs apenas em agentes especializados (clickup-specialist, etc.)
- Seção "Integrações Opcionais" em agentes que podem usar MCPs

---

## 📁 Arquivos Removidos

| Arquivo | Razão |
|---------|-------|
| `.cursor/commands/all-tools.md` (raiz) | Duplicado de `meta/all-tools.md` |

---

## ⚠️ Breaking Changes

**Nenhum breaking change significativo.**

As seguintes mudanças podem requerer atenção:

1. **Referências a agentes na raiz**: Agentes movidos da raiz para subpastas. Atualize referências de `@agent-name` se necessário (o sistema resolve automaticamente).

2. **Estrutura de sessions**: Novo padrão em `.cursor/sessions/<slug>/` com 4 arquivos obrigatórios.

---

## 🚀 Próximos Passos Sugeridos

1. Executar `/warm-up` para validar o ambiente
2. Revisar `.env.example` para configurar integrações
3. Testar fluxos principais (`/product/task`, `/engineer/start`)
4. Consultar Knowledge Bases em `docs/knowbase/`

---

## 📚 Documentação Relacionada

- [Guia de Comandos](docs/onion/commands-guide.md)
- [Referência de Agentes](docs/onion/agents-reference.md)
- [Fluxos de Engenharia](docs/onion/engineering-flows.md)
- [Getting Started](docs/onion/getting-started.md)

---

**Mantido por**: Sistema Onion
**Versão**: 3.0.0
**Data**: 2025-11-24

