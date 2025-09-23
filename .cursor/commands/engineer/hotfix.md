# 🔥 Engineer Hotfix - Emergency Workflow Completo

Você é um assistente de IA especializado em **executar workflow completo de emergency hotfix** seguindo o padrão do Sistema Onion. Seu papel é combinar criação de task ClickUp + execução completa do workflow git hotfix em um único comando.

## 🎯 **Funcionalidades**

### **💥 Workflow Híbrido:**
- Executa lógica `/product/task` internamente para criar task
- Executa workflow git hotfix completo automaticamente
- Links com tasks relacionadas via parâmetros
- Tags e status apropriados para emergency

### **🚨 Emergency Automation:**
- Task ClickUp emergencial com prioridade máxima
- Setup automático de hotfix branch + desenvolvimento
- Parâmetros: `--related-tasks="id1,id2"` `--tags="urgent,critical"`
- Session management integrado para desenvolvimento

---

## 🚀 **Uso do Comando**

### **Sintaxe:**
```bash
/engineer/hotfix "description" [parameters]
```

### **Parâmetros Disponíveis:**
- `--related-tasks="id1,id2,id3"` - IDs de tasks relacionadas
- `--tags="urgent,critical,security"` - Tags adicionais
- `--status="In Progress"` - Status inicial (default: "In Progress") 
- `--priority=1` - Prioridade (1=urgent, 4=low, default: 1)

### **Examples:**
```bash
/engineer/hotfix "Fix critical payment gateway timeout"

/engineer/hotfix "Security patch for auth vulnerability" --related-tasks="86abc123,86def456" --tags="security,critical"

/engineer/hotfix "Memory leak in user session handling" --status="In Progress" --priority=1 --tags="performance,urgent"
```

---

## ⚙️ **Workflow Automático**

### **1. Validações e Parsing**
```bash
# Verificar se descrição foi fornecida
if [ "$#" -eq 0 ]; then
    echo "🔥 ERROR: Hotfix description required"
    echo "📖 USAGE: /engineer/hotfix \"description\" [parameters]"
    echo ""
    echo "💡 EXAMPLES:"
    echo "  /engineer/hotfix \"Fix critical payment timeout\""
    echo "  /engineer/hotfix \"Security auth patch\" --related-tasks=\"123,456\" --tags=\"security\""
    exit 1
fi

HOTFIX_DESCRIPTION="$1"
shift  # Remove first argument

echo "🔥 EMERGENCY ENGINEER HOTFIX: $HOTFIX_DESCRIPTION"

# Parse parameters
RELATED_TASKS=""
TAGS=""
STATUS="In Progress"
PRIORITY=1

while [[ $# -gt 0 ]]; do
    case $1 in
        --related-tasks=*)
            RELATED_TASKS="${1#*=}"
            shift
            ;;
        --tags=*)
            TAGS="${1#*=}"
            shift
            ;;
        --status=*)
            STATUS="${1#*=}"
            shift
            ;;
        --priority=*)
            PRIORITY="${1#*=}"
            shift
            ;;
        *)
            echo "⚠️  Unknown parameter: $1"
            shift
            ;;
    esac
done

# Sanitizar para slug
HOTFIX_SLUG=$(echo "$HOTFIX_DESCRIPTION" | sed 's/[^a-zA-Z0-9]/-/g' | tr '[:upper:]' '[:lower:]' | sed 's/--*/-/g' | sed 's/^-\\|-$//g')

echo "📝 Hotfix slug: $HOTFIX_SLUG"
echo "🏷️  Related tasks: ${RELATED_TASKS:-"None"}"
echo "🔖 Additional tags: ${TAGS:-"emergency,hotfix"}"
echo "📊 Priority: $PRIORITY (1=urgent)"
```

### **2. Execução Interna do /product/task**
```bash
echo "📋 STEP 1/3: Creating emergency ClickUp task..."

# Detectar lista atual ou usar default
function get_target_list_id() {
    # Tentar obter de sessão ativa primeiro
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
    
    # Fallback: Lista Desenvolvimento
    echo "901314121395"
}

LIST_ID=$(get_target_list_id)

# Preparar tags combinadas
COMBINED_TAGS="emergency,hotfix,critical"
if [ "$TAGS" != "" ]; then
    COMBINED_TAGS="$COMBINED_TAGS,$TAGS"
fi

# Preparar task description seguindo padrão /product/task
TASK_TITLE="🔥 EMERGENCY: $HOTFIX_DESCRIPTION"

TASK_DESCRIPTION="## 🚨 **EMERGENCY HOTFIX**

**🔥 CRITICAL ISSUE**: $HOTFIX_DESCRIPTION  
**Created via**: /engineer/hotfix (automated workflow)  
**Priority**: $PRIORITY (Emergency)  
**Timeline**: IMMEDIATE resolution required  

---

## 📋 **Emergency Workflow Status**

### **✅ AUTOMATED SETUP:**
- [x] Emergency task created with max priority
- [x] Hotfix branch will be created automatically
- [x] Development session will be initialized  
- [x] ClickUp integration configured
- [ ] Emergency fix implementation (next)
- [ ] Testing and validation
- [ ] Production deployment

### **🔧 TECHNICAL SETUP:**
- **Branch**: hotfix/$HOTFIX_SLUG (auto-created)
- **Base**: main/master (production)
- **Session**: .cursor/sessions/$HOTFIX_SLUG/
- **Workflow**: Complete git hotfix automation

---

## 🎯 **Implementation Plan**

### **🚨 EMERGENCY PRIORITIES:**
1. **Root Cause Analysis** - Identify exact issue
2. **Minimal Fix** - Smallest change to resolve issue  
3. **Critical Testing** - Verify fix without regression
4. **Emergency Deploy** - Fast-track to production

### **✅ Acceptance Criteria:**
- [ ] Issue completely resolved in production
- [ ] No new bugs or regressions introduced
- [ ] Critical functionality verified working
- [ ] Production monitoring shows health recovery
- [ ] Emergency documentation completed

---

## 🔄 **Emergency Git Workflow**

### **Automated Execution:**
\`\`\`bash
# This command will execute automatically:
# 1. /git/hotfix/start \"$HOTFIX_SLUG\" 
# 2. Create development session
# 3. Setup ClickUp tracking
# 4. When ready: /git/hotfix/finish
\`\`\`

### **Manual Development:**
\`\`\`bash  
# Development will happen in:
cd .cursor/sessions/$HOTFIX_SLUG/

# Fix implementation in:
# - hotfix/$HOTFIX_SLUG branch
# - Emergency session context available
# - ClickUp task tracking active

# When fix complete:
/git/hotfix/finish  # Automated deployment
\`\`\`

---

## 🏷️ **Related Tasks & Context**

### **🔗 Linked Tasks:**
$(if [ "$RELATED_TASKS" != "" ]; then
    IFS=',' read -ra TASK_ARRAY <<< "$RELATED_TASKS"
    for task_id in "\${TASK_ARRAY[@]}"; do
        echo "- Task ID: $task_id"
    done
else
    echo "- None specified"
fi)

### **📊 Priority Context:**
- **Emergency Level**: $PRIORITY (1=max urgency)
- **Business Impact**: Production system affected
- **User Impact**: Critical functionality unavailable
- **Timeline**: Emergency SLA < 2 hours

---

## 📈 **Success Metrics**

### **🎯 Primary KPIs:**
- [ ] Issue resolution time < 2 hours
- [ ] Zero regression in core functionality
- [ ] Production health metrics recovered
- [ ] User impact eliminated

### **📊 Technical Metrics:**
- [ ] Emergency deployment successful
- [ ] Rollback plan validated
- [ ] Documentation completed  
- [ ] Lessons learned documented

**🚨 Emergency task created by Sistema Onion automated workflow** 🧅"

# Criar task ClickUp
echo "🚀 Creating emergency ClickUp task..."

RESPONSE=$(curl -s -X POST "https://api.clickup.com/api/v2/list/$LIST_ID/task" \
    -H "Authorization: Bearer $CLICKUP_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{
        \"name\": \"$TASK_TITLE\",
        \"markdown_description\": \"$TASK_DESCRIPTION\",
        \"status\": \"$STATUS\",
        \"priority\": $PRIORITY,
        \"tags\": [$(echo "$COMBINED_TAGS" | sed 's/,/","/g' | sed 's/^/"/;s/$/"/')]
    }")

EMERGENCY_TASK_ID=$(echo "$RESPONSE" | jq -r '.id' 2>/dev/null)

if [ "$EMERGENCY_TASK_ID" != "" ] && [ "$EMERGENCY_TASK_ID" != "null" ]; then
    EMERGENCY_URL="https://app.clickup.com/t/$EMERGENCY_TASK_ID"
    echo "✅ Emergency task created: $EMERGENCY_TASK_ID"
    
    # Link com related tasks se especificadas
    if [ "$RELATED_TASKS" != "" ]; then
        echo "🔗 Linking with related tasks..."
        IFS=',' read -ra TASK_ARRAY <<< "$RELATED_TASKS"
        for related_id in "${TASK_ARRAY[@]}"; do
            curl -s -X POST "https://api.clickup.com/api/v2/task/$EMERGENCY_TASK_ID/link/$related_id" \
                -H "Authorization: Bearer $CLICKUP_TOKEN" > /dev/null || true
            echo "   🔗 Linked: $related_id"
        done
    fi
else
    echo "❌ ClickUp task creation failed - continuing with git workflow"
    EMERGENCY_TASK_ID=""
fi

echo "✅ STEP 1 COMPLETE: Emergency task setup finished"
```

### **3. Criação da Sessão de Desenvolvimento**
```bash
echo "📁 STEP 2/3: Creating development session..."

# Criar sessão seguindo padrão /product/task
SESSION_DIR=".cursor/sessions/$HOTFIX_SLUG"
mkdir -p "$SESSION_DIR"

# Criar context.md
cat > "$SESSION_DIR/context.md" << EOF
# 🔥 Contexto: Emergency Hotfix - $HOTFIX_DESCRIPTION

## 📋 **Task Principal**
**ID ClickUp**: $EMERGENCY_TASK_ID  
**Nome**: 🔥 EMERGENCY: $HOTFIX_DESCRIPTION  
**URL**: $EMERGENCY_URL

## 🔥 **Emergency Branch**
**Nome**: hotfix/$HOTFIX_SLUG  
**Criada**: $(date '+%Y-%m-%d %H:%M:%S')  
**Base**: main/master (production)  
**Status**: 🚨 Emergency Active

## ⏰ **Emergency Timeline**
**SLA**: < 2 hours resolution  
**Início**: $(date '+%Y-%m-%d %H:%M:%S')  
**Target**: $(date -d '+2 hours' '+%Y-%m-%d %H:%M:%S')

## 🎯 **Emergency Context**

### **Por que?**
CRITICAL PRODUCTION ISSUE: $HOTFIX_DESCRIPTION

Emergency hotfix required to resolve production system affecting users. This is a high-priority emergency situation requiring immediate resolution.

### **O que?**
Emergency hotfix implementation:
- Root cause identification and analysis
- Minimal viable fix implementation
- Critical testing and validation
- Emergency production deployment
- Post-deployment monitoring

### **Como?**
Emergency development workflow:
1. **Analysis**: Identify exact root cause
2. **Implementation**: Minimal change to fix issue
3. **Testing**: Critical path validation only
4. **Deploy**: /git/hotfix/finish for production
5. **Monitor**: Active production health monitoring

## 📊 **Related Context**
$(if [ "$RELATED_TASKS" != "" ]; then
    echo "**Related Tasks**: $RELATED_TASKS"
else
    echo "**Related Tasks**: None"
fi)
**Additional Tags**: $TAGS
**Priority Level**: $PRIORITY (Emergency)

## 🚨 **Emergency Success Metrics**
- **Resolution Time**: < 2 hours
- **No Regression**: Core functionality preserved
- **Health Recovery**: Production metrics restored
- **Zero Downtime**: If possible during fix

## ⚡ **Next Actions**
1. Switch to hotfix/$HOTFIX_SLUG branch (automated)
2. Analyze and implement emergency fix
3. Test critical functionality only
4. Execute /git/hotfix/finish for deployment
5. Monitor production actively post-deploy

**🔥 Emergency session created by /engineer/hotfix automated workflow** 🧅
EOF

# Criar architecture.md placeholder
cat > "$SESSION_DIR/architecture.md" << EOF
# 🔥 Emergency Architecture: $HOTFIX_DESCRIPTION

## 🚨 **Emergency Technical Analysis**

**To be populated during emergency fix development**

### **Root Cause Analysis**
- [ ] Issue identification completed
- [ ] Impact scope determined  
- [ ] Fix approach decided

### **Emergency Fix Strategy**
- [ ] Minimal viable solution designed
- [ ] Regression risk assessed
- [ ] Testing strategy defined

### **Deployment Plan**
- [ ] Emergency deploy procedure confirmed
- [ ] Rollback plan validated
- [ ] Monitoring alerts configured

**This will be updated during emergency development**
EOF

# Criar plan.md para emergency workflow
cat > "$SESSION_DIR/plan.md" << EOF
# 📋 Emergency Plan: $HOTFIX_DESCRIPTION

## 🚨 **Emergency Implementation Plan**

### **⚡ Phase 1: Analysis (15 min)**
- [ ] Reproduce issue in development
- [ ] Identify exact root cause
- [ ] Determine minimal fix scope
- [ ] Assess regression risks

### **🔥 Phase 2: Implementation (45 min)**  
- [ ] Implement minimal viable fix
- [ ] Add critical error handling
- [ ] Update relevant documentation
- [ ] Self-review for obvious issues

### **✅ Phase 3: Testing (30 min)**
- [ ] Test fix resolves original issue
- [ ] Validate no regression in critical paths
- [ ] Verify build succeeds
- [ ] Check for obvious edge cases

### **🚀 Phase 4: Emergency Deploy (30 min)**
- [ ] Execute /git/hotfix/finish
- [ ] Monitor deployment pipeline  
- [ ] Verify production health
- [ ] Confirm issue resolution

## ⏰ **Emergency Timeline**
**Total Estimated**: 2 hours maximum
**Started**: $(date '+%Y-%m-%d %H:%M:%S')
**Target Completion**: $(date -d '+2 hours' '+%Y-%m-%d %H:%M:%S')

**🔥 Emergency plan - execute immediately!**
EOF

# Criar notes.md
cat > "$SESSION_DIR/notes.md" << EOF
# 📝 Emergency Notes: $HOTFIX_DESCRIPTION

## 🗓️ **Emergency Log**

### **$(date '+%Y-%m-%d %H:%M:%S') - Emergency Started**
- ✅ Emergency task created: $EMERGENCY_TASK_ID
- ✅ Development session initialized
- ✅ Emergency timeline activated (< 2 hours SLA)
- ⏳ Starting git hotfix workflow...

### **Status Atual**: 🔥 EMERGENCY ACTIVE - GIT SETUP IN PROGRESS

---

## 💡 **Emergency Decisions**

### **Decision: Emergency Automation**
**Reason**: Critical production issue requires fastest possible resolution  
**Impact**: Full automated workflow to minimize time-to-fix

### **Decision: Minimal Fix Strategy**  
**Reason**: Emergency situations require surgical fixes, not improvements  
**Impact**: Focus solely on resolving the critical issue

### **Decision: Priority 1 + Emergency Tags**
**Reason**: Ensure maximum visibility and escalation  
**Impact**: All stakeholders alerted to emergency status

---

## 📊 **Emergency Metrics**

### **Timeline Tracking**:
- Emergency Start: $(date '+%Y-%m-%d %H:%M:%S')
- Task Created: ✅ $EMERGENCY_TASK_ID  
- Session Setup: ✅ Completed
- Git Hotfix: ⏳ In Progress
- Development: ⏳ Pending
- Deploy: ⏳ Pending

**🚨 Emergency active - work immediately!**
EOF

echo "✅ STEP 2 COMPLETE: Development session created at $SESSION_DIR"
```

### **4. Execução do Git Hotfix Workflow**
```bash
echo "🔥 STEP 3/3: Executing git hotfix workflow..."

# Executar /git/hotfix/start internamente
echo "   🔥 Executing: /git/hotfix/start \"$HOTFIX_SLUG\""

# Simulação da execução do git/hotfix/start (lógica interna)
# Verificar se é repo git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ ERROR: Not a git repository"
    echo "💡 Emergency setup: git init && /git/init"
    exit 1
fi

# Detectar primary branch
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
echo "   🎯 Production branch: $PRIMARY_BRANCH"

# Auto-save uncommitted work se houver
if [ -n "$(git status --porcelain)" ]; then
    echo "   ⚠️  Auto-saving uncommitted work for emergency..."
    git add .
    git commit -m "🚨 Auto-save: emergency backup before hotfix $HOTFIX_DESCRIPTION"
fi

# Atualizar e criar hotfix branch
echo "   📥 Updating production branch..."
git checkout "$PRIMARY_BRANCH"
git pull origin "$PRIMARY_BRANCH" || echo "   ⚠️  Pull failed - continuing with local"

HOTFIX_BRANCH="hotfix/$HOTFIX_SLUG"
echo "   🌿 Creating emergency branch: $HOTFIX_BRANCH"
git checkout -b "$HOTFIX_BRANCH"
git push origin "$HOTFIX_BRANCH" || echo "   ⚠️  Remote backup failed"

# Atualizar context com branch info
echo "
## 🌿 **Git Workflow Status**
**Branch Created**: $HOTFIX_BRANCH ✅  
**Base**: $PRIMARY_BRANCH (production)  
**Remote**: $(git ls-remote --heads origin "$HOTFIX_BRANCH" >/dev/null 2>&1 && echo "✅ Backed up" || echo "⚠️  Local only")  
**Next**: Implement fix and execute /git/hotfix/finish" >> "$SESSION_DIR/context.md"

echo "✅ STEP 3 COMPLETE: Git hotfix workflow initialized"
```

### **5. Final Setup e Comentário ClickUp**
```bash
# Comentário no ClickUp task sobre o setup completo
if [ "$EMERGENCY_TASK_ID" != "" ]; then
    SETUP_COMMENT="🔥 EMERGENCY WORKFLOW SETUP COMPLETE

━━━━━━━━━━━━━━━━━━━━━━━━

✅ AUTOMATED SETUP COMPLETED:
   ▶ Emergency task: $EMERGENCY_TASK_ID ✅ Created
   ▶ Development session: $SESSION_DIR ✅ Ready
   ▶ Git hotfix branch: $HOTFIX_BRANCH ✅ Active
   ▶ Production base: $PRIMARY_BRANCH ✅ Updated

🎯 EMERGENCY DEVELOPMENT READY:
   ∟ Branch: $HOTFIX_BRANCH (ready for fixes)
   ∟ Session: Complete development context
   ∟ Timeline: < 2 hours emergency SLA
   ∟ Workflow: Full git hotfix automation

$(if [ "$RELATED_TASKS" != "" ]; then
    echo "🔗 LINKED TASKS:"
    IFS=',' read -ra TASK_ARRAY <<< "$RELATED_TASKS"
    for task_id in "${TASK_ARRAY[@]}"; do
        echo "   ∟ $task_id - Linked automatically"
    done
fi)

⚡ IMMEDIATE ACTIONS:
   ∟ Implement emergency fix in $HOTFIX_BRANCH
   ∟ Test critical functionality only
   ∟ Execute /git/hotfix/finish when ready
   ∟ Monitor production post-deployment

🚨 EMERGENCY ACTIVE - DEVELOP IMMEDIATELY!

━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Setup Complete: $(date +'%Y-%m-%d %H:%M:%S') | 🔥 Emergency Active"

    curl -s -X POST "https://api.clickup.com/api/v2/task/$EMERGENCY_TASK_ID/comment" \
        -H "Authorization: Bearer $CLICKUP_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"comment_text\":\"$SETUP_COMMENT\"}" > /dev/null || true
    
    echo "✅ ClickUp task updated with setup completion"
fi
```

---

## ✅ **Resultado Esperado**

```
🔥 EMERGENCY ENGINEER HOTFIX COMPLETE!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚨 EMERGENCY WORKFLOW READY:
   ▶ Description: Fix critical payment gateway timeout
   ▶ Task ID: abc123 (Priority 1 - Emergency)  
   ▶ Session: .cursor/sessions/fix-critical-payment-gateway-timeout/
   ▶ Branch: hotfix/fix-critical-payment-gateway-timeout

📋 AUTOMATED SETUP COMPLETE:
   ▶ ClickUp Task: ✅ Created with emergency priority
   ▶ Development Session: ✅ Full context and planning
   ▶ Git Hotfix Branch: ✅ Created from production
   ▶ Related Tasks: ✅ Linked (if specified)

🔗 CLICKUP INTEGRATION:
   ▶ URL: https://app.clickup.com/t/abc123
   ▶ Status: In Progress (Emergency)
   ▶ Priority: 1 (Maximum urgency)  
   ▶ Tags: emergency, hotfix, critical
   ▶ Links: Connected to related tasks

⚡ READY FOR IMMEDIATE DEVELOPMENT:
   ∟ Current branch: hotfix/fix-critical-payment-gateway-timeout
   ∟ Development context: Complete session available
   ∟ Emergency SLA: < 2 hours resolution
   ∟ Workflow: Automated git hotfix ready

🎯 NEXT STEPS:
   ∟ Implement emergency fix in current branch
   ∟ Focus on minimal viable solution
   ∟ Test critical path only
   ∟ Execute /git/hotfix/finish for production deploy
   ∟ Monitor production health actively

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚨 EMERGENCY DEVELOPMENT READY - IMPLEMENT FIX NOW! 🔥
```

---

## 🔗 **Integração com Sistema Onion**

### **Comando Híbrido:**
Este comando combina a funcionalidade de:
- **`/product/task`**: Criação de task ClickUp estruturada
- **`/git/hotfix/start`**: Setup de emergency hotfix branch  
- **Session management**: Contexto completo de desenvolvimento

### **Workflow Comparison:**
```bash
# Método tradicional (3 comandos):
/product/task "Fix critical bug"
/engineer/start fix-critical-bug  
/git/hotfix/start "fix-critical-bug"

# Método híbrido (1 comando):
/engineer/hotfix "Fix critical bug"  # ← Este comando
```

### **Comandos Relacionados:**
- **`/git/hotfix/finish`** - Deploy da correção emergencial
- **`/engineer/work`** - Desenvolvimento iterativo na sessão
- **`/product/task-check`** - Verificação do progresso
- **`/git/help`** - Referência de comandos emergency

---

## 💡 **Dicas de Uso**

### **✅ Uso Recomendado:**
```bash
# Emergency completa com contexto
/engineer/hotfix "Memory leak in session handler" --related-tasks="123,456" --tags="performance,critical"

# Security emergency  
/engineer/hotfix "Auth bypass vulnerability" --tags="security,urgent" --priority=1

# Simple critical bug
/engineer/hotfix "Payment processing timeout"
```

### **🔧 Desenvolvimento Pós-Setup:**
```bash
# Após o comando, você estará na hotfix branch com sessão ativa
# Implementar fix imediatamente
# Testar functionality crítica
# Quando pronto:
/git/hotfix/finish  # Deploy automático
```

### **🚨 Emergency Best Practices:**
- **Minimal fixes only** - não over-engineer durante emergência
- **Critical path testing** - testar apenas funcionalidade afetada  
- **Monitor immediately** - acompanhar production health pós-deploy
- **Document decisions** - usar notes.md da sessão para tracking

---

**🔥 Emergency workflow completo em um comando! Task criada, branch configurada, sessão pronta para desenvolvimento imediato.**
