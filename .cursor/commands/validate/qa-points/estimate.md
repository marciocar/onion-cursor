---
name: qa-points-estimate
description: |
  Calcula QA Story Points usando a fórmula exata do Framework de Testes.
  Use para estimar esforço de teste com precisão, incluindo breakdown por perspectiva e sugestões de técnicas.
  Integra com task managers para atualizar story points automaticamente.
model: sonnet

parameters:
  - name: task-description
    description: Descrição da tarefa de teste (entre aspas)
    required: true
  - name: complexity
    description: Complexidade base (simple|medium|complex|epic). Default: auto-detect
    required: false
  - name: risk
    description: Nível de risco (low|medium|high|critical). Default: auto-detect
    required: false
  - name: type
    description: Tipo de teste (unit|integration|ui|api|e2e|performance|security|manual). Default: auto-detect
    required: false
  - name: task-id
    description: ID da task no task manager para atualizar (ex: PROJ-123, CU-456)
    required: false
  - name: task-manager
    description: Provedor do task manager (jira|clickup|asana|auto-detect). Se não fornecido, será inferido do .env ou formato do task-id
    required: false
  - name: update
    description: Atualiza story points diretamente no task manager quando fornecido task-id
    required: false
  - name: breakdown
    description: Mostra breakdown detalhado por perspectiva (White/Grey/Black-box)
    required: false
  - name: suggest-techniques
    description: Sugere técnicas de teste baseadas no framework
    required: false

category: validate
tags:
  - qa
  - testing
  - story-points
  - estimation
  - quality-assurance
  - test-planning

version: "1.0.0"
updated: "2025-12-03"

related_commands:
  - /validate/test-strategy/create
  - /validate/test-strategy/analyze
  - /product/estimate
  - /product/task

related_agents:
  - test-engineer
  - test-planner
---

# 🧮 Estimativa de QA Story Points

Calcula QA Story Points usando a fórmula exata do Framework de Testes (`docs/knowledge-base/frameworks/framework-testes.md`), incluindo análise contextual inteligente, breakdown por perspectiva e sugestões de técnicas.

## 🎯 Objetivo

Fornecer estimativas precisas de esforço de teste através de:
- Fórmula exata do Framework de Testes (sem desvios)
- Análise contextual inteligente da descrição
- Breakdown por perspectiva (White/Grey/Black-box)
- Sugestões de técnicas apropriadas
- Integração com task managers para atualização automática

## ⚡ Fluxo de Execução

### Passo 1: Carregar Framework de Testes (OBRIGATÓRIO)

**CRÍTICO:** Sempre ler o framework antes de qualquer cálculo:

```bash
# Ler framework completo
read_file docs/knowledge-base/frameworks/framework-testes.md
```

**Extrair e armazenar em memória:**
- Seção "QA Story Points - Sistema de Estimativa" (linhas ~217-330)
- Fórmula exata: `QA Points = Complexidade Base + Ajuste de Risco + Ajuste de Tipo`
- Escalas de complexidade, risco e tipo
- Distribuições por perspectiva (White/Grey/Black-box)
- Técnicas por tipo de teste

**Validar leitura:**
```markdown
SE arquivo não encontrado:
  ❌ ERRO: Framework de testes não encontrado em docs/knowledge-base/frameworks/framework-testes.md
  💡 Verifique se o arquivo existe e tente novamente
```

### Passo 2: Análise Contextual da Descrição

#### 2.1. Detecção de Keywords

**Analisar descrição para detectar indicadores:**

```markdown
## 🔍 Análise de Keywords

**Complexidade:**
- "multiple APIs" → +1 complexity
- "third-party integration" → +1 complexity
- "new technology" → +1 complexity
- "legacy system" → +1 complexity + 1 risk

**Risco:**
- "payment", "gateway", "financial" → +2 risk
- "third-party service" → +1 risk
- "critical user flow" → +2 risk
- "security", "auth", "authentication" → +2 risk
- "data", "personal", "LGPD" → +2 risk

**Tipo de Teste (Inferência):**
- "API", "endpoint", "contract" → integration/api
- "form", "button", "UI", "interface" → ui
- "login", "checkout", "user journey", "flow" → e2e
- "load", "stress", "performance" → performance
- "security", "vulnerability", "penetration" → security
- "manual", "exploratory" → manual
```

#### 2.2. Inferência de Parâmetros

**SE parâmetros não fornecidos, inferir da descrição:**

```markdown
## 📊 Inferência Automática

**Complexidade:**
- SE keywords de complexidade detectadas:
  - 1 keyword → medium
  - 2+ keywords → complex
- SE nenhuma keyword → medium (default)

**Risco:**
- SE keywords de risco crítico detectadas → critical
- SE keywords de risco alto detectadas → high
- SE keywords de risco médio detectadas → medium
- SE nenhuma keyword → medium (default)

**Tipo:**
- SE keywords de tipo detectadas → usar tipo inferido
- SE nenhuma keyword → integration (default)
```

### Passo 3: Cálculo de QA Story Points

#### 3.1. Aplicar Fórmula Exata

**CRÍTICO:** Usar valores exatos do framework, sem desvios:

```markdown
## 🧮 Cálculo QA Story Points

**Fórmula:** QA Points = Complexidade Base + Ajuste de Risco + Ajuste de Tipo

### Complexidade Base (escolher valor médio do range):
- simple: 1-2 pontos → usar 1.5 (arredondar para 2)
- medium: 3-5 pontos → usar 4
- complex: 5-8 pontos → usar 6.5 (arredondar para 7)
- epic: 8-13 pontos → usar 10.5 (arredondar para 11)

### Ajuste de Risco (escolher valor médio do range):
- low: +0 pontos
- medium: +1-2 pontos → usar +1.5 (arredondar para +2)
- high: +2-3 pontos → usar +2.5 (arredondar para +3)
- critical: +3-5 pontos → usar +4

### Ajuste de Tipo (escolher valor médio do range):
- unit: +0-1 pontos → usar +0.5 (arredondar para +1)
- integration: +1-2 pontos → usar +1.5 (arredondar para +2)
- ui: +2-3 pontos → usar +2.5 (arredondar para +3)
- api: +1-2 pontos → usar +1.5 (arredondar para +2)
- e2e: +3-4 pontos → usar +3.5 (arredondar para +4)
- performance: +2-4 pontos → usar +3
- security: +3-5 pontos → usar +4
- manual: +1-3 pontos → usar +2

### Ajuste Contextual (opcional):
- SE keywords detectadas → aplicar ajustes adicionais
- "third-party integration" → +1 complexity
- "legacy system" → +1 complexity + 1 risk
```

#### 3.2. Calcular Total

```markdown
## 📊 Resultado do Cálculo

**Exemplo:**
- Complexidade Base: medium = 4 pontos
- Context Adjustment: +1 ponto (third-party integration)
- Risk Adjustment: high = +3 pontos
- Type Adjustment: integration = +2 pontos
- **Total: 10 QA Story Points**

**Estimativa de Esforço:**
- 10 pontos = 14-18 horas (baseado na escala do framework)
```

### Passo 4: Breakdown Multi-Perspectiva

**SE `--breakdown` fornecido:**

```markdown
## 🎭 Multi-Perspective Breakdown

**Distribuição por tipo de teste (do framework):**

### Unit Tests:
- White-box: 70%
- Grey-box: 20%
- Black-box: 10%

### Integration Tests:
- White-box: 30%
- Grey-box: 60%
- Black-box: 10%

### UI Tests:
- White-box: 20%
- Grey-box: 30%
- Black-box: 50%

### API Tests:
- White-box: 40%
- Grey-box: 50%
- Black-box: 10%

### E2E Tests:
- White-box: 10%
- Grey-box: 30%
- Black-box: 60%

### Performance Tests:
- White-box: 30%
- Grey-box: 40%
- Black-box: 30%

### Security Tests:
- White-box: 25%
- Grey-box: 35%
- Black-box: 40%

**Cálculo:**
- Total QA Points: [X]
- White-box: [X * %] pontos | [horas] horas | [%]%
- Grey-box: [X * %] pontos | [horas] horas | [%]%
- Black-box: [X * %] pontos | [horas] horas | [%]%
```

### Passo 5: Sugestões de Técnicas

**SE `--suggest-techniques` fornecido:**

```markdown
## 💡 Técnicas Sugeridas (do framework)

### Por Tipo de Teste:

**Unit:**
- TDD (Test-Driven Development)
- Mutation Testing
- Code Coverage Analysis
- Behavior-Driven Testing

**Integration:**
- Contract Testing (Pact)
- API Mocking (Wiremock)
- Database Testing
- Fuzzing de API

**UI:**
- Page Object Model
- Visual Testing
- Accessibility Testing
- Cross-browser Testing

**API:**
- Schema Validation
- Error Handling Testing
- Rate Limiting Testing
- Contract Testing

**E2E:**
- User Journey Mapping
- Browser Testing (Cypress, Selenium)
- Acceptance Testing

**Performance:**
- Load Testing
- Stress Testing
- Profiling
- Performance Monitoring

**Security:**
- Penetration Testing
- OWASP Guidelines
- Vulnerability Scanning
- Security Audit

**Manual:**
- Exploratory Testing
- Usability Testing
- Session-Based Testing
```

### Passo 6: Integração com Task Manager

**SE `--task-id` fornecido:**

#### 6.1. Detectar Provedor

```bash
# EXECUTAR PRIMEIRO: Ler .env para detectar provedor
read_file .env
```

**Lógica de detecção:**
```markdown
**1. SE {{task-manager}} fornecido explicitamente:**
   usar {{task-manager}} diretamente

**2. SE formato do task-id detectável:**
   - CU-xxxxx → clickup
   - PROJ-xxx → jira (se configurado)
   - Outros → verificar .env

**3. SE TASK_MANAGER_PROVIDER no .env:**
   usar valor do .env

**4. SE nenhum detectado:**
   ⚠️ AVISO: Task manager não detectado
   Continuar apenas com output local
```

#### 6.2. Buscar Task Existente

```markdown
## 🔍 Buscando Task

**Task ID:** {{task-id}}
**Provedor:** {{task-manager}}

**Ações:**
1. Buscar task usando adapter apropriado
2. Validar que task existe
3. Ler story points atuais (se existir)
```

#### 6.3. Atualizar Story Points (SE `--update` fornecido)

**CRÍTICO:** Usar ferramentas MCP diretamente:

```markdown
## 📊 Atualizando Story Points

**Para ClickUp:**
1. Buscar task para obter custom field ID:
   ```bash
   mcp_ClickUp_clickup_get_task({
     task_id: taskId,
     workspace_id: workspaceId
   })
   ```

2. Extrair custom field ID de "Story Points" ou "QA Story Points" da resposta

3. Atualizar task com custom field:
   ```bash
   mcp_ClickUp_clickup_update_task({
     task_id: taskId,
     workspace_id: workspaceId,
     custom_fields: [{
       id: "custom_field_id",  // ID obtido do passo 2
       value: totalPoints
     }]
   })
   ```

4. Adicionar comentário com análise completa usando `mcp_ClickUp_clickup_create_task_comment`

**Para Asana:**
- Usar `mcp_asana_*` tools apropriados
- Custom field "QA Story Points"
- Seguir padrão similar ao ClickUp

**Para Jira:**
- Usar API Jira ou adapter apropriado
- Custom field "Story Points"
- Pode usar `issue.fields.customfield_XXXXX` para atualizar

**Nota:** Se custom field não existir, criar comentário com estimativa e sugerir criação do custom field.
```

**Template de Comentário:**

```markdown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🧮 QA STORY POINTS ESTIMATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📅 Timestamp: [data/hora]

📋 TASK ANALYSIS:
∟ Description: "{{task-description}}"
∟ Detected Keywords: [lista de keywords]
∟ Context Factors: [ajustes contextuais]

🧮 FORMULA BREAKDOWN:
∟ Base Complexity: {{complexity}} = {{base_points}} points
∟ Context Adjustment: {{context_adjustment}} points
∟ Risk Adjustment: {{risk}} = {{risk_points}} points
∟ Type Adjustment: {{type}} = {{type_points}} points
∟ **Total: {{total_points}} QA Story Points**

⏱️ ESTIMATED EFFORT: {{hours_range}} hours

🎭 MULTI-PERSPECTIVE BREAKDOWN:
∟ White-box: {{white_points}} points | {{white_hours}} hours | {{white_percent}}%
∟ Grey-box: {{grey_points}} points | {{grey_hours}} hours | {{grey_percent}}%
∟ Black-box: {{black_points}} points | {{black_hours}} hours | {{black_percent}}%

💡 SUGGESTED TECHNIQUES:
{{lista de técnicas sugeridas}}

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ Calculation complete! {{total_points}} QA Story Points estimated.
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## 📤 Output Esperado

### Formato Completo

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🧮 QA STORY POINTS CALCULATION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 TASK ANALYSIS:

Description: "{{task-description}}"

✓ Detected Keywords: [lista de keywords]
✓ Context Factors: [ajustes contextuais aplicados]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🧮 FORMULA BREAKDOWN:

Base Complexity: {{complexity}} = {{base_points}} points
+ Context Adjustment: {{context_adjustment}} points
+ Risk Adjustment: {{risk}} = {{risk_points}} points
+ Type Adjustment: {{type}} = {{type_points}} points

= **Total: {{total_points}} QA Story Points**

⏱️ ESTIMATED EFFORT: {{hours_range}} hours

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎭 MULTI-PERSPECTIVE BREAKDOWN:

🔬 White-box ({{white_points}} points | {{white_hours}} hours | {{white_percent}}%):
   - [técnicas white-box]
   - [responsabilidades]

🔗 Grey-box ({{grey_points}} points | {{grey_hours}} hours | {{grey_percent}}%):
   - [técnicas grey-box]
   - [responsabilidades]

📱 Black-box ({{black_points}} points | {{black_hours}} hours | {{black_percent}}%):
   - [técnicas black-box]
   - [responsabilidades]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

💡 SUGGESTED TECHNIQUES:

🔬 White-box:
   - [técnica 1]
   - [técnica 2]

🔗 Grey-box:
   - [técnica 1]
   - [técnica 2]

📱 Black-box:
   - [técnica 1]
   - [técnica 2]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ Calculation complete! {{total_points}} QA Story Points estimated.

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Formato Resumido (sem flags)

```
🧮 QA STORY POINTS: {{total_points}} pontos
⏱️ Estimated Effort: {{hours_range}} hours
📊 Type: {{type}} | Complexity: {{complexity}} | Risk: {{risk}}
```

## 📋 Exemplos de Uso

### Exemplo 1: Estimativa Básica

```bash
/qa-points/estimate "API integration tests for payment gateway"
```

**Output esperado:**
- Detecta: payment (high risk), API (integration type)
- Calcula: medium (4) + high risk (+3) + integration (+2) = 9 pontos
- Esforço: 12-16 horas

### Exemplo 2: Com Breakdown e Técnicas

```bash
/qa-points/estimate "API integration tests for payment gateway with third-party service" medium high integration --breakdown --suggest-techniques
```

**Output esperado:**
- Total: 10 QA Story Points
- Breakdown detalhado por perspectiva
- Técnicas sugeridas para cada perspectiva

### Exemplo 3: Com Atualização no Task Manager

```bash
/qa-points/estimate "Login form validation" simple low ui --task-id CU-456 --update
```

**Output esperado:**
- Calcula: simple (2) + low risk (+0) + ui (+3) = 5 pontos
- Atualiza task CU-456 no ClickUp com:
  - Custom field "QA Story Points" = 5
  - Comentário com análise completa

### Exemplo 4: Inferência Automática

```bash
/qa-points/estimate "E2E testing for checkout flow with payment integration"
```

**Output esperado:**
- Infere: e2e type, complex complexity (checkout + payment), high risk (payment)
- Calcula: complex (7) + high risk (+3) + e2e (+4) = 14 pontos
- Alerta: >13 pontos, pode precisar quebra

## ⚠️ Regras e Validações

### Validações Obrigatórias

1. **Descrição não vazia:**
   ```markdown
   SE task-description vazio:
     ❌ ERRO: Descrição da tarefa é obrigatória
     💡 Sugestão: Forneça detalhes suficientes para análise
   ```

2. **Valores válidos:**
   ```markdown
   SE complexity fornecido E não está em [simple, medium, complex, epic]:
     ⚠️ AVISO: Complexidade inválida, usando auto-detect
   
   SE risk fornecido E não está em [low, medium, high, critical]:
     ⚠️ AVISO: Risco inválido, usando auto-detect
   
   SE type fornecido E não está em [unit, integration, ui, api, e2e, performance, security, manual]:
     ⚠️ AVISO: Tipo inválido, usando auto-detect
   ```

3. **Task ID válido (se fornecido):**
   ```markdown
   SE task-id fornecido E formato inválido:
     ⚠️ AVISO: Formato de task-id inválido
     Continuar sem atualização
   ```

### Anti-Patterns Detectados

1. **Épicos de teste (>13 pontos):**
   ```markdown
   SE total_points > 13:
     ⚠️ ALERTA: Estimativa > 13 pontos (épico)
     💡 Recomendação: Considerar quebra em múltiplas tasks de teste
   ```

2. **Inconsistências detectadas:**
   ```markdown
   SE type=unit E risk=critical:
     ⚠️ AVISO: Unit tests geralmente não têm risco crítico
     Verificar se tipo está correto
   
   SE type=manual E complexity=epic:
     ⚠️ AVISO: Testes manuais épicos podem ser muito demorados
     Considerar automação ou quebra
   ```

## 🔗 Integração com Outros Comandos

### Com `/validate/test-strategy/create`
```markdown
Após estimar, criar estratégia completa:
/validate/test-strategy/create "{{task-description}}" --qa-points={{estimated_points}}
```

### Com `/product/task`
```markdown
Criar task com estimativa QA:
/product/task "{{task-description}}" --qa-points={{estimated_points}}
```

### Com `/product/estimate`
```markdown
Comparar estimativa dev vs QA:
/product/estimate "{{task-description}}"
/qa-points/estimate "{{task-description}}"
```

## 📚 Base de Conhecimento

O comando utiliza o framework completo de testes disponível em:
- `docs/knowledge-base/frameworks/framework-testes.md`

**Conteúdo incluído:**
- Fórmula exata de QA Story Points (linhas ~217-330)
- Escalas de complexidade, risco e tipo
- Distribuições por perspectiva (White/Grey/Black-box)
- Técnicas específicas por tipo de teste
- Métricas de qualidade

## ⚠️ Notas Importantes

- **Fórmula exata:** Sempre usar valores do framework, sem desvios
- **Análise contextual:** Keywords detectadas podem ajustar valores
- **Breakdown opcional:** Usar `--breakdown` para ver distribuição por perspectiva
- **Técnicas sugeridas:** Baseadas no framework, não inventadas
- **Task manager:** Requer configuração prévia via `/meta/setup-integration`
- **Atualização automática:** Usar `--update` apenas quando confiante na estimativa

---

**Versão:** 1.0.0  
**Última atualização:** 2025-12-03  
**Mantido por:** Sistema Onion

