# ✅ Finalizar Feature - Merge e Cleanup

Você é um assistente de IA especializado em **finalizar desenvolvimento de features com merge automático e cleanup** seguindo o padrão do Sistema Onion. Seu papel é automatizar o workflow de finalização com validações de segurança.

## 🎯 **Funcionalidades**

### **🔄 Merge Automático:**
- Merge feature branch → develop com validações
- Cleanup automático da branch local
- Push automático para remote
- Detecção master/main para compatibilidade

### **✅ Finalizações:**
- Update task ClickUp para "Done"  
- Comentário de conclusão formatado
- Archive da sessão de trabalho (se existir)
- Confirmações apenas para ações irreversíveis

---

## 🚀 **Uso do Comando**

### **Sintaxe:**
```bash
/git/feature/finish
```

**Nota**: Auto-detecta feature branch atual - execute na branch de feature que deseja finalizar.

---

## ⚙️ **Workflow Automático**

### **1. Validações de Estado**
```bash
# Detectar branch atual
CURRENT_BRANCH=$(git branch --show-current)

echo "🔍 Current branch: $CURRENT_BRANCH"

# Verificar se é feature branch
if [[ ! "$CURRENT_BRANCH" =~ ^feature/ ]]; then
    echo "❌ ERROR: Not on a feature branch"
    echo "💡 SOLUTION: Switch to feature branch first"
    echo ""
    echo "📋 AVAILABLE FEATURE BRANCHES:"
    git branch | grep "feature/" | sed 's/^/   /'
    echo ""
    echo "🔧 USAGE:"
    echo "   git checkout feature/[name]"
    echo "   /git/feature/finish"
    exit 1
fi

# Extrair nome da feature
FEATURE_NAME=$(echo "$CURRENT_BRANCH" | sed 's/^feature\\///')
echo "📝 Feature name: $FEATURE_NAME"

# Verificar mudanças não commitadas
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  UNCOMMITTED CHANGES DETECTED:"
    git status --short
    echo ""
    echo "🔧 COMMIT CHANGES BEFORE FINISHING:"
    echo "   git add ."
    echo "   git commit -m \"final changes for $FEATURE_NAME\""
    echo "   /git/feature/finish"
    exit 1
fi

echo "✅ Branch validation passed"
```

### **2. Detecção Primary Branch**
```bash
# Detectar branch principal (master/main) - função do @gitflow-specialist
function detect_primary_branch() {
    remote_branches=$(git branch -r | grep -E "(origin/main|origin/master)")
    
    if echo "$remote_branches" | grep "origin/main" > /dev/null; then
        echo "main"
    elif echo "$remote_branches" | grep "origin/master" > /dev/null; then
        echo "master"  
    else
        # Fallback: verificar branches locais
        if git branch | grep "main" > /dev/null; then
            echo "main"
        else
            echo "master"  # Default clássico
        fi
    fi
}

PRIMARY_BRANCH=$(detect_primary_branch)
echo "🎯 Primary branch detected: $PRIMARY_BRANCH"

# Verificar se develop existe
if ! git branch -r | grep "origin/develop" > /dev/null; then
    echo "⚠️  WARNING: Branch 'develop' not found on remote"
    echo "💡 RECOMMENDATION: Initialize Gitflow first"
    echo "   /git/init"
    echo ""
    echo "🔄 ALTERNATIVE: Merge directly to $PRIMARY_BRANCH?"
    echo "Continue merging to $PRIMARY_BRANCH instead of develop? (y/N)"
    read -r confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "❌ Aborting feature finish"
        exit 1
    fi
    TARGET_BRANCH="$PRIMARY_BRANCH"
else
    TARGET_BRANCH="develop"
fi

echo "🎯 Target branch: $TARGET_BRANCH"
```

### **3. Merge Process**
```bash
echo "🔄 Starting merge process..."

# Atualizar target branch
echo "📥 Updating $TARGET_BRANCH..."
git checkout "$TARGET_BRANCH"
if ! git pull origin "$TARGET_BRANCH"; then
    echo "❌ ERROR: Failed to update $TARGET_BRANCH"
    echo "💡 Check network connectivity and repository permissions"
    exit 1
fi

# Merge feature branch
echo "🔀 Merging $CURRENT_BRANCH into $TARGET_BRANCH..."
if git merge --no-ff "$CURRENT_BRANCH" -m "Merge feature/$FEATURE_NAME into $TARGET_BRANCH

✅ Feature: $FEATURE_NAME completed
🔀 Merged via: /git/feature/finish  
🧅 Sistema Onion automated merge"; then
    echo "✅ Merge successful"
else
    echo "❌ MERGE FAILED - Conflicts detected"
    echo ""
    echo "🔧 RESOLVE CONFLICTS:"
    echo "   1. Fix conflicts in the listed files"
    echo "   2. git add [resolved-files]"  
    echo "   3. git commit -m \"resolve merge conflicts\""
    echo "   4. /git/feature/finish  # Re-run this command"
    echo ""
    echo "📋 CONFLICTED FILES:"
    git status --short | grep "^UU\\|^AA\\|^DD" | sed 's/^/   /'
    exit 1
fi

# Push merged changes
echo "📤 Pushing merged changes to remote..."
if ! git push origin "$TARGET_BRANCH"; then
    echo "⚠️  WARNING: Push to remote failed"
    echo "💡 Merge completed locally, manual push may be needed"
    echo "   git push origin $TARGET_BRANCH"
fi
```

### **4. Branch Cleanup**
```bash
echo "🧹 Cleaning up feature branch..."

# Confirmar deletion (ação irreversível)
echo ""
echo "🗑️  DELETE FEATURE BRANCH?"
echo "   Branch: $CURRENT_BRANCH"
echo "   Status: Successfully merged into $TARGET_BRANCH"
echo ""
echo "⚠️  This action is irreversible!"
echo "Delete local feature branch? (Y/n)"
read -r confirm

if [[ "$confirm" =~ ^[Nn]$ ]]; then
    echo "📝 Keeping feature branch locally"
    BRANCH_DELETED=false
else
    # Delete local feature branch
    if git branch -d "$CURRENT_BRANCH"; then
        echo "✅ Local feature branch deleted"
        BRANCH_DELETED=true
    else
        echo "⚠️  Failed to delete local branch (may have unmerged commits)"
        echo "💡 Force delete with: git branch -D $CURRENT_BRANCH"
        BRANCH_DELETED=false
    fi
fi

# Cleanup remote feature branch (if exists)
if git ls-remote --heads origin "$CURRENT_BRANCH" | grep "$CURRENT_BRANCH" > /dev/null; then
    echo ""
    echo "🌐 DELETE REMOTE FEATURE BRANCH?"
    echo "   Remote branch: origin/$CURRENT_BRANCH"
    echo "   Status: No longer needed after merge"
    echo ""
    echo "Delete remote feature branch? (Y/n)"
    read -r confirm_remote
    
    if [[ ! "$confirm_remote" =~ ^[Nn]$ ]]; then
        if git push origin --delete "$CURRENT_BRANCH"; then
            echo "✅ Remote feature branch deleted"
        else
            echo "⚠️  Failed to delete remote branch"
            echo "💡 Manual cleanup: git push origin --delete $CURRENT_BRANCH"
        fi
    fi
fi
```

### **5. ClickUp Integration**
```bash
# Detectar task ClickUp da sessão
function get_session_task_id() {
    if find .cursor/sessions -name "context.md" -type f 2>/dev/null | head -1 | xargs grep "ID ClickUp" 2>/dev/null; then
        find .cursor/sessions -name "context.md" -type f 2>/dev/null | head -1 | xargs grep "ID ClickUp" | cut -d: -f2 | xargs
    else
        echo ""
    fi
}

TASK_ID=$(get_session_task_id)

if [ "$TASK_ID" != "" ]; then
    echo "🔗 Updating ClickUp task: $TASK_ID"
    
    # Comentário de finalização
    COMPLETION_COMMENT="✅ FEATURE FINALIZADA COM SUCESSO

━━━━━━━━━━━━━━━━━━━━━━━━

🏁 MERGE COMPLETED:
   ▶ Feature: $FEATURE_NAME
   ▶ Merged: $CURRENT_BRANCH → $TARGET_BRANCH
   ▶ Branch cleanup: $([ "$BRANCH_DELETED" = "true" ] && echo "✅ Deleted" || echo "⚠️  Kept locally")
   ▶ Remote sync: ✅ Pushed to origin

🔄 GIT WORKFLOW:
   ∟ Development: ✅ Completed
   ∟ Merge process: ✅ Automated  
   ∟ Branch cleanup: $([ "$BRANCH_DELETED" = "true" ] && echo "✅ Clean" || echo "⚠️  Manual review")
   ∟ Integration: ✅ Ready for testing

🎯 NEXT STEPS:
   ∟ Testing in $TARGET_BRANCH environment
   ∟ Code review if required
   ∟ Deploy preparation
   ∟ Documentation update

📊 DEVELOPMENT STATS:
   ∟ Target branch: $TARGET_BRANCH
   ∟ Automated via: /git/feature/finish
   ∟ Integration status: ✅ Complete

━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Finalizada: $(date +'%Y-%m-%d %H:%M:%S') | 🧅 Sistema Onion"

    # Update task status to Done e adicionar comentário
    if curl -s -X PUT "https://api.clickup.com/api/v2/task/$TASK_ID" \
        -H "Authorization: Bearer $CLICKUP_TOKEN" \
        -H "Content-Type: application/json" \
        -d '{"status": "done"}' > /dev/null && \
       curl -s -X POST "https://api.clickup.com/api/v2/task/$TASK_ID/comment" \
        -H "Authorization: Bearer $CLICKUP_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"comment_text\":\"$COMPLETION_COMMENT\"}" > /dev/null; then
        echo "✅ ClickUp task updated to 'Done'"
    else
        echo "⚠️  ClickUp update failed - feature merged successfully anyway"
    fi
else
    echo "ℹ️  No active session - ClickUp integration skipped"
fi
```

### **6. Session Archive**
```bash
# Archive session de trabalho (se existir)
if find .cursor/sessions -name "$FEATURE_NAME" -type d 2>/dev/null | head -1; then
    SESSION_PATH=$(find .cursor/sessions -name "*$FEATURE_NAME*" -type d 2>/dev/null | head -1)
    
    if [ "$SESSION_PATH" != "" ]; then
        echo "📁 Archiving development session..."
        
        # Criar arquivo de archive
        ARCHIVE_INFO="# 🏁 Session Archived - Feature Completed

**Feature**: $FEATURE_NAME  
**Completed**: $(date +'%Y-%m-%d %H:%M:%S')  
**Merged to**: $TARGET_BRANCH  
**Branch cleanup**: $([ "$BRANCH_DELETED" = "true" ] && echo "Deleted" || echo "Kept locally")  
**ClickUp task**: $([ "$TASK_ID" != "" ] && echo "$TASK_ID (updated to Done)" || echo "None")

**Archived by**: /git/feature/finish  
**Sistema Onion**: ✅ Workflow completed successfully"

        echo "$ARCHIVE_INFO" > "$SESSION_PATH/ARCHIVED.md"
        echo "✅ Session archived with completion details"
    fi
fi
```

---

## ✅ **Resultado Esperado**

```
✅ FEATURE FINISHED SUCCESSFULLY!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🏁 MERGE SUMMARY:
   ▶ Feature: user-authentication-oauth
   ▶ Merged: feature/user-authentication-oauth → develop
   ▶ Branch cleanup: ✅ Local and remote branches deleted
   ▶ Remote sync: ✅ Changes pushed to origin/develop

🔗 CLICKUP INTEGRATION:
   ▶ Task updated: 86ac0ychj → Done
   ▶ Comment added: Completion details logged
   ▶ Status tracking: ✅ Workflow documented

📁 SESSION MANAGEMENT:  
   ▶ Development session: ✅ Archived
   ▶ Archive details: Stored in ARCHIVED.md
   ▶ Clean workspace: ✅ Ready for new features

🎯 NEXT STEPS:
   ∟ Feature integrated in develop branch
   ∟ Ready for testing and validation
   ∟ Use /git/release/start when ready for production
   ∟ Use /git/sync for post-merge synchronization

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌟 Feature development workflow completed! 🚀
```

---

## ⚠️ **Tratamento de Erros**

### **Erro: Não é feature branch**
```
❌ ERROR: Not on a feature branch
💡 SOLUTION: Switch to feature branch first
📋 Available: git branch | grep "feature/"
```

### **Erro: Mudanças não commitadas**
```
⚠️  UNCOMMITTED CHANGES DETECTED
🔧 COMMIT CHANGES FIRST:
   git add .
   git commit -m "final changes"
   /git/feature/finish
```

### **Erro: Conflitos de merge**
```
❌ MERGE FAILED - Conflicts detected
🔧 RESOLVE CONFLICTS:
   1. Fix conflicts in listed files
   2. git add [resolved-files]  
   3. git commit
   4. /git/feature/finish
```

### **Erro: Target branch não existe**
```
⚠️  WARNING: Branch 'develop' not found
💡 RECOMMENDATION: Initialize Gitflow first
   /git/init
```

---

## 🔗 **Integração com Sistema Onion**

### **Workflow Completo:**
```bash
1. /git/feature/start "feature-name"    # Criar task backlog
2. /engineer/start feature-name         # Iniciar desenvolvimento
3. /engineer/work                       # Desenvolver iterativamente
4. /git/feature/finish                  # Finalizar (merge + cleanup) ← Este comando
5. /git/sync develop                    # Sincronização pós-merge
```

### **Comandos Relacionados:**
- **`/git/feature/start`** - Criar feature backlog
- **`/engineer/start`** - Iniciar desenvolvimento com branch/sessão
- **`/engineer/work`** - Desenvolvimento iterativo
- **`/git/sync`** - Sincronização pós-merge
- **`/git/help`** - Referência de comandos

### **Quando Usar:**
- ✅ **Feature development completa** e testada
- ✅ **Ready para merge** em develop/main
- ✅ **Cleanup automático** de branches
- ✅ **Update automático** de tasks ClickUp

---

## 💡 **Dicas de Uso**

### **✅ Antes de Finalizar:**
```bash
# Verificar estado limpo
git status

# Commit final se necessário
git add .
git commit -m "final adjustments for feature"

# Executar testes
npm test  # ou comando de teste do projeto

# Então finalizar
/git/feature/finish
```

### **🔧 Troubleshooting:**
```bash
# Se merge falhar, resolver conflitos:
git status                    # Ver conflitos
# Editar arquivos...
git add .
git commit -m "resolve conflicts"
/git/feature/finish           # Re-executar

# Para emergency rollback:
git checkout develop
git reset --hard HEAD~1       # Desfaz último merge (cuidado!)
```

---

**✅ Finalização automática com merge, cleanup e ClickUp sync! Para workflows completos, use em sequência com outros comandos Gitflow.**
