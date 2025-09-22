# ClickUp MCP - Solução de Formatação Universal

## 🎯 **Templates Padrão para Comentários**

### **Template 1: Status Update**
```markdown
## 🔄 **Status Update: [TIPO]**

### ✅ **Concluído:**
- Item 1 finalizado
- Item 2 implementado

### 🔄 **Em Progresso:**
- Item em desenvolvimento
- Próximas etapas definidas

### 📋 **Próximos Passos:**
- [ ] Task 1
- [ ] Task 2

---
**⏰ Updated**: [TIMESTAMP]
```

### **Template 2: PR/Review Update**  
```markdown
## 🚀 **Pull Request Status**

### 📋 **Mudanças:**
- Feature X implementada
- Bug Y corrigido
- Documentation atualizada

### 🔗 **Links:**
- **PR**: [LINK]
- **Branch**: `[BRANCH_NAME]`

### ✅ **Status:**
- [x] Tests passando
- [x] Code review aprovado
- [x] Ready para merge

---
**🔗 Task movida para**: `[STATUS]` + tag `[TAG]`
```

### **Template 3: Technical Documentation**
```markdown
## 📚 **Technical Update**

### 🏗️ **Arquitetura:**
- Componente A modificado
- Integration B implementada

### 🔧 **Implementação:**
```typescript
// Code example se relevante
```

### 📊 **Métricas:**
| Metric | Before | After | Status |
|--------|--------|-------|--------|
| Performance | X | Y | ✅ |
| Coverage | A | B | ✅ |

---
**🎯 Impact**: [DESCRIPTION]
```

### **Template 4: Error/Issue Report**
```markdown
## 🚨 **Issue Report**

### ❌ **Problema Identificado:**
[DETAILED_DESCRIPTION]

### 🔍 **Root Cause:**
- Causa identificada: [CAUSE]
- Files afetados: [FILES]

### 🛠️ **Solução:**
- [x] Fix implementado
- [ ] Testing necessário
- [ ] Documentation update

### 📊 **Impact:**
- **Severity**: [HIGH/MEDIUM/LOW]
- **Users affected**: [NUMBER/DESCRIPTION]

---
**🔧 Status**: [RESOLVED/IN_PROGRESS/BLOCKED]
```

## 🔧 **Implementação: Comandos Específicos**

### **1. `/engineer/pr` - Correção**

**Problema atual**: Só muda status, não adiciona comentário formatado

**Solução**:
```typescript
// Adicionar após o update_task:
await create_task_comment(taskId, `
## 🚀 **Pull Request Created**

### 📋 **Changes Implemented:**
- [FEATURE_DESCRIPTION]
- Code review requested
- All tests passing

### 🔗 **Review Details:**
- **PR**: ${prLink}
- **Branch**: \`${branchName}\`
- **Status**: Ready for review

### ✅ **Checklist:**
- [x] Code committed
- [x] Tests passing  
- [x] Documentation updated
- [x] Task moved to "in progress"
- [x] Tag "under-review" added

---
**⏰ Created**: ${new Date().toISOString()}
`)
```

### **2. `/product/task` - Enhancement**

**Problema atual**: Não adiciona comentários automáticos na criação

**Solução**:
```typescript
// Após criar a task, adicionar:
await create_task_comment(taskId, `
## 📋 **Task Created via Product Command**

### 🎯 **Objective:**
${taskDescription}

### 🏗️ **Architecture Planned:**
- Components: [LIST_COMPONENTS]
- Libraries: [SUGGESTED_LIBRARIES]
- Integration points: [LIST_INTEGRATIONS]

### ✅ **Acceptance Criteria:**
- [ ] Functional requirements met
- [ ] Technical requirements implemented
- [ ] Testing completed
- [ ] Documentation updated

### 📊 **Estimation:**
- **Complexity**: [LOW/MEDIUM/HIGH]
- **Priority**: [PRIORITY_LEVEL]

---
**🎯 Ready for development assignment**
`)
```

### **3. Agentes Especializados - Guidelines**

**Para todos os 16 agentes**, estabelecer regra:

```typescript
// Sempre que um agente criar comentários:
const formatComment = (type: string, content: any) => {
  const templates = {
    progress: `## 🔄 **Development Progress**\n\n${content.details}\n\n---\n**⏰ Updated**: ${new Date().toLocaleString()}`,
    completion: `## ✅ **Task Completed**\n\n${content.summary}\n\n### 📊 **Results:**\n${content.metrics}\n\n---\n**🎉 Status**: Complete`,
    issue: `## 🚨 **Issue Reported**\n\n${content.problem}\n\n### 🛠️ **Next Steps:**\n${content.solution}\n\n---\n**🔧 Requires attention**`,
    technical: `## 📚 **Technical Documentation**\n\n${content.details}\n\n---\n**📖 Reference added**`
  }
  
  return templates[type] || `## 📝 **Update**\n\n${content}\n\n---\n**⏰ ${new Date().toLocaleString()}**`
}
```

## 🎨 **Style Guide Universal**

### **Elementos Obrigatórios:**
1. **Header com emoji**: `## 🎯 **Title**`
2. **Seções estruturadas**: `### ✅ **Section**`
3. **Lists formatadas**: `- [ ] Checkbox` ou `- ✅ Done item`
4. **Tables quando relevante**: Para métricas/comparações
5. **Footer separator**: `---` antes do timestamp/status
6. **Status final**: Sempre indicar próximos passos

### **Emojis Padrão:**
- 🎯 Objectives/Goals
- ✅ Completed items  
- 🔄 In progress
- 📋 Lists/Checklists
- 🚀 Releases/PRs
- 🛠️ Fixes/Solutions
- 🚨 Issues/Alerts
- 📚 Documentation
- 📊 Metrics/Data
- 🔗 Links/References
- ⏰ Timestamps

## 📁 **Arquivos para Atualização**

### **Priority 1 - Comandos Críticos:**
1. `.cursor/commands/engineer/pr.md` - Adicionar comentário formatado
2. `.cursor/commands/product/task.md` - Comments na criação
3. `.cursor/commands/engineer/start.md` - Progress tracking

### **Priority 2 - Agentes Core:**
1. `.cursor/agents/product-agent.md` - Guidelines de comentários
2. `.cursor/agents/development/clickup-specialist.md` - Exemplos de formatação
3. `.cursor/agents/python-developer.md` - Template integration
4. `.cursor/agents/react-developer.md` - Template integration

### **Priority 3 - Documentation:**
1. `docs/onion/clickup-integration.md` - Best practices
2. `.cursorrules` - Regras universais de formatação

## 🔧 **Implementation Checklist**

### **Immediate Actions:**
- [ ] Atualizar `/engineer/pr` com comment template
- [ ] Atualizar `/product/task` com progress tracking
- [ ] Testar formatação em task real
- [ ] Validar rendering markdown

### **System-wide Updates:**
- [ ] Guidelines para todos os agentes
- [ ] Template function utilitário
- [ ] Documentation atualizada
- [ ] Style guide distribuído

### **Quality Assurance:**
- [ ] Test formatting em diferentes cenários
- [ ] Validate consistency across agents
- [ ] User feedback on readability
- [ ] Performance impact analysis

---

## 🎯 **Expected Results**

Após implementação:
- ✅ **100% formatted comments** em todo ClickUp
- ✅ **Visual consistency** entre agentes e comandos
- ✅ **Professional appearance** em todas as tasks
- ✅ **Improved readability** para todo o time
- ✅ **Structured information** sempre presente
