# Template de Documentação ISO/IEC 27001:2022 (SGSI / ISMS)

*Framework para gerar documentação auditável de Sistema de Gestão de Segurança da Informação*

---

## Propósito Deste Template

Este template orienta a geração de documentação de compliance **ISO/IEC 27001:2022** alinhada ao **ISO/IEC 27002:2022** (controles) e **ISO/IEC 27005:2022** (gestão de riscos).

**Use para:**
- Certificação ISO 27001 ou preparação para auditoria
- Due diligence de clientes enterprise
- Base de controles com overlap ~70% com SOC2 Type II
- Integração com LGPD e políticas internas de segurança

**Output directory:** `docs/compliance-context/security/`

**Idioma:** PT-BR com termos técnicos em inglês na primeira menção (ex.: *Risk Assessment (Avaliação de Riscos)*)

---

## Estrutura de Arquivos (multi-arquivo)

**IMPORTANTE:** Criar `index.md` na pasta de saída antes dos documentos individuais.

```
docs/compliance-context/
├── index.md                          # Perfil + links por framework
└── security/
    ├── index.md                      # Índice ISO 27001
    ├── information-security-policy.md
    ├── risk-assessment.md
    ├── asset-management.md
    ├── access-control.md
    ├── incident-response.md
    └── statement-of-applicability.md # SoA — opcional, recomendado
```

### index.md (security/)

```markdown
# ISO/IEC 27001:2022 — Documentação de Segurança da Informação

## Escopo do SGSI
- Organização: [Nome]
- Sistemas: [Lista]
- Exclusões: [Se houver, justificar]

## Documentos
- [Política de Segurança](information-security-policy.md)
- [Avaliação de Riscos](risk-assessment.md)
- [Gestão de Ativos](asset-management.md)
- [Controle de Acesso](access-control.md)
- [Resposta a Incidentes](incident-response.md)
- [Statement of Applicability](statement-of-applicability.md)

## Referências normativas
- ISO/IEC 27001:2022, ISO/IEC 27002:2022, ISO/IEC 27005:2022
```

---

## Documento 1: information-security-policy.md

**Referência:** ISO 27001 Clause 5.2 | **Prioridade:** Alta

### Seções obrigatórias

```markdown
# Política de Segurança da Informação

## 1. Propósito e Escopo
[Objetivo da política, escopo organizacional, exclusões]

## 2. Princípios CIA
### Confidenciality (Confidencialidade)
[Classificação de dados, RBAC, criptografia, MFA]

### Integrity (Integridade)
[Audit logs, versionamento, segregação de ambientes]

### Availability (Disponibilidade)
[HA, backups, DR, monitoramento]

## 3. Matriz de Responsabilidades
| Papel | Responsabilidades |
|-------|-------------------|
| Alta Direção | Aprovação, recursos, compromisso |
| CISO / Security Lead | SGSI, risk assessments, métricas |
| Engenharia | Secure coding, code review, vulnerabilidades |
| Todos colaboradores | Credenciais, reporte de incidentes, treinamento |

## 4. Controles Annex A Implementados
| Controle | Status | Evidência |
|----------|--------|-----------|
| A.5.1 Políticas | ✅/⚠️/❌ | [Link] |
| A.5.9 Inventário de ativos | | |
| A.5.15 Controle de acesso | | |
| A.5.24 Resposta a incidentes | | |

## 5. Revisão e Aprovação
- Versão: 1.0
- Aprovado por: [Nome, cargo]
- Próxima revisão: [Data — anual]
```

---

## Documento 2: risk-assessment.md

**Referência:** ISO 27001 Clause 6.1.2, ISO 27005 | **Prioridade:** Alta

### Metodologia (6 passos)

1. Identificação de ativos (dados, sistemas, pessoas, processos)
2. Identificação de ameaças (externas, internas, ambientais)
3. Identificação de vulnerabilidades
4. Análise de risco (Likelihood × Impact)
5. Avaliação e priorização
6. Tratamento (Mitigar, Transferir, Aceitar, Evitar)

### Template de registro de riscos

```markdown
# Avaliação de Riscos de Segurança da Informação

## Metodologia
Framework: ISO/IEC 27005:2022
Escala Impacto: 1 (Baixo) — 5 (Crítico)
Escala Probabilidade: 1 (Raro) — 5 (Quase certo)
Risk Score = Impacto × Probabilidade

## Risk Register
| ID | Ativo | Ameaça | Vulnerabilidade | I | P | Score | Tratamento | Owner | Prazo |
|----|-------|--------|-----------------|---|---|-------|------------|-------|-------|
| R-001 | [Ativo] | [Ameaça] | [Vuln] | | | | Mitigar | | |

## Top 10 Riscos Prioritários
[Resumo executivo dos riscos score ≥ 15]

## Plano de Tratamento
| Risco | Ação | Controle Annex A | Status |
|-------|------|------------------|--------|
| R-001 | [Ação] | A.8.x | Aberto |
```

---

## Documento 3: asset-management.md

**Referência:** Annex A 5.9–5.14 | **Prioridade:** Média

```markdown
# Gestão de Ativos de Informação

## Inventário de Ativos
| ID | Ativo | Tipo | Owner | Classificação | Localização | Criticidade |
|----|-------|------|-------|---------------|-------------|-------------|
| A-001 | [Nome] | Dado/Sistema/Pessoa | | Público/Interno/Confidencial/Restrito | | Alta/Média/Baixa |

## Classificação de Dados
| Nível | Definição | Exemplos | Controles mínimos |
|-------|-----------|----------|-------------------|
| Restrito | Dano severo se exposto | PII, credenciais, chaves | Criptografia, MFA, need-to-know |
| Confidencial | Dano significativo | Financeiro, contratos | RBAC, logging |
| Interno | Uso interno | Docs operacionais | Acesso autenticado |
| Público | Divulgação permitida | Marketing, site | Integridade |

## Ciclo de Vida
- Aquisição → Registro → Uso → Manutenção → Descarte seguro
```

---

## Documento 4: access-control.md

**Referência:** Annex A 5.15–5.18, 8.2–8.5 | **Prioridade:** Alta

```markdown
# Controle de Acesso (Access Control)

## Princípios
- Least Privilege
- Need-to-Know
- Segregation of Duties

## Autenticação
| Sistema | MFA | SSO | Política de senha | Session timeout |
|---------|-----|-----|-------------------|-----------------|
| [App] | ✅ | ✅ | [Política] | [Tempo] |

## Autorização (RBAC)
| Role | Permissões | Sistemas | Aprovação |
|------|------------|----------|-----------|
| Admin | Full | [Lista] | CISO |
| Developer | Read/Write code | Git, CI | Tech Lead |

## Provisionamento / Deprovisionamento
- Onboarding: [Processo + SLA]
- Offboarding: [Revogação imediata + checklist]
- Revisão periódica: Trimestral

## Controles técnicos
- [ ] MFA obrigatório para produção
- [ ] Service accounts com rotação de secrets
- [ ] Break-glass documentado
```

---

## Documento 5: incident-response.md

**Referência:** Annex A 5.24–5.28 | **Prioridade:** Alta

```markdown
# Resposta a Incidentes de Segurança

## Classificação de Severidade
| Nível | Critério | SLA resposta | Escalation |
|-------|----------|--------------|------------|
| P1 Crítico | Data breach, sistema down | 15 min | CISO + CEO |
| P2 Alto | Tentativa de intrusão | 1 hora | Security Lead |
| P3 Médio | Phishing, malware contenido | 4 horas | On-call |
| P4 Baixo | Evento informativo | 24 horas | Ticket |

## Incident Response Team (IRT)
| Papel | Nome/Função | Contato | Responsabilidade |
|-------|-------------|---------|------------------|
| Incident Commander | | | Coordenação |
| Security Lead | | | Análise técnica |
| Comunicação | | | Stakeholders/clientes |
| Legal/DPO | | | LGPD, notificações |

## Playbooks
### Playbook: Data Breach
1. Contenção → 2. Eradicação → 3. Recuperação → 4. Lições aprendidas

### Playbook: Ransomware
[Passos específicos]

## Comunicação e LGPD
- Notificação ANPD: [Prazo e responsável]
- Notificação titulares: [Critérios]
- Evidências preservadas: [Logs, snapshots, chain of custody]
```

---

## Documento opcional: statement-of-applicability.md (SoA)

```markdown
# Statement of Applicability (SoA)

| Controle Annex A | Aplicável | Justificativa | Status | Evidência |
|------------------|-----------|---------------|--------|-----------|
| A.5.1 | Sim | Política obrigatória | Implementado | [Link] |
| A.5.x | Não | [Justificar exclusão] | N/A | — |
```

---

## Mapeamento Annex A (93 controles — resumo por tema)

| Tema | Controles | Documentos relacionados |
|------|-----------|-------------------------|
| Organizacional (5) | A.5.1–A.5.37 | policy, risk, assets, access, incident |
| Pessoas (6) | A.6.1–A.6.8 | policy, access |
| Físico (7) | A.7.1–A.7.14 | policy (se aplicável) |
| Tecnológico (8) | A.8.1–A.8.34 | access, incident, assets |

---

## Cross-Reference SOC2

| ISO 27001 | SOC2 TSC | Overlap |
|-----------|----------|---------|
| Access Control | CC6.x Security | ~90% |
| Incident Response | CC7.x | ~85% |
| Risk Assessment | CC3.x Risk | ~75% |
| Asset Management | CC6.1 | ~70% |

---

## Checklist de Qualidade

- [ ] Escopo do SGSI definido e aprovado
- [ ] 5 documentos principais gerados em `docs/compliance-context/security/`
- [ ] Risk register com ≥ 10 riscos identificados
- [ ] SoA com justificativas para controles não aplicáveis
- [ ] Termos técnicos em inglês preservados na primeira menção
- [ ] Evidências referenciadas (links, tickets, políticas reais)
- [ ] index.md com links funcionais

---

## Notas para o Agente

- Customizar placeholders `[...]` com contexto real do projeto
- Não inventar certificações ou auditorias inexistentes
- Marcar controles como ⚠️ quando parcialmente implementados
- Referenciar implementação real (AWS, GitHub, Jira, etc.) quando disponível
