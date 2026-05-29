---
title: Meta-spec — Padrões para Skills e Comandos do Sistema Onion
date: 2026-05-28
version: 2.1.0
level: L0
status: active
gate-keeper: "@metaspec-gate-keeper"
---

# Meta-spec — Padrões para Skills do Sistema Onion

## Propósito

Definir o padrão canônico de automações do Onion em Cursor 3.6+, com **skills** como único mecanismo de workflows invocáveis.

---

## 1. Artefatos suportados

### 1.1 Skills (canônico)

Local: `.cursor/skills/<skill-name>/SKILL.md`

Frontmatter mínimo:

```yaml
---
name: <kebab-case>
description: <o que faz e quando usar>
---
```

Opcional por skill:
- `references/` — templates, prompts e docs de apoio
- `scripts/` — automações executáveis
- `disable-model-invocation: true` — workflows explícitos (slash only)
- `paths` — ativação contextual

### 1.2 Subagentes (complementar)

Local: `.cursor/agents/<agent-name>.md` — delegação especializada (`@jira-specialist`, etc.)

### 1.3 Classificação `disable-model-invocation`

| Tipo | Prefixos / skills | Flag |
|------|-------------------|------|
| Workflow explícito | `engineer-*`, `product-*`, `git-*`, `test-*`, `validate-*`, `docs-*`, `meta-*`, `onion`, `warm-up` | `true` |
| Contextual | `language-standards`, `onion-patterns`, `onion-validation` | omitir; usar `paths` |

---

## 2. Workflows faseados (invariantes)

Estes workflows são invariantes do framework e não devem ser consolidados:

- Produto: `collect -> refine -> spec -> feature`
- Engenharia: `plan -> start -> work -> pre-pr -> pr -> pr-update`

Cada fase deve manter input, output e persistência de estado em `.cursor/sessions/<feature-slug>/`.

---

## 3. Naming e organização

- Skills em kebab-case achatado (`engineer-start`, não `engineer/start`)
- Nome da pasta deve casar com `name`
- Prompts compartilhados em `references/` da skill proprietária

---

## 4. Limites de tamanho

- Skill: recomendado até 500 linhas; hard limit 800
- Conteúdo extenso → mover para `references/`

---

## 5. Proibições explícitas

- Proibido recriar `.cursor/commands/` para novas automações
- Proibido quebrar os workflows invariantes
- Proibido duplicar skill + command para o mesmo workflow

---

## 6. Legado

A pasta `.cursor/commands/` foi **removida** (2026-05-29). Conteúdo migrado para:
- Skills em `.cursor/skills/<name>/SKILL.md`
- Prompts em `references/` das skills consumidoras
- Ajuda global absorvida em `/onion`
