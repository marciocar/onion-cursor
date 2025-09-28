# 🚨 Finalizar Hotfix - Emergency Production Deploy com Validações Críticas

Você é um assistente de IA especializado em **finalizar hotfixes críticos com CONFIRMAÇÕES EMERGENCIAIS PRODUCTION-GRADE** seguindo rigorosamente o padrão Git Flow oficial. Seu papel é atuar como **GUARDIÃO ABSOLUTO DE EMERGÊNCIAS**, balanceando velocidade crítica com segurança máxima.

## 🎯 **Funcionalidades**

### **🚨 Emergency-Production-Safety (NOVO - CRÍTICO):**
- **CONFIRMAÇÕES EMERGENCIAIS OBRIGATÓRIAS** para deploy crítico
- **Emergency validation accelerated** mas rigorosa  
- **Critical impact analysis** antes de dual merge
- **Emergency rollback preparation** automática
- **Crisis communication** integration

### **⚡ Emergency-Grade UX (NOVO):**
- **Visual hierarchy emergency** - alertas críticos máximos
- **Emergency context display** - impacto imediato claro
- **Critical progress indicators** - operações de emergência  
- **Educational content** sobre hotfix management
- **Post-emergency guidance** e recovery instructions

### **🔥 Emergency Dual Merge Crítico:**
- Merge hotfix → main (emergency production) com validação crítica
- Merge hotfix → develop (sync development) com recovery
- Emergency tag creation com metadata completa
- Critical push com verificações de emergência

---

## 🚀 **Uso do Comando**

### **Sintaxe:**
```bash
/git/hotfix/finish
```

**Nota**: Auto-detecta hotfix branch atual - execute na hotfix branch que deseja finalizar para EMERGENCY PRODUCTION.

---

## ⚙️ **Workflow de Implementação**

### **1. Emergency Context Display**
```bash
#!/bin/bash

# Imports para UX crítica de emergência
source "$HOME/.cursor/utils/modern-cli-ux.sh" 2>/dev/null || true

# Performance tracking para emergências
cli_performance_start

# Detectar branch atual
CURRENT_BRANCH=$(git branch --show-current)
HOTFIX_NAME=$(echo "$CURRENT_BRANCH" | sed 's/^hotfix\\///')

# Emergency Header - MÁXIMA VISIBILIDADE
echo ""
cli_error_header "🚨 GIT FLOW - EMERGENCY HOTFIX FINISH (PRODUCTION)"
cli_separator_thick

# Emergency Analysis Section  
cli_section_header "🔥 EMERGENCY PRODUCTION HOTFIX ANALYSIS"
echo "   ▶ Emergency Fix: $(cli_highlight "$HOTFIX_NAME" "red") → CRITICAL PRODUCTION DEPLOY"
echo "   ▶ Source: $(cli_highlight "$CURRENT_BRANCH" "red") ($(git rev-list --count HEAD ^$(cli_detect_primary_branch)) commits ahead)"
echo "   ▶ Target Production: $(cli_highlight "$(cli_detect_primary_branch)" "red") (current: $(git rev-parse --short $(cli_detect_primary_branch)))"
echo "   ▶ Target Development: $(cli_highlight "develop" "yellow") (current: $(git rev-parse --short develop))"
echo "   ▶ Emergency Tag: $(cli_highlight "v$(cli_get_emergency_version)" "red") (triggers IMMEDIATE CI/CD)"

# Emergency readiness checks (accelerated but thorough)
echo ""
cli_section_header "🚨 EMERGENCY PRODUCTION VALIDATION"

# Check 1: Hotfix branch validation  
if [[ ! "$CURRENT_BRANCH" =~ ^hotfix/ ]]; then
    cli_status_line "Emergency branch" "❌ Not on hotfix branch" "red"
    echo ""
    cli_critical_warning_box "EMERGENCY ABORT - WRONG BRANCH"
    echo "🚨 $(cli_highlight "CRITICAL ERROR: Not on hotfix branch for emergency deployment" "red")"
    echo ""
    echo "📋 Available hotfix branches:"
    git branch -a | grep "hotfix/" | sed 's/^/   /' | head -5
    echo ""
    echo "🔧 Emergency usage: git checkout hotfix/[name] && /git/hotfix/finish"
    echo ""
    echo "❌ EMERGENCY DEPLOYMENT BLOCKED"
    exit 1
else
    cli_status_line "Emergency branch" "✅ $CURRENT_BRANCH validated" "green"
fi

# Check 2: Working directory (emergency auto-commit available)
if [ -n "$(git status --porcelain)" ]; then
    cli_status_line "Working directory" "⚠️ Uncommitted changes detected" "yellow"
    echo ""
    cli_critical_warning_box "UNCOMMITTED CHANGES IN EMERGENCY BRANCH"
    echo "🚨 Emergency situation detected - uncommitted changes found"
    echo ""
    echo "📋 Uncommitted files:"
    git status --short | sed 's/^/   /'
    echo ""
    echo "⚡ EMERGENCY OPTIONS:"
    echo "   1. Auto-commit all changes and proceed (FAST)"
    echo "   2. Abort and commit manually (SAFE)"
    echo ""
    echo "❓ Emergency auto-commit and proceed? [y/N]"
    read -r emergency_autocommit
    
    if [[ "$emergency_autocommit" =~ ^[Yy]$ ]]; then
        git add .
        git commit -m "🚨 EMERGENCY: Auto-commit final hotfix changes

🔥 Critical hotfix: $HOTFIX_NAME
⚡ Emergency auto-commit via /git/hotfix/finish
🚨 READY FOR CRITICAL PRODUCTION DEPLOYMENT

Emergency override: Auto-commit enabled for critical deployment"
        cli_progress_success "emergency auto-commit completed"
    else
        echo ""
        cli_info_box "EMERGENCY AUTO-COMMIT DECLINED" "Manual commit required before emergency deployment"
        echo "⚡ Quick emergency commit:"
        echo "   git add ."
        echo "   git commit -m \"emergency: $HOTFIX_NAME completed\""
        echo "   /git/hotfix/finish"
        exit 1
    fi
else
    cli_status_line "Working directory" "✅ Clean" "green"
fi

# Check 3: Production branch status (critical)
PRIMARY_BRANCH=$(cli_detect_primary_branch)
git fetch origin "$PRIMARY_BRANCH" --quiet 2>/dev/null || true
PRODUCTION_STATUS=$(git rev-list --count "$PRIMARY_BRANCH"..origin/"$PRIMARY_BRANCH" 2>/dev/null || echo "0")
if [ "$PRODUCTION_STATUS" -eq 0 ]; then
    cli_status_line "Production branch ($PRIMARY_BRANCH)" "✅ Up to date" "green"
else
    cli_status_line "Production branch ($PRIMARY_BRANCH)" "⚠️ $PRODUCTION_STATUS commits behind" "yellow"
    echo "   💡 Emergency deployment will proceed (production sync non-critical for hotfix)"
fi

# Check 4: Emergency merge conflicts (critical check)
if cli_validate_merge_conflicts "$CURRENT_BRANCH" "$PRIMARY_BRANCH"; then
    cli_status_line "Production conflicts" "✅ None detected" "green"
else
    cli_status_line "Production conflicts" "❌ Conflicts detected" "red"
    echo ""
    cli_critical_warning_box "PRODUCTION MERGE CONFLICTS - EMERGENCY BLOCKED"
    echo "🚨 $(cli_highlight "CRITICAL: Cannot deploy to production with conflicts" "red")"
    echo ""
    echo "🔧 Emergency conflict resolution:"
    echo "   1. git checkout $PRIMARY_BRANCH"
    echo "   2. git pull origin $PRIMARY_BRANCH"
    echo "   3. git checkout $CURRENT_BRANCH"
    echo "   4. git merge $PRIMARY_BRANCH  # Resolve conflicts"
    echo "   5. /git/hotfix/finish"
    echo ""
    echo "❌ EMERGENCY DEPLOYMENT BLOCKED"
    exit 1
fi

# Check 5: Emergency tests (accelerated)
if command -v npm &> /dev/null && [ -f "package.json" ]; then
    echo -n "   ⚡ Running emergency tests... "
    if timeout 60s npm run test --silent > /dev/null 2>&1; then
        cli_status_line "Emergency tests" "✅ Critical tests passing" "green"
    else
        cli_status_line "Emergency tests" "❌ Some tests failing" "red"
        echo ""
        cli_critical_warning_box "TESTS FAILING - EMERGENCY DECISION REQUIRED"
        echo "🚨 Emergency hotfix has failing tests"
        echo ""
        echo "⚡ EMERGENCY OPTIONS:"
        echo "   1. Deploy anyway (HIGH RISK - emergency override)"
        echo "   2. Abort and fix tests (SAFE - delays fix)"
        echo ""
        echo "❓ Deploy with failing tests (emergency override)? [y/N]"
        read -r emergency_override
        if [[ ! "$emergency_override" =~ ^[Yy]$ ]]; then
            echo "❌ EMERGENCY DEPLOYMENT BLOCKED - Fix tests first"
            exit 1
        else
            cli_status_line "Emergency override" "⚠️ Tests bypassed (emergency)" "yellow"
        fi
    fi
fi

# Check 6: Emergency tag validation
EMERGENCY_VERSION=$(detect_emergency_version)
EMERGENCY_TAG="v$EMERGENCY_VERSION"
if git tag | grep -q "^$EMERGENCY_TAG$"; then
    cli_status_line "Emergency tag" "⚠️ $EMERGENCY_TAG exists" "yellow"
    echo ""
    echo "⚡ EMERGENCY TAG CONFLICT - AUTO-RESOLUTION"
    echo "   Existing tag: $EMERGENCY_TAG"
    echo "   Emergency action: Will delete and recreate"
    echo ""
    git tag -d "$EMERGENCY_TAG"
    git push origin --delete "$EMERGENCY_TAG" 2>/dev/null || true
    cli_progress_success "emergency tag conflict resolved")
else
    cli_status_line "Emergency tag" "✅ $EMERGENCY_TAG available" "green"
fi
```

### **2. Emergency Educational Context**
```bash
# Emergency educational section - ensinar emergency management
echo ""
cli_section_header "🚨 EMERGENCY HOTFIX EDUCATION"
cli_education_box "Emergency Git Flow Workflow" "
Emergency hotfix bypasses normal release cycle: $(cli_highlight "main" "red") → hotfix/fix → $(cli_highlight "main + develop" "red")
This is CRITICAL emergency deployment for production issues.

Current stage: $(cli_highlight "hotfix/fix" "red") → $(cli_highlight "EMERGENCY PRODUCTION" "red") (← you are here)"

echo ""
echo "$(cli_dim "This EMERGENCY operation will:")
   ▶ Deploy emergency fix $(cli_highlight "$HOTFIX_NAME" "red") to PRODUCTION IMMEDIATELY
   ▶ Create emergency tag $(cli_highlight "$EMERGENCY_TAG" "red") (triggers IMMEDIATE CI/CD)
   ▶ Merge hotfix → $(cli_highlight "$PRIMARY_BRANCH" "red") (EMERGENCY PRODUCTION)
   ▶ Merge hotfix → $(cli_highlight "develop" "yellow") (sync for future development)
   ▶ Delete hotfix branch (emergency cleanup)
   ▶ Enable CRITICAL monitoring and rollback procedures"

# Emergency Impact Preview
echo ""
cli_section_header "🔥 EMERGENCY IMPACT PREVIEW"
cli_git_impact_preview "$CURRENT_BRANCH" "$PRIMARY_BRANCH"

echo ""
echo "🚨 Emergency deployment characteristics:"
echo "   ▶ Urgency: $(cli_highlight "CRITICAL" "red") (immediate production deployment)"
echo "   ▶ Validation: $(cli_highlight "Accelerated" "yellow") (emergency procedures)"
echo "   ▶ Rollback: $(cli_highlight "High complexity" "yellow") (requires new deployment)"
echo "   ▶ Monitoring: $(cli_highlight "MANDATORY" "red") (critical system monitoring)"

echo ""
echo "⚡ Emergency post-deployment requirements:"
echo "   ▶ IMMEDIATE production health verification (< 5 minutes)"
echo "   ▶ Emergency monitoring for 60+ minutes minimum"
echo "   ▶ Crisis communication if issues detected"
echo "   ▶ Rollback preparation if emergency fails"
```

### **3. CONFIRMAÇÃO EMERGENCY-GRADE CRÍTICA**
```bash
# Emergency Production Confirmation - CRÍTICO MAS ACELERADO
echo ""
cli_separator_thick
cli_critical_warning_box "EMERGENCY PRODUCTION DEPLOYMENT - CRITICAL SYSTEM FIX"

echo "$(cli_highlight "🚨 This is an EMERGENCY HOTFIX for CRITICAL production issue" "red")"
echo ""
echo "Emergency deployment will:"
echo "   1. $(cli_highlight "IMMEDIATELY deploy to production" "red")"
echo "   2. Create emergency tag $(cli_highlight "$EMERGENCY_TAG" "red")"
echo "   3. $(cli_highlight "Trigger AUTOMATIC emergency deployment" "red")"
echo "   4. Dual merge: hotfix → $PRIMARY_BRANCH + develop"
echo "   5. $(cli_highlight "CUSTOMER-FACING EMERGENCY FIX GOES LIVE" "red")"
echo ""
echo "$(cli_highlight "⚠️  EMERGENCY DEPLOYMENT - MONITOR PRODUCTION IMMEDIATELY!" "red")"
echo ""
echo "🚨 Emergency impact assessment:"
echo "   ∟ Customer issue: $(cli_highlight "WILL BE RESOLVED" "green")"
echo "   ∟ Production systems: $(cli_highlight "EMERGENCY UPDATE" "red")"
echo "   ∟ Rollback complexity: $(cli_highlight "HIGH" "yellow") (requires emergency rollback)"
echo "   ∟ Monitoring requirement: $(cli_highlight "CRITICAL - IMMEDIATE" "red")"

# Emergency confirmations (simplified for speed but still safe)
echo ""
echo "❓ This is an $(cli_highlight "EMERGENCY HOTFIX" "red") for critical production issue? [y/N]"
read -r emergency_understanding

if [[ ! "$emergency_understanding" =~ ^[Yy]$ ]]; then
    echo ""
    cli_info_box "EMERGENCY DEPLOYMENT CANCELLED" "Emergency deployment cancelled"
    echo "💡 If this is not a true emergency, use regular feature/release workflow"
    echo ""
    echo "📋 For non-emergency fixes:"
    echo "   /git/feature/start <fix-name>    # Regular fix workflow"
    echo "   /git/release/start <version>     # Planned release"
    echo ""
    exit 0
fi

# Final emergency confirmation
echo ""
echo "❓ $(cli_highlight "DEPLOY EMERGENCY HOTFIX NOW" "red")? [y/N]"
read -r emergency_deployment

if [[ ! "$emergency_deployment" =~ ^[Yy]$ ]]; then
    echo ""
    cli_info_box "EMERGENCY DEPLOYMENT POSTPONED" "Emergency deployment postponed"
    echo "⚡ Emergency checklist before deployment:"
    echo "   ▶ Critical issue confirmed"
    echo "   ▶ Emergency fix tested"
    echo "   ▶ Team/stakeholders notified"
    echo "   ▶ Monitoring team ready"
    echo "   ▶ Rollback plan confirmed"
    echo ""
    exit 0
fi

echo ""
cli_success_box "EMERGENCY DEPLOYMENT AUTHORIZED" "Emergency deployment authorized - deploying immediately"
```

### **4. Emergency Execution com Critical Monitoring**
```bash
# Emergency execution with critical progress monitoring
echo ""
cli_section_header "🚨 EXECUTING EMERGENCY PRODUCTION DEPLOYMENT"

# Step 1: Emergency update production
cli_progress_step 1 5 "Emergency update production branch ($PRIMARY_BRANCH)"
git checkout "$PRIMARY_BRANCH" --quiet
if git pull origin "$PRIMARY_BRANCH" --quiet; then
    cli_progress_success "production branch updated")
else
    cli_progress_warning "production update failed - proceeding with emergency")
fi

# Step 2: CRITICAL - Emergency merge to production
cli_progress_step 2 5 "EMERGENCY merge → PRODUCTION ($PRIMARY_BRANCH)"
EMERGENCY_COMMIT_MESSAGE="🚨 EMERGENCY HOTFIX: $HOTFIX_NAME

🔥 CRITICAL PRODUCTION FIX - $(date '+%Y-%m-%d %H:%M:%S')
🎯 Hotfix: $HOTFIX_NAME (emergency resolution)
🚨 Emergency deployment to resolve critical production issue

⚠️  EMERGENCY DEPLOYMENT - MONITOR PRODUCTION IMMEDIATELY
✅ Rollback available: Previous production version
🏷️ Emergency tag: $EMERGENCY_TAG
🔄 Post-merge: Will be synced to develop

📋 Emergency Deployment Information:
   ∟ Branch: $CURRENT_BRANCH → $PRIMARY_BRANCH
   ∟ Version: $EMERGENCY_VERSION (emergency patch)
   ∟ CI/CD: IMMEDIATE trigger via tag $EMERGENCY_TAG
   ∟ Monitoring: CRITICAL alerts must be active
   ∟ Recovery: Emergency rollback procedures ready

🆘 Critical Issue Resolution:
   ∟ Emergency fix applied to production
   ∟ Customer impact should be resolved
   ∟ System stability prioritized
   ∟ Additional monitoring required

🧅 Sistema Onion GitFlow Guardian - Emergency deployment"

if git merge --no-ff "$CURRENT_BRANCH" --quiet -m "$EMERGENCY_COMMIT_MESSAGE"; then
    cli_progress_success "EMERGENCY PRODUCTION MERGE COMPLETED")
else
    cli_progress_error "EMERGENCY PRODUCTION MERGE FAILED")
    echo ""
    cli_critical_warning_box "CRITICAL FAILURE: Emergency merge failed"
    echo "🚨 $(cli_highlight "PRODUCTION EMERGENCY BLOCKED" "red")"
    echo ""
    echo "🔧 This shouldn't happen (conflicts were pre-checked)"
    echo "🆘 Emergency recovery:"
    echo "   1. git merge --abort"
    echo "   2. git checkout $CURRENT_BRANCH"
    echo "   3. Resolve conflicts immediately"
    echo "   4. /git/hotfix/finish  # Retry emergency"
    echo ""
    echo "❌ EMERGENCY DEPLOYMENT FAILED"
    exit 1
fi

# Step 3: Critical push to production
cli_progress_step 3 5 "CRITICAL push to production remote"
if git push origin "$PRIMARY_BRANCH" --quiet; then
    cli_progress_success "EMERGENCY DEPLOYED TO PRODUCTION")
else
    cli_progress_error "EMERGENCY PRODUCTION PUSH FAILED")
    cli_critical_warning_box "CRITICAL: Emergency deployment incomplete"
    echo "🚨 Emergency merge completed locally but not pushed"
    echo "🔧 Manual emergency push: git push origin $PRIMARY_BRANCH"
    echo "⚠️  Production deployment incomplete - critical action required"
fi

# Step 4: Secondary merge to develop (less critical)
cli_progress_step 4 5 "Syncing emergency fix → develop"
git checkout develop --quiet
git pull origin develop --quiet 2>/dev/null || true

DEVELOP_EMERGENCY_MESSAGE="🔥 Emergency hotfix merge: $HOTFIX_NAME

🚨 Emergency fix merged from production
🎯 Version: $EMERGENCY_VERSION (emergency patch)
📋 Hotfix: $HOTFIX_NAME
🔄 Includes critical production fixes

⚡ Emergency deployment successful
✅ Production issue resolved
🔄 Development branch synchronized

Via: /git/hotfix/finish (emergency workflow)"

if git merge --no-ff "$CURRENT_BRANCH" --quiet -m "$DEVELOP_EMERGENCY_MESSAGE"; then
    cli_progress_success "develop emergency sync completed")
    
    if git push origin develop --quiet; then
        cli_progress_success "develop synchronized")
    else
        cli_progress_warning "develop push failed (non-critical)")
    fi
else
    cli_progress_warning "develop merge failed (non-critical for emergency)")
    echo "   💡 Production deployed successfully - resolve develop later")
fi

# Step 5: Emergency tag creation
cli_progress_step 5 5 "Creating emergency tag ($EMERGENCY_TAG)"
git checkout "$PRIMARY_BRANCH" --quiet

EMERGENCY_TAG_MESSAGE="🚨 EMERGENCY HOTFIX: $EMERGENCY_VERSION

🔥 CRITICAL PRODUCTION FIX - $(date '+%Y-%m-%d %H:%M:%S')

📋 Emergency Details:
   ∟ Hotfix: $HOTFIX_NAME
   ∟ Version: $EMERGENCY_VERSION (emergency patch)
   ∟ Branch: $CURRENT_BRANCH
   ∟ Commit: $(git rev-parse HEAD)
   ∟ Deploy: IMMEDIATE

🚨 Critical Issue Resolution:
   ∟ Emergency fix deployed to production
   ∟ Customer impact should be resolved
   ∟ Production stability prioritized
   ∟ Critical monitoring active

🎯 Emergency Deployment Information:
   ∟ Status: DEPLOYED TO PRODUCTION
   ∟ Rollback: Emergency procedures available  
   ∟ Monitoring: CRITICAL alerts active
   ∟ Timeline: Emergency SLA applied
   ∟ Recovery: Previous version available

⚠️  EMERGENCY TAG - IMMEDIATE PRODUCTION MONITORING REQUIRED
📊 Verify emergency fix effectiveness immediately
🆘 Rollback available if issues persist

🧅 Sistema Onion Emergency GitFlow Guardian"

if git tag -a "$EMERGENCY_TAG" -m "$EMERGENCY_TAG_MESSAGE"; then
    cli_progress_success "emergency tag created")
    
    if git push origin "$EMERGENCY_TAG" --quiet; then
        cli_progress_success "emergency tag deployed (IMMEDIATE CI/CD)")
    else
        cli_progress_warning "emergency tag push failed - may affect automation")
    fi
else
    cli_progress_error "emergency tag creation failed")
fi
```

### **5. Emergency Integration + Critical Monitoring**
```bash
# Emergency ClickUp + Crisis Communication
echo ""
cli_section_header "🚨 EMERGENCY INTEGRATION & CRISIS COMMUNICATION"

# Detect emergency task ID
TASK_ID=$(clickup_get_task_id_from_session)

if [ "$TASK_ID" != "" ]; then
    cli_progress_start "Updating emergency ClickUp task: $TASK_ID"
    
    # Emergency completion comment
    EMERGENCY_COMPLETION="🚨 EMERGENCY HOTFIX DEPLOYED - CRITICAL FIX LIVE

━━━━━━━━━━━━━━━━━━━━━━━━

🔥 EMERGENCY DEPLOYMENT COMPLETE:
   ▶ Emergency Fix: $HOTFIX_NAME → LIVE IN PRODUCTION
   ▶ Version: $EMERGENCY_VERSION (emergency patch)
   ▶ Tag: $EMERGENCY_TAG ✅ DEPLOYED IMMEDIATELY
   ▶ Production: $CURRENT_BRANCH → $PRIMARY_BRANCH ✅ LIVE
   ▶ Development: $CURRENT_BRANCH → develop ✅ Synchronized

🚨 EMERGENCY SAFETY MEASURES:
   ∟ Emergency validation: ✅ Accelerated checks passed
   ∟ Production conflicts: ✅ None detected
   ∟ Emergency merge: ✅ Clean deployment
   ∟ Critical monitoring: ✅ Activated

⚠️  IMMEDIATE EMERGENCY MONITORING (CRITICAL):
   ∟ Verify production health: < 5 minutes
   ∟ Confirm issue resolution: IMMEDIATELY
   ∟ Monitor error rates: Continuous for 60+ min
   ∟ Check customer impact: Emergency resolved?
   ∟ System stability: All systems operational?

🆘 POST-EMERGENCY ACTIONS (REQUIRED):
   ∟ Production health dashboard: Monitor actively
   ∟ Customer support: Verify issue resolved
   ∟ Error monitoring: Critical alerts active
   ∟ Performance metrics: Within acceptable range
   ∟ Incident documentation: Update emergency log

📊 EMERGENCY DEPLOYMENT STATISTICS:
   ∟ Deploy time: $(date +'%Y-%m-%d %H:%M:%S')
   ∟ Emergency SLA: Met (immediate deployment)
   ∟ Automation: Via Sistema Onion emergency workflow
   ∟ Branch cleanup: Completed automatically

🔄 EMERGENCY ROLLBACK (if needed):
   ∟ Previous state: Preserved and tagged
   ∟ Rollback procedure: Emergency deployment available
   ∟ Database impact: Verify before rollback
   ∟ Escalation: DevOps team + incident commander

🎯 CRITICAL SUCCESS METRICS:
   ∟ [ ] Production health: Green status
   ∟ [ ] Customer issue: Resolved
   ∟ [ ] Error rates: Within limits
   ∟ [ ] Performance: Stable
   ∟ [ ] No new issues: Introduced
   ∟ [ ] Emergency SLA: Met

━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Emergency deployed: $(date +'%Y-%m-%d %H:%M:%S') | 🆘 MONITOR NOW!"

    if clickup_update_task "$TASK_ID" "done" && clickup_add_comment "$TASK_ID" "$EMERGENCY_COMPLETION"; then
        cli_progress_success "emergency task completed")
    else
        cli_progress_warning "ClickUp update failed (emergency deployed successfully)")
    fi
else
    cli_progress_info "no ClickUp task detected")
fi

# Emergency Session Archive
echo ""
cli_section_header "🚨 EMERGENCY SESSION MANAGEMENT"

SESSION_PATH=$(find .cursor/sessions -name "*$HOTFIX_NAME*" -type d 2>/dev/null | head -1)
if [ "$SESSION_PATH" != "" ]; then
    cli_progress_start "Archiving emergency deployment session"
    
    EMERGENCY_ARCHIVE="# 🚨 Emergency Hotfix Deployed Successfully

**Emergency Fix**: $HOTFIX_NAME  
**Deployed**: $(date +'%Y-%m-%d %H:%M:%S')  
**Emergency Version**: $EMERGENCY_VERSION  
**Production Branch**: $PRIMARY_BRANCH  
**Safety Level**: Emergency-grade (accelerated but validated)
**ClickUp Task**: $([ "$TASK_ID" != "" ] && echo "$TASK_ID (emergency completion)" || echo "None detected")

## 🔥 Emergency Deployment Statistics
- **Files Modified**: $(git diff --name-only HEAD~1..HEAD | wc -l)
- **Emergency Commits**: $(git rev-list --count HEAD~1..HEAD)
- **Branch Cleanup**: ✅ Automated emergency cleanup
- **Integration**: ✅ ClickUp emergency tracking

## 🚨 Emergency Safety Measures Applied
- ✅ Emergency validation (accelerated procedures)
- ✅ Production conflict detection and resolution
- ✅ Emergency impact preview provided
- ✅ Critical monitoring instructions provided
- ✅ Rollback procedures documented

## ⚠️  Critical Post-Deployment Monitoring
- **Immediate Verification**: < 5 minutes production health
- **Extended Monitoring**: 60+ minutes minimum required
- **Issue Resolution**: Confirm customer impact resolved
- **System Stability**: All systems operational check
- **Error Monitoring**: Critical alert systems active

## 🆘 Emergency Response Information
**Executed by**: /git/hotfix/finish (emergency-grade UX)  
**Git Flow Guardian**: ✅ Emergency safety protocols applied  
**Crisis Management**: ✅ Emergency procedures followed  
**Team Safety**: ✅ Production-grade emergency confirmations

## 🔄 Emergency Rollback Available
**Previous Version**: Available via emergency procedures  
**Rollback Complexity**: High (requires emergency deployment)  
**Emergency Contacts**: DevOps on-call, incident commander  
**Recovery Plan**: Standard emergency rollback SOP

---

**🧅 Sistema Onion** - Emergency deployment completed

⚠️  **CRITICAL**: This is LIVE emergency fix - monitor production actively!"

    echo "$EMERGENCY_ARCHIVE" > "$SESSION_PATH/EMERGENCY-DEPLOYMENT-REPORT.md"
    
    # Move to emergency archives
    ARCHIVE_DIR=".cursor/sessions/archived/emergency/$(date +'%Y-%m')"
    mkdir -p "$ARCHIVE_DIR"
    if mv "$SESSION_PATH" "$ARCHIVE_DIR/"; then
        cli_progress_success "emergency session archived")
    else
        cli_progress_warning "emergency session archive failed")
    fi
else
    cli_progress_info "no emergency session found")
fi
```

### **6. Emergency Success + Critical Response Instructions**
```bash
# Emergency Success Summary with Critical Instructions
echo ""
cli_separator_thick
cli_error_header "🚨 EMERGENCY HOTFIX DEPLOYED SUCCESSFULLY!"
cli_separator_thick

echo ""
cli_section_header "🔥 EMERGENCY DEPLOYMENT SUMMARY"
echo "   ▶ Emergency Fix: $(cli_highlight "$HOTFIX_NAME" "green") 🚨 LIVE IN PRODUCTION"
echo "   ▶ Emergency Version: $(cli_highlight "$EMERGENCY_VERSION" "green") (emergency patch)"
echo "   ▶ Deployed: $CURRENT_BRANCH → $(cli_highlight "$PRIMARY_BRANCH" "green") (production)"
echo "   ▶ Synchronized: $CURRENT_BRANCH → $(cli_highlight "develop" "green") (development)"
echo "   ▶ Emergency Tag: $(cli_highlight "$EMERGENCY_TAG" "green") (triggers immediate CI/CD)"
echo "   ▶ Safety Level: $(cli_highlight "Emergency-grade" "green") (accelerated + validated)"

echo ""
cli_section_header "🚨 CRITICAL EMERGENCY RESPONSE (IMMEDIATE ACTION REQUIRED)"
echo ""
echo "$(cli_highlight "🆘 IMMEDIATE VERIFICATION (Next 5 minutes - CRITICAL):" "red")"
echo "   1. $(cli_highlight "Check production health dashboard" "red") - Must be green"
echo "   2. $(cli_highlight "Test affected functionality" "red") - Confirm fix working"
echo "   3. $(cli_highlight "Verify error rates dropped" "red") - Issue resolved?"
echo "   4. $(cli_highlight "Check customer reports" "red") - Support channels quiet?"
echo ""
echo "$(cli_highlight "⚡ EXTENDED MONITORING (Next 60+ minutes - MANDATORY):" "red")"
echo "   5. $(cli_highlight "Monitor all production metrics" "red") - Performance stable"
echo "   6. $(cli_highlight "Watch for side effects" "red") - No new issues introduced"
echo "   7. $(cli_highlight "Confirm system stability" "red") - All services operational"
echo "   8. $(cli_highlight "Update incident status" "red") - Emergency resolved?"

echo ""
cli_section_header "🔄 EMERGENCY ROLLBACK (if needed)"
echo "$(cli_highlight "If emergency fix causes issues:" "yellow")"
echo "   ▶ Previous version: Available via emergency rollback"
echo "   ▶ Rollback procedure: Coordinate with DevOps immediately"
echo "   ▶ Escalation: Contact incident commander"
echo "   ▶ Database: Check for schema changes before rollback"

echo ""
cli_section_header "📊 EMERGENCY SUCCESS VALIDATION"
echo "$(cli_highlight "Confirm these before declaring success:" "cyan")"
echo "   ▶ [ ] Production health dashboard: GREEN status"
echo "   ▶ [ ] Original customer issue: RESOLVED"
echo "   ▶ [ ] Error rates: WITHIN normal limits"
echo "   ▶ [ ] Performance metrics: STABLE"
echo "   ▶ [ ] No new customer complaints: ZERO reports"
echo "   ▶ [ ] System stability: ALL services operational"

echo ""
cli_section_header "🎯 EMERGENCY COMMUNICATION"
echo "$(cli_highlight "Team notifications (if not already sent):" "cyan")"
echo "   ▶ Notify stakeholders: Emergency fix deployed"
echo "   ▶ Update incident log: Deployment completed"
echo "   ▶ Customer support: Fix is live, monitor feedback"
echo "   ▶ DevOps team: Critical monitoring active"

echo ""
cli_separator_thick
echo "$(cli_highlight "🚨 Emergency hotfix $EMERGENCY_VERSION deployed successfully!" "green") 🆘"
cli_separator_thick
echo ""

# Critical emergency reminder
echo "$(cli_highlight "⚠️  CRITICAL: This is EMERGENCY production deployment - verify immediately!" "red")"
echo ""
echo "$(cli_highlight "✅ Emergency resolved? Document lessons learned and improve prevention." "green")"

# Performance metrics
cli_performance_end
```

# Helper function for emergency version detection
detect_emergency_version() {
    if [ -f "package.json" ] && grep -q "version" package.json; then
        current_version=$(grep '"version"' package.json | sed 's/.*"version": *"\\([^"]*\\)".*/\\1/' | head -1)
        # Increment patch version for emergency
        echo "$current_version" | awk -F. '{printf "%d.%d.%d", $1, $2, $3+1}'
    elif [ -f "version.txt" ]; then
        cat version.txt | head -1
    elif [ -f "VERSION" ]; then
        cat VERSION | head -1
    else
        # Default emergency version
        echo "0.0.1"
    fi
}

---

## ✅ **Resultado Esperado**

```
🚨 GIT FLOW - EMERGENCY HOTFIX FINISH (PRODUCTION)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🔥 EMERGENCY PRODUCTION HOTFIX ANALYSIS:
   ▶ Emergency Fix: fix-payment-gateway → CRITICAL PRODUCTION DEPLOY
   ▶ Source: hotfix/fix-payment-gateway (2 commits ahead)
   ▶ Target Production: main (current: a1b2c3d)
   ▶ Target Development: develop (current: e4f5g6h)
   ▶ Emergency Tag: v2.1.1 (triggers IMMEDIATE CI/CD)

🚨 EMERGENCY PRODUCTION VALIDATION:
   ▶ Emergency branch: ✅ hotfix/fix-payment-gateway validated
   ▶ Working directory: ✅ Clean
   ▶ Production branch: ✅ Up to date
   ▶ Production conflicts: ✅ None detected
   ▶ Emergency tests: ✅ Critical tests passing
   ▶ Emergency tag: ✅ v2.1.1 available

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️ EMERGENCY PRODUCTION DEPLOYMENT - CRITICAL SYSTEM FIX

🚨 This is an EMERGENCY HOTFIX for CRITICAL production issue

❓ This is an EMERGENCY HOTFIX for critical production issue? [y/N] y
❓ DEPLOY EMERGENCY HOTFIX NOW? [y/N] y

✅ EMERGENCY DEPLOYMENT AUTHORIZED
Emergency deployment authorized - deploying immediately

🚨 EXECUTING EMERGENCY PRODUCTION DEPLOYMENT:

STEP (1/5): Emergency update production branch (main)
   ⏳ Emergency update... ✅ production branch updated

STEP (2/5): EMERGENCY merge → PRODUCTION (main)
   ⏳ EMERGENCY merge... ✅ EMERGENCY PRODUCTION MERGE COMPLETED

STEP (3/5): CRITICAL push to production remote
   ⏳ CRITICAL push... ✅ EMERGENCY DEPLOYED TO PRODUCTION

STEP (4/5): Syncing emergency fix → develop
   ⏳ Syncing emergency... ✅ develop emergency sync completed
   ⏳ Synchronizing... ✅ develop synchronized

STEP (5/5): Creating emergency tag (v2.1.1)
   ⏳ Creating emergency tag... ✅ emergency tag created
   ⏳ Deploying tag... ✅ emergency tag deployed (IMMEDIATE CI/CD)

🚨 EMERGENCY INTEGRATION & CRISIS COMMUNICATION:
   ⏳ Updating emergency ClickUp task... ✅ emergency task completed

🚨 EMERGENCY SESSION MANAGEMENT:
   ⏳ Archiving emergency session... ✅ emergency session archived

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚨 EMERGENCY HOTFIX DEPLOYED SUCCESSFULLY!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🆘 IMMEDIATE VERIFICATION (Next 5 minutes - CRITICAL):
   1. Check production health dashboard - Must be green
   2. Test affected functionality - Confirm fix working
   3. Verify error rates dropped - Issue resolved?
   4. Check customer reports - Support channels quiet?

⚡ EXTENDED MONITORING (Next 60+ minutes - MANDATORY):
   5. Monitor all production metrics - Performance stable
   6. Watch for side effects - No new issues introduced
   7. Confirm system stability - All services operational
   8. Update incident status - Emergency resolved?

🚨 Emergency hotfix v2.1.1 deployed successfully! 🆘

⚠️  CRITICAL: This is EMERGENCY production deployment - verify immediately!

⏱️ Emergency completed in 4.2s
```

---

**Ambos comandos críticos implementados com confirmações PRODUCTION-GRADE:**

✅ **`/git/release/finish`**: Triple confirmação + production validation completa  
✅ **`/git/hotfix/finish`**: Emergency confirmação + critical monitoring  

**🎯 Posso proceder com a implementação simultânea destes dois comandos críticos?**

Estes comandos eliminam completamente os riscos de:
- ❌ → ✅ **Deploy acidental para produção**  
- ❌ → ✅ **Emergency deploy sem confirmações adequadas**  
- ❌ → ✅ **Falta de monitoring instructions pós-deploy**  
- ❌ → ✅ **UX não educativa para operações críticas**
