# Template de Documentação PMBOK Guide 7th Edition

*Framework para governança de projetos — princípios, performance domains e integração técnica*

---

## Propósito Deste Template

Este template orienta a geração de documentação de **governança de projetos** conforme **PMBOK Guide 7th Edition (2021)** com integração a metodologias ágeis e monorepos NX.

**Use para:**
- Estabelecer governança de projetos auditável
- Due diligence de maturidade de engenharia
- Integração com Sistema Onion (skills, agentes, task manager)
- Complemento a ISO 27001 (change control) e SOC2 (SDLC)

**Output directory:** `docs/compliance-context/project-management/`

**Idioma:** PT-BR preservando Project Charter, RFC, Change Management, RACI, DoD

---

## Estrutura de Arquivos

```
docs/compliance-context/
├── index.md
└── project-management/
    ├── index.md
    ├── project-governance.md
    ├── change-management.md
    ├── quality-management.md
    ├── stakeholder-management.md
    └── risk-management.md
```

---

## Referência Rápida: PMBOK 7th

### 12 Princípios
1. Stewardship (Zelo) | 2. Team | 3. Stakeholders | 4. Value
5. Holistic Thinking | 6. Leadership | 7. Tailoring | 8. Quality
9. Complexity | 10. Risk | 11. Adaptability | 12. Change

### 8 Performance Domains
Stakeholders | Team | Development Approach & Life Cycle | Planning
Project Work | Delivery | Measurement | Uncertainty

---

## Documento 1: project-governance.md

**Domains:** Stakeholders, Team, Planning | **Prioridade:** Alta

```markdown
# Governança de Projetos

## 1. Framework de Governança
**Modelo PMO:** [Lightweight / Suporte / Diretivo]
**Chair:** [Engineering Manager / PM]
**Cadência:** [Weekly portfolio review, monthly steering]

## 2. 12 Princípios (aplicação organizacional)
| Princípio | Como aplicamos | Evidência |
|-----------|----------------|-----------|
| Stewardship | Uso eficiente de recursos, ética | |
| Value | Priorização por impacto | Backlog, OKRs |
| Tailoring | Agile + GitFlow | Sistema Onion |

## 3. Ciclo de Vida do Projeto
```
Iniciação → Planejamento → Execução → Monitoramento → Encerramento
```
Integração Sistema Onion:
- Iniciação: `/product-task`, `/product-spec`
- Execução: `/engineer-start`, `/engineer-work`
- Encerramento: `/engineer-pr`, `/docs-sync-sessions`

## 4. RACI Matrix (exemplo)
| Atividade | PM | Tech Lead | Dev | QA | Stakeholder |
|-----------|----|-----------|----|----|-------------|
| Project Charter | A | R | C | I | I |
| Arquitetura | C | A/R | R | C | I |
| Deploy prod | I | A | R | R | I |

## 5. Integração NX Monorepo
- **CODEOWNERS:** [Path → reviewers]
- **Module boundaries:** [Tags tier/scope/type]
- **Dependency graph:** `nx graph` para impact analysis
- **Affected commands:** CI roda apenas apps/libs impactados

## 6. Templates Operacionais
- Project Charter: [Link ou embed]
- Definition of Ready (DoR): [Critérios]
- Definition of Done (DoD): [Critérios]
```

---

## Documento 2: change-management.md

**Domains:** Development Approach, Delivery | **Prioridade:** Alta

```markdown
# Change Management (Gestão de Mudanças)

## 1. Tipos de Mudança
| Tipo | Exemplo | Aprovação | SLA |
|------|---------|-----------|-----|
| Standard | Patch dependência | Auto (CI) | Imediato |
| Normal | Nova feature | Tech Lead + PM | 1 sprint |
| Emergency | Hotfix produção | Tech Lead + on-call | < 4h |

## 2. Processo de Change Request (CR)
```
Solicitação → Análise impacto → Aprovação → Implementação → Validação → Deploy → Review
```

### Template: Change Request
| Campo | Valor |
|-------|-------|
| ID | CR-YYYY-NNN |
| Solicitante | |
| Descrição | |
| Justificativa de negócio | |
| Impacto técnico (NX graph) | |
| Rollback plan | |
| Aprovadores | |

## 3. RFC (Request for Comments) — mudanças arquiteturais
- Trigger: [Breaking change, nova lib shared, migração]
- Template: [Problema → Proposta → Alternativas → Decisão → Consequências]
- Aprovação: [Architecture review, ADR]

## 4. CI/CD e GitFlow
- Branches: `main`, `develop`, `feature/*`, `hotfix/*`, `release/*`
- Skills: `/git-feature-start`, `/git-feature-finish`, `/git-hotfix-start`
- Proteção: PR obrigatório, review, CI green

## 5. Auditoria de Mudanças
- [ ] Todo deploy rastreável a commit + PR + ticket
- [ ] Changelog mantido
- [ ] Rollback testado
```

---

## Documento 3: quality-management.md

**Domains:** Delivery, Measurement | **Prioridade:** Alta

```markdown
# Quality Management (Gestão da Qualidade)

## 1. Definition of Done (DoD)
- [ ] Código revisado (≥ 1 approval)
- [ ] Testes unitários passando
- [ ] Testes integração/E2E quando aplicável
- [ ] Documentação atualizada
- [ ] Sem vulnerabilidades críticas (SAST)
- [ ] Task manager atualizado

## 2. Code Review
- Obrigatório para: [main, develop]
- Checklist: [Segurança, performance, testes, naming]
- Skill: `/git-code-review`, `/engineer-pre-pr`

## 3. Métricas DORA
| Métrica | Target | Atual | Fonte |
|---------|--------|-------|-------|
| Deployment Frequency | [ex: daily] | | CI/CD |
| Lead Time for Changes | [ex: < 1 day] | | Git + Jira |
| Change Failure Rate | [ex: < 15%] | | Incidents |
| MTTR | [ex: < 1h] | | PagerDuty |

## 4. Métricas SPACE (opcional)
Satisfaction, Performance, Activity, Communication, Efficiency

## 5. Quality Gates
| Gate | Critério | Bloqueante |
|------|----------|------------|
| Pre-commit | Lint | Sim |
| CI | Tests + build | Sim |
| Pre-PR | `/engineer-pre-pr` | Sim |
| Pre-deploy | Smoke tests staging | Sim |
```

---

## Documento 4: stakeholder-management.md

**Domain:** Stakeholders | **Prioridade:** Média

```markdown
# Stakeholder Management

## 1. Identificação de Stakeholders
| Stakeholder | Papel | Interesse | Influência | Estratégia |
|-------------|-------|-----------|------------|------------|
| [Cliente enterprise] | Sponsor | Alta | Alta | Manage closely |
| [Time dev] | Executor | Alta | Média | Keep informed |
| [Auditor] | Avaliador | Média | Alta | Keep satisfied |

## 2. Plano de Comunicação
| Audiência | Canal | Frequência | Conteúdo | Owner |
|-----------|-------|------------|----------|-------|
| Executivos | Email/dashboard | Mensal | Status, riscos | PM |
| Time | Slack/standup | Diário | Blockers, progress | Tech Lead |
| Clientes | Status page | Ad-hoc | Incidents, releases | Support |

## 3. Engajamento
- Sprint reviews / demos
- Retrospectivas (lições aprendidas → KB)
- Feedback loops pós-release
```

---

## Documento 5: risk-management.md

**Domain:** Uncertainty | **Prioridade:** Alta

```markdown
# Risk Management (Projetos)

## 1. Risk Register
| ID | Risco | Categoria | Prob | Impact | Score | Resposta | Owner | Status |
|----|-------|-----------|------|--------|-------|----------|-------|--------|
| PR-001 | Atraso por dependência externa | Schedule | M | H | | Mitigar | PM | Aberto |
| PR-002 | Key person dependency | Resource | L | H | | Mitigar | EM | Aberto |

## 2. Categorias
- Técnico | Schedule | Resource | External | Compliance | Quality

## 3. Respostas
- **Mitigar:** Ação preventiva
- **Transferir:** Seguro, terceirizar
- **Aceitar:** Documentar com aprovação
- **Evitar:** Mudar escopo/plano

## 4. Integração com ISO 27001
Riscos de segurança → referenciar `docs/compliance-context/security/risk-assessment.md`

## 5. Revisão
- Cadência: [Sprint planning, monthly]
- Escalation: Score ≥ [threshold] → steering committee
```

---

## Templates Embutidos

### Project Charter (resumo)
```markdown
# Project Charter: [Nome]

## Objetivo
## Escopo (in/out)
## Stakeholders
## Entregáveis
## Cronograma alto nível
## Orçamento (se aplicável)
## Riscos iniciais
## Critérios de sucesso
## Aprovação
```

### RFC (resumo)
```markdown
# RFC-NNN: [Título]
Status: Proposed | Accepted | Rejected
## Problema
## Proposta
## Alternativas consideradas
## Impacto (NX, teams, deploy)
## Decisão
```

---

## Checklist de Qualidade

- [ ] 12 princípios referenciados com aplicação concreta
- [ ] RACI definida para atividades-chave
- [ ] Integração NX/Sistema Onion documentada
- [ ] DORA metrics com targets
- [ ] Change process com rollback
- [ ] Risk register com ≥ 5 riscos de projeto

---

## Cross-Reference

| PMBOK | ISO 27001 | SOC2 |
|-------|-----------|------|
| Change Management | A.8.32 Change management | CC8.1 |
| Quality / SDLC | Secure development | CC8.1 |
| Risk Management | ISO 27005 | CC3.x |
