---
name: task
description: |
  Criação de tasks com decomposição hierárquica inteligente.
  Use para criar tasks estruturadas com subtasks e action items.
  Suporta: ClickUp, Asana, Linear (via TASK_MANAGER_PROVIDER).
model: sonnet

parameters:
  - name: description
    description: Descrição da task
    required: true
  - name: project_name
    description: Nome do projeto/lista (opcional)
    required: false

category: product
tags:
  - task
  - task-manager
  - decomposition

version: "3.0.0"
updated: "2025-11-24"

related_commands:
  - /product/spec
  - /product/estimate
  - /engineer/start

related_agents:
  - task-specialist
  - product-agent
  - story-points-framework-specialist
---

# 🚀 Criação de Task com Decomposição

Criar tasks estruturadas no gerenciador de tarefas configurado.

## 🔧 Pré-requisito: Verificar Provedor

```markdown
Antes de criar tasks, verificar configuração:
1. Ler `.env` para TASK_MANAGER_PROVIDER
2. Se não configurado ou "none":
   - Avisar: "⚠️ Nenhum gerenciador configurado. Execute /meta/setup-integration"
   - Continuar com estrutura local (sem sincronização)
3. Se configurado:
   - Usar adapter correspondente de `.cursor/utils/task-manager/adapters/`
```

## 🎯 Objetivo

Estabelecer base sólida para desenvolvimento com decomposição Task → Subtask → Action Item.

## ⚡ Fluxo de Execução

### Passo 1: Detectar Provedor e Configuração

**CRÍTICO:** Executar estas ações na ordem:

1. **Ler `.env` para detectar provedor:**
   ```bash
   # Usar read_file para ler .env
   read_file .env
   
   # Extrair TASK_MANAGER_PROVIDER (padrão: 'none')
   # Verificar variáveis obrigatórias:
   # - ClickUp: CLICKUP_API_TOKEN
   # - Asana: ASANA_ACCESS_TOKEN
   # - Linear: LINEAR_API_KEY
   ```

2. **Validar configuração:**
   ```markdown
   SE TASK_MANAGER_PROVIDER = 'clickup':
     ✅ Verificar CLICKUP_API_TOKEN existe
     ✅ Se não existe: avisar e continuar em modo offline
     
   SE TASK_MANAGER_PROVIDER = 'asana':
     ✅ Verificar ASANA_ACCESS_TOKEN existe
     ✅ Se não existe: avisar e continuar em modo offline
     
   SE TASK_MANAGER_PROVIDER = 'none' ou não configurado:
     ⚠️ Modo offline - tasks não serão sincronizadas
     💡 Avisar: Execute /meta/setup-integration para configurar
   ```

3. **Resolver projeto/lista (se `project_name` fornecido):**
   ```markdown
   SE project_name fornecido:
     - ClickUp: usar mcp_ClickUp_clickup_get_list com list_name
     - Asana: usar mcp_asana_asana_get_projects e buscar por nome
     - Se não encontrado: perguntar ao usuário ou usar padrão
   
   SE project_name não fornecido:
     - ClickUp: usar CLICKUP_DEFAULT_LIST_ID do .env
     - Asana: usar ASANA_DEFAULT_PROJECT_ID do .env
     - Se não configurado: listar opções e perguntar ao usuário
   ```

### Passo 2: Análise de Contexto

```bash
# Revisar documentação do projeto
read_file README.md
ls docs/*.md

# Entender estrutura existente
list_dir src/
```

### Passo 3: Compreender Tarefa

1. **Ler descrição**: `{{description}}`
2. **Identificar complexidade**:
   - Simples (1-3 dias): 2-3 subtasks
   - Média (4-7 dias): 3-4 subtasks
   - Complexa (1-2 sem): 4-6 subtasks
   - Épico (>2 sem): Quebrar em múltiplas tasks

3. **Confirmar com usuário** antes de criar

### Passo 4: Decompor Hierarquicamente

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

### Passo 5: Estimar Story Points (Automático)

**CRÍTICO:** Após decomposição, SEMPRE estimar story points para task principal e cada subtask.

#### 5.1. Estimar Task Principal

```markdown
@story-points-framework-specialist

Por favor, analise e estime a seguinte tarefa:

**Tarefa Principal:** {{description}}
**Subtasks identificadas:** [lista de subtasks]
**Complexidade inicial:** [simples/média/complexa]

Forneça:
1. Story points para task principal
2. Análise de complexidade, risco e incerteza
3. Recomendações (quebra, riscos, dependências)
```

**Output esperado:**
- Story points da task principal
- Análise completa de fatores
- Recomendações

#### 5.2. Estimar Cada Subtask

```markdown
Para cada subtask identificada:

@story-points-framework-specialist

**Subtask:** [nome da subtask]
**Descrição:** [descrição da subtask]
**Action items:** [lista de action items]

Estime story points para esta subtask.
```

**Armazenar:**
- Story points por subtask
- Total de pontos (soma das subtasks)

#### 5.3. Validar Consistência

```markdown
SE soma(subtasks) > task_principal:
  ⚠️ AVISO: Soma das subtasks maior que task principal
  Ajustar task principal para: soma(subtasks)
  
SE task_principal > 13 pontos:
  ⚠️ ALERTA: Task identificada como ÉPICO
  Propor quebra em múltiplas tasks menores
```

### Passo 6: Criar no Gerenciador

**CRÍTICO:** 
- ✅ Usar ferramentas MCP diretamente (`mcp_ClickUp_*`, `mcp_asana_*`)
- ✅ Seguir padrão de abstração do Task Manager para normalizar entrada/saída
- ✅ Consultar `.cursor/utils/task-manager/interface.md` para formato de dados
- ✅ Consultar `.cursor/utils/task-manager/adapters/{provedor}.md` para mapeamentos específicos

**IMPORTANTE:** Mesmo usando MCP diretamente, os dados devem seguir o padrão da abstração:
- Entrada normalizada (priority: urgent/high/normal/low)
- Saída normalizada (TaskOutput com campos padronizados)
- Mapeamento de status conforme interface

#### 6.1. Preparar Dados Normalizados (Padrão Abstração)

```markdown
Preparar estrutura normalizada seguindo interface ITaskManager:

**Task Principal:**
- name: "{{description}}"
- markdownDescription: [formato markdown com objetivo, critérios, story points]
- priority: 'high' (normalizado: urgent/high/normal/low)
- tags: ['feature']
- projectId: [resolvido no Passo 1]

**Cada Subtask:**
- name: [nome da subtask]
- markdownDescription: [descrição + story points]
- priority: [herdar da task principal ou 'normal']
- tags: [tags da subtask se houver]
```

#### 6.2. Criar Task Principal (Executar MCP)

**SE provedor = 'clickup':**
```markdown
1. Chamar mcp_ClickUp_clickup_create_task com:
   - list_id: [projectId resolvido]
   - name: [nome normalizado]
   - markdown_description: [descrição markdown completa]
   - priority: 'high' (mapear: high → 'high' no ClickUp)
   - tags: ['feature']
   - workspace_id: [CLICKUP_WORKSPACE_ID do .env, se disponível]

2. Extrair task.id da resposta
3. Armazenar task.url para output final
```

**SE provedor = 'asana':**
```markdown
1. Chamar mcp_asana_asana_create_task com:
   - name: [nome normalizado]
   - html_notes: [descrição markdown convertida para HTML]
   - project_id: [projectId resolvido]
   - workspace: [ASANA_WORKSPACE_ID do .env, se disponível]

2. Extrair task.gid da resposta (data.gid)
3. Construir URL: https://app.asana.com/0/0/{gid}
```

**SE provedor = 'none' ou não configurado:**
```markdown
⚠️ Modo offline - criar apenas estrutura local
- Gerar ID local: local-{timestamp}
- Criar documento em .cursor/sessions/tasks/{id}.md
- Avisar que não será sincronizado
```

#### 6.3. Criar Subtasks (Executar MCP)

**Para cada subtask da decomposição:**

**SE provedor = 'clickup':**
```markdown
Chamar mcp_ClickUp_clickup_create_task com:
- list_id: [mesmo list_id da task principal]
- parent: [task.id da task principal criada]
- name: [nome da subtask]
- markdown_description: [descrição + story points]
- priority: [mapear para ClickUp]
- tags: [tags da subtask]
```

**SE provedor = 'asana':**
```markdown
Chamar mcp_asana_asana_create_task com:
- name: [nome da subtask]
- html_notes: [descrição + story points em HTML]
- parent: [task.gid da task principal]
- workspace: [ASANA_WORKSPACE_ID]
```

**SE provedor = 'none':**
```markdown
Criar documento local: .cursor/sessions/tasks/{parent-id}/subtasks/{subtask-id}.md
```

#### 6.4. Adicionar Comentário Inicial (Executar MCP)

**Preparar comentário formatado:**
```markdown
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 TASK CRIADA VIA /product/task
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 COMPLEXIDADE: ${complexity}
🎲 STORY POINTS:
∟ Task Principal: ${mainTaskStoryPoints} pontos
∟ Subtasks: ${subtasksPoints} pontos (${subtasks.length} subtasks)
∟ Total: ${totalPoints} pontos

⚡ FATORES:
${factorsSummary}

💡 RECOMENDAÇÕES:
${recommendations}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

**SE provedor = 'clickup':**
```markdown
Chamar mcp_ClickUp_clickup_create_task_comment com:
- task_id: [task.id]
- comment_text: [comentário formatado acima]
```

**SE provedor = 'asana':**
```markdown
Chamar mcp_asana_asana_create_task_story com:
- task_id: [task.gid]
- text: [comentário formatado acima]
```

**SE provedor = 'none':**
```markdown
Adicionar comentário ao documento local
```

#### 6.5. Normalizar Saída (Padrão Abstração)

```markdown
Após criar, normalizar resposta para formato padrão:

**TaskOutput normalizado:**
- id: [task.id ou task.gid]
- provider: [clickup/asana/none]
- name: [nome da task]
- url: [URL completa da task]
- status: 'todo' (padrão inicial)
- createdAt: [timestamp ISO]
- projectId: [ID do projeto/lista]
- storyPoints: [story points da task principal]
- subtasks: [array de subtasks normalizadas]
```

### Passo 7: Apresentar Resultado

## 📤 Output Esperado

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ TASK CRIADA
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 Task: {{description}}
🔗 URL: [url do provedor]
📊 Provedor: [clickup/asana/linear/local]

🎲 STORY POINTS:
∟ Task Principal: [X] pontos
∟ Subtasks: [Y] pontos ([N] subtasks)
∟ Total: [Z] pontos

📊 ANÁLISE:
∟ Complexidade: [alta/média/baixa]
∟ Risco: [alto/médio/baixo]
∟ Incerteza: [alta/média/baixa]

🔧 ESTRUTURA:
├── Subtask 1: [nome] - [X] pontos
│   ├── ✅ Item 1.1
│   └── ✅ Item 1.2
└── Subtask 2: [nome] - [Y] pontos
    └── ✅ Item 2.1

💡 RECOMENDAÇÕES:
${recommendations}

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

### Task Manager Abstraction
- **Interface:** `.cursor/utils/task-manager/interface.md` - Formato de entrada/saída normalizado
- **Detector:** `.cursor/utils/task-manager/detector.md` - Como detectar provedor do .env
- **Adapters (Guias de Mapeamento):**
  - `.cursor/utils/task-manager/adapters/clickup.md` - Mapeamento ClickUp MCP
  - `.cursor/utils/task-manager/adapters/asana.md` - Mapeamento Asana MCP
  - `.cursor/utils/task-manager/types.md` - Tipos compartilhados

### Decomposição e Estimativas
- **Decomposição:** @task-specialist
- **Estimativas:** @story-points-framework-specialist, /product/estimate
- **Framework:** `docs/knowbase/frameworks/framework_story_points.md`

### Padrões de Formatação
- **ClickUp:** `.cursor/commands/common/prompts/clickup-patterns.md`
- **Formatação:** `.cursor/utils/clickup-formatting.md`

## ⚠️ Notas

- SEMPRE confirmar com usuário antes de criar
- Action items: máximo 4h cada
- Se épico: sugerir quebrar em múltiplas tasks
- Se provedor não configurado: funciona em modo local
- **Estimativas automáticas:** Story points calculados automaticamente para task principal e todas subtasks
- **Validação:** Se soma(subtasks) > task principal, ajustar task principal
- **Épicos:** Se task > 13 pontos, alertar e propor quebra
