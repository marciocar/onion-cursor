# 📋 Onion v4 Migration - Tasks

> **Épico**: [ONION-V4-EPIC-001](../onion-v4-epic.md) | **Total**: 53 Story Points | **Duração**: 4-6 semanas

---

## 📊 Visão Geral

Esta pasta contém todas as subtasks do épico de migração Onion v3 → v4, organizadas por fase de implementação.

---

## 🎯 Fases do Épico

### ✅ FASE 1: CLI e Estrutura Base - **CONCLUÍDO**
**Arquivo**: [`fase-01-cli-structure.md`](fase-01-cli-structure.md)  
**Story Points**: 8 SP  
**Status**: ✅ Concluído em 2025-12-20

**Entregáveis**:
- ✅ CLI `onion init` funcional com wizard
- ✅ Estrutura `.onion/` gerada automaticamente
- ✅ Compatibilidade com Claude Code
- ✅ Documentação completa

---

### 🚧 FASE 2: Migração de Comandos e Agentes - **PRÓXIMA**
**Arquivo**: [`fase-02-migration-commands-agents.md`](fase-02-migration-commands-agents.md)  
**Story Points**: 21 SP  
**Status**: 📋 Planejada (início imediato)

**Objetivo**: Migrar 90 comandos e 46 agentes de `.claude/` para `.onion/contexts/`

**Entregáveis**:
- [ ] Migrar business context (15-20 comandos)
- [ ] Migrar technical context (20-25 comandos)
- [ ] Migrar outros contextos
- [ ] Classificar por nível (starter/intermediate/advanced)
- [ ] Criar `.context-config.yml` por contexto

---

### 📋 FASE 3: Sistema de Níveis e Help Inteligente
**Arquivo**: [`fase-03-levels-help.md`](fase-03-levels-help.md) *(a criar)*  
**Story Points**: 8 SP  
**Status**: 📋 Planejada

**Objetivo**: Implementar sistema de níveis e descoberta progressiva

---

### 📋 FASE 4: IDE Loaders e Compatibilidade
**Arquivo**: [`fase-04-ide-loaders.md`](fase-04-ide-loaders.md) *(a criar)*  
**Story Points**: 8 SP  
**Status**: 📋 Planejada

**Objetivo**: Implementar loaders para Claude Code, Windsurf, Claude

---

### 📋 FASE 5: Abstractions e Extensibilidade
**Arquivo**: [`fase-05-abstractions.md`](fase-05-abstractions.md) *(a criar)*  
**Story Points**: 5 SP  
**Status**: 📋 Planejada

**Objetivo**: Implementar abstractions pluggáveis

---

### 📋 FASE 6: Gestão de Contexto e Learnings
**Arquivo**: [`fase-06-context-management.md`](fase-06-context-management.md) *(a criar)*  
**Story Points**: 5 SP  
**Status**: 📋 Planejada

**Objetivo**: Implementar ciclo fechado de aprendizado

---

### 📋 FASE 7: Story Points Cross-Context
**Arquivo**: [`fase-07-story-points-cycle.md`](fase-07-story-points-cycle.md) *(a criar)*  
**Story Points**: 3 SP  
**Status**: 📋 Planejada

**Objetivo**: Implementar ciclo cross-context de estimativas

---

### 📋 FASE 8: Documentação e Onboarding
**Arquivo**: [`fase-08-documentation.md`](fase-08-documentation.md) *(a criar)*  
**Story Points**: 3 SP  
**Status**: 📋 Planejada

**Objetivo**: Reescrever documentação completa para v4

---

## 📈 Progresso

```
Total: 53 Story Points

✅ Concluído:     8 SP  (FASE 1)      [███░░░░░░░] 15%
🚧 Em Progresso:  0 SP                [░░░░░░░░░░] 0%
📋 Planejado:    45 SP  (FASE 2-8)    [░░░░░░░░░░] 0%
```

---

## 📅 Timeline

```
✅ Semana 0     → FASE 1: CLI (CONCLUÍDO)
🚧 Semana 1-2   → FASE 2: Migração de comandos
📋 Semana 3     → FASE 3: Sistema de níveis  
📋 Semana 4     → FASE 4: IDE Loaders
📋 Semana 5     → FASE 5-6: Abstractions + Learnings
📋 Semana 6     → FASE 7-8: Story Points + Documentação
🎉 Release      → Onion v4.0.0
```

---

## 🔗 Documentos Relacionados

- [Épico Principal](../onion-v4-epic.md)
- [Plano de Migração Completo](../onion-v4-migration-plan.md)
- [Visão Multi-Context Orchestrator](../../knowledge-base/frameworks/onion-multi-context-orchestrator-vision.md)
- [Entendimento do Ciclo Completo](../../knowledge-base/frameworks/onion-complete-cycle-understanding.md)

---

**Última atualização**: 2025-12-20  
**Versão**: 1.0.0  
**Status**: 🚧 Em Progresso (15% concluído)

