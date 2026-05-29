---
title: Meta-spec — Padrões para Skills e Comandos do Sistema Onion
date: 2026-05-28
version: 2.0.0
level: L0
status: active
gate-keeper: "@metaspec-gate-keeper"
---

# Meta-spec — Padrões para Skills e Comandos do Sistema Onion

## Propósito

Definir o padrão canônico de automações do Onion em Cursor 3.6+, com skills como mecanismo primário e comandos legados como camada de compatibilidade.

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

### 1.2 Comandos (legado)

Local: `.cursor/commands/**/*.md`

Uso: compatibilidade e transição. Novas automações devem priorizar skills.

---

## 2. Workflows faseados (invariantes)

Estes workflows são invariantes do framework e não devem ser consolidados:

- Produto: `collect -> refine -> spec -> feature`
- Engenharia: `plan -> start -> work -> pre-pr -> pr -> pr-update`

Cada fase deve manter input, output e persistência de estado em `.cursor/sessions/<feature-slug>/`.

---

## 3. Naming e organização

- Skills em kebab-case
- Nome da pasta deve casar com `name`
- Comandos legados mantêm a estrutura por categoria para rastreabilidade

---

## 4. Limites de tamanho

- Skill: recomendado até 500 linhas; hard limit 800
- Comando legado: manter estável e migrar para skill quando houver refactor funcional

---

## 5. Proibições explícitas

- Proibido criar automação nova apenas em `.cursor/commands/`
- Proibido usar placeholders legados não suportados como base canônica
- Proibido quebrar os workflows invariantes

---

## 6. Legado

A base histórica em `.cursor/commands/` foi substituída operacionalmente por `.cursor/skills/` e `.cursor/commands/`. Referências ao modelo antigo devem ser tratadas como documentação de migração.
