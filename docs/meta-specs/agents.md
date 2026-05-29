---
title: Meta-spec — Padrões para Subagentes do Sistema Onion
date: 2026-05-28
version: 2.0.0
level: L0
status: active
gate-keeper: "@metaspec-gate-keeper"
---

# Meta-spec — Padrões para Subagentes do Sistema Onion

## Propósito

Definir padrões obrigatórios para subagentes Cursor em `.cursor/agents/`, garantindo consistência de naming, escopo e delegação.

---

## 1. Estrutura obrigatória

Cada subagente deve usar frontmatter com, no mínimo:

```yaml
---
name: <kebab-case-slug>
description: <quando invocar este subagente>
---
```

Campos opcionais permitidos:

- `model` (`inherit` ou model id suportado)
- `readonly` (`true` para agentes de auditoria/revisão)
- `is_background` (quando execução em background for padrão)

Não usar campos legados como `tools`, `priority`, `category`, `color` ou `expertise`.

---

## 2. Localização e descoberta

- Local obrigatório: `.cursor/agents/*.md`
- Descoberta canônica: estrutura achatada (sem subpastas)
- Nome do arquivo deve corresponder ao `name`

---

## 3. Convenção de naming

- `name` em kebab-case, único
- Invocação por slash: `/nome-do-subagente`
- Sufixos aceitos: `-specialist`, `-agent`, `-developer`, `-engineer`, `-reviewer`, `-checker`

---

## 4. Critérios de qualidade

- `description` deve explicar gatilho de uso (quando usar), não só capacidade
- Escopo explícito: quando não usar e para qual subagente delegar
- Limite recomendado: até 1200 linhas; hard limit: 1500 linhas

---

## 5. Legado

Referências históricas a `.cursor/agents/` devem ser tratadas como compatibilidade. Novos subagentes e revisões canônicas devem seguir exclusivamente a estrutura `.cursor/agents/`.
