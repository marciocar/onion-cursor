# Índice Central de Documentação

> Última atualização: 2026-05-28  
> Direção canônica: Cursor-first (Cursor 3.6+)

---

## Visão geral

Este repositório mantém o Sistema Onion como framework interno para orquestração de produto, engenharia e compliance.

Estado validado no workspace:

- `49` subagentes em `.cursor/agents/`
- `83` skills em `.cursor/skills/`
- `4` rules em `.cursor/rules/`
- `94` comandos legados em `.cursor/commands/` (compatibilidade/transição)
- `3` scripts de hook em `.cursor/hooks/` + `.cursor/hooks.json`
- `1` configuração MCP em `.cursor/mcp.json`

---

## Documentos canônicos

- [`../README.md`](../README.md) — visão executiva do framework
- [`../AGENTS.md`](../AGENTS.md) — regras operacionais principais
- [`meta-specs/index.md`](meta-specs/index.md) — constituição L0
- [`analysis/onion-review-2026-05.md`](analysis/onion-review-2026-05.md) — revisão analítica e histórico de decisões
- [`migration/onion-to-cursor-transformation.md`](migration/onion-to-cursor-transformation.md) — blueprint e checklist de migração

---

## Meta-specs (L0)

- [`meta-specs/architecture.md`](meta-specs/architecture.md)
- [`meta-specs/agents.md`](meta-specs/agents.md)
- [`meta-specs/commands.md`](meta-specs/commands.md)
- [`meta-specs/code-standards.md`](meta-specs/code-standards.md)
- [`meta-specs/integrations.md`](meta-specs/integrations.md)

---

## Referências operacionais Cursor

- Regras: `.cursor/rules/*.mdc`
- Skills: `.cursor/skills/<skill>/SKILL.md`
- Subagentes: `.cursor/agents/*.md`
- Hooks: `.cursor/hooks.json` e `.cursor/hooks/*.sh`
- MCP: `.cursor/mcp.json`
- Sessões: `.cursor/sessions/<feature-slug>/`

---

## Legado Claude (compatibilidade)

`CLAUDE.md` foi mantido como ponte de compatibilidade e referência histórica. A base operacional atual está em `AGENTS.md` e `.cursor/rules/`.
