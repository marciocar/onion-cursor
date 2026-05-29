---
name: onion
description: >
  Orquestrador e ajuda global do Sistema Onion. Use para descobrir skills,
  workflows, agentes especialistas e roteamento skills-first. Substitui
  /global/help e ponto de entrada quando não souber qual skill invocar.
disable-model-invocation: true
paths:
  - .cursor/**
  - docs/**
---
# 🧅 Skill Onion

Atalho inteligente para o agente orquestrador master @onion.

## 🎯 Objetivo

Acessar o Sistema Onion para navegação, recomendações e orquestração **skills-first**.

## ⚡ Uso

```bash
/onion                    # Ajuda geral
/onion "como criar task"  # Pergunta específica
/onion "workflow de PR"   # Orientação de workflow
```

## 🆘 Ajuda Global (ex-/global/help)

1. Leia `AGENTS.md` — identidade, task manager e roteamento base
2. Ajuda por domínio:
   - `/engineer-help` — fluxos de engenharia
   - `/product-help` — fluxos de produto
   - `/docs-help` — documentação
   - `/git-help` — GitFlow e comandos git
   - `/git-readme` / `/product-readme` — workflows detalhados
3. Dúvida de especialista → delegar para `@onion` ou skill `/onion`
4. Runflow SDK → `@runflow-specialist` (sem command legado)

## 🧭 Roteamento

| Intenção | Skill recomendada |
|----------|-------------------|
| Criar task | `/product-task` |
| Iniciar feature | `/engineer-start` |
| Implementar | `/engineer-work` |
| Pré-PR | `/engineer-pre-pr` |
| Pull Request | `/engineer-pr` |
| GitFlow feature | `/git-feature-start` |
| Sincronizar | `/git-sync` |
| Compliance | `/docs-build-compliance-docs` |

**Contextuais (auto):** `language-standards`, `onion-patterns`, `onion-validation`

## 🔄 Workflow Feature Completa

```
/product-task → /engineer-start → /git-feature-start → /engineer-work
→ /engineer-pre-pr → /engineer-pr → /docs-sync-sessions
```

## 🔗 Referências

- Agente master: @onion
- Docs: `docs/onion/`
- Meta-spec: `docs/meta-specs/commands.md`
- Skills index: `.cursor/skills/README.md`

## 🔴 REGRA CRÍTICA: Tasks no Task Manager

Ao usar skills que criam tasks (`/product-task`, `/product-feature`):
1. Detectar provedor via `.cursor/utils/task-manager/detector.md`
2. Usar abstração `getTaskManager()` — nunca só documentos locais
3. Respeitar `TASK_MANAGER_PROVIDER` no `.env`
