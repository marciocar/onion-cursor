# 🔧 Correção Crítica: Hierarquia ClickUp MCP (29/09/2025)

## 🚨 **Problema Identificado**

As subtasks no Sistema Onion estavam sendo criadas **independentemente** em vez de hierarquicamente vinculadas às tasks principais.

### **Root Cause:**
- Comandos usavam `create_bulk_tasks` ou `create_task` sem parâmetro `parent`
- Resultava em: `"parent": null` e `"subtasks": []` nas tasks principais
- Estrutura hierárquica perdida no ClickUp

## ✅ **Solução Implementada**

### **Template Corrigido:**
```javascript
// 1. CRIAR TASK PRINCIPAL PRIMEIRO
const mainTask = await mcp_clickup_create_task({
  name: "🎯 Task Principal",
  listId: "901314121395",
  description: "...",
  tags: ["feature"],
  priority: 2
});

// 2. CRIAR SUBTASKS COM PARENT RELATIONSHIP
const subtask1 = await mcp_clickup_create_task({
  name: "🔧 Subtask 1",
  listId: "901314121395", 
  parent: mainTask.id,    // ← CRITICAL: Vincula à task principal
  description: "...",
  tags: ["subtask"]
});

const subtask2 = await mcp_clickup_create_task({
  name: "🔧 Subtask 2",
  listId: "901314121395",
  parent: mainTask.id,    // ← CRITICAL: Vincula à task principal  
  description: "...",
  tags: ["subtask"]
});
```

### **🔄 Sequência Obrigatória:**
1. **create_task** → Task Principal (obter task.id)
2. **create_task** → Subtask 1 (parent: task.id)
3. **create_task** → Subtask 2 (parent: task.id)
4. **create_task** → Subtask N (parent: task.id)

## 📁 **Arquivos Corrigidos**

### ✅ `.cursor/commands/product/task.md`
- Adicionado template hierárquico completo
- Documentação do parâmetro `parent`
- Aviso sobre create_bulk_tasks não suportar hierarquia

### ✅ `.cursor/commands/engineer/start.md`  
- Adicionado seção de correção hierárquica
- Template para subtasks em comandos engineer

## ⚠️ **Regras Importantes**

### **❌ NÃO FAZER:**
```javascript
// NUNCA usar create_bulk_tasks para hierarquia
create_bulk_tasks([
  { name: "Task Principal" },
  { name: "Subtask 1" },     // ← Não tem parent parameter
  { name: "Subtask 2" }      // ← Será task independente
]);
```

### **✅ FAZER:**
```javascript
// Sempre usar create_task individual com parent
const main = await create_task({ name: "Principal" });
const sub1 = await create_task({ name: "Sub 1", parent: main.id });
const sub2 = await create_task({ name: "Sub 2", parent: main.id });
```

## 🔍 **Validação da Hierarquia**

### **Como Verificar se Funcionou:**
```javascript
const taskWithSubs = await mcp_clickup_get_task({
  taskId: mainTaskId,
  subtasks: true
});

// ✅ Resultado esperado:
console.log(taskWithSubs.subtasks.length); // > 0
console.log(taskWithSubs.subtasks[0].parent); // mainTaskId
```

### **Na Interface ClickUp:**
- Task principal mostra subtasks aninhadas visualmente
- Subtasks aparecem indentadas abaixo da task principal
- Hierarchy está correta na visualização

## 📋 **Para Desenvolvedores Futuros**

### **Checklist ao Criar Tasks:**
- [ ] Task principal criada primeiro?
- [ ] Subtasks usam parâmetro `parent`?
- [ ] Evitando `create_bulk_tasks` para hierarquia?
- [ ] Testando com `subtasks: true` no get_task?

### **Pattern Recognition:**
```bash
# ✅ Padrão correto para implementações futuras
Main Task → get task.id → Subtasks with parent parameter
```

---

**🎯 Status**: ✅ **CORRIGIDO**  
**📅 Data**: 29/09/2025  
**🔧 Aplicado em**: product/task.md, engineer/start.md  
**🧪 Testado**: Aguardando próxima execução dos comandos
