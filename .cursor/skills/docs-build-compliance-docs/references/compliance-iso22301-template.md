# Template de Documentação ISO 22301:2019 (BCMS)

*Framework para Business Continuity Management System — continuidade, DR e resiliência*

---

## Propósito Deste Template

Este template orienta a geração de documentação **ISO 22301:2019** alinhada a **ISO/TS 22317:2021** (BIA) e **ISO/TS 22318:2021** (supply chain).

**Use para:**
- Certificação ISO 22301 ou preparação para auditoria
- Due diligence enterprise (ex.: Serasa Experian — 5/8 requisitos)
- Complemento a SOC2 Availability (A1.x)
- Evidências de testes anuais BC/DR

**Output directory:** `docs/compliance-context/business-continuity/`

**Idioma:** PT-BR preservando BCP, DRP, BIA, RTO, RPO, MTPD

---

## Estrutura de Arquivos

```
docs/compliance-context/
├── index.md
└── business-continuity/
    ├── index.md
    ├── business-continuity-plan.md
    ├── disaster-recovery-plan.md
    ├── crisis-management.md
    ├── resilience-testing.md
    └── recovery-objectives.md
```

### Mapeamento Serasa Experian (referência DD)

| Requisito Serasa | Documento | Status |
|------------------|-----------|--------|
| #1 Plano de Continuidade | business-continuity-plan.md | ☐ |
| #2 Plano de Recuperação | disaster-recovery-plan.md | ☐ |
| #3 Gerenciamento de Crise | crisis-management.md | ☐ |
| #4 Evidências testes BC/DR | resilience-testing.md | ☐ |
| #5 Backup/RTOs/RPOs | recovery-objectives.md | ☐ |

---

## Documento 1: business-continuity-plan.md

**Referência:** ISO 22301 Clause 8.4 | **Serasa Req #1**

```markdown
# Business Continuity Plan (BCP)

## 1. Executive Summary
**Objetivo:** Manter operações críticas durante disrupções.
**Escopo:** [Processos, infra, pessoas essenciais]
**MTPD (Maximum Tolerable Period of Disruption):**
- Críticos: [ex: 2 horas]
- Importantes: [ex: 8 horas]
- Suporte: [ex: 24 horas]

## 2. Business Impact Analysis (BIA)
Metodologia: ISO/TS 22317:2021

| Processo | Descrição | Criticidade | MTPD | Impacto financeiro/operacional |
|----------|-----------|-------------|------|--------------------------------|
| [API Gateway] | | Crítico | 15min | |
| [Auth Service] | | Crítico | 30min | |
| [Transações] | | Crítico | 1h | |

## 3. Estratégias de Continuidade
| Processo | Estratégia | Recursos alternativos | Owner |
|----------|------------|----------------------|-------|
| | Hot standby / Warm / Manual | | |

## 4. Equipes e Responsabilidades
| Equipe | Líder | Responsabilidade em crise |
|--------|-------|---------------------------|
| BC Team | | Ativação do BCP |
| Tech Ops | | Restauração técnica |
| Comunicação | | Stakeholders e clientes |

## 5. Ativação do BCP
**Gatilhos:** [Indisponibilidade > X min, desastre natural, cyber incident]
**Processo de ativação:** [Quem declara, canal, checklist]

## 6. Comunicação
- Interna: [Slack, war room, phone tree]
- Externa: [Status page, email clientes, SLA breach notification]
```

---

## Documento 2: disaster-recovery-plan.md

**Referência:** ISO 22301 Clause 8.4 | **Serasa Req #2**

```markdown
# Disaster Recovery Plan (DRP)

## 1. Escopo Técnico
- Ambientes: [Prod, Staging, DR site]
- Infraestrutura: [AWS Multi-AZ, região secundária]
- Dados: [RDS, S3, backups]

## 2. Cenários de Desastre
| Cenário | Probabilidade | Impacto | Runbook |
|---------|---------------|---------|---------|
| Falha AZ | Média | Alto | RB-AZ-001 |
| Região indisponível | Baixa | Crítico | RB-REGION-001 |
| Ransomware | Média | Crítico | RB-RANSOM-001 |
| Corrupção de DB | Baixa | Alto | RB-DB-001 |

## 3. Runbooks (template por cenário)
### RB-XXX: [Nome do cenário]
1. **Detecção:** [Alertas, monitoramento]
2. **Contenção:** [Isolar, failover]
3. **Recuperação:** [Restore backup, validar integridade]
4. **Validação:** [Smoke tests, health checks]
5. **Comunicação:** [Status page, incident ticket]
6. **Post-mortem:** [Timeline, RCA, ações]

## 4. Infraestrutura DR
| Componente | Primary | DR/Failover | RTO | RPO |
|------------|---------|-------------|-----|-----|
| API | [AZ-a] | [AZ-b / região] | | |
| Database | [Primary RDS] | [Replica/backup] | | |

## 5. Dependências de Terceiros
| Vendor | Serviço | SLA | Plano alternativo |
|--------|---------|-----|-------------------|
| AWS | Infra | 99.99% | Multi-region |
```

---

## Documento 3: crisis-management.md

**Referência:** ISO 22301 Clause 8.4 | **Serasa Req #3**

```markdown
# Plano de Gerenciamento de Crise

## Crisis Management Team (CMT)
| Papel | Responsável | Backup | Contato 24/7 |
|-------|-------------|--------|--------------|
| Crisis Leader (CEO/COO) | | | |
| Tech Lead | | | |
| Legal/DPO | | | |
| Comunicação/PR | | | |

## Níveis de Crise
| Nível | Definição | Exemplo | Autoridade decisória |
|-------|-----------|---------|---------------------|
| 1 | Operacional | Degradação parcial | Tech Lead |
| 2 | Significativa | Serviço crítico down | CMT parcial |
| 3 | Corporativa | Data breach, desastre | CMT completo + Board |

## Fluxo de Comunicação
```
Detecção → Triagem → Ativação CMT → War Room → Decisões → Comunicação → Recovery → Lições
```

## Templates de Comunicação
- Comunicado interno (all-hands)
- Comunicado clientes (status page + email)
- Comunicado regulatório (se aplicável)
```

---

## Documento 4: resilience-testing.md

**Referência:** ISO 22301 Clause 8.5 | **Serasa Req #4**

```markdown
# Testes de Resiliência (BC/DR)

## Programa de Testes Anual
| Teste | Tipo | Frequência | Último | Próximo | Owner | Resultado |
|-------|------|------------|--------|---------|-------|-----------|
| Failover DB | Simulado | Semestral | [Data] | [Data] | | ✅/⚠️ |
| Restore backup | Simulado | Trimestral | | | | |
| Tabletop BCP | Discussão | Anual | | | | |
| Full DR drill | Produção controlada | Anual | | | | |

## Template de Relatório de Teste
### Teste: [ID] — [Nome]
- **Data:** [Data]
- **Objetivo:** [Validar RTO de X para serviço Y]
- **Participantes:** [Lista]
- **Cenário:** [Descrição]
- **Resultado:** Pass / Fail / Parcial
- **RTO alcançado:** [Tempo real vs target]
- **Gaps identificados:** [Lista]
- **Ações corretivas:** [Ticket, owner, prazo]
- **Evidências:** [Logs, screenshots, tickets — links]

## Histórico de Testes
[Manter últimos 3 anos para auditoria]
```

---

## Documento 5: recovery-objectives.md

**Referência:** ISO 22301 Clause 8.2 | **Serasa Req #5**

```markdown
# Recovery Objectives (RTOs / RPOs)

## Definições
- **RTO (Recovery Time Objective):** Tempo máximo aceitável para restaurar serviço
- **RPO (Recovery Point Objective):** Perda máxima aceitável de dados (janela de backup)
- **MTPD:** Tempo máximo de disrupção tolerável pelo negócio

## Matriz por Serviço
| Serviço | Criticidade | RTO | RPO | MTPD | Estratégia backup | Frequência backup |
|---------|-------------|-----|-----|------|-------------------|-------------------|
| API Gateway | Crítico | 15min | 0 | 15min | Multi-AZ + failover | Contínuo |
| Auth | Crítico | 30min | 1h | 30min | Replica + snapshot | Horário |
| Database | Crítico | 1h | 1h | 2h | PITR + cross-region | Contínuo + daily |
| Analytics | Suporte | 24h | 24h | 24h | Daily snapshot | Diário |

## Política de Backup e Restauração
- **Retenção:** [Daily 30d, weekly 90d, monthly 1y]
- **Criptografia:** [At rest, in transit]
- **Testes de restore:** [Frequência, último teste]
- **Localização:** [Região primária + DR]
- **Responsável:** [Time/owner]

## Validação
- [ ] RTOs alinhados com SLAs contratuais
- [ ] RPOs testados com restore real
- [ ] Documentação aprovada por negócio + tech
```

---

## Checklist de Qualidade

- [ ] BIA completa com processos críticos identificados
- [ ] RTOs/RPOs realistas (baseados em BIA, não aspiracionais)
- [ ] Runbooks testáveis com passos concretos
- [ ] Evidência de ≥ 1 teste BC/DR nos últimos 12 meses (ou plano)
- [ ] Mapeamento Serasa 5/5 documentado no index
- [ ] Cross-ref com SOC2 Availability (A1.x) quando aplicável

---

## Cross-Reference

| ISO 22301 | SOC2 | Notas |
|-----------|------|-------|
| BCP/DRP | A1.1–A1.3 Availability | SLAs, monitoring |
| Resilience testing | A1.2 | Evidências operacionais |
| Recovery objectives | A1.2 | RTO/RPO em contratos |
