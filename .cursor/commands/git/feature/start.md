# 🌿 Iniciar Feature - Criar Task ClickUp Backlog

Você é um assistente de IA especializado em **criar tasks de feature no ClickUp para planejamento** seguindo o padrão do Sistema Onion. Seu papel é criar tasks de backlog sem iniciar desenvolvimento imediato.

## 🎯 **Funcionalidades**

### **📋 Criar Task Backlog:**
- Criar task ClickUp com tag "backlog" 
- Status: "Backlog" (sem branch/sessão de desenvolvimento)
- Lista: Mesma lista da sessão atual ou lista padrão
- Auto-detecção de contexto e projeto

### **🔗 Integração Inteligente:**
- Auto-detecção da lista ClickUp atual
- Herda contexto da sessão ativa (se houver)
- Links com tasks relacionadas
- Tags apropriadas para categorização

---

## 🚀 **Uso do Comando**

### **Sintaxe:**
```bash
/git/feature/start "nome-ou-descrição-da-feature"
```

### **Examples:**
```bash
/git/feature/start "implementar-autenticacao-oauth"
/git/feature/start "adicionar-filtros-avancados-dashboard"  
/git/feature/start "integrar-payment-gateway-stripe"
```

---

## ⚙️ **Workflow Automático**

### **1. Validação de Parâmetros**
```bash
# Verificar se nome da feature foi fornecido
if [ "$#" -eq 0 ]; then
    echo "❌ ERROR: Feature name required"
    echo "📖 USAGE: /git/feature/start \"feature-name-or-description\""
    echo ""
    echo "💡 EXAMPLES:"
    echo "  /git/feature/start \"implement-oauth-authentication\""
    echo "  /git/feature/start \"add-advanced-dashboard-filters\""
    exit 1
fi

FEATURE_NAME="$1"
# Sanitizar nome da feature (remover caracteres especiais)
FEATURE_SLUG=$(echo "$FEATURE_NAME" | sed 's/[^a-zA-Z0-9]/-/g' | tr '[:upper:]' '[:lower:]' | sed 's/--*/-/g' | sed 's/^-\\|-$//g')

echo "🌿 Creating feature backlog task: $FEATURE_NAME"
echo "📝 Feature slug: $FEATURE_SLUG"
```

### **2. Detecção de Contexto ClickUp**
```bash
# Detectar lista ClickUp da sessão atual
function get_current_list_id() {
    # Tentar obter de sessão ativa
    if find .cursor/sessions -name "context.md" -type f 2>/dev/null | head -1 | xargs grep "ID ClickUp" 2>/dev/null; then
        CURRENT_TASK_ID=$(find .cursor/sessions -name "context.md" -type f 2>/dev/null | head -1 | xargs grep "ID ClickUp" | cut -d: -f2 | xargs)
        
        # Obter lista da task atual via ClickUp API
        if [ "$CURRENT_TASK_ID" != "" ]; then
            echo "🔍 Detecting list from current task: $CURRENT_TASK_ID"
            LIST_ID=$(curl -s -H "Authorization: Bearer $CLICKUP_TOKEN" \
                "https://api.clickup.com/api/v2/task/$CURRENT_TASK_ID" | \
                jq -r '.list.id' 2>/dev/null)
            
            if [ "$LIST_ID" != "" ] && [ "$LIST_ID" != "null" ]; then
                echo "$LIST_ID"
                return 0
            fi
        fi
    fi
    
    # Fallback: usar lista padrão "Desenvolvimento" se não conseguir detectar
    echo "901314121395"  # ID da lista Desenvolvimento
}

LIST_ID=$(get_current_list_id)
echo "📋 Target list ID: $LIST_ID"
```

### **3. Criação da Task ClickUp**
```bash
# Preparar dados da task
TASK_TITLE="🌿 $FEATURE_NAME"

# Descrição da task com contexto
TASK_DESCRIPTION="## 🎯 **Feature Backlog**

**Tipo**: Feature Development  
**Status**: Backlog - Aguardando desenvolvimento  
**Criada via**: /git/feature/start

---

## 📋 **Descrição**
$FEATURE_NAME

---

## 🔄 **Próximos Passos**

### **Para Iniciar Desenvolvimento:**
\`\`\`bash
# 1. Iniciar sessão de desenvolvimento
/engineer/start $FEATURE_SLUG

# 2. Ou usar comando específico quando implementado
/git/feature/develop $FEATURE_SLUG  
\`\`\`

### **Workflow Recomendado:**
1. **📋 Planejamento**: Task criada (atual)
2. **🛠️ Desenvolvimento**: /engineer/start $FEATURE_SLUG  
3. **🔄 Iteração**: /engineer/work
4. **✅ Finalização**: /git/feature/finish
5. **🚀 Deploy**: /engineer/pr + /git/sync

---

## 📊 **Critérios de Aceitação**
- [ ] Funcionalidade implementada conforme especificação
- [ ] Testes unitários criados
- [ ] Documentação atualizada
- [ ] Code review aprovado
- [ ] Deploy em ambiente de teste

---

## 🏷️ **Tags e Categorização**
- **Type**: feature
- **Status**: backlog  
- **Priority**: medium (ajustar conforme necessário)

**Criada automaticamente pelo Sistema Onion** 🧅"

# Criar task via ClickUp API
echo "🚀 Creating ClickUp task..."

RESPONSE=$(curl -s -X POST "https://api.clickup.com/api/v2/list/$LIST_ID/task" \
    -H "Authorization: Bearer $CLICKUP_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{
        \"name\": \"$TASK_TITLE\",
        \"markdown_description\": \"$TASK_DESCRIPTION\",
        \"status\": \"backlog\",
        \"priority\": 3,
        \"tags\": [\"feature\", \"backlog\", \"gitflow\"]
    }")

# Extrair ID da task criada
TASK_ID=$(echo "$RESPONSE" | jq -r '.id' 2>/dev/null)
```

### **4. Resultado e Links**
```bash
if [ "$TASK_ID" != "" ] && [ "$TASK_ID" != "null" ]; then
    TASK_URL="https://app.clickup.com/t/$TASK_ID"
    
    echo ""
    echo "✅ FEATURE BACKLOG TASK CREATED SUCCESSFULLY!"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "📋 TASK DETAILS:"
    echo "   ▶ Title: $TASK_TITLE"
    echo "   ▶ ID: $TASK_ID"
    echo "   ▶ Status: Backlog"
    echo "   ▶ URL: $TASK_URL"
    echo ""
    echo "🏷️  TAGS: feature, backlog, gitflow"
    echo "📝 DESCRIPTION: Auto-generated with development workflow"
    echo ""
    echo "🔄 NEXT STEPS:"
    echo "   ∟ Start development: /engineer/start $FEATURE_SLUG"
    echo "   ∟ View task: Open $TASK_URL"  
    echo "   ∟ Planning: Add details and acceptance criteria"
    echo ""
    echo "💡 WORKFLOW:"
    echo "   1. 📋 Backlog (current) → 2. 🛠️ Development → 3. ✅ Done"
    echo ""
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
    echo ""
    echo "🌟 Feature '$FEATURE_NAME' ready for development!"
    
    # Adicionar comentário inicial na task
    INITIAL_COMMENT="🌱 FEATURE BACKLOG CRIADA

━━━━━━━━━━━━━━━━━━━━━━━━

✅ TASK SETUP:
   ▶ Feature: $FEATURE_NAME
   ▶ Slug: $FEATURE_SLUG
   ▶ Status: Backlog
   ▶ Criada via: /git/feature/start

🎯 PRÓXIMA AÇÃO:
   ▶ Para iniciar: /engineer/start $FEATURE_SLUG
   ▶ Para planejar: Adicionar critérios de aceitação
   ▶ Para priorizar: Ajustar priority conforme roadmap

📋 WORKFLOW PADRÃO:
   ∟ Backlog → Development → Review → Done

━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Criada: $(date +'%Y-%m-%d %H:%M:%S') | 🧅 Sistema Onion"

    # Adicionar comentário (graceful degradation)
    curl -s -X POST "https://api.clickup.com/api/v2/task/$TASK_ID/comment" \
        -H "Authorization: Bearer $CLICKUP_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"comment_text\":\"$INITIAL_COMMENT\"}" > /dev/null || \
        echo "⚠️  Comment creation failed - task created successfully anyway"
        
else
    echo "❌ FAILED TO CREATE CLICKUP TASK"
    echo ""
    echo "💡 POSSIBLE CAUSES:"
    echo "   ∟ ClickUp API token not configured"
    echo "   ∟ Invalid list ID or permissions"  
    echo "   ∟ Network connectivity issues"
    echo ""
    echo "🔧 TROUBLESHOOTING:"
    echo "   ∟ Check CLICKUP_TOKEN environment variable"
    echo "   ∟ Verify list permissions and ID"
    echo "   ∟ Try manual task creation as fallback"
    echo ""
    echo "📖 MANUAL FALLBACK:"
    echo "   ∟ Create task manually: '$TASK_TITLE'"
    echo "   ∟ Add tags: feature, backlog, gitflow"
    echo "   ∟ Set status: Backlog"
    exit 1
fi
```

---

## 🔗 **Integração com Sistema Onion**

### **Diferença de Outros Comandos:**
- **`/git/feature/start`**: Cria task backlog (planejamento)
- **`/engineer/start`**: Inicia desenvolvimento (branch + sessão)
- **`/git/feature/finish`**: Finaliza desenvolvimento (merge)

### **Workflow Típico:**
```bash
1. /git/feature/start "nova-funcionalidade"    # Planejar
2. # ... tempo de planejamento ...
3. /engineer/start nova-funcionalidade         # Desenvolver  
4. /engineer/work                              # Iterar
5. /git/feature/finish                         # Finalizar
```

### **Quando Usar:**
- ✅ **Criar features para backlog** sem desenvolvimento imediato
- ✅ **Organizar roadmap** e priorização  
- ✅ **Capturar ideias** de features rapidamente
- ✅ **Setup inicial** de projetos com múltiplas features

### **Quando NÃO usar:**
- ❌ Desenvolvimento imediato (use `/engineer/start`)
- ❌ Hotfixes urgentes (use `/engineer/hotfix`)  
- ❌ Tasks já existem (use `/engineer/start task-slug`)

---

## ⚠️ **Tratamento de Erros**

### **Erro: Nome da feature não fornecido**
```
❌ ERROR: Feature name required
📖 USAGE: /git/feature/start "feature-name-or-description"
```

### **Erro: ClickUp API falhou**
```
❌ FAILED TO CREATE CLICKUP TASK
🔧 Check CLICKUP_TOKEN and permissions
📖 Create task manually as fallback
```

### **Erro: Lista não encontrada**
```
❌ ERROR: Unable to detect ClickUp list
💡 Run from active session or configure default list
```

---

## 💡 **Dicas de Uso**

### **✅ Boas Práticas:**
```bash
# Nomes descritivos e específicos
/git/feature/start "implement-oauth2-authentication-flow"

# Features modulares e focadas  
/git/feature/start "add-user-profile-avatar-upload"

# Include context quando útil
/git/feature/start "integrate-stripe-payment-gateway-checkout"
```

### **❌ Evitar:**
```bash
# Muito genérico
/git/feature/start "melhorias"

# Muito técnico/interno
/git/feature/start "refactor-class-x"

# Tasks que não são features
/git/feature/start "fix-bug-payment"  # Use /engineer/hotfix
```

---

**🌱 Criação rápida de features para backlog! Para iniciar desenvolvimento, use `/engineer/start [feature-slug]`.**
