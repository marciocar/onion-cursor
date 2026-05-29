---
name: docs-build-compliance-docs
description: >
  Gera documentação de compliance multi-framework (ISO 27001, ISO 22301, SOC2,
  PMBOK) para auditorias e due diligence. Use quando precisar de docs
  auditáveis, checklist DD ou certificação. Delega para especialistas via
  @security-information-master.
disable-model-invocation: true
paths:
  - docs/**
---
# 📋 Gerador de Documentação de Compliance

Criar documentação de conformidade para auditorias e certificações.

## 🎯 Objetivo

Gerar arquitetura completa de docs de compliance multi-framework.

## 🔧 Modos de Execução

```bash
# Modo 1: Seletivo
/docs-build-compliance-docs frameworks="iso27001,soc2"

# Modo 2: Due Diligence
/docs-build-compliance-docs due_diligence="path/to/checklist.md"

# Modo 3: Auto (analisa projeto)
/docs-build-compliance-docs

# Modo 4: Completo
/docs-build-compliance-docs frameworks="all"
```

## ⚡ Fluxo de Execução

### Passo 1: Detectar Modo

SE `{{frameworks}}` → Modo Seletivo
SE `{{due_diligence}}` → Modo DD (analisar checklist)
SENÃO → Modo Auto (analisar projeto)

### Passo 2: Selecionar Frameworks

| Framework | Foco | Quando Usar |
|-----------|------|-------------|
| ISO 27001 | Segurança da Info | Certificação, DD |
| ISO 22301 | Continuidade | DR, BCP |
| SOC2 | Trust Services | Clientes enterprise |
| PMBOK | Governança | Projetos |

### Passo 3: Delegar para Especialistas

Para cada framework selecionado:

```
SE "iso27001" → @iso-27001-specialist
SE "iso22301" → @iso-22301-specialist
SE "soc2" → @soc2-specialist
SE "pmbok" → @pmbok-specialist
```

Coordenação via @security-information-master

### Passo 4: Gerar Documentação

**Leia o template do framework antes de gerar:**

| Framework | Template | Output |
|-----------|----------|--------|
| ISO 27001 | `references/compliance-iso27001-template.md` | `docs/compliance-context/security/` |
| ISO 22301 | `references/compliance-iso22301-template.md` | `docs/compliance-context/business-continuity/` |
| SOC2 | `references/compliance-soc2-template.md` | `docs/compliance-context/soc2/` |
| PMBOK | `references/compliance-pmbok-template.md` | `docs/compliance-context/project-management/` |

Estrutura consolidada:
```
docs/compliance-context/
├── index.md
├── iso27001/
│   ├── policy.md
│   ├── risk-assessment.md
│   └── controls.md
├── soc2/
│   ├── trust-services.md
│   └── evidence.md
└── reports/
    └── summary.md
```

### Passo 5: Validar e Entregar

## 📤 Output Esperado

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ DOCS DE COMPLIANCE GERADOS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 Frameworks:
∟ ISO 27001: ✅ 12 documentos
∟ SOC2: ✅ 8 documentos

📁 Estrutura:
∟ docs/compliance-context/index.md
∟ docs/compliance-context/iso27001/ (12)
∟ docs/compliance-context/soc2/ (8)

📋 Cobertura:
∟ Políticas: 100%
∟ Controles: 85%
∟ Evidências: Template

🚀 Próximo: Revisar e customizar
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## 🔗 Referências

- Orquestrador: @security-information-master
- ISO 27001: @iso-27001-specialist — `references/compliance-iso27001-template.md`
- ISO 22301: @iso-22301-specialist — `references/compliance-iso22301-template.md`
- SOC2: @soc2-specialist — `references/compliance-soc2-template.md`
- PMBOK: @pmbok-specialist — `references/compliance-pmbok-template.md`

## ⚠️ Notas

- Docs gerados são templates base
- Customizar para contexto específico
- Revisar antes de auditorias
