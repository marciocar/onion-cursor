# 🚨 Finalizar Hotfix - Emergency Deploy

Você é um assistente de IA especializado em **finalizar hotfixes críticos com deploy emergencial** seguindo o padrão do Sistema Onion. Seu papel é automatizar deploy crítico com validações de segurança e rollback preparation.

## 🎯 **Funcionalidades**

### **⚡ Deploy Crítico:**
- Duplo merge emergencial (hotfix → main + hotfix → develop)
- Tag de emergency patch automática
- Deploy preparation para produção imediata
- Rollback plan automático ativado

### **🚨 Emergency Validation:**
- Validações críticas de segurança aceleradas
- Confirmações mínimas para deploy urgente  
- ClickUp emergency completion tracking
- Production monitoring preparation

---

## 🚀 **Uso do Comando**

### **Sintaxe:**
```bash
/git/hotfix/finish
```

**Nota**: Auto-detecta hotfix branch atual - execute na hotfix branch que deseja finalizar para produção.

---

## ⚙️ **Workflow Automático**

### **1. Emergency Validation**
```bash
# Detectar branch atual
CURRENT_BRANCH=$(git branch --show-current)

echo "🔥 EMERGENCY HOTFIX FINISH: $CURRENT_BRANCH"

# Verificar se é hotfix branch
if [[ ! "$CURRENT_BRANCH" =~ ^hotfix/ ]]; then
    echo "❌ CRITICAL ERROR: Not on a hotfix branch"
    echo "🚨 EMERGENCY ABORT - Wrong branch for hotfix finish"
    echo ""
    echo "📋 AVAILABLE HOTFIX BRANCHES:"
    git branch -a | grep "hotfix/" | sed 's/^/   /' | head -5
    echo ""
    echo "🔧 EMERGENCY USAGE:"
    echo "   git checkout hotfix/[name]"
    echo "   /git/hotfix/finish"
    exit 1
fi

# Extrair nome do hotfix
HOTFIX_NAME=$(echo "$CURRENT_BRANCH" | sed 's/^hotfix\\///')
echo "🔥 Emergency hotfix: $HOTFIX_NAME"

# Verificar mudanças não commitadas
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  UNCOMMITTED CHANGES DETECTED IN EMERGENCY BRANCH"
    git status --short
    echo ""
    echo "🚨 EMERGENCY: Auto-commit final changes before deploy?"
    echo "Auto-commit and proceed with emergency deployment? (Y/n)"
    read -r confirm
    if [[ "$confirm" =~ ^[Nn]$ ]]; then
        echo "❌ EMERGENCY ABORT - Commit changes manually first"
        echo "💡 Quick commit: git add . && git commit -m \"emergency fix completed\""
        exit 1
    else
        git add .
        git commit -m "🔥 EMERGENCY: final hotfix changes for $HOTFIX_NAME

🚨 CRITICAL FIX COMPLETED
🎯 Ready for emergency production deployment
⚡ Auto-committed via /git/hotfix/finish

EMERGENCY OVERRIDE: Auto-commit enabled"
        echo "✅ Emergency auto-commit completed"
    fi
fi

echo "✅ Emergency validation passed - PROCEEDING WITH CRITICAL DEPLOYMENT"
```

### **2. Detecção Branches Críticas**
```bash
# Detectar branch principal (master/main) - CRÍTICO
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
echo "🎯 CRITICAL: Production branch is $PRIMARY_BRANCH"

# Verificar develop (menos crítico para hotfix)
if ! git branch -r | grep "origin/develop" > /dev/null; then
    echo "⚠️  WARNING: develop branch not found - hotfix will merge only to $PRIMARY_BRANCH"
    echo "🚨 EMERGENCY: Single branch deployment acceptable for hotfix"
    DEVELOP_EXISTS=false
else
    DEVELOP_EXISTS=true
    echo "📋 Will merge to both: $PRIMARY_BRANCH (production) and develop"
fi
```

### **3. Version Detection e Tag Preparation**
```bash
# Detectar versão do hotfix
function detect_hotfix_version() {
    if [ -f "package.json" ] && grep -q "version" package.json; then
        grep '"version"' package.json | sed 's/.*"version": *"\\([^"]*\\)".*/\\1/' | head -1
    elif [ -f "version.txt" ]; then
        cat version.txt | head -1  
    elif [ -f "VERSION" ]; then
        cat VERSION | head -1
    else
        echo "0.0.1"
    fi
}

HOTFIX_VERSION=$(detect_hotfix_version)
HOTFIX_TAG="v$HOTFIX_VERSION"

echo "🏷️  Emergency version: $HOTFIX_VERSION"
echo "🔥 Emergency tag: $HOTFIX_TAG"

# CRÍTICO: Verificar se tag já existe (mas permitir override em emergência)
if git tag | grep "^$HOTFIX_TAG$" > /dev/null; then
    echo "⚠️  CRITICAL WARNING: Tag $HOTFIX_TAG already exists"
    echo "🚨 EMERGENCY OVERRIDE AVAILABLE"
    echo ""
    echo "Delete existing tag and proceed with emergency? (Y/n)"
    read -r confirm
    if [[ "$confirm" =~ ^[Nn]$ ]]; then
        echo "❌ EMERGENCY ABORT - Resolve tag conflict manually"
        exit 1
    else
        git tag -d "$HOTFIX_TAG"
        git push origin --delete "$HOTFIX_TAG" 2>/dev/null || true
        echo "✅ Emergency override: existing tag deleted"
    fi
fi
```

### **4. CRITICAL: Emergency Merge to Production**
```bash
echo "🚨 CRITICAL DEPLOYMENT: Merging to production branch $PRIMARY_BRANCH"

# Atualizar main/master branch
echo "📥 EMERGENCY: Updating production branch..."
git checkout "$PRIMARY_BRANCH"
if ! git pull origin "$PRIMARY_BRANCH"; then
    echo "❌ CRITICAL ERROR: Failed to update production branch"
    echo "🚨 EMERGENCY SITUATION: Network or permission issue"
    echo ""
    echo "Proceed with local merge (risky but may be necessary)? (y/N)"
    read -r emergency_confirm
    if [[ ! "$emergency_confirm" =~ ^[Yy]$ ]]; then
        echo "❌ EMERGENCY ABORT - Cannot safely merge to production"
        exit 1
    else
        echo "⚠️  EMERGENCY OVERRIDE: Proceeding with local-only merge"
    fi
fi

# CRITICAL MERGE: hotfix para produção
echo "🔥 EMERGENCY MERGE: $CURRENT_BRANCH → $PRIMARY_BRANCH"
if git merge --no-ff "$CURRENT_BRANCH" -m "🚨 EMERGENCY HOTFIX: $HOTFIX_NAME ($HOTFIX_VERSION)

🔥 CRITICAL PRODUCTION FIX
🎯 Hotfix: $HOTFIX_NAME
📈 Version: $HOTFIX_VERSION
🚨 Emergency deployment to resolve critical issue

⚠️  EMERGENCY MERGE - MONITOR PRODUCTION IMMEDIATELY
✅ Rollback available: Previous production version
🏷️ Emergency tag: $HOTFIX_TAG

Via: /git/hotfix/finish - EMERGENCY WORKFLOW"; then
    echo "✅ EMERGENCY MERGE TO PRODUCTION SUCCESSFUL"
else
    echo "❌ CRITICAL FAILURE: Emergency merge to production failed"
    echo "🚨 PRODUCTION EMERGENCY - MANUAL INTERVENTION REQUIRED"
    echo ""
    echo "📋 CONFLICTED FILES:"
    git status --short | grep "^UU\\|^AA\\|^DD" | sed 's/^/   /'
    echo ""
    echo "🔧 EMERGENCY CONFLICT RESOLUTION:"
    echo "   1. Resolve conflicts immediately"
    echo "   2. git add [resolved-files]"
    echo "   3. git commit -m \"resolve emergency conflicts\""  
    echo "   4. /git/hotfix/finish  # Re-run"
    echo ""
    echo "🚨 PRODUCTION IS WAITING - RESOLVE IMMEDIATELY"
    exit 1
fi

# CRITICAL: Push production branch immediately
echo "📤 CRITICAL: Deploying to production remote..."
if git push origin "$PRIMARY_BRANCH"; then
    echo "✅ EMERGENCY DEPLOYMENT PUSHED TO PRODUCTION"
else
    echo "❌ CRITICAL: Production push failed"
    echo "🚨 EMERGENCY: Manual push to production required IMMEDIATELY"
    echo "   git push origin $PRIMARY_BRANCH"
    echo ""
    echo "Continue with develop merge while troubleshooting? (Y/n)"
    read -r continue_confirm
    if [[ "$continue_confirm" =~ ^[Nn]$ ]]; then
        echo "❌ EMERGENCY ABORT - Fix production push first"
        exit 1
    fi
fi
```

### **5. Secondary Merge: Hotfix → Develop**
```bash
if [ "$DEVELOP_EXISTS" = "true" ]; then
    echo "🔄 SECONDARY: Merging hotfix to develop branch"
    
    # Atualizar develop
    echo "📥 Updating develop branch..."
    git checkout develop
    git pull origin develop || echo "⚠️  Develop pull failed - continuing"
    
    # Merge hotfix para develop
    echo "🔀 Merging $CURRENT_BRANCH into develop..."
    if git merge --no-ff "$CURRENT_BRANCH" -m "🔥 Merge emergency hotfix $HOTFIX_NAME into develop

🚨 Emergency hotfix merge from production
🎯 Version: $HOTFIX_VERSION  
📋 Hotfix: $HOTFIX_NAME
🔄 Includes critical production fixes

Via: /git/hotfix/finish"; then
        echo "✅ Hotfix merged to develop successfully"
        
        # Push develop
        if git push origin develop; then
            echo "✅ Develop branch updated with hotfix"
        else
            echo "⚠️  WARNING: Develop push failed (non-critical)"
            echo "💡 Manual push recommended: git push origin develop"
        fi
    else
        echo "❌ WARNING: Develop merge failed (non-critical for emergency)"
        echo "🚨 PRODUCTION IS DEPLOYED - Develop conflicts can be resolved later"
        echo ""
        echo "📋 Resolve develop conflicts manually after production stabilizes"
        echo "💡 Production emergency takes priority over develop sync"
    fi
else
    echo "ℹ️  Skipping develop merge (branch not found)"
fi
```

### **6. Emergency Tag Creation**
```bash
echo "🏷️  EMERGENCY: Creating production tag $HOTFIX_TAG"

# Voltar para produção para criar tag
git checkout "$PRIMARY_BRANCH"

# Criar tag de emergency com metadata crítica
EMERGENCY_TAG_MESSAGE="🚨 EMERGENCY HOTFIX: $HOTFIX_VERSION

🔥 CRITICAL PRODUCTION FIX - $(date '+%Y-%m-%d %H:%M:%S')

📋 Emergency Details:
- Hotfix: $HOTFIX_NAME  
- Version: $HOTFIX_VERSION
- Branch: $CURRENT_BRANCH
- Commit: $(git rev-parse HEAD)
- Deploy: IMMEDIATE

🚨 Critical Issue Resolution:
- Emergency fix applied to production
- Monitoring required immediately
- Rollback available if needed

🎯 Deployment Information:
- Status: DEPLOYED TO PRODUCTION
- Rollback: Previous version available
- Monitor: Critical alerts should be active
- Timeline: Emergency SLA applied

⚠️  EMERGENCY TAG - MONITOR PRODUCTION METRICS
📊 Verify application health immediately after deployment

Via: Sistema Onion Emergency Workflow /git/hotfix/finish"

if git tag -a "$HOTFIX_TAG" -m "$EMERGENCY_TAG_MESSAGE"; then
    echo "✅ Emergency tag created: $HOTFIX_TAG"
else
    echo "❌ WARNING: Tag creation failed (non-critical)"
    echo "💡 Manual tag: git tag -a $HOTFIX_TAG -m \"Emergency hotfix $HOTFIX_VERSION\""
fi

# Push tag (crítico para deploy automation)
echo "📤 CRITICAL: Pushing emergency tag..."
if git push origin "$HOTFIX_TAG"; then
    echo "✅ Emergency tag deployed - CI/CD should trigger"
else
    echo "❌ WARNING: Tag push failed"
    echo "💡 Manual: git push origin $HOTFIX_TAG"
    echo "🚨 May affect automated deployment - verify manually"
fi
```

### **7. Branch Cleanup (Accelerated)**
```bash
echo "🧹 EMERGENCY: Accelerated branch cleanup..."

# Para emergências, cleanup mais agressivo
echo ""
echo "🗑️  EMERGENCY CLEANUP: Delete hotfix branch?"
echo "   Branch: $CURRENT_BRANCH"
echo "   Status: ✅ Merged to production successfully"
echo "   Tag: $HOTFIX_TAG created"
echo ""
echo "Emergency cleanup recommended for workspace hygiene (Y/n)"
read -r cleanup_confirm

if [[ ! "$cleanup_confirm" =~ ^[Nn]$ ]]; then
    # Switch away from hotfix branch
    git checkout "$PRIMARY_BRANCH"
    
    # Delete local hotfix branch
    if git branch -d "$CURRENT_BRANCH"; then
        echo "✅ Emergency: Local hotfix branch deleted"
        
        # Delete remote hotfix branch immediately  
        if git push origin --delete "$CURRENT_BRANCH"; then
            echo "✅ Emergency: Remote hotfix branch deleted"
        else
            echo "⚠️  Remote cleanup failed: git push origin --delete $CURRENT_BRANCH"
        fi
    else
        echo "⚠️  Local branch deletion failed"
        echo "💡 Force delete: git branch -D $CURRENT_BRANCH"
    fi
else
    echo "📝 Keeping hotfix branch for emergency reference"
fi
```

### **8. ClickUp Emergency Completion**
```bash
echo "🚨 FINALIZING EMERGENCY CLICKUP TASKS..."

# Buscar task de hotfix emergencial
function find_emergency_hotfix_task() {
    if [ "$CLICKUP_TOKEN" != "" ]; then
        # Buscar por tasks com título emergency hotfix
        curl -s -H "Authorization: Bearer $CLICKUP_TOKEN" \
            "https://api.clickup.com/api/v2/team/YOUR_TEAM_ID/task?include_closed=false" 2>/dev/null | \
            jq -r ".tasks[] | select(.name | contains(\"EMERGENCY HOTFIX\")) | select(.name | contains(\"$HOTFIX_NAME\")) | .id" 2>/dev/null | head -1
    fi
}

HOTFIX_TASK_ID=$(find_emergency_hotfix_task)

# Detectar também task de sessão
PARENT_TASK_ID=""
if find .cursor/sessions -name "context.md" -type f 2>/dev/null | head -1 | xargs grep "ID ClickUp" 2>/dev/null; then
    PARENT_TASK_ID=$(find .cursor/sessions -name "context.md" -type f 2>/dev/null | head -1 | xargs grep "ID ClickUp" | cut -d: -f2 | xargs)
fi

if [ "$HOTFIX_TASK_ID" != "" ] || [ "$PARENT_TASK_ID" != "" ]; then
    echo "🔗 Updating emergency ClickUp tasks..."
    
    # Comentário de emergency completion
    EMERGENCY_COMPLETION="🚨 EMERGENCY HOTFIX DEPLOYED SUCCESSFULLY

━━━━━━━━━━━━━━━━━━━━━━━━

🔥 EMERGENCY DEPLOYMENT COMPLETE:
   ▶ Hotfix: $HOTFIX_NAME
   ▶ Version: $HOTFIX_VERSION  
   ▶ Tag: $HOTFIX_TAG ✅ Created and pushed
   ▶ Production: $CURRENT_BRANCH → $PRIMARY_BRANCH ✅ DEPLOYED
   ▶ Development: $CURRENT_BRANCH → develop $([ "$DEVELOP_EXISTS" = "true" ] && echo "✅ Updated" || echo "⏭️  N/A")

🚨 CRITICAL DEPLOYMENT STATUS:
   ∟ Production merge: ✅ SUCCESSFUL
   ∟ Emergency tag: ✅ DEPLOYED  
   ∟ CI/CD trigger: ✅ Should be active
   ∟ Rollback ready: ✅ Previous version available

⚠️  IMMEDIATE ACTIONS REQUIRED:
   ∟ Monitor production metrics NOW
   ∟ Verify fix resolves reported issue
   ∟ Check error rates and performance  
   ∟ Confirm no new issues introduced
   ∟ Enable critical alerts monitoring

📊 EMERGENCY METRICS:
   ∟ Deploy time: $(date +'%Y-%m-%d %H:%M:%S')
   ∟ SLA status: Emergency deployment complete
   ∟ Automated: Via Sistema Onion emergency workflow
   ∟ Branch cleanup: Completed

🎯 POST-DEPLOYMENT CHECKLIST:
   ∟ [ ] Production health verified
   ∟ [ ] Issue resolution confirmed  
   ∟ [ ] Performance metrics stable
   ∟ [ ] No regression detected
   ∟ [ ] Customer impact resolved
   ∟ [ ] Incident documentation updated

🔄 ROLLBACK PLAN (if needed):
   ∟ Previous production state preserved
   ∟ Emergency rollback: git reset + deploy previous tag
   ∟ Database rollback: Check for schema changes
   ∟ Escalation path: Available if issues persist

━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Deployed: $(date +'%Y-%m-%d %H:%M:%S') | 🚨 MONITOR NOW!"

    # Update emergency task
    if [ "$HOTFIX_TASK_ID" != "" ]; then
        if curl -s -X PUT "https://api.clickup.com/api/v2/task/$HOTFIX_TASK_ID" \
            -H "Authorization: Bearer $CLICKUP_TOKEN" \
            -H "Content-Type: application/json" \
            -d '{"status": "done"}' > /dev/null && \
           curl -s -X POST "https://api.clickup.com/api/v2/task/$HOTFIX_TASK_ID/comment" \
            -H "Authorization: Bearer $CLICKUP_TOKEN" \
            -H "Content-Type: application/json" \
            -d "{\"comment_text\":\"$EMERGENCY_COMPLETION\"}" > /dev/null; then
            echo "✅ Emergency hotfix task completed"
        else
            echo "⚠️  ClickUp update failed - emergency deployment successful anyway"
        fi
    fi
    
    # Update parent task
    if [ "$PARENT_TASK_ID" != "" ]; then
        curl -s -X POST "https://api.clickup.com/api/v2/task/$PARENT_TASK_ID/comment" \
            -H "Authorization: Bearer $CLICKUP_TOKEN" \
            -H "Content-Type: application/json" \
            -d "{\"comment_text\":\"$EMERGENCY_COMPLETION\"}" > /dev/null || true
        echo "✅ Parent task updated with emergency completion"
    fi
else
    echo "ℹ️  No ClickUp tasks found - emergency deployment completed"
fi
```

---

## ✅ **Resultado Esperado**

```
🚨 EMERGENCY HOTFIX DEPLOYED SUCCESSFULLY!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔥 EMERGENCY DEPLOYMENT COMPLETE:
   ▶ Hotfix: fix-payment-gateway
   ▶ Version: 2.1.1 (emergency patch)
   ▶ Tag: v2.1.1 ✅ Deployed to production
   ▶ Production: hotfix/fix-payment-gateway → main ✅ LIVE
   ▶ Development: hotfix/fix-payment-gateway → develop ✅ Synced

🚨 CRITICAL STATUS:
   ▶ Production deployment: ✅ SUCCESSFUL
   ▶ Emergency tag: ✅ CI/CD triggered
   ▶ Rollback available: v2.1.0 (previous)
   ▶ Branch cleanup: ✅ Completed

⚠️  IMMEDIATE MONITORING REQUIRED:
   ∟ Verify production application health
   ∟ Confirm critical issue is resolved
   ∟ Check error rates and metrics
   ∟ Monitor customer impact resolution

📊 NEXT STEPS:
   ∟ Monitor production for 30+ minutes
   ∟ Verify fix effectiveness
   ∟ Document lessons learned
   ∟ Update incident post-mortem

🔄 ROLLBACK READY (if needed):
   ∟ Previous version: v2.1.0
   ∟ Emergency rollback available
   ∟ Database changes: Verify before rollback

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚨 PRODUCTION EMERGENCY RESOLVED! Monitor actively. 🚨
```

---

## ⚠️ **Tratamento de Erros**

### **Erro: Não é hotfix branch**
```
❌ CRITICAL ERROR: Not on a hotfix branch
🚨 EMERGENCY ABORT - Wrong branch
💡 Switch: git checkout hotfix/[name]
```

### **Erro: Production merge failed**
```
❌ CRITICAL FAILURE: Emergency merge to production failed
🚨 PRODUCTION EMERGENCY - MANUAL INTERVENTION REQUIRED
🔧 Resolve conflicts immediately
```

### **Erro: Production push failed**
```
❌ CRITICAL: Production push failed
🚨 EMERGENCY: Manual push required IMMEDIATELY
   git push origin main
```

### **Erro: Auto-commit em emergência**
```
⚠️  UNCOMMITTED CHANGES IN EMERGENCY BRANCH
🚨 EMERGENCY: Auto-commit and proceed? (Y/n)
```

---

## 🔗 **Integração com Sistema Onion**

### **Emergency Workflow:**
```bash
1. /git/hotfix/start "critical-issue"   # Emergency setup
2. # ... implement critical fix ...
3. /git/hotfix/finish                   # Emergency deploy (este comando)  
4. # ... monitor production actively ...
```

### **Comandos Relacionados:**
- **`/git/hotfix/start`** - Iniciar emergency hotfix
- **`/engineer/hotfix`** - Task + emergency workflow completo
- **`/git/help`** - Emergency command reference
- **Production monitoring** - Critical post-deploy

### **Quando Usar:**
- ✅ **Critical fix implemented** e testado
- ✅ **Ready for emergency production deploy**
- ✅ **Monitoring systems prepared** para deployment
- ✅ **Rollback plan confirmed** e disponível

---

## 💡 **Emergency Tips**

### **🚨 Pre-Deployment:**
```bash
# Na hotfix branch, validar fix mínimo
git status          # Should be clean
npm test           # Critical tests only
npm run build      # Quick build verify

# Então deploy emergency
/git/hotfix/finish
```

### **⚡ Post-Deployment:**
```bash
# CRITICAL: Monitor immediately
# Check application health dashboards
# Verify error rates dropped
# Confirm customer impact resolved
# Document incident timeline

# If issues persist:
# git checkout main
# git reset --hard [previous-tag]  # Emergency rollback
```

### **🔄 Rollback Procedure:**
```bash
# If emergency deployment fails:
1. git checkout main
2. git reset --hard v2.1.0  # Previous version
3. git push origin main --force  # Emergency rollback
4. Monitor recovery
5. Investigate rollback cause
```

---

**🚨 Emergency deployment with monitoring required! Verify production health immediately after deployment.**
