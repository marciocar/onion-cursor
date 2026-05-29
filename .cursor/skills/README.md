# Cursor Skills

Diretório canônico de automações do Sistema Onion (Cursor 3.6+).

## Regra de nomenclatura

- Formato: `<categoria>-<subcategoria>-<comando>` em kebab-case achatado.
- Exemplos: `engineer-start`, `product-task`, `git-feature-start`.
- Para docs de categoria: sufixo `-readme` (`product-readme`, `git-readme`).
- Ajuda global: skill `onion` (substitui `/global/help`).

## Prompts compartilhados (`references/`)

| Arquivo | Skill proprietária |
|---------|-------------------|
| `clickup-patterns.md` | `product-task` |
| `git-workflow-patterns.md` | `git-sync` |
| `code-review-checklist.md` | `git-code-review` |
| `validation-rules.md` | `meta-create-command` |
| `output-formats.md` | `meta-create-command` |
| `technical.md` | `docs-build-tech-docs` |

## Índice de skills

### Engineer
- `engineer-bump`
- `engineer-docs`
- `engineer-help`
- `engineer-hotfix`
- `engineer-plan`
- `engineer-pr`
- `engineer-pr-update`
- `engineer-pre-pr`
- `engineer-start`
- `engineer-validate-phase-sync`
- `engineer-warm-up`
- `engineer-work`

### Product
- `product-analyze-pain-price`
- `product-branding`
- `product-check`
- `product-checklist-sync`
- `product-collect`
- `product-consolidate-meetings`
- `product-convert-to-tasks`
- `product-estimate`
- `product-extract-meeting`
- `product-feature`
- `product-help`
- `product-light-arch`
- `product-presentation`
- `product-readme`
- `product-refine`
- `product-spec`
- `product-task`
- `product-task-check`
- `product-transform-consolidated`
- `product-validate-task`
- `product-warm-up`
- `product-whisper`

### Docs
- `docs-build-business-docs`
- `docs-build-compliance-docs`
- `docs-build-index`
- `docs-build-tech-docs`
- `docs-consolidate-documents`
- `docs-docs-health`
- `docs-help`
- `docs-refine-vision`
- `docs-reverse-consolidate`
- `docs-sync-sessions`
- `docs-validate-docs`

### Git
- `git-code-review`
- `git-fast-commit`
- `git-feature-finish`
- `git-feature-publish`
- `git-feature-start`
- `git-help`
- `git-hotfix-finish`
- `git-hotfix-start`
- `git-init`
- `git-readme`
- `git-release-finish`
- `git-release-start`
- `git-sync`

### Validate
- `validate-collab-pair-testing`
- `validate-collab-three-amigos`
- `validate-qa-points-estimate`
- `validate-test-strategy-analyze`
- `validate-test-strategy-create`
- `validate-workflow`

### Test
- `test-e2e`
- `test-integration`
- `test-unit`

### Meta
- `meta-all-tools`
- `meta-analyze-complex-problem`
- `meta-create-abstraction`
- `meta-create-agent`
- `meta-create-agent-express`
- `meta-create-command`
- `meta-create-knowledge-base`
- `meta-create-skill`
- `meta-create-task-structure`
- `meta-setup-integration`

### Quick
- `quick-analisys`

### Raiz
- `onion`
- `warm-up`
