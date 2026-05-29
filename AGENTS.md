# Sistema Onion — Instruções do Projeto

Sistema Onion Cursor-first: plataforma única em Cursor com três dimensões peer (produto, engenharia e compliance).

## Idioma
- Código, variáveis, funções, classes, arquivos e branches: inglês.
- Comentários, documentação e respostas ao usuário: português brasileiro.
- Commits: português brasileiro, objetivos e atômicos.

## Task Manager (obrigatório antes de operar com tasks)
1. Carregar `.env` e ler `TASK_MANAGER_PROVIDER` (`jira|clickup|asana|linear|none`).
2. Validar variáveis obrigatórias do provider ativo.
3. Delegar operação técnica ao especialista correto (`/jira-specialist`, `/clickup-specialist`, `/task-specialist`).
4. Se provider for `none`, operar localmente sem chamadas de API externas.

## Roteamento mínimo por intenção
- Estratégia de produto: `/product-agent`
- Decomposição de tasks: `/task-specialist`
- Engenharia e implementação: skills `engineer-*`
- Revisão de código: `/code-reviewer`
- Compliance e metaspec: `/corporate-compliance-specialist` e `/metaspec-gate-keeper`

## Invariantes do framework
- Fluxo de produto faseado e retomável: `collect -> refine -> spec -> feature`
- Fluxo de engenharia faseado e retomável: `plan -> start -> work -> pre-pr -> pr -> pr-update`
- Sessões persistentes em `.cursor/sessions/<feature-slug>/`
