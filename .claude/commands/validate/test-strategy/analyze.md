---
name: test-strategy-analyze
description: |
  Analisa estratégias de teste existentes e sugere melhorias baseadas no Framework de Testes.
  Use para auditar conformidade, identificar gaps e otimizar estratégias de teste com base no framework.
model: sonnet

parameters:
  - name: feature-id
    description: ID da feature/epic no task manager (ex: PROJ-123, CU-456)
    required: true
  - name: task-manager
    description: Provedor do task manager (jira|clickup|asana). Se não fornecido, será inferido automaticamente do .env ou formato do feature-id
    required: false
  - name: deep-scan
    description: Análise profunda incluindo código e cobertura
    required: false
  - name: auto-fix
    description: Aplica correções automáticas quando possível
    required: false
  - name: export-report
    description: Gera relatório detalhado em arquivo
    required: false

category: validate
tags:
  - testing
  - qa
  - strategy
  - analysis
  - compliance
  - audit
  - improvement

version: "3.0.0"
updated: "2025-12-03"

related_commands:
  - /validate/test-strategy/create
  - /product/task
  - /product/estimate

related_agents:
  - test-engineer
  - test-planner
---

# 🔍 Análise de Estratégia de Teste

Analisa estratégias de teste existentes e sugere melhorias baseadas no Framework de Testes (`docs/knowbase/frameworks/framework_testes.md`), identificando gaps de conformidade e oportunidades de otimização.

## 🎯 Objetivo

Auditar e melhorar estratégias de teste existentes através de:
- Análise de conformidade com o Framework de Testes
- Identificação de gaps de cobertura e qualidade
- Sugestões priorizadas de melhorias
- Correções automáticas quando aplicável
- Relatórios detalhados e acionáveis

## ⚡ Fluxo de Execução

### Passo 1: Carregar Framework de Testes (OBRIGATÓRIO)

**CRÍTICO:** Sempre ler o framework antes de qualquer análise:

```bash
# Ler framework completo
read_file docs/knowbase/frameworks/framework_testes.md
```

**Extrair e armazenar em memória:**
- Seção "QA Story Points - Sistema de Estimativa" (linhas ~217-330)
- Seção "Diferenças entre White-box vs Black-box vs Grey-box" (linhas ~111-165)
- Seção "Técnicas Específicas por Tipo" (linhas ~464-594)
- Seção "Métricas de Qualidade" (linhas ~598-649)
- Seção "Template Universal de Caso de Teste" (linhas ~171-213)
- Seção "Padrões de Colaboração" (linhas ~855-928)

**Validar leitura:**
```markdown
SE arquivo não encontrado:
  ❌ ERRO: Framework de testes não encontrado em docs/knowbase/frameworks/framework_testes.md
  💡 Verifique se o arquivo existe e tente novamente
```

### Passo 2: Detectar e Configurar Task Manager

**CRÍTICO:** Detectar provedor automaticamente do `.env` primeiro, depois usar fallback:

```bash
# EXECUTAR PRIMEIRO: Ler .env para detectar provedor
read_file .env
```

**Lógica de detecção (prioridade):**

```markdown
**1. SE {{task-manager}} fornecido explicitamente:**
   usar {{task-manager}} diretamente
   validar que está em: jira|clickup|asana

**2. SENÃO, tentar detectar do .env:**
   Extrair TASK_MANAGER_PROVIDER do .env
   SE encontrado e válido (clickup|asana|linear):
     task-manager = TASK_MANAGER_PROVIDER
     SE linear: converter para jira (compatibilidade)
   
**3. SENÃO, tentar detectar pelo formato do feature-id:**
   SE feature-id começa com "CU-" ou "cu-":
     task-manager = "clickup"
   SE feature-id começa com "PROJ-", "JIRA-", "JIRA-" ou padrão numérico:
     task-manager = "jira"
   SE feature-id começa com "ASANA-" ou padrão específico:
     task-manager = "asana"
   
**4. SENÃO (nenhum método funcionou):**
   ❌ ERRO: Não foi possível detectar task manager
   💡 Configure TASK_MANAGER_PROVIDER no .env ou forneça --task-manager
```

**Validações:**
```markdown
- feature-id não pode estar vazio
- task-manager detectado deve ser válido: jira|clickup|asana
- SE task-manager não detectado: abortar com erro claro
```

### Passo 3: Validar e Normalizar Parâmetros

```markdown
**Parâmetros normalizados:**
- feature-id: {{feature-id}} ✅ obrigatório
- task-manager: [detectado do .env ou formato] ✅ detectado automaticamente
- deep-scan: {{deep-scan}} ou false
- auto-fix: {{auto-fix}} ou false
- export-report: {{export-report}} ou false
```

### Passo 4: Coletar Dados do Task Manager

**CRÍTICO:** Seguir padrão de `/product/task` para integração (`.env` já foi lido no Passo 2):

**Buscar dados completos da feature/epic:**

**Para ClickUp:**
```markdown
1. Buscar epic principal usando feature-id
   - Usar mcp_ClickUp_clickup_get_task ou mcp_ClickUp_clickup_search_tasks
   - Extrair: nome, descrição, status, labels, custom fields (QA Story Points)
   
2. Buscar todas subtasks relacionadas
   - Usar mcp_ClickUp_clickup_get_subtasks ou filtrar por parent
   - Para cada subtask: nome, status, pontos, labels, comentários
   
3. Buscar histórico e métricas
   - Comentários com timestamps
   - Mudanças de status
   - Time tracking (se disponível)
```

**Para Jira:**
```markdown
1. Buscar epic/issue principal
   - Usar API Jira ou MCP equivalente
   - Extrair: summary, description, status, labels, story points
   
2. Buscar linked issues (subtasks)
   - Issues vinculadas ao epic
   - Para cada: summary, status, story points, comments
   
3. Buscar histórico
   - Changelog para mudanças de status
   - Comments com timestamps
   - Worklog (tempo gasto)
```

**Para Asana:**
```markdown
1. Buscar task principal
   - Usar mcp_asana_asana_get_task
   - Extrair: name, notes, status, custom fields
   
2. Buscar subtasks
   - Usar mcp_asana_asana_get_subtasks
   - Para cada: name, status, custom fields, comments
   
3. Buscar histórico
   - Stories (histórico de mudanças)
   - Comments com timestamps
```

**Dados a coletar:**
- Epic/feature principal: nome, descrição, status, labels/tags
- QA Story Points atribuídos vs estimados
- Todas subtasks relacionadas (White-box, Grey-box, Black-box)
- Status atual de cada task
- Acceptance criteria definidos
- Histórico de updates e comentários
- Tempo gasto vs tempo estimado (se disponível)
- Labels e tags de categorização

### Passo 5: Coletar Dados do Código (se --deep-scan)

**SE deep-scan = true:**

```bash
# Buscar estrutura de testes no código
glob_file_search "**/*test*.{js,ts,jsx,tsx,py,spec.js,spec.ts}"
glob_file_search "**/*.test.{js,ts,jsx,tsx,py}"
glob_file_search "**/__tests__/**/*"
glob_file_search "**/tests/**/*"
glob_file_search "**/spec/**/*"

# Buscar arquivos de configuração
glob_file_search "**/jest.config.*"
glob_file_search "**/pytest.ini"
glob_file_search "**/.nycrc*"
glob_file_search "**/coverage/**/*"

# Buscar CI/CD configs
glob_file_search "**/.github/workflows/*test*.yml"
glob_file_search "**/.gitlab-ci.yml"
glob_file_search "**/azure-pipelines.yml"
```

**Analisar estrutura de testes:**
```markdown
1. Identificar tipos de teste presentes:
   - Unit tests (White-box)
   - Integration tests (Grey-box)
   - E2E tests (Black-box)
   
2. Contar arquivos por tipo
3. Verificar padrões de nomenclatura
4. Identificar estrutura de diretórios
```

**Buscar métricas de cobertura:**
```markdown
1. Ler coverage reports se existirem:
   - coverage/lcov-report/index.html
   - coverage/coverage-summary.json
   - .nyc_output/coverage.json
   
2. Extrair métricas:
   - Line coverage
   - Branch coverage
   - Function coverage
   - Statement coverage
```

**Analisar configurações de CI/CD:**
```markdown
1. Verificar pipelines de teste
2. Identificar quality gates
3. Verificar thresholds de cobertura
4. Analisar execução de testes
```

**Buscar logs de execução:**
```markdown
1. Verificar histórico de falhas recentes
2. Identificar testes flaky
3. Analisar tempo de execução
4. Verificar trends de qualidade
```

### Passo 6: Analisar Conformidade com Framework

**5.1. Validação de QA Story Points**

```markdown
**Verificar cada task:**
1. Extrair QA points atribuídos (custom field ou label)
2. Calcular QA points esperados usando fórmula do framework:
   - Complexidade Base (simples: 1-2, médio: 3-5, complexo: 5-8, épico: 8-13)
   - Ajuste por Risco (baixo: +0-1, médio: +1-2, alto: +2-3, crítico: +3-5)
   - Tipo de Teste (básico: +1, padrão: +2-3, extensivo: +4-6)
   
3. Comparar atribuído vs calculado
4. Identificar discrepâncias >20% como problema

**Distribuição por perspectiva:**
- Verificar se pontos estão distribuídos entre White/Grey/Black-box
- Validar proporções sugeridas pelo framework:
  * Simples/Médio: White 30%, Grey 30%, Black 40%
  * Complexo/Épico: White 25%, Grey 35%, Black 40%
```

**5.2. Análise Multi-Perspectiva**

```markdown
**Verificar cobertura das 3 perspectivas:**

1. White-box (Developer Testing):
   - Existem tasks/subtasks de unit testing?
   - Técnicas mencionadas: Code Coverage, Mutation Testing?
   - Métricas definidas: >80% coverage, >70% mutation score?
   - Ferramentas: Jest, PyTest, JUnit mencionadas?

2. Grey-box (Cross-Dev Testing):
   - Existem tasks de integration testing?
   - Técnicas: API Contract Testing, Fuzzing?
   - Métricas: >95% integration pass rate, 100% API contract coverage?
   - Foco em contratos e fronteiras?

3. Black-box (QA Testing):
   - Existem tasks de system/acceptance testing?
   - Técnicas: Partição de Equivalência, Análise de Valor Limite?
   - Métricas: 100% user story coverage, >85% bug detection rate?
   - Foco em jornada do usuário?

**Calcular score de cobertura:**
- 100% = todas 3 perspectivas presentes e bem definidas
- 67% = 2 perspectivas presentes
- 33% = 1 perspectiva presente
- 0% = nenhuma perspectiva identificada
```

**5.3. Conformidade com Templates**

```markdown
**Verificar se tasks seguem template universal:**

1. Acceptance criteria completos?
   - Objetivo claro
   - Pré-condições definidas
   - Dados de teste especificados
   - Passos de execução
   - Resultado esperado
   - Critérios de sucesso

2. Template de caso de teste presente?
   - Tipo (Unit/Integration/System/Acceptance)
   - Perspectiva (White/Grey/Black-box)
   - Prioridade e complexidade
   - QA Story Points
   - Tags apropriadas

3. Métricas de sucesso definidas?
   - Thresholds claros
   - KPIs mensuráveis
   - Critérios de aceitação
```

**5.4. Padrões de Colaboração**

```markdown
**Verificar evidência de colaboração:**

1. Three Amigos sessions:
   - Comentários indicando discussão PO+Dev+QA?
   - Histórico mostra refinement sessions?
   - Acceptance criteria refinados colaborativamente?

2. Pair Testing:
   - Comentários mencionam pair testing?
   - Tasks atribuídas a múltiplos owners?
   - Evidência de cross-review?

3. Handoff Protocols:
   - Comentários de handoff Dev→QA?
   - Documentação de "how to test"?
   - Evidência de validação de estimativas?
```

### Passo 7: Detectar Gaps e Problemas

**6.1. Identificar Gaps de Cobertura**

```markdown
**Perspectivas faltantes:**
- SE apenas White-box presente: falta Grey e Black-box
- SE apenas Black-box presente: falta White e Grey-box
- SE apenas Grey-box presente: falta White e Black-box
- SE nenhuma perspectiva clara: gap crítico

**Técnicas faltantes:**
- White-box sem Mutation Testing: gap médio
- Grey-box sem API Contract Testing: gap alto
- Black-box sem Exploratory Testing: gap médio
- Sem automação quando deveria ter: gap alto
```

**6.2. Identificar Estimativas Incorretas**

```markdown
**Comparar estimado vs real (se dados disponíveis):**
- SE tempo gasto > 150% do estimado: sobre-estimativa ou complexidade subestimada
- SE tempo gasto < 50% do estimado: sub-estimativa ou complexidade superestimada
- SE QA points atribuídos ≠ calculados pelo framework: recalcular necessário

**Identificar padrões:**
- Tasks consistentemente subestimadas: problema de processo
- Tasks consistentemente superestimadas: problema de processo
- Variação alta: falta de padronização
```

**6.3. Identificar Métricas Fora do Threshold**

```markdown
**Comparar métricas atuais vs thresholds do framework:**

1. Code Coverage:
   - SE < 80%: CRITICAL gap
   - SE 80-85%: MEDIUM gap (próximo do limite)
   - SE > 85%: OK

2. Integration Pass Rate:
   - SE < 95%: HIGH gap
   - SE 95-98%: MEDIUM gap
   - SE > 98%: OK

3. Mutation Score:
   - SE < 70%: HIGH gap
   - SE 70-75%: MEDIUM gap
   - SE > 75%: OK

4. Bug Detection Rate:
   - SE < 85%: HIGH gap
   - SE 85-90%: MEDIUM gap
   - SE > 90%: OK

5. QA Estimation Accuracy:
   - SE < 80%: HIGH gap
   - SE 80-85%: MEDIUM gap
   - SE > 85%: OK
```

**6.4. Identificar Técnicas Inadequadas**

```markdown
**Verificar alinhamento técnica-tipo:**
- White-box usando técnicas de Black-box: inadequado
- Black-box usando técnicas de White-box: inadequado
- Técnicas não mencionadas no framework: verificar relevância
- Técnicas obsoletas: sugerir atualização
```

**6.5. Identificar Falta de Automação**

```markdown
**Verificar tasks que deveriam estar automatizadas:**
- Testes de regressão manuais: deveriam ser automáticos
- Testes repetitivos manuais: candidatos a automação
- Testes de smoke sem automação: gap médio
- E2E críticos sem automação: gap alto
```

**6.6. Identificar Debt Técnico**

```markdown
**Problemas de qualidade:**
- Testes flaky mencionados em comentários: debt técnico
- Tempo de execução muito alto: otimização necessária
- Cobertura baixa em áreas críticas: risco alto
- Testes mal estruturados: refatoração necessária
```

### Passo 8: Calcular Impacto dos Gaps

**7.1. Risco de Bugs em Produção**

```markdown
**Calcular risco baseado em gaps:**
- CRITICAL gaps: risco alto de bugs críticos
- HIGH gaps: risco médio-alto de bugs
- MEDIUM gaps: risco médio
- LOW gaps: risco baixo

**Fatores de risco:**
- Cobertura insuficiente + área crítica = risco muito alto
- Falta de perspectiva + complexidade alta = risco alto
- Métricas abaixo do threshold = risco médio-alto
```

**7.2. Eficiência Perdida**

```markdown
**Calcular impacto em tempo/custo:**
- Estimativas incorretas: tempo perdido em replanejamento
- Falta de automação: tempo manual repetitivo
- Testes flaky: tempo perdido em debugging
- Debt técnico: tempo futuro de refatoração

**Estimativas:**
- Cada gap CRITICAL: ~8-16 horas de impacto
- Cada gap HIGH: ~4-8 horas de impacto
- Cada gap MEDIUM: ~2-4 horas de impacto
- Cada gap LOW: ~1-2 horas de impacto
```

**7.3. Qualidade Comprometida**

```markdown
**Score de qualidade:**
- Base: 100 pontos
- CRITICAL gap: -20 pontos cada
- HIGH gap: -10 pontos cada
- MEDIUM gap: -5 pontos cada
- LOW gap: -2 pontos cada

**Interpretação:**
- 90-100: Excelente
- 75-89: Bom (melhorias recomendadas)
- 60-74: Regular (melhorias necessárias)
- <60: Crítico (ação imediata)
```

**7.4. Velocity do Time Afetada**

```markdown
**Impacto na velocidade:**
- Estimativas incorretas: afeta planejamento
- Testes flaky: reduz confiança e velocidade
- Falta de automação: reduz capacidade de entrega
- Debt técnico: acumula e reduz velocidade ao longo do tempo
```

### Passo 9: Gerar Sugestões de Melhoria

**8.1. Categorizar por Severidade**

```markdown
**CRITICAL - Fixes que impactam qualidade diretamente:**
- Cobertura abaixo de threshold crítico
- Perspectivas críticas faltando
- Métricas críticas não atingidas
- Risco alto de bugs em produção

**HIGH - Otimizações que melhoram eficiência significativamente:**
- Estimativas incorretas afetando planejamento
- Falta de automação em áreas críticas
- Técnicas inadequadas
- Métricas importantes abaixo do threshold

**MEDIUM - Ajustes para conformidade com framework:**
- Templates não seguindo padrão
- Labels/tags faltantes
- Técnicas não otimais
- Métricas próximas do threshold

**LOW - Tweaks para otimização geral:**
- Melhorias de documentação
- Otimizações menores
- Ajustes de processo
- Refinamentos de métricas
```

**8.2. Tipos de Sugestões**

**Redistribuir QA Points:**
```markdown
Sugestão: Recalcular QA Story Points usando fórmula do framework
- Task: [ID] - Atual: [X] pontos, Esperado: [Y] pontos
- Ação: Atualizar custom field ou label
- Impacto: Melhor estimativa e planejamento
- Esforço: 15 minutos por task
```

**Adicionar Perspectivas:**
```markdown
Sugestão: Implementar perspectiva [White/Grey/Black-box] faltante
- Gap identificado: [descrição]
- Ação: Criar subtasks para perspectiva faltante
- Impacto: Cobertura completa multi-perspectiva
- Esforço: [X] horas baseado em complexidade
```

**Upgrade Técnicas:**
```markdown
Sugestão: Migrar de [técnica atual] para [técnica recomendada]
- Razão: [técnica atual] não é adequada para [tipo de teste]
- Ação: Refatorar testes para usar [técnica recomendada]
- Impacto: Maior eficácia e alinhamento com framework
- Esforço: [X] horas
```

**Automatizar Tasks:**
```markdown
Sugestão: Automatizar testes manuais de [área]
- Tasks afetadas: [lista de IDs]
- Ação: Criar suite de testes automatizados
- Impacto: Redução de tempo manual, maior confiabilidade
- Esforço: [X] horas (ROI: [Y] horas economizadas)
```

**Fix Métricas:**
```markdown
Sugestão: Atingir threshold de [métrica]
- Métrica atual: [X]%
- Threshold: [Y]%
- Gap: [Z]%
- Ação: [ações específicas para atingir threshold]
- Impacto: Conformidade com framework, maior qualidade
- Esforço: [X] horas
```

**Restructure Tasks:**
```markdown
Sugestão: Reorganizar épico/subtasks para melhor flow
- Problema: [estrutura atual problemática]
- Ação: [nova estrutura proposta]
- Impacto: Melhor organização e rastreabilidade
- Esforço: [X] horas
```

**8.3. Estimar Esforço**

```markdown
**Para cada sugestão, estimar:**
- Tempo necessário (horas)
- Dependências
- Prioridade relativa
- ROI esperado

**Fórmula de priorização:**
Prioridade = (Impacto × Severidade) / Esforço

**Impacto:** 1-10 (baixo-alto)
**Severidade:** CRITICAL=4, HIGH=3, MEDIUM=2, LOW=1
**Esforço:** horas estimadas
```

### Passo 10: Aplicar Auto-Fixes (se --auto-fix)

**CRÍTICO:** Apenas correções seguras e não-destrutivas

**9.1. Recalcular QA Story Points**

```markdown
**SE auto-fix = true E discrepância > 20%:**

1. Calcular pontos corretos usando fórmula do framework
2. Gerar backup da task atual
3. Atualizar custom field ou label com novos pontos
4. Adicionar comentário explicando mudança:
   "🔧 Auto-fix: QA Story Points recalculados de [X] para [Y] pontos baseado no Framework de Testes. Fórmula: [detalhes]"
5. Log da alteração para relatório
```

**9.2. Adicionar Labels/Tags Faltantes**

```markdown
**SE labels obrigatórias faltando:**

1. Identificar labels necessárias:
   - Perspectiva: white-box, grey-box, black-box
   - Tipo: unit, integration, e2e, acceptance
   - Prioridade: critical, high, medium, low
   
2. Adicionar labels faltantes às tasks
3. Comentar: "🏷️ Auto-fix: Labels adicionadas para melhor categorização"
4. Log da alteração
```

**9.3. Criar Subtasks para Perspectivas Faltantes**

```markdown
**SE perspectiva faltando E auto-fix = true:**

1. Calcular pontos para perspectiva faltante
2. Criar subtask no epic:
   - Nome: "[Perspectiva] Testing ([X] QA points)"
   - Descrição: Template da perspectiva do framework
   - Labels: [perspectiva, testing]
   - Custom fields: QA Story Points = [X]
   
3. Comentar no epic: "➕ Auto-fix: Subtask criada para perspectiva [X] faltante"
4. Log da criação
```

**9.4. Atualizar Templates**

```markdown
**SE acceptance criteria incompletos:**

1. Identificar campos faltantes do template universal
2. Adicionar campos faltantes à descrição da task
3. Usar template do framework como base
4. Comentar: "📝 Auto-fix: Template atualizado para conformidade com framework"
5. Log da alteração
```

**9.5. Limites de Auto-Fix**

```markdown
**NUNCA fazer auto-fix de:**
- Deletar tasks existentes
- Modificar código de testes
- Alterar estimativas sem validação se discrepância < 20%
- Criar tasks sem contexto suficiente
- Modificar histórico ou comentários existentes

**SEMPRE:**
- Gerar backup antes de mudanças
- Log detalhado de todas alterações
- Comentar mudanças nas tasks afetadas
- Permitir rollback se necessário
```

### Passo 11: Gerar Relatório Detalhado

**10.1. Estrutura do Relatório**

```markdown
# 📊 Análise de Estratégia de Teste: [Feature Name]

**Data:** [YYYY-MM-DD HH:MM]
**Feature ID:** [feature-id]
**Task Manager:** [provedor]
**Analisado por:** Sistema Onion Test Strategy Analyzer

## 📋 Resumo Executivo

- **Score de Conformidade:** [X]% ([classificação])
- **Total de Gaps Identificados:** [N]
  - CRITICAL: [N]
  - HIGH: [N]
  - MEDIUM: [N]
  - LOW: [N]
- **Risco de Qualidade:** [Alto/Médio/Baixo]
- **Impacto Estimado:** [X] horas

## 📊 Dados Coletados

### Task Manager Data
- Epic/Feature: [nome] ([ID])
- Status: [status]
- QA Points Atribuídos: [X] pontos
- QA Points Esperados: [Y] pontos
- Subtasks: [N] tasks
- Perspectivas Cobertas: [White/Grey/Black-box]

### Code Analysis (se deep-scan)
- Test Files: [N] arquivos
- Coverage: [X]%
- Test Types: [lista]
- CI/CD: [configurado/não configurado]

## ✅ Conformidade com Framework

### QA Story Points Validation
- **Score:** [X]% conforme
- **Discrepâncias:** [lista de tasks com problemas]
- **Distribuição:** [análise por perspectiva]

### Multi-Perspective Coverage
- **Score:** [X]% completo
- **White-box:** [presente/faltando] ([detalhes])
- **Grey-box:** [presente/faltando] ([detalhes])
- **Black-box:** [presente/faltando] ([detalhes])

### Template Compliance
- **Score:** [X]% conforme
- **Problemas:** [lista de não-conformidades]

### Collaboration Patterns
- **Three Amigos:** [evidência encontrada/não encontrada]
- **Pair Testing:** [evidência encontrada/não encontrada]
- **Handoff Protocols:** [evidência encontrada/não encontrada]

## 🔍 Gap Analysis

### CRITICAL Gaps
[Para cada gap crítico:]
- **Gap:** [descrição]
- **Impacto:** [descrição do impacto]
- **Risco:** [nível de risco]
- **Ação Recomendada:** [ação específica]
- **Esforço Estimado:** [X] horas

### HIGH Gaps
[Similar para gaps HIGH]

### MEDIUM Gaps
[Similar para gaps MEDIUM]

### LOW Gaps
[Similar para gaps LOW]

## 📈 Impact Assessment

### Risco de Bugs em Produção
- **Nível:** [Alto/Médio/Baixo]
- **Fatores:** [lista de fatores de risco]

### Eficiência Perdida
- **Tempo Impactado:** [X] horas
- **Custo Estimado:** [se aplicável]

### Qualidade Comprometida
- **Score Atual:** [X]/100
- **Score Esperado:** [Y]/100
- **Gap:** [Z] pontos

### Velocity do Time
- **Impacto:** [descrição]
- **Recomendações:** [ações para melhorar]

## 💡 Improvement Recommendations

### Prioridade CRITICAL
[Para cada sugestão crítica:]
1. **[Título da Sugestão]**
   - **Problema:** [descrição]
   - **Solução:** [ação específica]
   - **Impacto:** [benefício esperado]
   - **Esforço:** [X] horas
   - **ROI:** [se aplicável]

### Prioridade HIGH
[Similar para HIGH]

### Prioridade MEDIUM
[Similar para MEDIUM]

### Prioridade LOW
[Similar para LOW]

## 📊 Metrics Tracking

### Current vs Target

| Métrica | Atual | Target | Status | Gap |
|---------|-------|--------|--------|-----|
| Unit Coverage | [X]% | >80% | [✅/⚠️/❌] | [Y]% |
| Integration Pass | [X]% | >95% | [✅/⚠️/❌] | [Y]% |
| E2E Flakiness | [X]% | <3% | [✅/⚠️/❌] | [Y]% |
| QA Estimation Acc | [X]% | >85% | [✅/⚠️/❌] | [Y]% |

## 🔧 Auto-Fixes Aplicados (se --auto-fix)

[Para cada auto-fix:]
- **Task:** [ID] - [nome]
- **Ação:** [descrição da correção]
- **Antes:** [estado anterior]
- **Depois:** [estado após correção]
- **Timestamp:** [data/hora]

## 📋 Action Items

[Lista priorizada de ações:]
- [ ] [Ação 1] - [responsável] - [prazo]
- [ ] [Ação 2] - [responsável] - [prazo]

## 🔗 Referências

- Framework: `docs/knowbase/frameworks/framework_testes.md`
- Tasks Analisadas: [links para tasks]
- Relatórios Relacionados: [se houver]

---

**Gerado por:** Sistema Onion v3.0
**Versão do Analyzer:** 3.0.0
```

**10.2. Salvar Relatório**

```bash
# Criar diretório se não existir
mkdir -p reports/test-strategy-analysis

# Salvar relatório
write reports/test-strategy-analysis/analysis-[feature-id]-[YYYYMMDD-HHMM].md
```

**SE export-report = true:**
- Gerar também versão JSON estruturada
- Gerar versão executiva (resumo de 1 página)
- Incluir gráficos se possível (métricas visuais)

### Passo 12: Apresentar Resultado Final

## 📤 Output Esperado

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 ANÁLISE DE ESTRATÉGIA DE TESTE
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 Feature: [feature-id] - [nome]
📊 Task Manager: [provedor] (inferido do .env: TASK_MANAGER_PROVIDER=[valor])

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📈 DATA COLLECTION
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✓ Conectado ao [task-manager]
✓ Epic encontrado: "[nome]" ([ID])
✓ Coletadas [N] tasks relacionadas em [X] sprints
[SE deep-scan:] ✓ Analisado codebase e cobertura de testes
[SE deep-scan:] ✓ Coletadas métricas de execução do CI/CD

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ FRAMEWORK COMPLIANCE ANALYSIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠️ QA Story Points: [X]% conforme
  └── [N] tasks usando cálculo incorreto
  └── Discrepância média: [±X] pontos

✅ Multi-Perspective: [X]% cobertura
  └── White-box: [presente/faltando]
  └── Grey-box: [presente/faltando]
  └── Black-box: [presente/faltando]

❌ Test Metrics: [N] thresholds críticos não atingidos
  └── Coverage: [X]% (target: >80%)
  └── Pass Rate: [X]% (target: >95%)
  └── [outras métricas]

⚠️ Collaboration: Conformidade parcial
  └── Three Amigos: [evidência encontrada/não encontrada]
  └── Pair Testing: [evidência encontrada/não encontrada]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔍 GAP ANALYSIS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔴 CRITICAL ([N] issues):
  └── [Gap 1]: [descrição breve]
  └── [Gap 2]: [descrição breve]

🟡 HIGH ([N] issues):
  └── [Gap 1]: [descrição breve]
  └── [Gap 2]: [descrição breve]
  └── [Gap 3]: [descrição breve]

🟢 MEDIUM ([N] issues):
  └── [Gap 1]: [descrição breve]
  └── [Gap 2]: [descrição breve]

🔵 LOW ([N] issues):
  └── [Gap 1]: [descrição breve]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 IMPACT ASSESSMENT
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Risk Level: [ALTO/MÉDIO/BAIXO]
Estimated Bug Leakage: [±X]% increase
Team Velocity Impact: [±X]%
Technical Debt: [X] hours
Quality Score: [X]/100 ([classificação])

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💡 IMPROVEMENT RECOMMENDATIONS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔴 CRITICAL - Fix Immediately:

1. [Título da Sugestão]
   └── Esforço: [X] horas | Impacto: [descrição]
   └── Foco em: [áreas específicas]
   [SE auto-fix disponível:] └── Auto-fix disponível: --auto-fix

2. [Título da Sugestão]
   └── Esforço: [X] horas | Impacto: [descrição]

🟡 HIGH - Next Sprint:

3. [Título da Sugestão]
   └── Esforço: [X] horas | Impacto: [descrição]
   [SE auto-fix disponível:] └── Auto-fix disponível: --auto-fix

4. [Título da Sugestão]
   └── Esforço: [X] horas | Impacto: [descrição]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📊 METRICS TRACKING
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

Current vs Target:

- Unit Coverage: [X]% → 80% (target) [gap: ±Y%]
- Integration Pass: [X]% → 95% (target) [gap: ±Y%]
- E2E Flakiness: [X]% → <3% (target) [gap: ±Y%]
- QA Estimation Accuracy: [X]% → 85% (target) [gap: ±Y%]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
📄 GENERATED REPORTS
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[SE export-report:]
✓ Detailed analysis: ./reports/test-strategy-analysis/analysis-[feature-id]-[date].md
✓ Executive summary: ./reports/test-strategy-analysis/exec-summary-[feature-id].md
✓ Action items JSON: ./reports/test-strategy-analysis/actions-[feature-id].json

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🔧 AUTO-FIXES APPLIED
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

[SE auto-fix aplicado:]
✓ [N] QA Story Points recalculados
✓ [N] labels adicionadas
✓ [N] subtasks criadas para perspectivas faltantes
✓ [N] templates atualizados

📋 Log completo: Ver relatório detalhado

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✨ Análise completa! [N] gaps identificados, [M] melhorias sugeridas.

💡 Próximos Passos:
1. Revisar gaps críticos e altos
2. Aplicar melhorias prioritárias
3. [SE auto-fix não usado:] Executar com --auto-fix para correções automáticas
4. Monitorar métricas ao longo do tempo

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## 📋 Exemplos de Uso

### Exemplo 1: Análise Básica (Provedor Inferido do .env)

```bash
/test-strategy/analyze PROJ-123
```

**Output esperado:**
- Provedor detectado automaticamente do `TASK_MANAGER_PROVIDER` no `.env`
- Análise de conformidade básica
- Identificação de gaps principais
- Sugestões priorizadas
- Relatório em console

### Exemplo 2: Análise com Provedor Explícito

```bash
/test-strategy/analyze CU-456 --task-manager clickup
```

**Output esperado:**
- Usa provedor especificado (ignora .env)
- Útil quando precisa analisar task de outro provedor
- Análise completa

### Exemplo 3: Análise Profunda com Auto-Fix (Provedor Inferido)

```bash
/test-strategy/analyze TICKET-101 --deep-scan --auto-fix
```

**Output esperado:**
- Provedor inferido do `.env` ou formato do ID
- Análise completa incluindo código
- Correções automáticas aplicadas
- Relatório detalhado
- Log de todas alterações

### Exemplo 4: Análise Completa com Relatório

```bash
/test-strategy/analyze FEATURE-789 --deep-scan --export-report --auto-fix
```

**Output esperado:**
- Provedor detectado automaticamente
- Todas funcionalidades ativadas
- Análise mais completa possível
- Correções aplicadas
- Relatórios em múltiplos formatos (markdown, JSON, executivo)

## ⚠️ Validações e Regras

### Validações Obrigatórias

1. **Framework deve existir:**
   ```markdown
   SE framework_testes.md não encontrado:
     ❌ ERRO: Framework não encontrado
     💡 Verifique: docs/knowbase/frameworks/framework_testes.md
   ```

2. **Feature ID não vazio:**
   ```markdown
   SE feature-id vazio:
     ❌ ERRO: Feature ID é obrigatório
   ```

3. **Task Manager detectado e acessível:**
   ```markdown
   SE não conseguir detectar provedor:
     ❌ ERRO: Não foi possível detectar task manager
     💡 Configure TASK_MANAGER_PROVIDER no .env ou forneça --task-manager
   
   SE não conseguir conectar ao task manager detectado:
     ❌ ERRO: Não foi possível conectar ao [provedor]
     💡 Verifique configuração em .env (API tokens, workspace IDs, etc)
   ```

4. **Epic/Feature encontrado:**
   ```markdown
   SE epic não encontrado no task manager:
     ❌ ERRO: Feature [feature-id] não encontrada
     💡 Verifique se o ID está correto
   ```

### Regras de Negócio

1. **Análise sempre baseada no framework:** Todas verificações devem referenciar seções específicas do framework
2. **Auto-fix apenas seguro:** Nunca aplicar mudanças destrutivas automaticamente
3. **Priorização inteligente:** Sugestões ordenadas por impacto/effort ratio
4. **Relatórios acionáveis:** Todas sugestões devem incluir ações específicas e estimativas
5. **Preservar histórico:** Nunca deletar ou modificar dados históricos

## 🔗 Referências

- **Framework:** `docs/knowbase/frameworks/framework_testes.md`
- **Comando relacionado:** `/validate/test-strategy/create`
- **Task Manager:** `.claude/utils/task-manager/`
- **Agentes relacionados:** @test-engineer, @test-planner

## ⚠️ Notas Importantes

- **Framework é obrigatório:** Comando falha se `framework_testes.md` não existir
- **Análise baseada em evidências:** Todas conclusões devem ser baseadas em dados coletados
- **Auto-fix conservador:** Apenas correções seguras e não-destrutivas
- **Relatórios detalhados:** Use `--export-report` para análises formais
- **Deep-scan opcional:** Use `--deep-scan` para análise mais completa (mais lento)
- **Integração flexível:** Funciona com múltiplos task managers ou modo offline
- **Detecção automática:** Provedor é inferido automaticamente do `.env` (TASK_MANAGER_PROVIDER), com fallback para formato do feature-id

---

**Versão:** 3.0.0  
**Última atualização:** 2025-12-03  
**Mantido por:** Sistema Onion

