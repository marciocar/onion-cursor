---
title: Meta-spec — Padrões de Integração do Sistema Onion
date: 2026-05-28
version: 2.0.0
level: L0
status: active
gate-keeper: "@metaspec-gate-keeper"
---

# Meta-spec — Padrões de Integração do Sistema Onion

## Propósito

Definir padrões obrigatórios para integrações externas no Onion Cursor-first, com foco em Task Manager Abstraction e configuração MCP.

---

## 1. Referências canônicas

- Abstração de task manager: `.cursor/utils/task-manager/`
- Configuração MCP: `.cursor/mcp.json`
- Regras operacionais: `AGENTS.md`

---

## 2. Task Manager Abstraction

Estrutura obrigatória:

```
.cursor/utils/task-manager/
├── interface.md
├── types.md
├── factory.md
├── detector.md
└── adapters/
    ├── jira.md
    ├── clickup.md
    ├── asana.md
    └── linear.md
```

Regras:

- Sempre detectar `TASK_MANAGER_PROVIDER` no `.env` antes de operar
- Nunca assumir provider por padrão implícito
- Em ausência de configuração, operar em modo offline (`none`) quando aplicável

---

## 3. MCP (`.cursor/mcp.json`)

Toda integração MCP deve:

- Usar `${env:VAR}` para segredos/tokens
- Evitar hardcode de credenciais
- Passar por validação de JSON antes de merge

---

## 4. Formatação por provider

- Jira Cloud v3: ADF para descrição e comentários
- ClickUp: Markdown em descrição e padrão visual definido para comentários
- Asana: HTML notes ou plain text conforme adapter
- Linear: Markdown

Adapters são responsáveis por traduzir payload interno para formato do provider.

---

## 5. Legado

Referências a integração em `.cursor/utils/task-manager/` são históricas. O caminho operacional canônico é `.cursor/utils/task-manager/`.
