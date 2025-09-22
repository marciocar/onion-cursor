# ClickUp Comment Formatter - Estrutura Correta para API

## 🎯 **Problema Descoberto**

ClickUp API **NÃO aceita markdown simples** em comentários. Precisa de estrutura JSON específica com `attributes`.

## ✅ **Formato Correto ClickUp API**

### **Estrutura Required:**
```json
{
  "comment": [
    {
      "text": "texto aqui",
      "attributes": {
        "bold": true,
        "italic": false,
        "code": false
      }
    }
  ]
}
```

## 🔧 **Templates Convertidos**

### **1. Status Update Template (ClickUp Format)**
```json
[
  {
    "text": "🔄 Status Update: ",
    "attributes": { "bold": true }
  },
  {
    "text": "[TITLE]",
    "attributes": { "bold": true }
  },
  {
    "text": "\n\n✅ Completed:\n",
    "attributes": { "bold": true }
  },
  {
    "text": "- [ITEM_1]\n- [ITEM_2]",
    "attributes": {}
  },
  {
    "text": "\n\n🔄 In Progress:\n",
    "attributes": { "bold": true }
  },
  {
    "text": "- [PROGRESS_ITEM]",
    "attributes": {}
  },
  {
    "text": "\n\n📋 Next Steps:\n",
    "attributes": { "bold": true }
  },
  {
    "text": "- [ ] [TASK_1]\n- [ ] [TASK_2]",
    "attributes": {}
  },
  {
    "text": "\n\n⏰ Updated: ",
    "attributes": { "bold": true }
  },
  {
    "text": "[TIMESTAMP]",
    "attributes": { "code": true }
  }
]
```

### **2. PR Template (ClickUp Format)**
```json
[
  {
    "text": "🚀 Pull Request Created",
    "attributes": { "bold": true }
  },
  {
    "text": "\n\n📋 Changes Implemented:\n",
    "attributes": { "bold": true }
  },
  {
    "text": "- [CHANGE_1]\n- [CHANGE_2]\n- All tests passing ✅",
    "attributes": {}
  },
  {
    "text": "\n\n🔗 Review Details:\n",
    "attributes": { "bold": true }
  },
  {
    "text": "PR: ",
    "attributes": { "bold": true }
  },
  {
    "text": "[PR_LINK]",
    "attributes": { "code": true }
  },
  {
    "text": "\nBranch: ",
    "attributes": { "bold": true }
  },
  {
    "text": "[BRANCH_NAME]",
    "attributes": { "code": true }
  },
  {
    "text": "\nStatus: Ready for review",
    "attributes": { "bold": true }
  },
  {
    "text": "\n\n✅ Checklist:\n",
    "attributes": { "bold": true }
  },
  {
    "text": "- [x] Code committed and pushed\n- [x] Tests passing\n- [x] Documentation updated\n- [x] Task status updated",
    "attributes": {}
  },
  {
    "text": "\n\n⏰ Created: ",
    "attributes": { "bold": true }
  },
  {
    "text": "[TIMESTAMP]",
    "attributes": { "code": true }
  }
]
```

### **3. Technical Documentation Template (ClickUp Format)**
```json
[
  {
    "text": "📚 Technical Documentation",
    "attributes": { "bold": true }
  },
  {
    "text": "\n\n🏗️ Architecture:\n",
    "attributes": { "bold": true }
  },
  {
    "text": "- [COMPONENT_CHANGES]\n- [INTEGRATION_DETAILS]",
    "attributes": {}
  },
  {
    "text": "\n\n🔧 Implementation:\n",
    "attributes": { "bold": true }
  },
  {
    "text": "[CODE_EXAMPLE]",
    "attributes": { "code": true }
  },
  {
    "text": "\n\n📊 Impact:\n",
    "attributes": { "bold": true }
  },
  {
    "text": "Metric 1: [OLD] → [NEW] ✅\nMetric 2: [OLD] → [NEW] 🔄",
    "attributes": {}
  },
  {
    "text": "\n\n📖 Reference: ",
    "attributes": { "bold": true }
  },
  {
    "text": "[DOCUMENTATION_LINK]",
    "attributes": { "code": true }
  }
]
```

## 🔧 **Helper Function para Conversão**

```javascript
function createClickUpComment(template, variables = {}) {
  // Replace placeholders with actual values
  let processedTemplate = JSON.parse(JSON.stringify(template));
  
  processedTemplate.forEach(segment => {
    Object.keys(variables).forEach(key => {
      segment.text = segment.text.replace(`[${key}]`, variables[key]);
    });
  });
  
  return processedTemplate;
}

// Usage example:
const prComment = createClickUpComment(PR_TEMPLATE, {
  CHANGE_1: "Feature X implemented",
  CHANGE_2: "Bug Y fixed", 
  PR_LINK: "https://github.com/repo/pull/123",
  BRANCH_NAME: "feature/new-feature",
  TIMESTAMP: new Date().toLocaleString()
});
```

## 📋 **Attributes Disponíveis**

### **Text Formatting:**
- `bold`: true/false
- `italic`: true/false
- `underline`: true/false
- `strikethrough`: true/false

### **Special Formatting:**
- `code`: true/false (inline code)
- `link`: { "url": "https://example.com" }

### **Headers (simulados com bold + size):**
- Para headers, use `bold: true` + emojis
- ClickUp não tem headers nativos em comments

## 🚀 **Implementação Requerida**

### **Atualizar comandos:**
1. `/engineer/pr` - Usar PR Template em formato ClickUp
2. `/product/task` - Usar Technical Template
3. Todos os agentes - Converter para estrutura attributes

### **MCP Function Call:**
```javascript
// Em vez de:
create_task_comment(taskId, "markdown string")

// Usar:
create_task_comment(taskId, clickupFormattedArray)
```

---

## ✅ **Esta é a solução definitiva para comentários formatados no ClickUp!**
