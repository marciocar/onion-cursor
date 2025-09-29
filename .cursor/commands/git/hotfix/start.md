# 🔥 Iniciar Hotfix - Emergency Fix

Você é um assistente de IA especializado em **iniciar hotfixes emergenciais** seguindo o padrão do Sistema Onion. Seu papel é automatizar workflow crítico de hotfix com validações de segurança e tracking urgente.

## 🎯 **Funcionalidades**

### **⚡ Hotfix Emergencial:**
- Criar hotfix branch a partir de main/master (produção)
- Auto-versioning para patch releases emergenciais  
- Task ClickUp urgente com prioridade máxima
- Validações críticas de estado de produção
- Setup rápido para correção imediata

### **🚨 Criticidade e Tracking:**
- Tags de urgência automáticas
- Notificações escaladas no ClickUp
- Rollback preparation automática
- Documentation de emergency changes

---

## 🚀 **Uso do Comando**

### **Sintaxe:**
```bash
/git/hotfix/start "hotfix-name"
```

### **Examples:**
```bash
/git/hotfix/start "fix-payment-gateway"
/git/hotfix/start "security-patch-auth"  
/git/hotfix/start "critical-memory-leak"
/git/hotfix/start "api-timeout-fix"
```

---

## ⚙️ **Workflow Automático**

### **1. Validações Críticas**
```bash
# Verificar se nome do hotfix foi fornecido
if [ "$#" -eq 0 ]; then
    echo "🔥 ERROR: Hotfix name required for emergency fix"
    echo "📖 USAGE: /git/hotfix/start \"hotfix-description\""
    echo ""
    echo "💡 EXAMPLES:"
    echo "  /git/hotfix/start \"fix-payment-gateway\""
    echo "  /git/hotfix/start \"security-patch-auth\""
    echo "  /git/hotfix/start \"critical-memory-leak\""
    exit 1
fi

HOTFIX_NAME="$1"
# Sanitizar nome do hotfix
HOTFIX_SLUG=$(echo "$HOTFIX_NAME" | sed 's/[^a-zA-Z0-9]/-/g' | tr '[:upper:]' '[:lower:]' | sed 's/--*/-/g' | sed 's/^-\\|-$//g')

echo "🔥 EMERGENCY HOTFIX STARTING: $HOTFIX_NAME"
echo "📝 Hotfix slug: $HOTFIX_SLUG"
echo "⚠️  CRITICAL FIX IN PROGRESS..."

# Verificar se é repositório git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ ERROR: Not a git repository"
    echo "💡 Emergency setup needed: git init && /git/init"
    exit 1
fi

# Verificar mudanças não commitadas
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  UNCOMMITTED CHANGES DETECTED - EMERGENCY OVERRIDE"
    git status --short
    echo ""
    echo "🚨 EMERGENCY: Save current work before hotfix?"
    echo "Stash changes and continue with hotfix? (Y/n)"
    read -r confirm
    if [[ "$confirm" =~ ^[Nn]$ ]]; then
        echo "❌ Aborting hotfix - commit changes first"
        echo "💡 Quick save: git add . && git commit -m \"WIP: save before hotfix\""
        exit 1
    else
        git add .
        git commit -m "WIP: emergency save before hotfix $HOTFIX_NAME"
        echo "✅ Changes saved automatically"
    fi
fi

echo "✅ Emergency validation passed"
```

### **2. Detecção Primary Branch**
```bash
# Detectar branch principal (master/main) - CRÍTICO para hotfix
function detect_primary_branch() {
    remote_branches=$(git branch -r | grep -E "(origin/main|origin/master)")
    
    if echo "$remote_branches" | grep "origin/main" > /dev/null; then
        echo "main"
    elif echo "$remote_branches" | grep "origin/master" > /dev/null; then
        echo "master"  
    else
        if git branch | grep "main" > /dev/null; then
            echo "main"
        else
            echo "master"
        fi
    fi
}

PRIMARY_BRANCH=$(detect_primary_branch)
echo "🎯 Production branch detected: $PRIMARY_BRANCH"

# CRÍTICO: Atualizar branch de produção
echo "📥 CRITICAL: Updating production branch $PRIMARY_BRANCH..."
git checkout "$PRIMARY_BRANCH"
if ! git pull origin "$PRIMARY_BRANCH"; then
    echo "❌ CRITICAL ERROR: Failed to update production branch"
    echo "🚨 EMERGENCY: Cannot proceed without latest production code"
    echo "💡 Check network connectivity and resolve conflicts immediately"
    exit 1
fi

echo "✅ Production branch updated successfully"
```

### **3. Version Detection para Patch**
```bash
# Detectar versão atual de produção
function detect_current_version() {
    # Procurar por package.json
    if [ -f "package.json" ] && grep -q "version" package.json; then
        grep '"version"' package.json | sed 's/.*"version": *"\\([^"]*\\)".*/\\1/' | head -1
    # Procurar última tag de versão
    elif git describe --tags --abbrev=0 2>/dev/null; then
        git describe --tags --abbrev=0 | sed 's/^v//'
    # Procurar por version files
    elif [ -f "version.txt" ]; then
        cat version.txt | head -1
    elif [ -f "VERSION" ]; then
        cat VERSION | head -1
    else
        echo "0.0.1"  # Emergency default
    fi
}

CURRENT_VERSION=$(detect_current_version)
echo "📋 Production version detected: $CURRENT_VERSION"

# Auto-calcular próxima versão patch para hotfix
HOTFIX_VERSION=$(echo "$CURRENT_VERSION" | awk -F. '{print $1"."$2"."($3+1)}')
echo "🔥 Hotfix version calculated: $HOTFIX_VERSION"
echo "🚨 EMERGENCY PATCH: $CURRENT_VERSION → $HOTFIX_VERSION"
```

### **4. Verificações de Conflito**
```bash
# Verificar se hotfix branch já existe
HOTFIX_BRANCH="hotfix/$HOTFIX_SLUG"
if git branch -a | grep -E "(^|\\s+)$HOTFIX_BRANCH(\\s+|$)" > /dev/null; then
    echo "❌ CRITICAL: Hotfix branch '$HOTFIX_BRANCH' already exists"
    echo "🚨 EMERGENCY CONFLICT - Multiple hotfixes in progress?"
    echo ""
    echo "📋 EXISTING HOTFIX BRANCHES:"
    git branch -a | grep "hotfix/" | sed 's/^/   /'
    echo ""
    echo "💡 EMERGENCY OPTIONS:"
    echo "   1. Switch to existing: git checkout $HOTFIX_BRANCH"
    echo "   2. Delete and recreate: git branch -D $HOTFIX_BRANCH"
    echo "   3. Use different name: /git/hotfix/start \"$HOTFIX_NAME-v2\""
    exit 1
fi

# Verificar se tag de versão já existe  
if git tag | grep -E "^v?$HOTFIX_VERSION$" > /dev/null; then
    echo "⚠️  WARNING: Tag for version $HOTFIX_VERSION already exists"
    echo "🔄 Auto-incrementing patch version..."
    HOTFIX_VERSION=$(echo "$HOTFIX_VERSION" | awk -F. '{print $1"."$2"."($3+1)}')
    echo "🎯 New hotfix version: $HOTFIX_VERSION"
fi

echo "✅ Emergency conflict validation passed"
```

### **5. Criação da Hotfix Branch**
```bash
echo "🔥 CREATING EMERGENCY HOTFIX BRANCH: $HOTFIX_BRANCH"

# Criar hotfix branch a partir de produção
if git checkout -b "$HOTFIX_BRANCH"; then
    echo "✅ Emergency hotfix branch created successfully"
else
    echo "❌ CRITICAL ERROR: Failed to create hotfix branch"
    echo "🚨 EMERGENCY ABORT - Manual intervention required"
    exit 1
fi

# Push branch para remote IMEDIATAMENTE (backup crítico)
echo "📤 CRITICAL: Backing up hotfix branch to remote..."
if git push origin "$HOTFIX_BRANCH"; then
    echo "✅ Emergency branch backed up to remote"
    git branch --set-upstream-to=origin/"$HOTFIX_BRANCH" "$HOTFIX_BRANCH"
else
    echo "⚠️  WARNING: Remote backup failed - continuing locally"
    echo "💡 Manual backup recommended: git push origin $HOTFIX_BRANCH"
fi
```

### **6. Version File Updates**
```bash
echo "📝 EMERGENCY: Updating version files..."

# Atualizar package.json
if [ -f "package.json" ] && grep -q "version" package.json; then
    echo "📦 Emergency updating package.json..."
    sed -i "s/\\\"version\\\": *\\\"[^\\\"]*\\\"/\\\"version\\\": \\\"$HOTFIX_VERSION\\\"/" package.json
    echo "✅ package.json updated to $HOTFIX_VERSION"
fi

# Atualizar outros version files
if [ -f "version.txt" ]; then
    echo "$HOTFIX_VERSION" > version.txt
    echo "✅ version.txt updated"
fi

if [ -f "VERSION" ]; then
    echo "$HOTFIX_VERSION" > VERSION
    echo "✅ VERSION file updated"
fi

# Commit das mudanças de versioning
if [ -n "$(git status --porcelain)" ]; then
    echo "💾 EMERGENCY: Committing version updates..."
    git add .
    git commit -m "🔥 HOTFIX: prepare version $HOTFIX_VERSION for emergency fix

🚨 EMERGENCY HOTFIX: $HOTFIX_NAME
🎯 Version: $CURRENT_VERSION → $HOTFIX_VERSION  
🔥 Branch: $HOTFIX_BRANCH
🏭 Base: $PRIMARY_BRANCH (production)

⚠️  CRITICAL FIX IN PROGRESS
📋 Description: $HOTFIX_NAME

Via: /git/hotfix/start"
    echo "✅ Version changes committed"
fi
```

### **7. ClickUp Emergency Task**
```bash
echo "🚨 CREATING EMERGENCY CLICKUP TASK..."

# Detectar lista ClickUp da sessão ou usar default
function get_list_for_hotfix() {
    # Tentar obter de sessão ativa
    if find .cursor/sessions -name "context.md" -type f 2>/dev/null | head -1 | xargs grep "ID ClickUp" 2>/dev/null; then
        CURRENT_TASK_ID=$(find .cursor/sessions -name "context.md" -type f 2>/dev/null | head -1 | xargs grep "ID ClickUp" | cut -d: -f2 | xargs)
        
        if [ "$CURRENT_TASK_ID" != "" ]; then
            LIST_ID=$(curl -s -H "Authorization: Bearer $CLICKUP_TOKEN" \
                "https://api.clickup.com/api/v2/task/$CURRENT_TASK_ID" | \
                jq -r '.list.id' 2>/dev/null)
            
            if [ "$LIST_ID" != "" ] && [ "$LIST_ID" != "null" ]; then
                echo "$LIST_ID"
                return 0
            fi
        fi
    fi
    
    # Default: Lista Desenvolvimento  
    echo "901314121395"
}

LIST_ID=$(get_list_for_hotfix)

# Preparar task emergencial
HOTFIX_TASK_TITLE="🔥 EMERGENCY HOTFIX: $HOTFIX_NAME"

HOTFIX_DESCRIPTION="## 🚨 **EMERGENCY HOTFIX**

**🔥 CRITICAL FIX**: $HOTFIX_NAME  
**Version**: $HOTFIX_VERSION  
**Branch**: $HOTFIX_BRANCH  
**Base**: $PRIMARY_BRANCH (production)  
**Created**: $(date +'%Y-%m-%d %H:%M:%S')  

---

## ⚠️ **EMERGENCY STATUS**

### **🚨 CRITICAL PRIORITY:**
- **Impact**: Production system affected
- **Urgency**: Immediate fix required
- **Timeline**: ASAP resolution needed
- **Escalation**: Auto-escalated to high priority

### **🔧 HOTFIX PROCESS:**
- [x] Emergency branch created from production
- [x] Version bumped to $HOTFIX_VERSION  
- [x] Emergency task created with max priority
- [ ] Critical fix implemented
- [ ] Emergency testing completed
- [ ] Production deployment approved

---

## 🎯 **FIX REQUIREMENTS**

### **🔥 Critical Tasks:**
- [ ] Identify root cause of issue
- [ ] Implement minimal viable fix
- [ ] Test fix in hotfix branch
- [ ] Validate no regression introduced
- [ ] Prepare emergency deployment

### **✅ Acceptance Criteria:**
- [ ] Issue completely resolved
- [ ] No new issues introduced
- [ ] Emergency tests passing
- [ ] Production ready for immediate deploy

---

## 🚀 **DEPLOYMENT WORKFLOW**

### **Emergency Finish Process:**
\`\`\`bash
# After implementing fix:
/git/hotfix/finish

# This will:
# 1. Merge hotfix → $PRIMARY_BRANCH (production)
# 2. Merge hotfix → develop (if exists)  
# 3. Create emergency tag v$HOTFIX_VERSION
# 4. Trigger deployment pipeline
# 5. Enable immediate rollback if needed
\`\`\`

---

## 📊 **EMERGENCY METRICS**
- **Start Time**: $(date +'%d/%m/%Y %H:%M')
- **SLA Target**: < 2 hours resolution
- **Rollback Available**: Previous version tagged
- **Monitor**: Enable critical alerts

---

## 🔄 **ROLLBACK PLAN**
- **Previous Version**: $CURRENT_VERSION
- **Rollback Command**: git checkout $PRIMARY_BRANCH && git reset --hard [previous-tag]
- **Database Changes**: Document if any schema changes
- **Dependencies**: Check for breaking changes

**🚨 Created by Sistema Onion Emergency Workflow** 🧅"

# Criar task emergencial com máxima prioridade
echo "🔥 Creating emergency ClickUp task..."

RESPONSE=$(curl -s -X POST "https://api.clickup.com/api/v2/list/$LIST_ID/task" \
    -H "Authorization: Bearer $CLICKUP_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{
        \"name\": \"$HOTFIX_TASK_TITLE\",
        \"markdown_description\": \"$HOTFIX_DESCRIPTION\",
        \"status\": \"in progress\",
        \"priority\": 1,
        \"tags\": [\"hotfix\", \"emergency\", \"critical\", \"production\", \"$HOTFIX_VERSION\"]
    }")

HOTFIX_TASK_ID=$(echo "$RESPONSE" | jq -r '.id' 2>/dev/null)

if [ "$HOTFIX_TASK_ID" != "" ] && [ "$HOTFIX_TASK_ID" != "null" ]; then
    HOTFIX_URL="https://app.clickup.com/t/$HOTFIX_TASK_ID"
    echo "✅ Emergency ClickUp task created: $HOTFIX_TASK_ID"
    echo "🔗 URL: $HOTFIX_URL"
    
    # Adicionar comentário inicial urgente
    EMERGENCY_COMMENT="🚨 EMERGENCY HOTFIX INICIADO

━━━━━━━━━━━━━━━━━━━━━━━━

🔥 HOTFIX SETUP COMPLETO:
   ▶ Emergency: $HOTFIX_NAME
   ▶ Version: $CURRENT_VERSION → $HOTFIX_VERSION
   ▶ Branch: $HOTFIX_BRANCH  
   ▶ Base: $PRIMARY_BRANCH (production)

🚨 CRITICALITY LEVEL: MAXIMUM
   ∟ Priority: 1 (Urgent)
   ∟ Tags: emergency, critical, production
   ∟ Auto-escalated: High priority workflow

⚡ NEXT ACTIONS:
   ∟ Implement critical fix immediately
   ∟ Test in $HOTFIX_BRANCH branch
   ∟ Execute /git/hotfix/finish when ready
   ∟ Monitor production deployment

━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Started: $(date +'%Y-%m-%d %H:%M:%S') | 🔥 Emergency Active"

    curl -s -X POST "https://api.clickup.com/api/v2/task/$HOTFIX_TASK_ID/comment" \
        -H "Authorization: Bearer $CLICKUP_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"comment_text\":\"$EMERGENCY_COMMENT\"}" > /dev/null || true
        
    echo "✅ Emergency comment added"
else
    echo "⚠️  ClickUp task creation failed - emergency continues"
    echo "💡 Manual task creation recommended for tracking"
fi
```

---

## ✅ **Resultado Esperado**

```
🔥 EMERGENCY HOTFIX STARTED SUCCESSFULLY!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚨 EMERGENCY STATUS:
   ▶ Hotfix: fix-payment-gateway
   ▶ Version: 2.1.0 → 2.1.1 (emergency patch)
   ▶ Branch: hotfix/fix-payment-gateway
   ▶ Base: main (production - updated)

📝 EMERGENCY SETUP:
   ▶ Version files: ✅ Updated to 2.1.1
   ▶ Emergency branch: ✅ Created and backed up
   ▶ Production base: ✅ Latest code pulled
   ▶ Conflict validation: ✅ Passed

🔗 CLICKUP EMERGENCY TASK:
   ▶ Task: 🔥 EMERGENCY HOTFIX: fix-payment-gateway  
   ▶ URL: https://app.clickup.com/t/abc123
   ▶ Priority: 1 (Urgent)
   ▶ Status: In Progress
   ▶ Tags: emergency, critical, production

⚡ READY FOR IMMEDIATE FIX:
   ∟ Current branch: hotfix/fix-payment-gateway
   ∟ Implement fix in this branch immediately
   ∟ Test critical functionality
   ∟ Execute /git/hotfix/finish when ready

🚨 EMERGENCY TIMELINE:
   ∟ Target resolution: < 2 hours
   ∟ Rollback available: v2.1.0
   ∟ Monitor: Critical alerts enabled

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔥 EMERGENCY HOTFIX ACTIVE - FIX IMMEDIATELY! 🚨
```

---

## ⚠️ **Tratamento de Erros**

### **Erro: Nome do hotfix não fornecido**
```
🔥 ERROR: Hotfix name required for emergency fix
📖 USAGE: /git/hotfix/start "hotfix-description"
```

### **Erro: Falha ao atualizar produção**
```
❌ CRITICAL ERROR: Failed to update production branch
🚨 EMERGENCY: Cannot proceed without latest production code
💡 Check connectivity and resolve conflicts immediately
```

### **Erro: Hotfix branch já existe**
```
❌ CRITICAL: Hotfix branch already exists
🚨 EMERGENCY CONFLICT - Multiple hotfixes?
💡 Switch to existing or use different name
```

### **Erro: Mudanças não commitadas**
```
⚠️  UNCOMMITTED CHANGES - EMERGENCY OVERRIDE
🚨 EMERGENCY: Save current work before hotfix? (Y/n)
```

---

## 🔗 **Integração com Sistema Onion**

### **Workflow Emergency:**
```bash
1. /git/hotfix/start "critical-bug"     # Start emergency fix (este comando)
2. # ... implement critical fix ...
3. /git/hotfix/finish                   # Deploy emergency fix  
4. # ... monitor production ...
```

### **Comandos Relacionados:**
- **`/git/hotfix/finish`** - Finalizar hotfix com duplo merge
- **`/engineer/hotfix`** - Task + git workflow completo
- **`/git/help`** - Emergency reference
- **`/git/sync`** - Pós-hotfix sync se necessário

### **Quando Usar:**
- ✅ **Bug crítico em produção** afetando usuários
- ✅ **Security vulnerability** que precisa fix imediato
- ✅ **System outage** requiring emergency patch
- ✅ **Data corruption** needing immediate resolution

---

## 💡 **Dicas Emergency**

### **🚨 Emergency Best Practices:**
```bash
# Minimal viable fix - não over-engineer
# Test only the critical path affected  
# Document rollback plan before deploy
# Monitor production metrics after deploy

# Quick emergency test
npm test        # Run critical tests only
npm run build   # Verify build works
```

### **⚡ Speed vs Safety:**
```bash
# Focus on:
✅ Minimal change to fix issue
✅ No regression in core functionality  
✅ Clear rollback path available
✅ Production monitoring ready

# Avoid:
❌ Large refactoring during emergency
❌ Unrelated improvements
❌ Complex feature additions  
❌ Untested experimental fixes
```

---

**🔥 Emergency hotfix ready for immediate implementation! Fix the critical issue and execute `/git/hotfix/finish` for deployment.**
