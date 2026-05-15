# Meta Specs - Sistema Onion

---

## 📋 Visão Geral

**Meta Specs** são especificações de nível mais alto que servem como "constituição" do Sistema Onion. Elas definem princípios, padrões e regras imutáveis que todos os componentes devem seguir.

### Hierarquia de Especificações

```
┌─────────────────────────────────────────────────────────┐
│                    META-SPECS (L0)                      │
│          "Constituição" - Regras Imutáveis              │
├─────────────────────────────────────────────────────────┤
│                    DOMAIN SPECS (L1)                    │
│          Regras de Negócio e Domínio                    │
├─────────────────────────────────────────────────────────┤
│                    FEATURE SPECS (L2)                   │
│          Especificações de Features                     │
├─────────────────────────────────────────────────────────┤
│                    TASK SPECS (L3)                      │
│          Sessions e Contextos de Trabalho               │
└─────────────────────────────────────────────────────────┘
```

---

## 📁 Estrutura

```
docs/meta-specs/
├── index.md              # Este arquivo
├── architecture.md       # Padrões arquiteturais
├── code-standards.md     # Padrões de código
├── agents.md             # Padrões para agentes
├── commands.md           # Padrões para comandos
└── integrations.md       # Padrões para integrações
```

---

## 🎯 Propósito

### O que são Meta Specs?

Meta Specs definem:
- **Princípios arquiteturais** que o sistema deve seguir
- **Padrões de código** para consistência
- **Convenções de nomenclatura** para agentes e comandos
- **Regras de integração** com sistemas externos
- **Critérios de qualidade** para validação

### Quando usar Meta Specs?

| Situação | Uso |
|----------|-----|
| Criar novo agente | Consultar `agents.md` |
| Criar novo comando | Consultar `commands.md` |
| Tomar decisão arquitetural | Consultar `architecture.md` |
| Revisar código | Consultar `code-standards.md` |
| Integrar sistema externo | Consultar `integrations.md` |

### Quem mantém Meta Specs?

- **@metaspec-gate-keeper**: Valida conformidade
- **@onion**: Orquestra aplicação
- **Administradores do projeto**: Atualizam specs

---

## 📜 Meta Specs Disponíveis

### 🏗️ architecture.md (A CRIAR)
Padrões arquiteturais do Sistema Onion:
- Estrutura de diretórios
- Separação de responsabilidades
- Fluxos de dados
- Dependências permitidas

### 📝 code-standards.md (A CRIAR)
Padrões de código:
- Linguagem (pt-BR para docs, en-US para código)
- Formatação
- Documentação
- Testes

### 🤖 agents.md (A CRIAR)
Padrões para agentes:
- Estrutura YAML obrigatória
- Campos obrigatórios vs opcionais
- Convenções de nomenclatura
- Integração com MCPs

### 🔧 commands.md (A CRIAR)
Padrões para comandos:
- Estrutura obrigatória
- Limite de tamanho (~500 linhas)
- Modularização
- Integração com ClickUp

### 🔌 integrations.md (A CRIAR)
Padrões para integrações:
- Gestão de credenciais (.env)
- Fallback quando indisponível
- MCPs suportados
- Agentes agnósticos vs especializados

---

## 🔄 Workflow de Validação

```
┌─────────────────┐     ┌─────────────────┐     ┌─────────────────┐
│    CHANGE       │────▶│  @metaspec-     │────▶│   APPROVED/     │
│    REQUEST      │     │  gate-keeper    │     │   REJECTED      │
└─────────────────┘     └─────────────────┘     └─────────────────┘
```

### Processo

1. **Proposta de mudança**: Desenvolvedor propõe alteração
2. **Validação**: `@metaspec-gate-keeper` verifica conformidade
3. **Decisão**: Aprovado se conforme, rejeitado com justificativa

---

## 📚 Referências

- **Knowledge Bases**: `docs/knowledge-base/`
- **Documentação Onion**: `docs/onion/`
- **Agentes**: `.claude/agents/`
- **Comandos**: `.claude/commands/`
- **Regras**: `.claude/rules/`

---

## 📅 Histórico

| Data | Versão | Mudança |
|------|--------|---------|
| 2025-11-24 | 1.0.0 | Criação inicial |

---

**Responsável**: Sistema Onion v3.0
**Última Atualização**: 2025-11-24

