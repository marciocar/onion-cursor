# Meta-specs do Sistema Onion

---

## Visão geral

As meta-specs (L0) definem a constituição do framework Onion em modo Cursor-first. Elas normatizam arquitetura, agentes, skills/comandos, integrações e padrões de qualidade.

Escopo: o próprio framework Onion neste repositório.

---

## Meta-specs ativas

- [`architecture.md`](./architecture.md) — estrutura obrigatória e plataforma alvo
- [`agents.md`](./agents.md) — padrões de subagentes Cursor
- [`commands.md`](./commands.md) — padrões de skills/comandos e workflows faseados
- [`code-standards.md`](./code-standards.md) — idioma e estilo
- [`integrations.md`](./integrations.md) — Task Manager Abstraction e MCP

---

## Princípios invariantes

- Plataforma canônica: Cursor 3.6+
- Três dimensões peer: produto, engenharia e compliance/governança
- Workflows faseados retomáveis:
  - `collect -> refine -> spec -> feature`
  - `plan -> start -> work -> pre-pr -> pr -> pr-update`
- Sessões persistentes em `.cursor/sessions/<feature-slug>/`

---

## Legado e compatibilidade

O histórico de Claude Code permanece documentado para compatibilidade. Regras e operação atual devem ser implementadas via `AGENTS.md` e `.cursor/rules/`.

---

**Última atualização:** 2026-05-28
