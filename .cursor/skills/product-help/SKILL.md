---
name: help
description: Skill convertida de /product/help.md.
paths:
  - docs/**
  - .cursor/sessions/**
disable-model-invocation: true
---
# /product/help

Guia rápido da trilha de produto no Sistema Onion.

## Fluxo principal
`/product/collect -> /product/refine -> /product/spec -> /product/feature`

## Quando usar cada etapa
- `collect`: coletar contexto e necessidades.
- `refine`: organizar e priorizar requisitos.
- `spec`: detalhar escopo funcional e critérios.
- `feature`: transformar spec em plano executável.

## Integração com Task Manager
Sempre detectar `TASK_MANAGER_PROVIDER` no `.env` antes de criar ou atualizar tasks.
