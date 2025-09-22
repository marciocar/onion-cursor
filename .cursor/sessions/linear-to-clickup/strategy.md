# Estratégia de Migração: Linear → ClickUp MCP

## Status Mapping Validado

### ✅ **Status ClickUp Disponíveis** (Testados):
- **"bakclog"** (backlog) - Status inicial padrão (cor: #656f7d)
- **"to do"** - Equivalente Linear "To Do" (cor: #d33d44)  
- **"in progress"** - Equivalente Linear "In Progress" (cor: #4466ff)
- **"done"** - Equivalente Linear "Done" (cor: #3db88b)

### ❌ **Status Não Disponíveis**:
- **"in review"** - Não existe (erro: "Status does not exist")
- **"review"** - Não existe  
- **"complete"** - Não existe

### 🔄 **Mapeamento Linear → ClickUp**:
| Linear Status | ClickUp Status | Estratégia |
|---------------|----------------|------------|
| "To Do"       | "to do"       | ✅ Direto  |
| "In Progress" | "in progress" | ✅ Direto  |
| **"In Review"** | **"done"** | 🔄 **Adaptação necessária** |
| "Done"        | "done"        | ✅ Direto  |

### ⚠️ **PROBLEMA IDENTIFICADO: "In Review"**

O comando **`engineer/pr.md`** move tasks para status **"In Review"** que **não existe no ClickUp**.

#### **Soluções Possíveis**:

1. **Opção A - Usar "done"**: 
   - Mapear "In Review" → "done"
   - ✅ Simples de implementar
   - ❌ Perde semântica de "review pendente"

2. **Opção B - Criar custom status**:
   - Configurar "In Review" no ClickUp
   - ✅ Mantém semântica perfeita
   - ❓ Requer configuração manual no ClickUp

3. **Opção C - Usar tags + "in progress"**:
   - Status "in progress" + tag "review"
   - ✅ Semântica preservada
   - ✅ Não requer configuração ClickUp
   - 🔄 Comandos precisam adicionar tag

## IDs e Estrutura Hierárquica

### **Ambiente Atual (Validado)**:
- **Workspace**: `90131664218` (Marcio de Carvalho)
- **Space "Grana.ai"**: `90136982915`
- **List "Tarefas"**: `901314121395`

### **Estratégia Hierárquica Linear → ClickUp**:
- **Linear Team** → **ClickUp Workspace** (`90131664218`)
- **Linear Project** → **ClickUp Space** (`90136982915`)
- **Linear Milestone** → **ClickUp Folder** (a criar se necessário)
- **Linear Issue/Card** → **ClickUp Task**

### **Custom Fields Disponíveis**:
- **"Tarefas"** (checkbox): `da8c38f6-87d9-4953-bff6-2618908bf36f`
- Possibilidade de criar campos adicionais se necessário

## Convenções de Nomenclatura

### **IDs nos Comandos**:
- Manter formato atual: `[INSERT CARD ID]` → `[INSERT TASK ID]`
- URLs ClickUp: `https://app.clickup.com/t/{taskId}`

### **Referências em Documentos**:
- "card do Linear" → "task do ClickUp"
- "projeto Linear" → "space ClickUp"  
- "time Linear" → "workspace ClickUp"

### **Logs e Templates**:
- Manter templates de conclusão existentes
- Substituir apenas referências específicas Linear → ClickUp

## Comandos MCP Finalizados

### **Core Functions (100% Validados)**:
1. `create_task` - Criação de tasks ✅
2. `update_task` - Status e conteúdo ✅
3. `create_task_comment` - Comentários ✅  
4. `get_task` - Recuperação por ID/name ✅
5. `delete_task` - Limpeza ✅

### **Advanced Functions (A Validar)**:
- `get_task_comments` - Recuperar discussões
- `move_task` - Entre lists diferentes
- Custom fields manipulation
- Bulk operations se necessário

## Recomendação de Implementação

### **Para "In Review" Problem**:
**RECOMENDO Opção C**: Status "in progress" + tag "under-review"

#### **Justificativa**:
- ✅ Sem configuração manual no ClickUp
- ✅ Semântica preservada  
- ✅ Visível na interface ClickUp
- ✅ Queries podem filtrar por tag
- ✅ Compatível com automações futuras

#### **Implementação**:
```typescript
// engineer/pr.md equivalente
await update_task(taskId, {
  status: "in progress",
  tags: ["under-review"]
})
```

### **Migration Priority**:
1. **FASE 2**: Agents (product-agent.md)
2. **FASE 3**: Product commands (task, collect, refine, light-arch)  
3. **FASE 4**: Engineer commands (start, pr)
4. **FASE 5**: Docs commands (build-index)

## Validações Finais Necessárias

1. **Tags functionality** - Testar adição/remoção tags
2. **Bulk status changes** - Performance com multiple tasks
3. **Error handling** - Task não encontrada, etc.
4. **List permissions** - Validar permissões workspace
5. **Custom fields** - Se necessário usar campos adicionais
