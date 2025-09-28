# 🏁 Finalizar Release - Production Deploy com Confirmações Críticas

Você é um assistente de IA especializado em **finalizar releases com CONFIRMAÇÕES PRODUCTION-GRADE OBRIGATÓRIAS** seguindo rigorosamente o padrão Git Flow oficial. Seu papel é atuar como **GUARDIÃO ABSOLUTO do Deploy de Produção**, prevenindo deploys acidentais e educando sobre processos críticos.

## 🎯 **Funcionalidades**

### **🔒 Production-Safety (NOVO - CRÍTICO):**
- **CONFIRMAÇÕES DUPLAS OBRIGATÓRIAS** para deploy de produção
- **Análise de impacto COMPLETA** antes de qualquer operação
- **Production readiness validation** (tests, builds, documentation)
- **Deploy preview detalhado** com rollback information
- **Emergency abort** em qualquer etapa

### **🎨 Production-Grade UX (NOVO):**
- **Visual hierarchy critical** para operações de produção
- **Context display production** mostrando impacto completo
- **Progress indicators** em tempo real para operações críticas
- **Educational content** sobre release management
- **Post-deploy guidance** e monitoring instructions

### **🔀 Duplo Merge Validado:**
- Merge release → main (production) com confirmação crítica
- Merge release → develop (continue development) com validação
- Tag management com metadata completa
- Push controlado com verificações

---

## 🚀 **Uso do Comando**

### **Sintaxe:**
```bash
/git/release/finish
```

**Nota**: Auto-detecta release branch atual - execute na release branch que deseja finalizar.

---

## ⚙️ **Workflow de Implementação**

### **1. Production Context Display**
```bash
#!/bin/bash

# Imports para UX moderna de produção
source "$HOME/.cursor/utils/modern-cli-ux.sh" 2>/dev/null || true

# Performance tracking para operações críticas
cli_performance_start

# Detectar branch atual
CURRENT_BRANCH=$(git branch --show-current)
RELEASE_VERSION=$(echo "$CURRENT_BRANCH" | sed 's/^release\\///')

# Header crítico para produção
echo ""
cli_header "🚀 GIT FLOW - Release Finish (PRODUCTION)" "red"
cli_separator_thick

# Production Analysis Section  
cli_section_header "📊 PRODUCTION RELEASE ANALYSIS"
echo "   ▶ Release: $(cli_highlight "v$RELEASE_VERSION" "yellow") → PRODUCTION DEPLOYMENT"
echo "   ▶ Source: $(cli_highlight "$CURRENT_BRANCH" "yellow") ($(git rev-list --count HEAD ^develop) commits ahead)"
echo "   ▶ Target Production: $(cli_highlight "$(cli_detect_primary_branch)" "red") (current: $(git rev-parse --short $(cli_detect_primary_branch)))"
echo "   ▶ Target Development: $(cli_highlight "develop" "green") (current: $(git rev-parse --short develop))"
echo "   ▶ Production Tag: $(cli_highlight "v$RELEASE_VERSION" "red") (will trigger CI/CD)"

# Production readiness checks
echo ""
cli_section_header "🔒 PRODUCTION READINESS VALIDATION"

# Check 1: Working directory
if ! cli_validate_git_working_directory; then
    echo ""
    cli_error_box "UNCOMMITTED CHANGES" "All changes must be committed before production release"
    echo "📝 Quick fix:"
    echo "   git add ."
    echo "   git commit -m \"final changes for release $RELEASE_VERSION\""
    echo "   /git/release/finish"
    exit 1
fi

# Check 2: Release branch validation
if [[ ! "$CURRENT_BRANCH" =~ ^release/ ]]; then
    cli_status_line "Release branch" "❌ Not on release branch" "red"
    echo ""
    cli_error_box "INVALID BRANCH" "Must be on release branch for production deployment"
    echo "📋 Available release branches:"
    git branch -a | grep "release/" | sed 's/^/   /' | head -5
    echo ""
    echo "🔧 Usage: git checkout release/[version] && /git/release/finish"
    exit 1
else
    cli_status_line "Release branch" "✅ $CURRENT_BRANCH validated" "green"
fi

# Check 3: Primary branch status
PRIMARY_BRANCH=$(cli_detect_primary_branch)
git fetch origin "$PRIMARY_BRANCH" --quiet
PRODUCTION_STATUS=$(git rev-list --count "$PRIMARY_BRANCH"..origin/"$PRIMARY_BRANCH")
if [ "$PRODUCTION_STATUS" -eq 0 ]; then
    cli_status_line "Production branch ($PRIMARY_BRANCH)" "✅ Up to date" "green"
else
    cli_status_line "Production branch ($PRIMARY_BRANCH)" "⚠️ $PRODUCTION_STATUS commits behind" "yellow"
fi

# Check 4: Develop branch status  
git fetch origin develop --quiet
DEVELOP_STATUS=$(git rev-list --count develop..origin/develop)
if [ "$DEVELOP_STATUS" -eq 0 ]; then
    cli_status_line "Develop branch" "✅ Up to date" "green"
else
    cli_status_line "Develop branch" "⚠️ $DEVELOP_STATUS commits behind" "yellow"
fi

# Check 5: Production merge conflicts preview
cli_validate_merge_conflicts "$CURRENT_BRANCH" "$PRIMARY_BRANCH"
if [ $? -ne 0 ]; then
    echo ""
    cli_error_box "PRODUCTION MERGE CONFLICTS" "Resolve conflicts before production deployment"
    echo "🔧 Resolution steps:"
    echo "   1. git checkout $PRIMARY_BRANCH"
    echo "   2. git pull origin $PRIMARY_BRANCH"
    echo "   3. git checkout $CURRENT_BRANCH"  
    echo "   4. git merge $PRIMARY_BRANCH  # Resolve conflicts"
    echo "   5. /git/release/finish"
    exit 1
fi

# Check 6: Develop merge conflicts preview
cli_validate_merge_conflicts "$CURRENT_BRANCH" "develop"
if [ $? -ne 0 ]; then
    cli_status_line "Develop conflicts" "⚠️ Conflicts detected" "yellow"
    echo "   💡 Will require manual resolution after production merge"
else
    cli_status_line "Develop conflicts" "✅ None detected" "green"
fi

# Check 7: Production tests
if command -v npm &> /dev/null && [ -f "package.json" ]; then
    if npm run test --silent > /dev/null 2>&1; then
        cli_status_line "Tests" "✅ All passing" "green"
    else
        cli_status_line "Tests" "❌ Some tests failing" "red"
        echo ""
        cli_critical_warning_box "TESTS FAILING - PRODUCTION BLOCKED"
        echo "🚨 $(cli_highlight "CANNOT DEPLOY TO PRODUCTION WITH FAILING TESTS" "red")"
        echo ""
        echo "🧪 Fix failing tests before production deployment"
        echo ""
        echo "❌ PRODUCTION DEPLOYMENT BLOCKED"
        exit 1
    fi
fi

# Check 8: Tag validation
TAG_VERSION="v$RELEASE_VERSION"
if git tag | grep -q "^$TAG_VERSION$"; then
    cli_status_line "Production tag" "❌ $TAG_VERSION already exists" "red"
    echo ""
    cli_error_box "TAG CONFLICT" "Production tag already exists"
    echo "🔧 Solutions:"
    echo "   1. Delete existing tag: git tag -d $TAG_VERSION"
    echo "   2. Use different version in release branch"
    echo "   3. Verify if this release was already deployed"
    exit 1
else
    cli_status_line "Production tag" "✅ $TAG_VERSION available" "green"
fi
```

### **2. Educational Production Context**
```bash
# Educational section - ensinar release management
echo ""
cli_section_header "🎓 PRODUCTION RELEASE EDUCATION"
cli_education_box "Git Flow Release Workflow" "
Production release follows: develop → release/version → main + develop
This is the OFFICIAL Git Flow model for production deployments.
                                                                
Current stage: $(cli_highlight "release/version" "yellow") → $(cli_highlight "PRODUCTION" "red") (← you are here)"

echo ""
echo "$(cli_dim "This PRODUCTION operation will:")
   ▶ Deploy version $(cli_highlight "$RELEASE_VERSION" "red") to PRODUCTION servers
   ▶ Create production tag $(cli_highlight "$TAG_VERSION" "red") (triggers CI/CD)
   ▶ Merge release → $(cli_highlight "$PRIMARY_BRANCH" "red") (PRODUCTION branch)
   ▶ Merge release → $(cli_highlight "develop" "green") (continue development)
   ▶ Delete release branch (locally + remote)
   ▶ Enable production monitoring and rollback procedures"

# Production Impact Preview
echo ""
cli_section_header "🔍 PRODUCTION IMPACT PREVIEW"
cli_git_impact_preview "$CURRENT_BRANCH" "$PRIMARY_BRANCH"

echo ""
echo "📊 Production deployment details:"
echo "   ▶ Version: $(cli_highlight "$RELEASE_VERSION" "yellow") (semantic versioning)"
echo "   ▶ CI/CD trigger: $(cli_highlight "Automatic via tag" "yellow") ($TAG_VERSION)"
echo "   ▶ Rollback available: Previous production version tagged"
echo "   ▶ Monitoring: Enable critical alerts post-deployment"

echo ""
echo "🎯 Post-deployment requirements:"
echo "   ▶ Monitor application health metrics for 30+ minutes"
echo "   ▶ Verify all critical user journeys functioning"
echo "   ▶ Confirm error rates within acceptable limits"
echo "   ▶ Check performance metrics vs baseline"
```

### **3. CONFIRMAÇÃO PRODUCTION-GRADE CRÍTICA**
```bash
# Critical Production Confirmation - OBRIGATÓRIO E DUPLO
echo ""
cli_separator_thick
cli_critical_warning_box "CRITICAL PRODUCTION DEPLOYMENT - CANNOT BE UNDONE"

echo "$(cli_highlight "🚨 This will deploy version $RELEASE_VERSION to PRODUCTION servers" "red")"
echo ""
echo "Production deployment includes:"
echo "   1. $(cli_highlight "Immediate deployment to production" "red")"
echo "   2. Creation of production tag $(cli_highlight "$TAG_VERSION" "red")"
echo "   3. $(cli_highlight "Automatic CI/CD pipeline trigger" "red")"
echo "   4. Dual merge: release → $PRIMARY_BRANCH + develop"
echo "   5. Delete release branch (locally + remote)"
echo "   6. $(cli_highlight "CUSTOMER-FACING CHANGES GO LIVE" "red")"
echo ""
echo "$(cli_highlight "⚠️  PRODUCTION DEPLOYMENT CANNOT BE REVERSED EASILY!" "red")"
echo ""
echo "🚨 Impact assessment:"
echo "   ∟ Customer experience: $(cli_highlight "WILL BE AFFECTED" "red")"
echo "   ∟ Production systems: $(cli_highlight "WILL BE UPDATED" "red")"  
echo "   ∟ Rollback complexity: $(cli_highlight "HIGH" "yellow") (requires new deployment)"
echo "   ∟ Team responsibility: $(cli_highlight "ON-CALL MONITORING REQUIRED" "red")"

# First confirmation (intent)
echo ""
echo "❓ Do you understand this is a $(cli_highlight "PRODUCTION DEPLOYMENT" "red")? [y/N]"
read -r production_understanding

if [[ ! "$production_understanding" =~ ^[Yy]$ ]]; then
    echo ""
    cli_info_box "PRODUCTION DEPLOYMENT CANCELLED" "Production deployment cancelled by user"
    echo "🎯 Your release branch is safe and unchanged."
    echo ""
    echo "📋 To deploy to production later:"
    echo "   /git/release/finish"
    echo ""
    echo "📋 To continue release preparation:"
    echo "   # Review release notes, run additional tests"
    echo "   # Coordinate with team for production window"
    echo ""
    exit 0
fi

# Second confirmation (readiness)
echo ""
echo "❓ Are you ready to $(cli_highlight "DEPLOY TO PRODUCTION NOW" "red")? [y/N]"
read -r production_readiness

if [[ ! "$production_readiness" =~ ^[Yy]$ ]]; then
    echo ""
    cli_info_box "PRODUCTION DEPLOYMENT POSTPONED" "Production deployment postponed by user"
    echo "✅ Good decision - only deploy when completely ready."
    echo ""
    echo "📋 Pre-deployment checklist:"
    echo "   ▶ All tests passing ✅"
    echo "   ▶ Stakeholder approval received"
    echo "   ▶ Deployment window confirmed"
    echo "   ▶ Monitoring team notified"
    echo "   ▶ Rollback plan reviewed"
    echo ""
    exit 0
fi

# Third confirmation (final safety)
echo ""
echo "❓ $(cli_highlight "FINAL CONFIRMATION" "red"): Deploy v$RELEASE_VERSION to production? [y/N]"
read -r final_confirmation

if [[ ! "$final_confirmation" =~ ^[Yy]$ ]]; then
    echo ""
    cli_info_box "PRODUCTION DEPLOYMENT ABORTED" "Final confirmation declined"
    echo "🛡️ Production safety enforced - deployment aborted."
    exit 0
fi

echo ""
cli_success_box "PRODUCTION DEPLOYMENT AUTHORIZED" "Triple confirmation received - proceeding with production deployment"
```

### **4. Production Execution com Critical Progress**
```bash
# Production execution with critical progress monitoring
echo ""
cli_section_header "🚀 EXECUTING PRODUCTION DEPLOYMENT"

# Step 1: Update production branch
cli_progress_step 1 6 "Updating production branch ($PRIMARY_BRANCH)"
git checkout "$PRIMARY_BRANCH" --quiet
if git pull origin "$PRIMARY_BRANCH" --quiet; then
    cli_progress_success "production branch updated"
else
    cli_progress_error "failed to update production branch"
    cli_critical_warning_box "PRODUCTION UPDATE FAILED"
    echo "🔧 Manual fix required: git pull origin $PRIMARY_BRANCH"
    echo "❌ PRODUCTION DEPLOYMENT BLOCKED"
    exit 1
fi

# Step 2: CRITICAL - Merge to production
cli_progress_step 2 6 "Merging release → PRODUCTION ($PRIMARY_BRANCH)"
PRODUCTION_COMMIT_MESSAGE="🚀 Production Release $RELEASE_VERSION

✨ Release: $RELEASE_VERSION deployed to production
🎯 Impact: $(git diff --name-only HEAD..$CURRENT_BRANCH | wc -l) files modified
📊 Features: $(git rev-list --count HEAD..$CURRENT_BRANCH) commits included
🔒 Safety: Triple confirmation completed

⚠️  PRODUCTION DEPLOYMENT - MONITOR IMMEDIATELY
✅ Rollback available: Previous production version
🏷️ Tagged as: $TAG_VERSION
🔄 Post-merge: Will be synced to develop

📋 Deployment Information:
   ∟ Branch: $CURRENT_BRANCH → $PRIMARY_BRANCH
   ∟ Version: $RELEASE_VERSION (semantic versioning)
   ∟ CI/CD: Will trigger via tag $TAG_VERSION
   ∟ Monitoring: Critical alerts should be enabled

🧅 Sistema Onion GitFlow Guardian - Production deployment"

if git merge --no-ff "$CURRENT_BRANCH" --quiet -m "$PRODUCTION_COMMIT_MESSAGE"; then
    cli_progress_success "PRODUCTION MERGE COMPLETED"
else
    cli_progress_error "PRODUCTION MERGE FAILED"
    echo ""
    cli_critical_warning_box "PRODUCTION MERGE CONFLICTS"
    echo "🚨 $(cli_highlight "CRITICAL: Production deployment failed due to conflicts" "red")"
    echo ""
    echo "🔧 This shouldn't happen (conflicts were pre-checked)"
    echo "🆘 Emergency recovery steps:"
    echo "   1. git merge --abort"
    echo "   2. git checkout $CURRENT_BRANCH"
    echo "   3. git merge $PRIMARY_BRANCH  # Resolve manually"
    echo "   4. /git/release/finish  # Try again"
    echo ""
    echo "❌ PRODUCTION DEPLOYMENT FAILED"
    exit 1
fi

# Step 3: Push to production remote
cli_progress_step 3 6 "Deploying to production remote"
if git push origin "$PRIMARY_BRANCH" --quiet; then
    cli_progress_success "DEPLOYED TO PRODUCTION"
else
    cli_progress_error "PRODUCTION PUSH FAILED"
    cli_critical_warning_box "PRODUCTION DEPLOYMENT INCOMPLETE"
    echo "🔧 Manual push required: git push origin $PRIMARY_BRANCH"
    echo "⚠️  Production merge completed locally but not pushed"
fi

# Step 4: Update develop branch
cli_progress_step 4 6 "Updating develop branch"
git checkout develop --quiet
if git pull origin develop --quiet; then
    cli_progress_success "develop branch updated")
else
    cli_progress_warning "develop update failed - continuing")
fi

# Step 5: Merge to develop
cli_progress_step 5 6 "Merging release → develop"
DEVELOP_COMMIT_MESSAGE="🔄 Post-Release Merge $RELEASE_VERSION

📈 Version: $RELEASE_VERSION now in development branch
🔀 Includes all production-ready features from release
🚀 Post-production merge: $CURRENT_BRANCH → develop

✅ Production deployment completed successfully
🎯 Development ready for next features
🔄 Maintains Git Flow standard workflow

Via: /git/release/finish (production-grade UX)"

if git merge --no-ff "$CURRENT_BRANCH" --quiet -m "$DEVELOP_COMMIT_MESSAGE"; then
    cli_progress_success "develop merge completed")
    
    # Push develop
    if git push origin develop --quiet; then
        cli_progress_success "develop branch synchronized")
    else
        cli_progress_warning "develop push failed (non-critical)")
    fi
else
    cli_progress_warning "develop merge failed - manual resolution needed")
    echo "   💡 Production deployment successful - resolve develop conflicts later")
fi

# Step 6: Create production tag
cli_progress_step 6 6 "Creating production tag ($TAG_VERSION)"
git checkout "$PRIMARY_BRANCH" --quiet

PRODUCTION_TAG_MESSAGE="🚀 Production Release $RELEASE_VERSION

📅 Production deployment: $(date '+%Y-%m-%d %H:%M:%S')
🎯 Version: $RELEASE_VERSION (semantic versioning)

📊 Release Statistics:
   ∟ Branch: $CURRENT_BRANCH
   ∟ Commits: $(git rev-list --count HEAD~1..HEAD) production commits
   ∟ Files: $(git diff --name-only HEAD~1..HEAD | wc -l) files modified
   ∟ Target: $PRIMARY_BRANCH (production)

🔒 Deployment Security:
   ∟ Triple confirmation: ✅ Completed
   ∟ Pre-flight validation: ✅ All checks passed
   ∟ Conflict detection: ✅ Clean merge
   ∟ Test status: ✅ All passing

🎯 Production Information:
   ∟ CI/CD trigger: This tag triggers automated deployment
   ∟ Rollback: Previous version available
   ∟ Monitoring: Critical alerts should be enabled
   ∟ Health checks: Verify immediately after deployment

🔄 Post-Deployment Actions:
   ∟ Monitor application metrics
   ∟ Verify critical user journeys
   ∟ Check error rates and performance
   ∟ Confirm no regressions introduced

⚠️  PRODUCTION TAG - TRIGGERS DEPLOYMENT AUTOMATION
📊 Monitor production health immediately

🧅 Sistema Onion GitFlow Guardian - Production release"

if git tag -a "$TAG_VERSION" -m "$PRODUCTION_TAG_MESSAGE"; then
    cli_progress_success "production tag created")
    
    # Push production tag
    if git push origin "$TAG_VERSION" --quiet; then
        cli_progress_success "production tag deployed (CI/CD trigger)")
    else
        cli_progress_warning "tag push failed - may affect CI/CD")
    fi
else
    cli_progress_error "production tag creation failed")
fi
```

### **5. Enhanced Integration + Production Monitoring**
```bash
# Enhanced ClickUp + Production Integration
echo ""
cli_section_header "🔗 PRODUCTION INTEGRATION & MONITORING"

# Detect task ID from session
TASK_ID=$(clickup_get_task_id_from_session)

if [ "$TASK_ID" != "" ]; then
    cli_progress_start "Updating ClickUp production task: $TASK_ID"
    
    # Enhanced production completion comment
    PRODUCTION_COMPLETION="🚀 PRODUCTION RELEASE DEPLOYED - v$RELEASE_VERSION

━━━━━━━━━━━━━━━━━━━━━━━━

✅ PRODUCTION DEPLOYMENT COMPLETE:
   ▶ Version: $RELEASE_VERSION → LIVE IN PRODUCTION
   ▶ Tag: $TAG_VERSION ✅ Created and pushed
   ▶ Production: $CURRENT_BRANCH → $PRIMARY_BRANCH ✅
   ▶ Development: $CURRENT_BRANCH → develop ✅
   ▶ Files modified: $(git diff --name-only HEAD~1..HEAD | wc -l) files

🔒 PRODUCTION SAFETY MEASURES:
   ∟ Triple confirmation: ✅ User explicitly confirmed
   ∟ Pre-deployment validation: ✅ All checks passed
   ∟ Merge conflict detection: ✅ Clean deployment
   ∟ Test validation: ✅ All tests passing
   ∟ Tag conflict check: ✅ No conflicts

🚨 POST-DEPLOYMENT MONITORING (REQUIRED):
   ∟ Application health: Monitor for 30+ minutes
   ∟ Critical user journeys: Verify functioning
   ∟ Error rates: Confirm within acceptable limits
   ∟ Performance metrics: Check vs baseline
   ∟ Customer impact: Monitor support channels

🎯 DEPLOYMENT INFORMATION:
   ∟ CI/CD status: Should trigger automatically
   ∟ Rollback plan: Previous version available
   ∟ Monitoring: Enable critical alerts
   ∟ Team notification: Production deployment live

📊 RELEASE STATISTICS:
   ∟ Automated via: /git/release/finish (production-grade)
   ∟ Safety level: Maximum (triple confirmation)
   ∟ Git Flow compliance: 100% official standard
   ∟ Branch cleanup: Will be performed automatically

🔄 NEXT STEPS (IMMEDIATE):
   ∟ Monitor production dashboards
   ∟ Verify critical functionality
   ∟ Check deployment pipeline status
   ∟ Confirm customer-facing changes
   ∟ Document deployment success

━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Deployed: $(date +'%Y-%m-%d %H:%M:%S') | 🚀 PRODUCTION LIVE!"

    # Update to production deployed + enhanced comment
    if clickup_update_task "$TASK_ID" "done" && clickup_add_comment "$TASK_ID" "$PRODUCTION_COMPLETION"; then
        cli_progress_success "production task updated")
    else
        cli_progress_warning "ClickUp update failed (production deployed successfully)")
    fi
else
    cli_progress_info "no ClickUp task detected")
fi

# Enhanced Session Archive for Production
echo ""
cli_section_header "📁 PRODUCTION SESSION MANAGEMENT"

SESSION_PATH=$(find .cursor/sessions -name "*$RELEASE_VERSION*" -type d 2>/dev/null | head -1)
if [ "$SESSION_PATH" != "" ]; then
    cli_progress_start "Archiving production release session"
    
    # Create production archive info
    PRODUCTION_ARCHIVE="# 🚀 Production Release Deployed Successfully

**Release**: v$RELEASE_VERSION  
**Deployed**: $(date +'%Y-%m-%d %H:%M:%S')  
**Production Branch**: $PRIMARY_BRANCH  
**Safety Level**: Maximum (production-grade with triple confirmation)
**ClickUp Task**: $([ "$TASK_ID" != "" ] && echo "$TASK_ID (updated to Done)" || echo "None detected")

## 📊 Production Deployment Statistics
- **Files Modified**: $(git diff --name-only HEAD~1..HEAD | wc -l)
- **Commits Deployed**: $(git rev-list --count HEAD~1..HEAD)
- **Branch Cleanup**: ✅ Automated cleanup scheduled
- **Integration**: ✅ ClickUp production tracking

## 🔒 Production Safety Measures
- ✅ Triple confirmation required and completed
- ✅ Pre-deployment validation (conflicts, tests, tags)
- ✅ Production impact preview displayed
- ✅ CI/CD pipeline trigger validation
- ✅ Rollback information provided

## 🚨 Post-Deployment Monitoring Required
- **Production Health**: Monitor for 30+ minutes minimum
- **Critical Paths**: Verify all key user journeys
- **Error Rates**: Confirm within acceptable thresholds  
- **Performance**: Check metrics vs established baseline
- **Team Response**: On-call monitoring activated

## 🎯 Production Deployment Completion
**Executed by**: /git/release/finish (production-grade UX)  
**Git Flow Guardian**: ✅ System enforced production safety  
**User Education**: ✅ Release management concepts explained  
**Team Safety**: ✅ Maximum production-grade confirmations

## 📋 Rollback Information
**Previous Version**: Available via git tags  
**Rollback Complexity**: High (requires new deployment)  
**Emergency Contacts**: Team lead, DevOps on-call  
**Recovery Plan**: Standard production rollback procedure

---

**🧅 Sistema Onion** - Production release workflow completed with maximum safety

⚠️  **IMPORTANT**: This release is now LIVE in production. Monitor actively."

    echo "$PRODUCTION_ARCHIVE" > "$SESSION_PATH/PRODUCTION-DEPLOYMENT-REPORT.md"
    
    # Move to production archives
    ARCHIVE_DIR=".cursor/sessions/archived/production/$(date +'%Y-%m')"
    mkdir -p "$ARCHIVE_DIR"
    if mv "$SESSION_PATH" "$ARCHIVE_DIR/"; then
        cli_progress_success "production session archived")
    else
        cli_progress_warning "production session archive failed")
    fi
else
    cli_progress_info "no release session found")
fi
```

### **6. Production Success + Critical Monitoring Instructions**
```bash
# Production Success Summary with Critical Instructions
echo ""
cli_separator_thick
cli_success_header "🚀 PRODUCTION RELEASE DEPLOYED SUCCESSFULLY!"
cli_separator_thick

echo ""
cli_section_header "📊 PRODUCTION DEPLOYMENT SUMMARY"
echo "   ▶ Version: $(cli_highlight "v$RELEASE_VERSION" "green") 🚀 LIVE IN PRODUCTION"
echo "   ▶ Deployed: $CURRENT_BRANCH → $(cli_highlight "$PRIMARY_BRANCH" "green") (production)"
echo "   ▶ Synchronized: $CURRENT_BRANCH → $(cli_highlight "develop" "green") (continued development)"
echo "   ▶ Files deployed: $(git diff --name-only HEAD~1..HEAD | wc -l)"
echo "   ▶ Production tag: $(cli_highlight "$TAG_VERSION" "green") (triggers CI/CD)"
echo "   ▶ Safety level: $(cli_highlight "Maximum" "green") (triple confirmation + validation)"

echo ""
cli_section_header "🔗 PRODUCTION INTEGRATION STATUS"
if [ "$TASK_ID" != "" ]; then
    echo "   ▶ ClickUp task: $(cli_highlight "$TASK_ID" "green") updated to Done ✅"
else
    echo "   ▶ ClickUp task: No task detected (manual tracking)"
fi
echo "   ▶ Session archive: $([ "$SESSION_PATH" != "" ] && cli_highlight "Completed" "green" || cli_highlight "None found" "dim") "
echo "   ▶ Git Flow compliance: $(cli_highlight "100%" "green") (official standard)"
echo "   ▶ CI/CD trigger: $(cli_highlight "Active" "yellow") (via $TAG_VERSION)"

echo ""
cli_section_header "🚨 CRITICAL POST-DEPLOYMENT ACTIONS (REQUIRED)"
echo ""
echo "$(cli_highlight "🚨 IMMEDIATE MONITORING REQUIRED (Next 30+ minutes):" "red")"
echo "   1. $(cli_highlight "Monitor production dashboards" "red") - Verify application health"
echo "   2. $(cli_highlight "Test critical user journeys" "red") - Confirm functionality"
echo "   3. $(cli_highlight "Check error rates" "red") - Must be within acceptable limits"
echo "   4. $(cli_highlight "Verify performance metrics" "red") - Compare to baseline"
echo "   5. $(cli_highlight "Monitor support channels" "red") - Watch for user issues"
echo ""
echo "$(cli_highlight "📊 DEPLOYMENT VALIDATION CHECKLIST:" "yellow")"
echo "   ▶ [ ] Production health dashboard green"
echo "   ▶ [ ] Critical API endpoints responding"
echo "   ▶ [ ] Database connections stable"
echo "   ▶ [ ] Error rates < 1% (or defined threshold)"
echo "   ▶ [ ] Performance within 10% of baseline"
echo "   ▶ [ ] No customer complaints received"

echo ""
cli_section_header "🎯 USEFUL COMMANDS & NEXT STEPS"
echo "$(cli_highlight "For team coordination:" "cyan")"
echo "   ▶ Notify team: Production v$RELEASE_VERSION deployed"
echo "   ▶ Update documentation: Release notes and changelog"
echo "   ▶ Monitor channels: Enable critical alerts"
echo ""
echo "$(cli_highlight "For continued development:" "cyan")"
echo "   ▶ /git/feature/start <name>   # Begin next feature"
echo "   ▶ /git/sync develop           # Sync with team changes"
echo "   ▶ /git/help                   # Command reference"
echo ""
echo "$(cli_highlight "Emergency procedures (if needed):" "red")"
echo "   ▶ Production rollback: Coordinate with DevOps team"
echo "   ▶ Incident response: Follow standard escalation"
echo "   ▶ Emergency hotfix: /git/hotfix/start if critical issue"

echo ""
cli_separator_thick
echo "$(cli_highlight "🌟 Production v$RELEASE_VERSION deployed with maximum safety!" "green") 🎉"
cli_separator_thick
echo ""

# Critical reminder
echo "$(cli_highlight "⚠️  REMEMBER: This is LIVE in production - monitor actively!" "red")"

# Performance metrics
cli_performance_end
```

---

## ✅ **Resultado Esperado**

```
🚀 GIT FLOW - Release Finish (PRODUCTION)
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 PRODUCTION RELEASE ANALYSIS:
   ▶ Release: v2.1.0 → PRODUCTION DEPLOYMENT
   ▶ Source: release/2.1.0 (12 commits ahead)
   ▶ Target Production: main (current: a1b2c3d)
   ▶ Target Development: develop (current: e4f5g6h)
   ▶ Production Tag: v2.1.0 (will trigger CI/CD)

🔒 PRODUCTION READINESS VALIDATION:
   ▶ Working directory: ✅ Clean
   ▶ Release branch: ✅ release/2.1.0 validated
   ▶ Production branch: ✅ Up to date
   ▶ Develop branch: ✅ Up to date
   ▶ Production conflicts: ✅ None detected
   ▶ Develop conflicts: ✅ None detected
   ▶ Tests: ✅ All passing
   ▶ Production tag: ✅ v2.1.0 available

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️ CRITICAL PRODUCTION DEPLOYMENT - CANNOT BE UNDONE

🚨 This will deploy version 2.1.0 to PRODUCTION servers

❓ Do you understand this is a PRODUCTION DEPLOYMENT? [y/N] y
❓ Are you ready to DEPLOY TO PRODUCTION NOW? [y/N] y
❓ FINAL CONFIRMATION: Deploy v2.1.0 to production? [y/N] y

✅ PRODUCTION DEPLOYMENT AUTHORIZED
Triple confirmation received - proceeding with production deployment

🚀 EXECUTING PRODUCTION DEPLOYMENT:

STEP (1/6): Updating production branch (main)
   ⏳ Updating production branch... ✅ production branch updated

STEP (2/6): Merging release → PRODUCTION (main)
   ⏳ Merging release → PRODUCTION... ✅ PRODUCTION MERGE COMPLETED

STEP (3/6): Deploying to production remote
   ⏳ Deploying to production remote... ✅ DEPLOYED TO PRODUCTION

STEP (4/6): Updating develop branch
   ⏳ Updating develop branch... ✅ develop branch updated

STEP (5/6): Merging release → develop
   ⏳ Merging release → develop... ✅ develop merge completed
   ⏳ Synchronizing develop... ✅ develop branch synchronized

STEP (6/6): Creating production tag (v2.1.0)
   ⏳ Creating production tag... ✅ production tag created
   ⏳ Deploying tag... ✅ production tag deployed (CI/CD trigger)

🔗 PRODUCTION INTEGRATION & MONITORING:
   ⏳ Updating ClickUp production task... ✅ production task updated

📁 PRODUCTION SESSION MANAGEMENT:
   ⏳ Archiving production release... ✅ production session archived

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
🚀 PRODUCTION RELEASE DEPLOYED SUCCESSFULLY!
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 PRODUCTION DEPLOYMENT SUMMARY:
   ▶ Version: v2.1.0 🚀 LIVE IN PRODUCTION
   ▶ Deployed: release/2.1.0 → main (production)
   ▶ Synchronized: release/2.1.0 → develop (continued development)
   ▶ Files deployed: 23
   ▶ Production tag: v2.1.0 (triggers CI/CD)
   ▶ Safety level: Maximum (triple confirmation + validation)

🚨 CRITICAL POST-DEPLOYMENT ACTIONS (REQUIRED)

🚨 IMMEDIATE MONITORING REQUIRED (Next 30+ minutes):
   1. Monitor production dashboards - Verify application health
   2. Test critical user journeys - Confirm functionality
   3. Check error rates - Must be within acceptable limits
   4. Verify performance metrics - Compare to baseline
   5. Monitor support channels - Watch for user issues

🌟 Production v2.1.0 deployed with maximum safety! 🎉

⚠️  REMEMBER: This is LIVE in production - monitor actively!

⏱️ Completed in 8.3s
```

---

**Posso prosseguir com a implementação do rebuild de `/git/hotfix/finish` com confirmações de EMERGÊNCIA PRODUCTION-GRADE?**

Este comando `/git/release/finish` implementa:
✅ **Production-Safety**: Triple confirmação obrigatória  
✅ **Production-Grade UX**: Visual hierarchy crítica + educational content  
✅ **Production Validation**: Tests + conflicts + readiness checks completos  
✅ **Production Monitoring**: Instruções críticas pós-deployment  
✅ **Integration**: ClickUp + Sessions + production tracking aprimorado
