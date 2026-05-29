---
name: pair-testing
description: |
  Organiza sessão de pair testing multi-perspectiva para validação colaborativa de features.
  Use para estruturar sessões de teste em par (Dev+Dev, Dev+QA, QA+QA) com foco em White-box, Grey-box ou Black-box.
model: sonnet

parameters:
  - name: feature
    description: Nome da feature/funcionalidade a ser testada (ex: "checkout", "login", "user-profile")
    required: true
  - name: perspective
    description: Perspectiva de teste (white-box|grey-box|black-box). Define o foco da sessão
    required: true
  - name: schedule
    description: Criar evento no calendário para a sessão
    required: false
  - name: task-manager
    description: Task manager usado (clickup|jira|linear|asana). Default: clickup
    required: false
    default: clickup
  - name: feature-id
    description: ID da feature no task manager (ex: TASK-123, CU-456). Opcional para buscar contexto
    required: false
  - name: participants
    description: Participantes da sessão (ex: "dev1,qa1" ou "dev1,dev2"). Se não fornecido, será inferido da perspectiva
    required: false

category: validate
tags:
  - collaboration
  - pair-testing
  - testing
  - qa
  - validation
  - grey-box
  - black-box
  - white-box

version: "3.0.0"
updated: "2025-12-03"

related_commands:
  - /validate/collab/three-amigos
  - /validate/test-strategy/create
  - /validate/test-strategy/analyze
  - /product/task

related_agents:
  - test-engineer
  - test-planner
---

# 🤝 Pair Testing - Sessão de Teste em Par

Organiza sessões de pair testing multi-perspectiva para validação colaborativa de features, seguindo padrões do Framework de Testes (`docs/knowledge-base/frameworks/framework-testes.md`).

## 🎯 Objetivo

Estruturar e facilitar sessões de pair testing que resultem em:
- **Validação colaborativa** da feature sob múltiplas perspectivas
- **Descoberta de edge cases** através de diferentes olhares
- **Transferência de conhecimento** entre participantes
- **Documentação em tempo real** de findings e bugs
- **Estimativa colaborativa** de QA Story Points
- **Test strategy refinada** baseada em descobertas

## ⚡ Fluxo de Execução

### Passo 1: Carregar Framework de Testes (OBRIGATÓRIO)

**CRÍTICO:** Sempre ler o framework antes de organizar a sessão:

```bash
# Ler framework completo
read_file docs/knowledge-base/frameworks/framework-testes.md
```

**Extrair e armazenar em memória:**
- Seção "Padrões de Colaboração - Sessões de Teste em Par Multi-perspectiva" (linhas ~879-904)
- Seção "Diferenças entre White-box vs Black-box vs Grey-box" (linhas ~111-165)
- Seção "Técnicas Específicas por Tipo" (linhas ~464-594)
- Seção "Template Universal de Caso de Teste" (linhas ~171-213)

**Validar leitura:**
```markdown
SE arquivo não encontrado:
  ❌ ERRO: Framework de testes não encontrado em docs/knowledge-base/frameworks/framework-testes.md
  💡 Verifique se o arquivo existe e tente novamente
```

### Passo 2: Validar e Normalizar Parâmetros

```markdown
**Parâmetros recebidos:**
- feature: {{feature}} ✅ obrigatório
- perspective: {{perspective}} ✅ obrigatório
- schedule: {{schedule}} ou false (default)
- task-manager: {{task-manager}} ou "clickup" (default)
- feature-id: {{feature-id}} ou null
- participants: {{participants}} ou inferir da perspectiva

**Normalização:**
- perspective: converter para minúsculas, validar (white-box|grey-box|black-box)
- Se valores inválidos: abortar com erro claro
```

**Validações:**
```markdown
SE perspective não está em [white-box, grey-box, black-box]:
  ❌ ERRO: Perspectiva inválida: {{perspective}}
  💡 Valores válidos: white-box, grey-box, black-box
  exit 1

SE feature está vazio:
  ❌ ERRO: Nome da feature é obrigatório
  exit 1
```

### Passo 3: Determinar Participantes e Combinação

**SE** `{{participants}}` fornecido:
- Usar participantes fornecidos diretamente
- Validar formato (ex: "dev1,qa1" ou "dev1,dev2")

**SENÃO** → Inferir da perspectiva:

```markdown
**Mapeamento Perspectiva → Combinação Recomendada:**

🔧 GREY-BOX → Dev + Dev
   - Code review com perspectiva de teste
   - Integration testing collaboration
   - Knowledge transfer técnico
   - Foco: Contratos de API, integrações, performance

🧪 WHITE-BOX + BLACK-BOX → Dev + QA
   - Feature walkthrough
   - Edge cases discovery
   - Test data preparation
   - Foco: Lógica interna + experiência do usuário

👥 BLACK-BOX → QA + QA
   - Exploratory testing collaboration
   - User journey validation
   - Cross-validation of findings
   - Foco: Experiência do usuário, fluxos, usabilidade
```

**Gerar sugestão de participantes:**
```markdown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
👥 PARTICIPANTES SUGERIDOS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Perspectiva: {{perspective}}
Combinação: [Dev+Dev | Dev+QA | QA+QA]

Participante 1: [NOME/ROLE]
Participante 2: [NOME/ROLE]

💡 Para customizar: use --participants "nome1,nome2"
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Passo 4: Buscar Contexto da Feature (Opcional)

**SE** `{{feature-id}}` fornecido **E** `{{task-manager}}` = `clickup`:

```bash
# Usar ClickUp MCP para buscar:
# - Detalhes da task/feature
# - Descrição atual
# - Critérios de aceitação
# - Test strategy existente
# - Bugs conhecidos
# - Comentários anteriores
```

**SENÃO SE** `{{feature-id}}` fornecido **E** `{{task-manager}}` = `jira`:

```bash
# Buscar via Jira API ou manualmente
# Extrair: summary, description, acceptance criteria, test cases
```

**SENÃO:**

```bash
# Buscar arquivos relacionados à feature no código
# - Testes existentes
# - Documentação
# - Especificações
```

### Passo 5: Gerar Agenda Estruturada

Criar agenda baseada na perspectiva escolhida:

```markdown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📅 PAIR TESTING SESSION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Feature: {{feature}}
👥 Participantes: [Participante 1] + [Participante 2]
🎯 Perspectiva: {{perspective}}
⏱️  Duração: 1-2 horas
📅 Data: [auto-detect ou --schedule]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🎯 AGENDA POR PERSPECTIVA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

{{SE perspective = "grey-box":}}
🔧 GREY-BOX PAIR TESTING (Dev + Dev)

1️⃣ SETUP E CONTEXTO (10-15min)
   ∟ Revisar código da feature
   ∟ Identificar pontos de integração
   ∟ Preparar ambiente de teste
   ∟ Definir contratos de API a validar

2️⃣ INTEGRATION TESTING (30-40min)
   ∟ Testar contratos de API
   ∟ Validar fluxos de integração
   ∟ Verificar tratamento de erros
   ∟ Testar timeouts e limites
   ∟ Rotação Driver/Navigator a cada 15min

3️⃣ PERFORMANCE & STRESS (20-30min)
   ∟ Testes de carga básicos
   ∟ Validação de fronteiras
   ∟ Análise de performance
   ∟ Identificação de bottlenecks

4️⃣ DOCUMENTAÇÃO (10-15min)
   ∟ Documentar findings
   ∟ Criar/atualizar casos de teste
   ∟ Estimar QA points para integração
   ∟ Definir próximos passos

{{SENÃO SE perspective = "white-box" OU "black-box" COM Dev+QA:}}
🧪 WHITE-BOX + BLACK-BOX PAIR TESTING (Dev + QA)

1️⃣ FEATURE WALKTHROUGH (15-20min)
   ∟ Dev explica implementação técnica
   ∟ QA entende lógica interna
   ∟ Identificar pontos críticos
   ∟ Mapear fluxos de dados

2️⃣ EDGE CASES DISCOVERY (30-40min)
   ∟ Explorar casos limite juntos
   ∟ Validar tratamento de erros
   ∟ Testar dados inválidos
   ∟ Verificar validações
   ∟ Rotação Driver/Navigator a cada 20min

3️⃣ TEST DATA PREPARATION (15-20min)
   ∟ Criar datasets de teste
   ∟ Preparar cenários complexos
   ∟ Documentar pré-condições
   ∟ Validar setup de ambiente

4️⃣ VALIDATION & DOCUMENTATION (15-20min)
   ∟ Validar findings juntos
   ∟ Criar casos de teste
   ∟ Estimar QA points colaborativamente
   ∟ Priorizar bugs encontrados

{{SENÃO SE perspective = "black-box" COM QA+QA:}}
👥 BLACK-BOX PAIR TESTING (QA + QA)

1️⃣ EXPLORATORY SETUP (10-15min)
   ∟ Revisar critérios de aceitação
   ∟ Definir charters de exploração
   ∟ Preparar checklist de validação
   ∟ Identificar user journeys

2️⃣ EXPLORATORY TESTING (40-50min)
   ∟ Explorar feature livremente
   ∟ Validar user journeys
   ∟ Testar diferentes cenários
   ∟ Cross-validar findings
   ∟ Rotação Driver/Navigator a cada 25min

3️⃣ USABILITY & UX VALIDATION (20-30min)
   ∟ Validar experiência do usuário
   ∟ Verificar feedback visual
   ∟ Testar acessibilidade básica
   ∟ Validar mensagens de erro

4️⃣ CONSOLIDATION (15-20min)
   ∟ Consolidar findings
   ∟ Priorizar bugs
   ∟ Criar casos de teste
   ∟ Estimar QA points
   ∟ Documentar próximos passos
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Passo 6: Criar Template de Documentação

Gerar template para documentação em tempo real:

```markdown
# 📝 Pair Testing Session: {{feature}}

**Data:** [DATA]
**Participantes:** 
- [Participante 1] ([Role])
- [Participante 2] ([Role])

**Perspectiva:** {{perspective}}
**Duração:** [DURAÇÃO]

## 📋 Feature Context

- **Nome:** {{feature}}
- **ID:** {{feature-id}} (se disponível)
- **Descrição:** [DESCRIÇÃO]

## 🎯 Objetivos da Sessão

- [ ] Objetivo 1
- [ ] Objetivo 2
- [ ] Objetivo 3

## 🔍 Findings por Rotação

### Rotação 1 (Driver: [Nome], Navigator: [Nome])
**Tempo:** [INÍCIO] - [FIM]

#### ✅ Validações Bem-sucedidas
- [ ] Validação 1: [Descrição]
- [ ] Validação 2: [Descrição]

#### 🐛 Bugs Encontrados
- [ ] **Bug #1:** [Título]
  - **Severidade:** [Crítica|Alta|Média|Baixa]
  - **Passos para reproduzir:**
    1. [Passo 1]
    2. [Passo 2]
  - **Comportamento esperado:** [Descrição]
  - **Comportamento atual:** [Descrição]
  - **Screenshots/Logs:** [Links]

#### 💡 Edge Cases Identificados
- [ ] Edge case 1: [Descrição]
- [ ] Edge case 2: [Descrição]

#### 📝 Notas e Observações
- [Nota 1]
- [Nota 2]

### Rotação 2 (Driver: [Nome], Navigator: [Nome])
[Repetir estrutura acima]

## 📊 Resumo Consolidado

### Bugs por Severidade
- **Crítica:** [X]
- **Alta:** [X]
- **Média:** [X]
- **Baixa:** [X]

### Validações Realizadas
- **Total:** [X]
- **Passou:** [X]
- **Falhou:** [X]
- **Bloqueado:** [X]

### Edge Cases Identificados
- **Total:** [X]
- **Documentados:** [X]
- **Priorizados:** [X]

## 🧪 Casos de Teste Criados/Atualizados

1. **TC-001:** [Nome do caso]
   - Tipo: [White-box|Grey-box|Black-box]
   - Prioridade: [P1|P2|P3|P4]
   - Status: [Criado|Atualizado]

2. **TC-002:** [Nome do caso]
   [Repetir estrutura]

## 📈 Estimativa QA Story Points

**Estimativa Inicial:** [X] pontos
**Estimativa Após Sessão:** [Y] pontos
**Justificativa:** [Razão da mudança]

### Breakdown por Área
- **Testes Funcionais:** [X] pontos
- **Testes de Integração:** [X] pontos
- **Testes Exploratórios:** [X] pontos
- **Edge Cases:** [X] pontos

## ✅ Próximos Passos

- [ ] [Ação 1] - Responsável: [Nome] - Prazo: [Data]
- [ ] [Ação 2] - Responsável: [Nome] - Prazo: [Data]
- [ ] [Ação 3] - Responsável: [Nome] - Prazo: [Data]

## 🔗 Referências

- Feature: [Link para task/feature]
- Test Strategy: [Link]
- Documentação: [Links relevantes]
```

### Passo 7: Criar Checklist de Execução

Gerar checklist para guiar a sessão:

```markdown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ CHECKLIST DE EXECUÇÃO - PAIR TESTING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 PREPARAÇÃO
  ✅ Ambiente de teste configurado
  ✅ Feature deployada/acessível
  ✅ Critérios de aceitação revisados
  ✅ Test data preparado
  ✅ Ferramentas de documentação prontas

🎯 DURANTE A SESSÃO
  ✅ Rotação Driver/Navigator a cada 20-30min
  ✅ Findings documentados em tempo real
  ✅ Bugs reportados imediatamente
  ✅ Edge cases capturados
  ✅ Dúvidas esclarecidas em tempo real

📝 DOCUMENTAÇÃO
  ✅ Template preenchido completamente
  ✅ Bugs documentados com repro steps
  ✅ Casos de teste criados/atualizados
  ✅ QA points estimados
  ✅ Próximos passos definidos

🔗 INTEGRAÇÃO
  ✅ Findings sincronizados com task manager
  ✅ Bugs criados como tasks/issues
  ✅ Test cases atualizados
  ✅ Comentários adicionados na feature
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Passo 8: Integração com Task Manager (Opcional)

**SE** `{{feature-id}}` fornecido **E** `{{task-manager}}` = `clickup`:

```bash
# 1. Buscar contexto da feature
# 2. Criar comentário com resumo da sessão planejada
# 3. Criar subtasks para:
#    - Preparação da sessão
#    - Execução da sessão
#    - Follow-up de bugs encontrados
# 4. Adicionar tags: pair-testing, {{perspective}}
# 5. Atualizar custom fields se disponíveis
```

**Formato de Comentário ClickUp:**

```markdown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🤝 PAIR TESTING SESSION SCHEDULED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Feature: {{feature}}
👥 Participantes: [Participante 1] + [Participante 2]
🎯 Perspectiva: {{perspective}}
📅 Data: [DATA]
⏱️  Duração: 1-2 horas

🎯 OBJETIVOS:
∟ Validação colaborativa da feature
∟ Descoberta de edge cases
∟ Refinamento de test strategy
∟ Estimativa colaborativa de QA points

📝 Documentação: [LINK para template]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**SENÃO:**

```bash
# Documentar manualmente ou usar integração específica
```

### Passo 9: Integração com Calendar (Opcional)

**SE** `{{schedule}}` fornecido:

```bash
# 1. Criar evento no calendário
#    - Título: "Pair Testing: {{feature}} ({{perspective}})"
#    - Duração: 1-2 horas
#    - Participantes: [Participante 1], [Participante 2]
#    - Descrição: Agenda + link para template
#    - Anexar: Template de documentação
# 2. Enviar convite
# 3. Criar reminder 15min antes
```

**SENÃO:**

```bash
# Gerar link de calendário (.ics) para importação manual
# Ou instruir criação manual
```

## 📤 Output Esperado

### Arquivos Gerados

1. **Agenda Estruturada** (`pair-testing-agenda-{{feature}}.md`)
   - Agenda completa baseada na perspectiva
   - Timing detalhado
   - Tópicos por rotação

2. **Template de Documentação** (`pair-testing-session-{{feature}}.md`)
   - Template preenchível
   - Seções por rotação
   - Checklists integrados

3. **Checklist de Execução** (`pair-testing-checklist-{{feature}}.md`)
   - Validação de preparação
   - Guia durante a sessão
   - Validação de outputs

4. **Calendar Event** (se `--schedule` fornecido)
   - Evento criado
   - Convites enviados
   - Reminders configurados

### Atualizações no Task Manager (se `{{feature-id}}` fornecido)

- ✅ Comentário com resumo da sessão planejada
- ✅ Subtasks criadas (preparação, execução, follow-up)
- ✅ Tags aplicadas (`pair-testing`, `{{perspective}}`)
- ✅ Custom fields atualizados (se disponíveis)

### Resumo Visual

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ PAIR TESTING SESSION ORGANIZED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Feature: {{feature}}
🎯 Perspectiva: {{perspective}}
👥 Participantes: [Participante 1] + [Participante 2]

📁 Arquivos criados:
  ∟ Agenda: pair-testing-agenda-{{feature}}.md
  ∟ Template: pair-testing-session-{{feature}}.md
  ∟ Checklist: pair-testing-checklist-{{feature}}.md

🔗 Task Manager: {{task-manager}}
  ∟ Feature ID: {{feature-id}} (se fornecido)
  ∟ Comentário adicionado ✓

📅 Calendar: [Status - criado se --schedule]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## 🔗 Referências

- **Framework de Testes:** `docs/knowledge-base/frameworks/framework-testes.md`
  - Seção "Padrões de Colaboração - Sessões de Teste em Par Multi-perspectiva" (linhas ~879-904)
  - Seção "Diferenças entre White-box vs Black-box vs Grey-box" (linhas ~111-165)
- **Three Amigos:** `/validate/collab/three-amigos`
- **Test Strategy:** `/validate/test-strategy/create`

## ⚠️ Notas

- **Duração recomendada:** 1-2 horas por sessão
- **Rotação Driver/Navigator:** A cada 20-30 minutos para manter engajamento
- **Perspectivas válidas:** `white-box`, `grey-box`, `black-box`
- **Combinações recomendadas:**
  - `grey-box` → Dev + Dev
  - `white-box` ou `black-box` com Dev+QA → Dev + QA
  - `black-box` com QA+QA → QA + QA
- **Documentação:** Sempre documentar findings em tempo real
- **Calendar:** Use `--schedule` para criar evento automaticamente
- **Task Manager:** Forneça `--feature-id` para integração automática

## 💡 Exemplos de Uso

### Exemplo 1: Pair Testing Grey-box com Agendamento

```bash
/validate/collab/pair-testing "checkout" grey-box --schedule --feature-id CU-123
```

**Output:**
- Agenda gerada para Dev+Dev
- Template de documentação criado
- Checklist preparado
- Evento criado no calendário
- Comentário adicionado na task CU-123 no ClickUp

### Exemplo 2: Pair Testing Black-box Manual

```bash
/validate/collab/pair-testing "login" black-box --participants "qa1,qa2"
```

**Output:**
- Agenda gerada para QA+QA
- Template de documentação criado
- Checklist preparado
- Sem integração automática (sem `--feature-id` e `--schedule`)

### Exemplo 3: Pair Testing White-box com Contexto

```bash
/validate/collab/pair-testing "user-profile" white-box --feature-id TASK-456 --task-manager jira
```

**Output:**
- Agenda gerada para Dev+QA
- Contexto buscado do Jira (TASK-456)
- Template preenchido com contexto
- Checklist preparado
- Comentário adicionado na task do Jira

