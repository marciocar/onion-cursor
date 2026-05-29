# Template de Documentação SOC2 Type II

*Framework para Trust Services Criteria — controles, SLAs e evidências auditáveis*

---

## Propósito Deste Template

Este template orienta a geração de documentação **SOC2 Type II** conforme **AICPA Trust Services Criteria (TSC)**.

**Use para:**
- Preparação para auditoria SOC2 Type II (6–12 meses)
- Due diligence enterprise (ex.: Serasa Experian — 3/8 requisitos)
- Complemento a ISO 27001 (~70% overlap em Security)
- Evidências operacionais coletáveis

**Output directory:** `docs/compliance-context/soc2/`

**Idioma:** PT-BR preservando Trust Services Criteria, Type II, Common Criteria (CC), TSC

---

## Estrutura de Arquivos

```
docs/compliance-context/
├── index.md
└── soc2/
    ├── index.md
    ├── trust-services-criteria.md
    ├── security-controls.md
    ├── availability-controls.md
    ├── confidentiality-controls.md
    └── evidence-collection.md
```

### Mapeamento Serasa Experian

| Requisito | Documento | Foco |
|-----------|-----------|------|
| #6 Certificado/Relatório SOC2 | trust-services-criteria.md | Overview Type II |
| #7 Confirmação SLAs | availability-controls.md | A1.2 monitoring + SLAs |
| #8 Documentação SLAs contratuais | availability-controls.md | A1.2 em contratos |

**Combined ISO 22301 + SOC2:** cobertura 8/8 requisitos Serasa (referência DD)

---

## Documento 1: trust-services-criteria.md

**TSC:** Overview | **Serasa Req #6**

```markdown
# Trust Services Criteria (TSC) — Overview SOC2

## 1. O que é SOC2
Service Organization Control 2 — framework AICPA para avaliar controles de service providers.

| Aspecto | Type I | Type II |
|---------|--------|---------|
| Escopo | Design dos controles | Design + eficácia operacional |
| Período | Snapshot | 6–12 meses contínuos |
| Evidências | Políticas | Logs, tickets, testes |
| Valor DD | Inicial | Maturidade enterprise |

**Nossa abordagem:** Type II — período [12 meses]

## 2. Trust Services Principles (in-scope)
| Princípio | In-scope | Justificativa |
|-----------|----------|---------------|
| Security (CC) | ✅ | Obrigatório — baseline |
| Availability (A) | ✅ | SLAs contratuais |
| Confidentiality (C) | ✅ | Dados clientes |
| Processing Integrity (PI) | ☐ | [Se aplicável] |
| Privacy (P) | ☐ | [Se PII + privacy program] |

## 3. System Description
- **Serviços oferecidos:** [SaaS, API, etc.]
- **Usuários:** [B2B enterprise]
- **Infraestrutura:** [AWS, regions, sub-processors]
- **Boundary:** [O que está dentro/fora do audit scope]

## 4. Control Environment
- Tone at the top (políticas aprovadas pela direção)
- Organização e responsabilidades (RACI security)
- Competência e treinamento
- Monitoramento de controles

## 5. Roadmap para Auditoria
| Fase | Atividade | Prazo | Status |
|------|-----------|-------|--------|
| 1 | Gap assessment | | |
| 2 | Remediação controles | | |
| 3 | Período de evidências (12m) | | |
| 4 | Auditor externo | | |
```

---

## Documento 2: security-controls.md

**TSC:** Security — Common Criteria (CC1–CC9)

```markdown
# Controles de Segurança (Security — CC)

## CC6 — Logical and Physical Access
| Controle | Descrição | Implementação | Evidência | Status |
|----------|-----------|---------------|-----------|--------|
| CC6.1 | Logical access controls | MFA, RBAC, SSO | IdP config, access reviews | |
| CC6.2 | Authentication | Password policy, session mgmt | Policy doc, settings | |
| CC6.6 | Encryption | TLS 1.2+, AES-256 at rest | Cert scan, KMS config | |
| CC6.7 | System operations | Monitoring, logging, alerting | Datadog/SIEM dashboards | |

## CC7 — System Operations
| Controle | Descrição | Implementação | Evidência |
|----------|-----------|---------------|-----------|
| CC7.1 | Vulnerability management | SAST, dependency scan | Scan reports |
| CC7.2 | Security incidents | IR playbooks, tickets | Incident logs |
| CC7.3 | Change detection | File integrity, audit logs | CloudTrail |

## CC8 — Change Management
| Controle | Descrição | Implementação | Evidência |
|----------|-----------|---------------|-----------|
| CC8.1 | Authorized changes | PR + review + CI | GitHub PR history |

## Cross-Reference ISO 27001
| SOC2 CC | ISO 27001 Annex A |
|---------|-------------------|
| CC6.x | A.5.15–A.5.18, A.8.2–A.8.5 |
| CC7.2 | A.5.24–A.5.28 |
| CC8.1 | A.8.32 |
```

---

## Documento 3: availability-controls.md

**TSC:** Availability (A1) | **Serasa Req #7, #8**

```markdown
# Controles de Disponibilidade (Availability)

## A1.1 — Capacity and Performance
- Monitoramento: [CPU, memory, latency, error rate]
- Auto-scaling: [Políticas, limits]
- Capacity planning: [Revisão trimestral]

## A1.2 — Environmental Protections, Recovery, SLAs
### SLAs Documentados
| Serviço | SLA Uptime | Janela manutenção | Penalidade | Contrato ref |
|---------|------------|-------------------|------------|--------------|
| API Production | 99.9% | Dom 02–06 UTC | [Crédito] | Anexo X |
| Auth Service | 99.95% | | | |

### High Availability
- Multi-AZ deployment
- Health checks e auto-heal
- Load balancing

### Disaster Recovery
- RTO: [ex: 2h] | RPO: [ex: 1h]
- Cross-ref: `docs/compliance-context/business-continuity/disaster-recovery-plan.md`

## A1.3 — Monitoring and Incident Response
- Uptime monitoring: [Status page, Pingdom, etc.]
- Incident communication: [SLA breach notification process]
- Post-mortem obrigatório para P1/P2

## Evidências para Type II
- [ ] Uptime reports mensais (12 meses)
- [ ] Incident tickets com timeline
- [ ] SLA reports para clientes
- [ ] Contratos com anexo SLA (Req #8)
```

---

## Documento 4: confidentiality-controls.md

**TSC:** Confidentiality (C1)

```markdown
# Controles de Confidencialidade (Confidentiality)

## C1.1 — Confidential Information Identification
| Tipo dado | Classificação | Onde armazenado | Controles |
|-----------|---------------|-----------------|-----------|
| PII clientes | Confidencial | RDS encrypted | RBAC, audit log |
| API keys | Restrito | Secrets Manager | Rotation, least privilege |

## C1.2 — Confidential Information Disposal
- Retention policy: [Períodos por tipo]
- Secure deletion: [Crypto-shred, wipe procedures]
- Media disposal: [Cloud provider responsibility + verification]

## Proteções Técnicas
- Encryption at rest: [KMS, AES-256]
- Encryption in transit: [TLS 1.2+]
- DLP: [Se aplicável]
- NDAs: [Employees, contractors, vendors]

## Cross-Reference
- ISO 27001: `access-control.md`, `asset-management.md`
- LGPD: base legal, DPO contact
```

---

## Documento 5: evidence-collection.md

**TSC:** All categories — estratégia Type II

```markdown
# Estratégia de Coleta de Evidências (SOC2 Type II)

## Princípios
1. **Continuous:** Evidências coletadas durante todo o período (não só pré-audit)
2. **Automated when possible:** Logs, CI, monitoring
3. **Traceable:** Evidência → controle → TSC criterion
4. **Retained:** Período de retenção ≥ audit period + 1 year

## Matriz Controle → Evidência
| TSC | Controle | Tipo evidência | Fonte | Frequência | Owner |
|-----|----------|----------------|-------|------------|-------|
| CC6.1 | Access review | Screenshot/report | IdP | Trimestral | Security |
| CC6.6 | Encryption | Config export | AWS KMS | Anual | DevOps |
| CC7.2 | Incident | Ticket + timeline | Jira/PagerDuty | Por evento | On-call |
| CC8.1 | Change | PR merge history | GitHub | Contínuo | Eng |
| A1.2 | Uptime | SLA report | Monitoring | Mensal | SRE |

## Tipos de Evidência Aceitos
- ✅ Configurações exportadas (IAM, security groups)
- ✅ Logs imutáveis (CloudTrail, audit logs)
- ✅ Tickets com aprovações (change, access, incident)
- ✅ Relatórios automatizados (vuln scan, uptime)
- ⚠️ Screenshots (suplementar, com timestamp)
- ❌ Afirmações sem artefato

## Calendário de Coleta (Type II — 12 meses)
| Mês | Atividades | Controles cobertos |
|-----|------------|-------------------|
| M1 | Baseline access review | CC6.1 |
| M3 | Vuln scan + remediation | CC7.1 |
| M6 | DR test evidence | A1.2 |
| M12 | Consolidation para auditor | All |

## Preparação para Auditor
- [ ] System Description atualizado
- [ ] Control matrix completa
- [ ] Evidências indexadas por controle
- [ ] Gaps documentados com plano de remediação
- [ ] Ponto focal designado
```

---

## Common Criteria — Referência Rápida

| Série | Tema |
|-------|------|
| CC1 | Control Environment |
| CC2 | Communication and Information |
| CC3 | Risk Assessment |
| CC4 | Monitoring Activities |
| CC5 | Control Activities |
| CC6 | Logical and Physical Access |
| CC7 | System Operations |
| CC8 | Change Management |
| CC9 | Risk Mitigation |

---

## Checklist de Qualidade

- [ ] Type I vs Type II explicado claramente
- [ ] In-scope principles definidos (Security + Availability + Confidentiality mínimo)
- [ ] SLAs documentados em controles E referência contratual (Serasa #7/#8)
- [ ] Matriz controle → evidência com fontes reais
- [ ] Cross-ref ISO 27001 e ISO 22301 onde overlap
- [ ] Nenhuma certificação inventada — usar "preparação para" se não certificado

---

## Cross-Reference Summary

| SOC2 | ISO 27001 | ISO 22301 |
|------|-----------|-----------|
| CC6 Security | Annex A 5, 8 | — |
| CC7 Incidents | A.5.24–28 | crisis-management |
| A1 Availability | — | BCP/DRP, RTO/RPO |
| CC8 Changes | A.8.32 | — |
