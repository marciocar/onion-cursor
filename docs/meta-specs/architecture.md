---
title: Meta-spec — Arquitetura do Sistema Onion
date: 2026-05-28
version: 2.0.0
level: L0
status: active
gate-keeper: "@metaspec-gate-keeper"
---

# Meta-spec — Arquitetura do Sistema Onion

## Propósito

Definir a arquitetura obrigatória do framework Onion em modo Cursor-first, incluindo estrutura de diretórios, separação entre artefatos operacionais e documentação, e regras de dependência entre componentes.

---

## 1. Estrutura obrigatória

### 1.1 Root do framework

```
.cursor/                    # Operacional — rules, skills, agents, hooks, MCP
docs/                       # Documentação e análise
README.md                   # Visão executiva
AGENTS.md                   # Regra operacional principal do projeto
CLAUDE.md                   # Stub legado de compatibilidade
```

### 1.2 Estrutura de `.cursor/`

```
.cursor/
├── rules/                  # Regras persistentes (.mdc)
├── skills/                 # Skills de workflow
├── agents/                 # Subagentes (achatado na raiz)
├── commands/               # Comandos legados (compatibilidade)
├── hooks.json              # Registro de hooks
├── hooks/                  # Scripts executáveis de hook
├── mcp.json                # Integrações MCP
├── sessions/               # Estado persistente por feature
├── utils/                  # Abstrações (ex.: task-manager)
├── validation/             # Artefatos de validação
└── docs/                   # Referências internas da camada operacional
```

### 1.3 Estrutura de `docs/`

```
docs/
├── INDEX.md
├── meta-specs/
├── analysis/
├── migration/
├── plans/
├── onion/
├── knowledge-base/
└── [demais contextos documentais]
```

---

## 2. Separação operacional vs documental

| Aspecto | `.cursor/` | `docs/` |
|---|---|---|
| Natureza | Operacional | Informacional |
| Consumo primário | Agent runtime | Humanos + IA |
| Mudança típica | Ajuste de execução | Ajuste de referência |
| Regra | Não conter doutrina extensa | Não conter comportamento executável |

Regra central: comportamento vive em `.cursor/`; explicação e histórico vivem em `docs/`.

---

## 3. Plataforma canônica e legado

- Plataforma canônica: **Cursor 3.6+**
- Claude Code: **legado/compatibilidade documental**
- Não há CLI standalone nem distribuição npm do framework

---

## 4. Dependências permitidas

| De → Para | Permitido | Observação |
|---|---|---|
| `skills/*` → `agents/*` | Sim | Delegação especializada |
| `skills/*` → `utils/*` | Sim | Reuso de abstrações |
| `skills/*` → `sessions/*` | Sim | Persistência de fases |
| `agents/*` → `utils/*` | Sim | Especialistas técnicos |
| `agents/*` → `docs/*` | Sim | Consulta de referência |
| `utils/*` → `skills/*`/`agents/*` | Não | Evitar acoplamento inverso |

As dimensões produto, engenharia e compliance devem permanecer peer, coordenadas por sessões, skills e documentação.

---

## 5. Proibições explícitas

- Proibido tratar `.cursor/` como base operacional canônica
- Proibido criar subpastas em `.cursor/agents/` para descoberta ativa
- Proibido usar path absoluto em regras operacionais
- Proibido remover histórico legado sem referência documental

