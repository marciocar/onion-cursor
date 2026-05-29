# 🚧 FASE 2: Migração de Comandos e Agentes

> **ID**: ONION-V4-TASK-002 | **Status**: 📋 Planejada | **Story Points**: 21 SP

---

## 📋 Informações da Task

| Campo | Valor |
|-------|-------|
| **Nome** | FASE 2: Migração de Comandos e Agentes |
| **Tipo** | Refactoring / Migration |
| **Prioridade** | Alta |
| **Story Points** | 21 SP |
| **Estimativa** | 2 semanas |
| **Status** | 📋 Planejada |
| **Épico** | [ONION-V4-EPIC-001](../onion-v4-epic.md) |
| **Dependências** | ✅ FASE 1 (concluída) |

---

## 🎯 Objetivo

Migrar todos os 90 comandos e 46 agentes de `.claude/` para `.onion/contexts/`, classificando cada um por nível (starter/intermediate/advanced) e contexto apropriado.

---

## 📝 Descrição Detalhada

### Comandos a Migrar (90 total)

#### Business Context (15-20 comandos)
**Starter (5)**:
- `spec` - Criar especificação
- `refine` - Refinar especificação
- `estimate` - Estimar story points
- `task` - Criar task
- `help` - Ajuda do contexto

**Intermediate (10)**:
- `collect` - Coletar requisitos
- `light-arch` - Arquitetura leve
- `extract-meeting` - Extrair reunião
- `consolidate-meetings` - Consolidar reuniões
- `convert-to-tasks` - Converter em tasks
- `whisper` - Transcrição de áudio
- `task-check` - Verificar task
- ...

**Advanced**:
- `create-*` - Meta-comandos
- Comandos avançados de análise

#### Technical Context (20-25 comandos)
**Starter (5)**:
- `plan` - Planejar implementação
- `work` - Desenvolver
- `pr` - Criar PR
- `sync` - Git sync
- `help` - Ajuda do contexto

**Intermediate (10)**:
- `validate-estimate` - Validar estimativas
- `review` - Code review
- `test` - Executar testes
- `deploy` - Deploy
- `docs` - Gerar documentação
- `pre-pr` - Preparar PR
- `warm-up` - Preparar contexto
- ...

**Advanced**:
- `create-*` - Meta-comandos
- Comandos avançados de arquitetura

#### Customer Success Context (10-15 comandos)
**Starter (5)**:
- `ticket` - Criar ticket
- `guide` - Criar guia
- `onboard` - Onboarding cliente
- `report` - Gerar relatório
- `help` - Ajuda

#### Compliance Context (8-12 comandos)
**Starter (5)**:
- `audit` - Criar audit
- `security-scan` - Scan de segurança
- `compliance-check` - Check de compliance
- `report` - Relatório de compliance
- `help` - Ajuda

#### Sales & Marketing Contexts (10-15 comandos cada)
**A definir baseado em necessidades**

### Agentes a Migrar (46 total)

#### Core Agents (5)
- `onion.md` - Orquestrador master
- `kb-manager.md` - Gerenciador de KBs
- `context-router.md` - Roteador de contextos
- `metaspec-gate-keeper.md` - Validador de specs
- `warm-up-specialist.md` - Preparador de contexto

#### Business Agents (~12)
- `product-agent.md`
- `strategy-analyst.md`
- `story-points-specialist.md`
- `extract-meeting-specialist.md`
- `meeting-consolidator.md`
- `whisper-specialist.md`
- `task-specialist.md`
- ...

#### Technical Agents (~15)
- `react-developer.md`
- `python-developer.md`
- `architecture-specialist.md`
- `gitflow-specialist.md`
- `test-engineer.md`
- `code-reviewer.md`
- `devops-specialist.md`
- ...

#### CS, Compliance, Review Agents (~14)
- `cs-specialist.md`
- `compliance-checker.md`
- `security-auditor.md`
- `documentation-specialist.md`
- ...

---

## ✅ Critérios de Aceitação

### Estrutura

- [ ] Todos os 90 comandos migrados para `.onion/contexts/{context}/commands/{level}/`
- [ ] Todos os 46 agentes migrados para `.onion/contexts/{context}/agents/`
- [ ] Cada contexto tem `.context-config.yml` configurado
- [ ] Cada comando tem header YAML atualizado com campos:
  - `level: starter|intermediate|advanced`
  - `context: business|technical|cs|compliance|sales|marketing`
  - `category: [categoria específica]`

### Classificação por Nível

- [ ] 5 comandos starter por contexto (80% dos casos)
- [ ] 10-15 comandos intermediate por contexto (15% dos casos)
- [ ] Restante como advanced (5% dos casos)
- [ ] Documentação clara de quando usar cada nível

### Testes

- [ ] Todos os comandos testados no Claude Code
- [ ] Todos os agentes testados e funcionais
- [ ] Nenhum comando quebrado na migração
- [ ] Links internos atualizados (ex: `related_commands`)

### Documentação

- [ ] Cada contexto tem `README.md` atualizado
- [ ] Lista de comandos por nível documentada
- [ ] Lista de agentes por contexto documentada
- [ ] Guia de migração em `docs/onion/migration-guide.md`

---

## 🔧 Implementação

### Passo 1: Análise Completa
```bash
# Listar todos os comandos atuais
ls -R .claude/commands/

# Listar todos os agentes atuais
ls -R .claude/agents/

# Analisar estrutura e dependências
```

### Passo 2: Criar Estrutura de Contextos
```bash
# Para cada contexto, criar estrutura completa
.onion/contexts/business/
├── .context-config.yml
├── commands/
│   ├── starter/
│   ├── intermediate/
│   └── advanced/
├── agents/
├── knowledge-base/
└── sessions/
```

### Passo 3: Migrar Comandos por Contexto
```bash
# Business context
mv .claude/commands/product-spec.md .onion/contexts/business/commands/starter/
mv .claude/commands/product-refine.md .onion/contexts/business/commands/starter/
# ... e assim por diante
```

### Passo 4: Atualizar Headers YAML
```yaml
---
name: spec
description: Criar especificação de feature
level: starter           # NOVO
context: business        # NOVO
category: product
version: "4.0.0"
updated: "2025-12-20"
---
```

### Passo 5: Criar `.context-config.yml`
```yaml
context:
  name: business
  description: Product, Strategy, Planning workflows
  
task_manager:
  provider: clickup  # ou asana, linear, none
  
commands:
  prefix: /business
  starter: 5
  intermediate: 10
  advanced: all
  
agents:
  - product-agent
  - strategy-analyst
  - story-points-specialist
  
integrations:
  - whisper
  - extract
  
onboarding:
  estimated_time: 30 minutes
  required_reading:
    - docs/business-context/getting-started.md
```

### Passo 6: Atualizar Links
```bash
# Atualizar todos os links internos
# Ex: .claude/commands/ → .onion/contexts/
# Ex: @agent-name → caminho correto
```

### Passo 7: Testar Tudo
```bash
# No Claude Code
/business/spec "test"
/technical/plan "test"
@product-agent "test"
```

---

## 🧪 Plano de Testes

### Teste 1: Comandos Starter
- [ ] Testar `/business/spec`
- [ ] Testar `/business/task`
- [ ] Testar `/technical/plan`
- [ ] Testar `/technical/work`
- [ ] Verificar que funcionam 100%

### Teste 2: Comandos Intermediate
- [ ] Testar `/business/light-arch`
- [ ] Testar `/business/extract-meeting`
- [ ] Testar `/technical/review`
- [ ] Verificar descoberta progressiva

### Teste 3: Agentes
- [ ] Testar `@product-agent`
- [ ] Testar `@react-developer`
- [ ] Testar `@onion`
- [ ] Verificar que acessam KBs corretas

### Teste 4: Integração
- [ ] Comandos business chamam agentes business
- [ ] Comandos technical chamam agentes technical
- [ ] Links entre contextos funcionam

---

## 📊 Decomposição em Subtarefas

```
FASE 2: Migração (21 SP total)
├── Subtask 2.1: Análise e Planejamento (2 SP, 1 dia)
│   ├── Listar todos os comandos
│   ├── Listar todos os agentes
│   ├── Classificar por contexto
│   └── Classificar por nível
│
├── Subtask 2.2: Migrar Business Context (5 SP, 2 dias)
│   ├── Criar estrutura
│   ├── Migrar 15-20 comandos
│   ├── Migrar 12 agentes
│   └── Criar .context-config.yml
│
├── Subtask 2.3: Migrar Technical Context (6 SP, 3 dias)
│   ├── Criar estrutura
│   ├── Migrar 20-25 comandos
│   ├── Migrar 15 agentes
│   └── Criar .context-config.yml
│
├── Subtask 2.4: Migrar Outros Contextos (4 SP, 2 dias)
│   ├── CS Context (10-15 comandos)
│   ├── Compliance Context (8-12 comandos)
│   ├── Sales/Marketing (stubs)
│   └── Configs de cada contexto
│
├── Subtask 2.5: Atualizar Headers e Links (2 SP, 1 dia)
│   ├── Atualizar YAML de todos os comandos
│   ├── Atualizar YAML de todos os agentes
│   ├── Atualizar links internos
│   └── Validar formatação
│
└── Subtask 2.6: Testes e Documentação (2 SP, 1 dia)
    ├── Testar todos os comandos
    ├── Testar todos os agentes
    ├── Documentar migração
    └── Criar guia de uso
```

---

## 🚨 Riscos e Mitigações

### Risco 1: Comandos Quebram na Migração
**Mitigação**: 
- Testar cada comando imediatamente após migração
- Manter backup de `.claude/` durante transição
- Script de rollback se necessário

### Risco 2: Links Internos Quebrados
**Mitigação**:
- Script para atualizar todos os links automaticamente
- Validação de links como parte dos testes
- Documentar novos paths claramente

### Risco 3: Agentes Não Encontram KBs
**Mitigação**:
- Atualizar paths de KBs nos headers YAML
- Testar cada agente individualmente
- Documentar estrutura de KBs por contexto

### Risco 4: Classificação Incorreta de Níveis
**Mitigação**:
- Review de classificação com usuários reais
- Estatísticas de uso para validar 80/15/5
- Flexibilidade para reclassificar posteriormente

---

## 📚 Referências

### Documentos de Referência
- [Visão Multi-Context](../../knowledge-base/frameworks/onion-multi-context-orchestrator-vision.md)
- [Entendimento do Ciclo](../../knowledge-base/frameworks/onion-complete-cycle-understanding.md)
- [Plano de Migração](../onion-v4-migration-plan.md)

### Comandos Atuais
- `.claude/commands/` - Estrutura atual de comandos
- `.claude/agents/` - Estrutura atual de agentes

---

## 🚀 Próxima Fase

➡️ **[FASE 3: Sistema de Níveis e Help Inteligente](fase-03-levels-help.md)**

**Objetivo**: Implementar descoberta progressiva e help inteligente

---

**Status**: 📋 Planejada  
**Story Points**: 21 SP  
**Estimativa**: 2 semanas  
**Dependências**: ✅ FASE 1 concluída

