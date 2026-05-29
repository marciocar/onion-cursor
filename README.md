# Onion

**Framework Cursor-first para orquestrar produto, engenharia e compliance com workflows faseados e retomáveis.**

Repositório canônico: [github.com/marciocar/onion-cursor](https://github.com/marciocar/onion-cursor)

---

## O que é

O Onion é um framework template para uso interno, com base canônica em artefatos do Cursor (`.cursor/`, `AGENTS.md` e `docs/`). O objetivo é padronizar o ciclo completo de desenvolvimento em três dimensões peer:

- Produto
- Engenharia
- Compliance/governança

O framework **não é produto npm**, **não tem distribuição pública** e **não possui CLI standalone**.

---

## Estado canônico atual

Snapshot validado em 2026-05-28:

- **83 skills** em `.cursor/skills/`
- **49 subagentes** em `.cursor/agents/` (achatado, raiz)
- **4 rules** em `.cursor/rules/`
- **Task Manager Abstraction** em `.cursor/utils/task-manager/` (Jira, ClickUp, Asana, Linear)

Invariantes do framework:

- Workflow de produto: `collect -> refine -> spec -> feature`
- Workflow de engenharia: `plan -> start -> work -> pre-pr -> pr -> pr-update`
- Sessões persistentes em `.cursor/sessions/<feature-slug>/`

---

## Legado e compatibilidade

O histórico em Claude Code é mantido como referência de migração e compatibilidade documental. A orientação operacional atual é Cursor 3.6+; referências legadas devem ser tratadas como contexto histórico quando não refletirem a estrutura `.cursor/`.

---

## Próximos passos

- Navegação geral: [docs/INDEX.md](docs/INDEX.md)
- Regras do projeto: [AGENTS.md](AGENTS.md)
- Documento de migração: [docs/migration/onion-to-cursor-transformation.md](docs/migration/onion-to-cursor-transformation.md)
- Contribuição: [CONTRIBUTING.md](CONTRIBUTING.md)

---

## Licença

Distribuído sob licença MIT. Veja `LICENSE`.
