---
name: task
description: |
  Criação de tasks ClickUp com decomposição hierárquica inteligente.
  Use para criar tasks estruturadas com subtasks e action items.
model: sonnet

parameters:
  - name: description
    description: Descrição da task
    required: true
  - name: list_name
    description: Nome da lista no ClickUp
    required: false

category: product
tags:
  - task
  - clickup
  - decomposition

version: "3.0.0"
updated: "2025-11-24"

related_commands:
  - /product/spec
  - /engineer/start

related_agents:
  - task-specialist
  - product-agent
  - clickup-specialist
---

# 🚀 Criação de Task com Decomposição

Criar tasks estruturadas no ClickUp com hierarquia inteligente.

## 🎯 Objetivo

Estabelecer base sólida para desenvolvimento com decomposição Task → Subtask → Action Item.

## ⚡ Fluxo de Execução

### Passo 1: Análise de Contexto

```bash
# Revisar documentação do projeto
read_file README.md
ls docs/*.md

# Entender estrutura existente
list_dir src/
```

### Passo 2: Compreender Tarefa

1. **Ler descrição**: `{{description}}`
2. **Identificar complexidade**:
   - Simples (1-3 dias): 2-3 subtasks
   - Média (4-7 dias): 3-4 subtasks
   - Complexa (1-2 sem): 4-6 subtasks
   - Épico (>2 sem): Quebrar em múltiplas tasks

3. **Confirmar com usuário** antes de criar

### Passo 3: Decompor Hierarquicamente

Consultar @task-specialist para estrutura:

```
📋 TASK (Objetivo de Alto Nível)
├── 🔧 Subtask 1 (Componente Funcional)  
│   ├── ✅ Action Item 1.1 (1-4h)
│   ├── ✅ Action Item 1.2 (1-4h)
│   └── ✅ Action Item 1.3 (1-4h)
└── 🔧 Subtask 2 (Componente Funcional)
    ├── ✅ Action Item 2.1 (1-4h)
    └── ✅ Action Item 2.2 (1-4h)
```

### Passo 4: Criar no ClickUp

Via @clickup-specialist:

1. **Criar Task Principal**
   ```yaml
   name: "{{description}}"
   list_id: [resolver de list_name]
   markdown_description: |
     ## 🎯 Objetivo
     [extraído da análise]
     
     ## ✅ Critérios de Aceite
     - [ ] Critério 1
     - [ ] Critério 2
   ```

2. **Criar Subtasks**
   Para cada subtask identificada

3. **Adicionar Comment Inicial**
   Usar padrão de `common/prompts/clickup-patterns.md`

### Passo 5: Apresentar Resultado

## 📤 Output Esperado

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ TASK CRIADA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Task: {{description}}
🔗 URL: https://app.clickup.com/t/[id]
📊 Complexidade: [simples/média/complexa]

🔧 Estrutura:
├── Subtask 1: [nome]
│   ├── ✅ Item 1.1
│   └── ✅ Item 1.2
└── Subtask 2: [nome]
    └── ✅ Item 2.1

📈 Estimativa: [X dias]

🚀 Próximo: /engineer/start [feature-slug]
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## 📏 Regras de Decomposição

| Tipo | Duração | Subtasks | Action Items/Subtask |
|------|---------|----------|---------------------|
| Simples | 1-3d | 2-3 | 2-3 |
| Média | 4-7d | 3-4 | 3-4 |
| Complexa | 1-2sem | 4-6 | 3-5 |
| Épico | >2sem | Quebrar | - |

## 🔗 Referências

- Padrões: `common/prompts/clickup-patterns.md`
- Decomposição: @task-specialist
- ClickUp: @clickup-specialist

## ⚠️ Notas

- SEMPRE confirmar com usuário antes de criar
- Action items: máximo 4h cada
- Se épico: sugerir quebrar em múltiplas tasks
