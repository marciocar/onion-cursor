# ClickUp MCP - Correção de Formatação Sistemática

## 🚨 **Problema Identificado**

Os comandos e agentes do Sistema Onion estão criando comentários no ClickUp **sem formatação markdown**, resultando em:
- Perda de legibilidade
- Falta de profissionalismo
- Inconsistência visual
- Informações mal estruturadas

## 🔍 **Root Cause Analysis**

### **Problema Técnico:**
1. **Comments sem formatação**: `create_task_comment` recebe texto puro
2. **Falta de template**: Não há padrão para formatação
3. **Inconsistência**: Cada agente/comando usa formato diferente
4. **Interface vs MCP**: Description funciona, comments não

### **Arquivos Afetados:**
- `.cursor/commands/engineer/pr.md` - Move status sem comentário formatado
- `.cursor/commands/product/task.md` - Cria tasks sem comentários estruturados  
- Todos os 16 agentes especializados - Podem criar comentários sem formatação
- Comandos automáticos - Updates sem contexto visual

## 🎯 **Objective**

Criar **sistema universal** para garantir que:
- ✅ Todos os comentários ClickUp usem formatação markdown
- ✅ Template padrão para diferentes tipos de comentários
- ✅ Consistência visual em todo o Sistema Onion
- ✅ Informações bem estruturadas e legíveis

## 🛠️ **Solution Strategy**

### **1. Template System**
Criar templates para diferentes tipos de comentários:
- Status updates (PR, completions)
- Progress reports (work updates)
- Technical documentation (architecture, decisions)
- Error reporting (issues, blockers)

### **2. Comando Updates**
Atualizar comandos críticos:
- `/engineer/pr` - Adicionar comentário formatado
- `/product/task` - Comments automáticos na criação
- `/engineer/start` - Context e progress tracking

### **3. Agent Guidelines**
Estabelecer regras para todos os agentes:
- Sempre usar markdown em comentários
- Seguir templates estabelecidos
- Incluir emojis e estrutura visual
- Manter consistência de formato

### **4. Quality Assurance**
- Validar formatação em todos os updates
- Criar exemplos de reference
- Documentar best practices
