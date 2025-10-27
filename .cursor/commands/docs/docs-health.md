# 🏥 Docs Health - Health Check de Documentação

Realiza uma verificação abrangente de saúde de toda a documentação do projeto, fornecendo um diagnóstico completo da qualidade, completude e manutenibilidade da base de conhecimento.

## 🎯 Objetivo

Este comando vai além da validação básica, fornecendo:
- Score de saúde geral da documentação (0-100)
- Análise de gaps críticos
- Métricas de qualidade e cobertura
- Recomendações priorizadas de melhoria
- Tendências ao longo do tempo

## 🎯 Funcionalidades

### Health Score Calculation
- Calcula score de 0-100 baseado em múltiplos critérios
- Pondera diferentes aspectos (estrutura, conteúdo, consistência)
- Compara com benchmarks do setor
- Rastreia evolução ao longo do tempo

### Gap Analysis
- Identifica documentação faltante crítica
- Detecta áreas subdesenvolvidas
- Mapeia funcionalidades sem documentação
- Sugere prioridades de preenchimento

### Coverage Metrics
- % de código documentado
- % de APIs especificadas
- % de workflows documentados
- % de decisões arquiteturais registradas

### Quality Assessment
- Legibilidade (Flesch Reading Ease)
- Consistência terminológica
- Profundidade de conteúdo
- Atualidade da informação

## 🚀 Como Usar

```bash
# Health check completo
/docs/docs-health

# Health check rápido (apenas score)
/docs/docs-health --quick

# Com comparação histórica
/docs/docs-health --compare

# Gerar relatório detalhado
/docs/docs-health --report

# Apenas gaps críticos
/docs/docs-health --gaps-only

# Com recomendações priorizadas
/docs/docs-health --recommendations
```

## 📊 Health Score Breakdown

### Componentes do Score (100 pontos)

#### 1. **Estrutura (20 pontos)**
- [x] Hierarquia clara (5 pts)
- [x] Índices navegáveis (5 pts)
- [x] Arquivos obrigatórios presentes (5 pts)
- [x] Convenções de nomenclatura (5 pts)

#### 2. **Completude (25 pontos)**
- [x] Business context completo (5 pts)
- [x] Technical context completo (5 pts)
- [x] APIs documentadas (5 pts)
- [x] Workflows documentados (5 pts)
- [x] ADRs para decisões importantes (5 pts)

#### 3. **Qualidade (20 pontos)**
- [x] Legibilidade adequada (5 pts)
- [x] Exemplos práticos (5 pts)
- [x] Diagramas e visualizações (5 pts)
- [x] Consistência terminológica (5 pts)

#### 4. **Atualidade (15 pontos)**
- [x] Documentos atualizados <6 meses (5 pts)
- [x] Reflete estado atual do código (5 pts)
- [x] Roadmap atualizado (5 pts)

#### 5. **Manutenibilidade (10 pontos)**
- [x] Links funcionando (3 pts)
- [x] Metadados completos (3 pts)
- [x] Processo de atualização claro (4 pts)

#### 6. **Acessibilidade (10 pontos)**
- [x] Onboarding claro (3 pts)
- [x] Search-friendly (3 pts)
- [x] AI-optimized (4 pts)

## 📋 Health Check Process

### 1. **Coleta de Métricas**
```typescript
interface HealthMetrics {
  structure: {
    directories: number;
    files: number;
    missingRequired: string[];
    score: number;
  };
  completeness: {
    businessContext: number;      // 0-100%
    technicalContext: number;     // 0-100%
    apisDocumented: number;       // 0-100%
    workflowsDocumented: number;  // 0-100%
    score: number;
  };
  quality: {
    readabilityScore: number;     // Flesch score
    hasExamples: boolean;
    hasDiagrams: boolean;
    terminologyConsistency: number; // 0-100%
    score: number;
  };
  freshness: {
    averageAge: number;           // dias
    outdatedDocs: string[];
    lastUpdate: Date;
    score: number;
  };
  maintainability: {
    brokenLinks: number;
    missingMetadata: number;
    updateProcessClear: boolean;
    score: number;
  };
  accessibility: {
    hasOnboarding: boolean;
    isSearchable: boolean;
    aiOptimized: boolean;
    score: number;
  };
}
```

### 2. **Cálculo do Score**
```
Health Score = (
  Structure * 0.20 +
  Completeness * 0.25 +
  Quality * 0.20 +
  Freshness * 0.15 +
  Maintainability * 0.10 +
  Accessibility * 0.10
)
```

### 3. **Gap Analysis**
Identifica:
- **Critical Gaps**: Documentação essencial faltando
- **High Priority**: Áreas importantes subdesenvolvidas
- **Medium Priority**: Melhorias recomendadas
- **Low Priority**: Nice-to-have

### 4. **Recommendations Generation**
Gera recomendações SMART:
- **S**pecific: O que fazer exatamente
- **M**easurable: Como medir sucesso
- **A**chievable: Esforço realista
- **R**elevant: Impacto no score
- **T**ime-bound: Prazo sugerido

## 📈 Output Esperado

### Health Check Excelente (90-100)
```bash
🏥 HEALTH CHECK DE DOCUMENTAÇÃO

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🎯 HEALTH SCORE: 95/100 🎉 EXCELENTE

📊 Breakdown por Categoria:
  ✅ Estrutura:         20/20  (100%) 🟢
  ✅ Completude:        24/25  (96%)  🟢
  ✅ Qualidade:         19/20  (95%)  🟢
  ✅ Atualidade:        14/15  (93%)  🟢
  ✅ Manutenibilidade:  10/10  (100%) 🟢
  ✅ Acessibilidade:    8/10   (80%)  🟡

📚 Estatísticas:
  • Total Documentos: 50
  • Linhas de Documentação: 12,543
  • Última Atualização: há 2 dias
  • Links Funcionando: 145/145 (100%)
  • Cobertura APIs: 19/19 (100%)
  • ADRs Registrados: 12

🎯 Gaps Identificados: 2 (baixa prioridade)
  1. Adicionar mais exemplos em TROUBLESHOOTING.md
  2. Melhorar search-friendliness do INDEX.md

💡 Recomendação: Documentação em excelente estado! 
   Continue mantendo atualizada.

📈 Tendência: +5 pontos vs última verificação (há 30 dias)
```

### Health Check Precisa Melhorias (50-69)
```bash
🏥 HEALTH CHECK DE DOCUMENTAÇÃO

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⚠️ HEALTH SCORE: 62/100 ⚠️ PRECISA MELHORIAS

📊 Breakdown por Categoria:
  ⚠️ Estrutura:         15/20  (75%)  🟡
  ❌ Completude:        12/25  (48%)  🔴
  ⚠️ Qualidade:         13/20  (65%)  🟡
  ❌ Atualidade:        7/15   (47%)  🔴
  ⚠️ Manutenibilidade:  7/10   (70%)  🟡
  ✅ Acessibilidade:    8/10   (80%)  🟢

📚 Estatísticas:
  • Total Documentos: 35 (15 faltando)
  • Última Atualização: há 4 meses ⚠️
  • Links Quebrados: 12/134 (9%)
  • Cobertura APIs: 11/19 (58%)
  • ADRs Faltando: 8 decisões não documentadas

🚨 Gaps Críticos Identificados: 5
  1. ❌ BUSINESS_LOGIC.md não existe
  2. ❌ TROUBLESHOOTING.md vazio
  3. ❌ 8 APIs sem documentação
  4. ❌ Onboarding guide desatualizado (4 meses)
  5. ❌ ADRs: 8 decisões arquiteturais não registradas

🔧 Recomendações Priorizadas:

📌 PRIORIDADE CRÍTICA (1-2 semanas):
  1. Criar BUSINESS_LOGIC.md (+8 pts)
     Comando: /docs/build-tech-docs
  
  2. Documentar 8 APIs faltantes (+6 pts)
     Tempo estimado: 2-3 dias
  
  3. Atualizar onboarding guide (+4 pts)
     Arquivo: docs/technical-context/CONTRIBUTING.md

📌 PRIORIDADE ALTA (2-4 semanas):
  4. Registrar 8 ADRs faltando (+5 pts)
     Decisões sem documentação identificadas
  
  5. Completar TROUBLESHOOTING.md (+4 pts)
     Adicionar soluções para problemas comuns
  
  6. Corrigir 12 links quebrados (+3 pts)
     Comando: /docs/validate-docs --fix

🎯 Meta: Alcançar 75+ pontos em 30 dias
   Foco: Completude e Atualidade

📈 Tendência: -8 pontos vs última verificação (há 60 dias) 📉
   ⚠️ ATENÇÃO: Score em declínio, ação necessária!
```

## 🤖 Integração com Agentes

Este comando convoca automaticamente:
- **@metaspec-gate-keeper**: Valida conformidade geral
- **@research-agent**: Identifica gaps e missing docs
- **@branch-documentation-writer**: Sugere melhorias específicas

## ⚙️ Opções Avançadas

### Modos de Execução
```bash
--quick              # Score apenas (30s)
--standard           # Score + gaps (padrão, 2-3min)
--deep               # Análise completa (5-10min)
--compare            # Comparar com histórico
--report             # Gerar relatório HTML/PDF
```

### Filters
```bash
--scope=business     # Apenas business context
--scope=technical    # Apenas technical context
--scope=esperanto    # Apenas Sistema Esperanto
--gaps-only          # Apenas análise de gaps
--trends             # Apenas tendências
```

### Output Formats
```bash
--json               # JSON para CI/CD
--html               # Relatório HTML
--markdown           # Relatório markdown (padrão)
--summary            # Apenas resumo executivo
```

## 📊 Historical Tracking

O comando mantém histórico de scores:

```bash
# Ver histórico
/docs/docs-health --history

# Comparar com versão anterior
/docs/docs-health --compare

# Output histórico
📈 Histórico de Health Score:
  2025-10-03: 95 (+5)  🟢
  2025-09-03: 90 (+3)  🟢
  2025-08-03: 87 (-2)  🟡
  2025-07-03: 89 (+7)  🟢
  2025-06-03: 82 (+4)  🟡

📊 Tendência: Melhoria consistente (+13 em 4 meses)
🎯 Projeção: 98 em 2 meses (se manter ritmo)
```

## 🎯 Benchmarks do Setor

### Classificação de Scores
- **90-100**: 🟢 Excelente - Documentação de referência
- **75-89**: 🟢 Bom - Acima da média do setor
- **60-74**: 🟡 Adequado - Atende necessidades básicas
- **50-59**: 🟡 Precisa Melhorias - Abaixo da média
- **0-49**: 🔴 Crítico - Requer ação imediata

### Benchmarks por Tipo de Projeto
```yaml
Startups Early Stage: 50-65
Scale-ups: 65-80
Empresas Maduras: 75-90
Open Source Popular: 85-95
Projetos Enterprise: 80-95
```

## 🔧 Auto-Remediation

Com flag `--auto-fix`, o comando pode:
- ✅ Criar índices faltantes
- ✅ Adicionar metadados básicos
- ✅ Corrigir links quebrados óbvios
- ✅ Gerar templates para docs faltando
- ✅ Atualizar datas de "última modificação"

```bash
/docs/docs-health --auto-fix --report
```

## ⚠️ Alertas e Notificações

### Alertas Automáticos
O comando pode configurar alertas para:
- **Score < 60**: Email para tech leads
- **Tendência negativa 3 meses**: Slack notification
- **Docs desatualizados > 6 meses**: Weekly reminder
- **Links quebrados > 5**: Immediate notification

### Configuração
```yaml
# .cursor/config/docs-health-alerts.yml
alerts:
  score_threshold: 60
  email: tech-leads@company.com
  slack_webhook: https://hooks.slack.com/...
  check_frequency: weekly
```

## 📋 Action Plan Template

Para scores baixos, o comando gera action plan:

```markdown
# 📋 Action Plan - Melhorar Health Score

## Meta
- Score Atual: 62
- Score Meta: 80
- Prazo: 6 semanas

## Sprint 1 (Semanas 1-2): Completude
- [ ] Criar BUSINESS_LOGIC.md (2 dias)
- [ ] Documentar 8 APIs (3 dias)
- [ ] Atualizar onboarding (1 dia)
- **Ganho Esperado**: +18 pts → 80 pts ✅

## Sprint 2 (Semanas 3-4): Qualidade
- [ ] Adicionar diagramas (2 dias)
- [ ] Melhorar exemplos (2 dias)
- [ ] Review terminologia (1 dia)
- **Ganho Esperado**: +5 pts → 85 pts

## Sprint 3 (Semanas 5-6): Manutenibilidade
- [ ] Corrigir todos os links (1 dia)
- [ ] Adicionar metadados (1 dia)
- [ ] Documentar processo de atualização (1 dia)
- **Ganho Esperado**: +3 pts → 88 pts

## Responsáveis
- Tech Lead: Coordenar sprints
- Devs: Documentar suas áreas
- Tech Writer: Review e qualidade
```

## 🔗 Comandos Relacionados

- `/docs/validate-docs` - Validação detalhada
- `/docs/sync-sessions` - Sincronizar sessões
- `/docs/build-index` - Reconstruir índice
- `/docs/build-business-docs` - Gerar business docs
- `/docs/build-tech-docs` - Gerar technical docs

## 📊 CI/CD Integration

```yaml
# .github/workflows/docs-health.yml
name: Documentation Health Check

on:
  schedule:
    - cron: '0 0 * * 1'  # Weekly, Monday midnight
  pull_request:
    paths:
      - 'docs/**'

jobs:
  health-check:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      
      - name: Run Health Check
        id: health
        run: |
          /docs/docs-health --json > health-report.json
          SCORE=$(jq '.score' health-report.json)
          echo "score=$SCORE" >> $GITHUB_OUTPUT
      
      - name: Fail if score < 60
        if: steps.health.outputs.score < 60
        run: |
          echo "Health score too low: ${{ steps.health.outputs.score }}"
          exit 1
      
      - name: Comment PR
        uses: actions/github-script@v6
        with:
          script: |
            const fs = require('fs');
            const report = JSON.parse(fs.readFileSync('health-report.json'));
            github.rest.issues.createComment({
              issue_number: context.issue.number,
              owner: context.repo.owner,
              repo: context.repo.repo,
              body: `## 🏥 Documentation Health Score: ${report.score}/100`
            });
```

## 🎯 Casos de Uso

### Caso 1: Auditoria Trimestral
```bash
/docs/docs-health --deep --report --compare
```

### Caso 2: Pre-Release Check
```bash
/docs/docs-health --strict
# Score deve ser >= 80 para release
```

### Caso 3: Onboarding Preparation
```bash
/docs/docs-health --scope=technical --gaps-only
# Focar em gaps que impactam onboarding
```

### Caso 4: Continuous Monitoring
```bash
# Cron job diário
0 0 * * * cd /project && /docs/docs-health --quick --json > /var/log/docs-health.json
```

## 📝 Best Practices

1. **Check Regularmente**: Semanal ou no mínimo mensal
2. **Track Trends**: Importante ver evolução, não apenas snapshot
3. **Priorize Gaps**: Foque em gaps críticos primeiro
4. **Automate**: Integre no CI/CD para manter qualidade
5. **Act on Results**: Ter score não adianta se não agir nas recomendações

---

**Agente Responsável**: @metaspec-gate-keeper + @research-agent  
**Validador**: @branch-documentation-writer  
**Categoria**: Documentação / Qualidade / Metrics  
**Prioridade**: Alta  
**Última Atualização**: Outubro 2025

