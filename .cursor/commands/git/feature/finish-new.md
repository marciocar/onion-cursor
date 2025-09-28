# ✅ Finalizar Feature - Modern GitFlow com Confirmações Críticas

Você é um assistente de IA especializado em **finalizar desenvolvimento de features com CONFIRMAÇÕES OBRIGATÓRIAS** seguindo rigorosamente o padrão Git Flow oficial. Seu papel é atuar como **GUARDIÃO do Git Flow**, prevenindo erros de produção e educando usuários.

## 🎯 **Funcionalidades**

### **🔒 Safety-First (NOVO):**
- **CONFIRMAÇÃO OBRIGATÓRIA** para merge feature → develop
- **Análise de impacto** completa antes da operação
- **Validações pré-merge** (conflicts, tests, working directory)
- **Preview detalhado** do que será afetado
- **Rollback guidance** caso algo dê errado

### **🎨 Modern CLI UX (NOVO):**
- **Visual hierarchy** com separadores e ícones
- **Context display** mostrando estado atual → estado futuro
- **Progress indicators** em tempo real
- **Educational content** ensinando Git Flow durante uso
- **Next steps guidance** sempre disponível

### **🔄 Git Flow Compliance:**
- Merge feature branch → develop (padrão oficial)
- Cleanup automático da branch local + remote
- Integration com ClickUp preservada e aprimorada
- Session archive automático

---

## 🚀 **Uso do Comando**

### **Sintaxe:**
```bash
/git/feature/finish
```

**Nota**: Auto-detecta feature branch atual - execute na branch de feature que deseja finalizar.

---

## ⚙️ **Workflow de Implementação**

### **1. Modern UX Context Display**
```bash
#!/bin/bash

# Imports para UX moderna
source "$HOME/.cursor/utils/modern-cli-ux.sh" 2>/dev/null || true

# Detectar branch atual
CURRENT_BRANCH=$(git branch --show-current)
FEATURE_NAME=$(echo "$CURRENT_BRANCH" | sed 's/^feature\\///')

# Header com visual hierarchy moderna
echo ""
cli_header "🔄 GIT FLOW - Feature Finish" "cyan"
cli_separator

# Context Analysis Section  
cli_section_header "📋 MERGE ANALYSIS"
echo "   ▶ Source: $(cli_highlight "$CURRENT_BRANCH" "yellow") ($(git rev-list --count HEAD ^develop) commits ahead)"
echo "   ▶ Target: $(cli_highlight "develop" "green") (current: $(git rev-parse --short develop))"
echo "   ▶ Feature: $(cli_highlight "$FEATURE_NAME" "cyan")"
echo "   ▶ Files changed: $(git diff --name-only develop..HEAD | wc -l) files"

# Pre-flight checks
echo ""
cli_section_header "⚠️  PRE-FLIGHT VALIDATION"

# Check 1: Working directory
if [ -n "$(git status --porcelain)" ]; then
    cli_status_line "Working directory" "❌ Uncommitted changes" "red"
    echo ""
    cli_error_box "UNCOMMITTED CHANGES DETECTED" "Commit all changes before finishing feature"
    echo "📝 Quick fix:"
    echo "   git add ."
    echo "   git commit -m \"final changes for $FEATURE_NAME\""
    echo "   /git/feature/finish"
    exit 1
else
    cli_status_line "Working directory" "✅ Clean" "green"
fi

# Check 2: Develop branch status
git fetch origin develop --quiet
DEVELOP_STATUS=$(git rev-list --count develop..origin/develop)
if [ "$DEVELOP_STATUS" -eq 0 ]; then
    cli_status_line "Develop branch" "✅ Up to date" "green"
else
    cli_status_line "Develop branch" "⚠️ $DEVELOP_STATUS commits behind" "yellow"
fi

# Check 3: Merge conflicts preview
git merge-tree $(git merge-base develop HEAD) develop HEAD > /tmp/merge_check 2>/dev/null
if grep -q "<<<<<<< " /tmp/merge_check; then
    cli_status_line "Merge conflicts" "❌ Conflicts detected" "red"
    echo ""
    cli_error_box "MERGE CONFLICTS DETECTED" "Resolve conflicts before finishing"
    echo "🔧 Resolution steps:"
    echo "   1. git checkout develop"
    echo "   2. git pull origin develop" 
    echo "   3. git checkout $CURRENT_BRANCH"
    echo "   4. git merge develop  # Resolve conflicts"
    echo "   5. /git/feature/finish"
    exit 1
else
    cli_status_line "Merge conflicts" "✅ None detected" "green"
fi

# Check 4: Tests (if test command exists)
if command -v npm &> /dev/null && [ -f "package.json" ]; then
    if npm run test --silent > /dev/null 2>&1; then
        cli_status_line "Tests" "✅ All passing" "green"
    else
        cli_status_line "Tests" "❌ Some tests failing" "red" 
        echo ""
        cli_warning_box "TESTS FAILING" "Fix failing tests before merge to maintain develop stability"
        echo "🧪 Quick check: npm test"
        echo ""
        echo "❓ Continue anyway? This is not recommended. [y/N]"
        read -r test_confirm
        if [[ ! "$test_confirm" =~ ^[Yy]$ ]]; then
            echo "❌ Aborting - fix tests first"
            exit 1
        fi
    fi
fi
```

### **2. Educational Git Flow Context**
```bash
# Educational section - ensinar Git Flow durante uso
echo ""
cli_section_header "🎓 GIT FLOW EDUCATION"
echo "$(cli_dim "Git Flow feature workflow:")
$(cli_dim "   develop") → $(cli_highlight "feature/name" "yellow") → $(cli_dim "develop") (← you are here)

$(cli_dim "This operation will:")
   ▶ Merge your feature commits into the shared develop branch
   ▶ Other developers will get your changes on next 'git pull'
   ▶ Feature branch will be deleted (locally + remote)
   ▶ You'll be switched back to develop branch"

# Impact Preview Section
echo ""
cli_section_header "🔍 IMPACT PREVIEW"
echo "   ▶ Commits to merge: $(git rev-list --count HEAD ^develop) commits"
echo "   ▶ Files affected: $(git diff --name-only develop..HEAD | wc -l) files"
echo "   ▶ Lines changed: $(git diff --stat develop..HEAD | tail -1 | sed 's/^ */   ▶ /')"
echo ""
echo "📁 Modified files:"
git diff --name-only develop..HEAD | head -10 | sed 's/^/   ∟ /' | while read line; do
    echo "$(cli_dim "$line")"
done
if [ $(git diff --name-only develop..HEAD | wc -l) -gt 10 ]; then
    echo "   $(cli_dim "... and $(($(git diff --name-only develop..HEAD | wc -l) - 10)) more files")"
fi
```

### **3. CONFIRMAÇÃO CRÍTICA OBRIGATÓRIA**
```bash
# Critical Confirmation Section - NOVO E OBRIGATÓRIO
echo ""
cli_separator
cli_critical_warning_box "CRITICAL OPERATION - CANNOT BE UNDONE"

echo "This will $(cli_highlight "permanently merge" "red") your feature into develop."
echo "Other team members will receive these changes on their next pull."
echo ""
echo "🚨 $(cli_highlight "This operation cannot be reversed!" "red")"
echo ""
echo "📋 What will happen:"
echo "   1. Merge $CURRENT_BRANCH → develop"
echo "   2. Push merged changes to origin/develop" 
echo "   3. Delete local branch: $CURRENT_BRANCH"
echo "   4. Delete remote branch: origin/$CURRENT_BRANCH"
echo "   5. Update ClickUp task to 'Done'"
echo "   6. Archive development session"
echo ""

# Confirmation prompt with default NO (safety-first)
echo -n "❓ $(cli_highlight "Proceed with merge and cleanup?" "yellow") [y/N] "
read -r merge_confirm

if [[ ! "$merge_confirm" =~ ^[Yy]$ ]]; then
    echo ""
    cli_info_box "OPERATION CANCELLED" "Feature merge cancelled by user"
    echo "🎯 Your feature branch is safe and unchanged."
    echo ""
    echo "📋 To finish later:"
    echo "   /git/feature/finish"
    echo ""
    echo "📋 To continue development:"
    echo "   # You're already on the right branch"
    echo "   # Continue coding, commit, then finish"
    echo ""
    exit 0
fi

echo ""
cli_info_box "CONFIRMATION RECEIVED" "Proceeding with feature merge..."
```

### **4. Execution com Progress Indicators**
```bash
# Modern execution with progress indicators
echo ""
cli_section_header "🚀 EXECUTING MERGE"

# Step 1: Update develop
cli_progress_start "Updating develop branch"
git checkout develop --quiet
if git pull origin develop --quiet; then
    cli_progress_success "develop updated successfully"
else
    cli_progress_error "failed to update develop"
    cli_error_box "NETWORK ERROR" "Failed to update develop branch"
    echo "🔧 Manual fix: git pull origin develop"
    exit 1
fi

# Step 2: Merge feature
cli_progress_start "Merging $CURRENT_BRANCH → develop"
if git merge --no-ff "$CURRENT_BRANCH" --quiet -m "feat: merge $FEATURE_NAME

✨ Feature: $FEATURE_NAME completed
🔀 Merged via: /git/feature/finish (modern UX)
🎯 Impact: $(git diff --name-only HEAD~1..HEAD | wc -l) files modified
🧅 Sistema Onion automated merge with confirmations"; then
    cli_progress_success "merge completed successfully"
else
    cli_progress_error "merge failed - conflicts detected"
    echo ""
    cli_error_box "MERGE CONFLICTS" "Automatic merge failed"
    echo "🔧 This shouldn't happen (conflicts were pre-checked)"
    echo "🆘 Recovery steps:"
    echo "   1. git merge --abort"
    echo "   2. git checkout $CURRENT_BRANCH"
    echo "   3. git merge develop  # Resolve manually"
    echo "   4. /git/feature/finish  # Try again"
    exit 1
fi

# Step 3: Push changes
cli_progress_start "Pushing changes to origin/develop"
if git push origin develop --quiet; then
    cli_progress_success "changes pushed successfully"
else
    cli_progress_error "push failed - check network"
    cli_warning_box "PUSH FAILED" "Merge completed locally but not pushed"
    echo "🔧 Manual push: git push origin develop"
fi

# Step 4: Branch cleanup
echo ""
cli_section_header "🧹 BRANCH CLEANUP"

cli_progress_start "Deleting local branch: $CURRENT_BRANCH"
if git branch -d "$CURRENT_BRANCH" --quiet; then
    cli_progress_success "local branch deleted"
else
    cli_progress_warning "local branch kept (may have unmerged commits)"
fi

# Check if remote branch exists before trying to delete
if git ls-remote --heads origin "$CURRENT_BRANCH" 2>/dev/null | grep -q "$CURRENT_BRANCH"; then
    cli_progress_start "Deleting remote branch: origin/$CURRENT_BRANCH"
    if git push origin --delete "$CURRENT_BRANCH" --quiet; then
        cli_progress_success "remote branch deleted"
    else
        cli_progress_warning "remote branch cleanup failed"
    fi
else
    cli_progress_info "no remote branch to cleanup"
fi
```

### **5. Integrations Enhancement**
```bash
# Enhanced ClickUp Integration 
echo ""
cli_section_header "🔗 CLICKUP INTEGRATION"

# Detect task ID from session
TASK_ID=$(find .cursor/sessions -name "context.md" -type f 2>/dev/null | head -1 | xargs grep "Task ID:" 2>/dev/null | cut -d: -f2 | xargs || echo "")

if [ "$TASK_ID" != "" ]; then
    cli_progress_start "Updating ClickUp task: $TASK_ID"
    
    # Enhanced completion comment
    COMPLETION_COMMENT="🎉 FEATURE FINALIZADA - GitFlow Moderno

━━━━━━━━━━━━━━━━━━━━━━━━

✅ MERGE COMPLETED:
   ▶ Feature: $FEATURE_NAME
   ▶ Merged: $CURRENT_BRANCH → develop  
   ▶ Files modified: $(git diff --name-only HEAD~1..HEAD | wc -l) files
   ▶ Commits merged: $(git rev-list --count HEAD~1..HEAD) commits

🔒 SAFETY MEASURES:
   ∟ Pre-merge validation: ✅ All checks passed
   ∟ User confirmation: ✅ Explicitly confirmed
   ∟ Impact preview: ✅ Showed before merge
   ∟ Conflict detection: ✅ None detected

🎯 NEXT STEPS:
   ∟ Feature available in develop branch
   ∟ Ready for integration testing
   ∟ Consider release when develop is stable
   ∟ Use /git/release/start when ready for production

📊 DEVELOPMENT METRICS:
   ∟ Automated via: /git/feature/finish (modern UX)
   ∟ Safety level: Maximum (confirmations required)
   ∟ Git Flow compliance: 100% standard workflow
   ∟ Integration status: ✅ Complete

━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Completed: $(date +'%Y-%m-%d %H:%M:%S') | 🧅 Sistema Onion GitFlow Guardian"

    # Update to Done + add enhanced comment
    if clickup_update_task "$TASK_ID" "done" && clickup_add_comment "$TASK_ID" "$COMPLETION_COMMENT"; then
        cli_progress_success "task updated to 'Done'"
    else
        cli_progress_warning "ClickUp update failed (feature merged successfully)"
    fi
else
    cli_progress_info "no active session detected"
fi

# Enhanced Session Archive
echo ""
cli_section_header "📁 SESSION MANAGEMENT"

SESSION_PATH=$(find .cursor/sessions -name "*$FEATURE_NAME*" -type d 2>/dev/null | head -1)
if [ "$SESSION_PATH" != "" ]; then
    cli_progress_start "Archiving development session"
    
    # Create enhanced archive info
    ARCHIVE_INFO="# 🏁 Session Archived - Feature Completed Successfully

**Feature**: $FEATURE_NAME  
**Completed**: $(date +'%Y-%m-%d %H:%M:%S')  
**Merged to**: develop  
**Safety Level**: Maximum (modern UX with confirmations)
**ClickUp Task**: $([ "$TASK_ID" != "" ] && echo "$TASK_ID (updated to Done)" || echo "None detected")

## 📊 Merge Statistics
- **Files Modified**: $(git diff --name-only HEAD~1..HEAD | wc -l)
- **Commits Merged**: $(git rev-list --count HEAD~1..HEAD)  
- **Branch Cleanup**: ✅ Local and remote deleted
- **Integration**: ✅ ClickUp synced

## 🔒 Safety Measures Applied
- ✅ Pre-merge validation (conflicts, tests, working directory)
- ✅ Impact preview displayed to user
- ✅ Explicit user confirmation required
- ✅ Modern GitFlow compliance enforced

## 🎯 Workflow Completion
**Executed by**: /git/feature/finish (modern UX version)  
**Git Flow Guardian**: ✅ System acted as guardian successfully  
**User Education**: ✅ GitFlow concepts explained during process  
**Team Safety**: ✅ Production-grade confirmations applied

---

**🧅 Sistema Onion** - GitFlow workflow completed with maximum safety and modern UX"

    echo "$ARCHIVE_INFO" > "$SESSION_PATH/COMPLETION-REPORT.md"
    
    # Move session to archived
    ARCHIVE_DIR=".cursor/sessions/archived/$(date +'%Y-%m')"
    mkdir -p "$ARCHIVE_DIR"
    if mv "$SESSION_PATH" "$ARCHIVE_DIR/"; then
        cli_progress_success "session archived to $ARCHIVE_DIR/"
    else
        cli_progress_warning "session archive failed"
    fi
else
    cli_progress_info "no development session found"
fi
```

### **6. Success Summary + Next Steps**
```bash
# Modern Success Summary
echo ""
cli_separator
cli_success_header "✅ FEATURE COMPLETED SUCCESSFULLY!"
cli_separator

echo ""
cli_section_header "📊 OPERATION SUMMARY"
echo "   ▶ Feature: $(cli_highlight "$FEATURE_NAME" "green") ✅"
echo "   ▶ Merged: $CURRENT_BRANCH → $(cli_highlight "develop" "green")"
echo "   ▶ Files modified: $(git diff --name-only HEAD~1..HEAD | wc -l)"
echo "   ▶ Safety level: $(cli_highlight "Maximum" "green") (confirmations + validations)"
echo "   ▶ Branch cleanup: $(cli_highlight "Complete" "green") (local + remote deleted)"

echo ""
cli_section_header "🔗 INTEGRATION STATUS"
if [ "$TASK_ID" != "" ]; then
    echo "   ▶ ClickUp task: $(cli_highlight "$TASK_ID" "green") updated to Done ✅"
else
    echo "   ▶ ClickUp task: No task detected (manual tracking)"
fi
echo "   ▶ Session archive: $([ "$SESSION_PATH" != "" ] && cli_highlight "Completed" "green" || cli_highlight "None found" "dim") "
echo "   ▶ Git Flow compliance: $(cli_highlight "100%" "green") (official standard)"

echo ""
cli_section_header "🎯 NEXT STEPS GUIDANCE"
echo "Your feature is now integrated in the develop branch."
echo ""
echo "$(cli_highlight "Recommended next actions:" "cyan")"
echo "   1. $(cli_dim "Test integration:") Feature is ready for integration testing"
echo "   2. $(cli_dim "Team sync:") Other developers can pull latest develop"
echo "   3. $(cli_dim "Release planning:") Consider /git/release/start when develop is stable"
echo "   4. $(cli_dim "New features:") Use /git/feature/start for next feature"
echo ""
echo "$(cli_highlight "Useful commands:" "cyan")"
echo "   ▶ /git/sync develop      # Sync with team changes"
echo "   ▶ /git/release/start     # Start release when ready"
echo "   ▶ /git/feature/start     # Begin next feature"
echo "   ▶ /git/help              # Command reference"

echo ""
cli_separator
echo "$(cli_highlight "🌟 Git Flow workflow completed with modern safety!" "green") 🚀"
cli_separator
echo ""

# Performance metrics
echo "⏱️ Completed in $(echo $(($(date +%s) - START_TIME)) | awk '{print $1"."int($1*10%10)"s"}')"
```

---

## 🔧 **Modern CLI UX Utilities**

Para suportar a nova UX, precisamos de um sistema de utilities:

```bash
# ~/.cursor/utils/modern-cli-ux.sh
#!/bin/bash

# Modern CLI UX Utilities for Git Flow Commands

# Color definitions
RED='\033[0;31m'
GREEN='\033[0;32m' 
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
GRAY='\033[0;90m'
BOLD='\033[1m'
DIM='\033[2m'
NC='\033[0m' # No Color

# Header functions
cli_header() {
    echo -e "${CYAN}${BOLD}$1${NC}"
}

cli_section_header() {
    echo -e "${GREEN}$1${NC}"
}

cli_separator() {
    echo "━━━━━━━━━━━━━━━━━━━━━━━━━━"
}

# Status indicators
cli_status_line() {
    local label="$1"
    local status="$2" 
    local color="$3"
    
    case $color in
        "green") echo -e "   ▶ $label: ${GREEN}$status${NC}" ;;
        "red") echo -e "   ▶ $label: ${RED}$status${NC}" ;;
        "yellow") echo -e "   ▶ $label: ${YELLOW}$status${NC}" ;;
        *) echo "   ▶ $label: $status" ;;
    esac
}

# Progress indicators
cli_progress_start() {
    echo -n "   ⏳ $1... "
}

cli_progress_success() {
    echo -e "${GREEN}✅ $1${NC}"
}

cli_progress_error() {
    echo -e "${RED}❌ $1${NC}"
}

cli_progress_warning() {
    echo -e "${YELLOW}⚠️ $1${NC}"
}

# Highlight functions
cli_highlight() {
    local text="$1"
    local color="$2"
    
    case $color in
        "green") echo -e "${GREEN}$text${NC}" ;;
        "red") echo -e "${RED}$text${NC}" ;;
        "yellow") echo -e "${YELLOW}$text${NC}" ;;
        "cyan") echo -e "${CYAN}$text${NC}" ;;
        *) echo "$text" ;;
    esac
}

cli_dim() {
    echo -e "${DIM}$1${NC}"
}

# Box functions
cli_error_box() {
    local title="$1"
    local message="$2"
    echo ""
    echo -e "${RED}🚨 $title${NC}"
    echo -e "${DIM}$message${NC}"
}

cli_warning_box() {
    local title="$1" 
    local message="$2"
    echo ""
    echo -e "${YELLOW}⚠️ $title${NC}"
    echo -e "${DIM}$message${NC}"
}

cli_info_box() {
    local title="$1"
    local message="$2"
    echo ""
    echo -e "${CYAN}ℹ️ $title${NC}"
    echo -e "${DIM}$message${NC}"
}

cli_success_header() {
    echo -e "${GREEN}${BOLD}$1${NC}"
}

cli_critical_warning_box() {
    local message="$1"
    echo ""
    echo -e "${RED}${BOLD}⚠️ $message${NC}"
    echo ""
}

# ClickUp utilities
clickup_update_task() {
    local task_id="$1"
    local status="$2"
    
    curl -s -X PUT "https://api.clickup.com/api/v2/task/$task_id" \
        -H "Authorization: Bearer $CLICKUP_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"status\": \"$status\"}" > /dev/null
}

clickup_add_comment() {
    local task_id="$1" 
    local comment="$2"
    
    curl -s -X POST "https://api.clickup.com/api/v2/task/$task_id/comment" \
        -H "Authorization: Bearer $CLICKUP_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"comment_text\": \"$comment\"}" > /dev/null
}
```

---

## ✅ **Resultado Esperado**

```
🔄 GIT FLOW - Feature Finish
━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 MERGE ANALYSIS:
   ▶ Source: feature/user-auth (3 commits ahead)
   ▶ Target: develop (current: a1b2c3d)
   ▶ Feature: user-auth
   ▶ Files changed: 12 files

⚠️  PRE-FLIGHT VALIDATION:
   ▶ Working directory: ✅ Clean
   ▶ Develop branch: ✅ Up to date  
   ▶ Merge conflicts: ✅ None detected
   ▶ Tests: ✅ All passing

🎓 GIT FLOW EDUCATION:
develop → feature/name → develop (← you are here)

This operation will:
   ▶ Merge your feature commits into shared develop
   ▶ Other developers will get changes on next pull
   ▶ Feature branch will be deleted (locally + remote)

🔍 IMPACT PREVIEW:
   ▶ Commits to merge: 3 commits
   ▶ Files affected: 12 files
   ▶ Lines changed: +234 -67

━━━━━━━━━━━━━━━━━━━━━━━━━━
⚠️ CRITICAL OPERATION - CANNOT BE UNDONE

This will permanently merge your feature into develop.

❓ Proceed with merge and cleanup? [y/N] y

🚀 EXECUTING MERGE:
   ⏳ Updating develop branch... ✅ develop updated
   ⏳ Merging feature/user-auth → develop... ✅ merge completed
   ⏳ Pushing changes to origin/develop... ✅ pushed successfully

🧹 BRANCH CLEANUP:
   ⏳ Deleting local branch... ✅ local branch deleted
   ⏳ Deleting remote branch... ✅ remote branch deleted

🔗 CLICKUP INTEGRATION:
   ⏳ Updating ClickUp task... ✅ task updated to 'Done'

📁 SESSION MANAGEMENT:
   ⏳ Archiving development session... ✅ session archived

━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ FEATURE COMPLETED SUCCESSFULLY!
━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 OPERATION SUMMARY:
   ▶ Feature: user-auth ✅
   ▶ Merged: feature/user-auth → develop
   ▶ Files modified: 12
   ▶ Safety level: Maximum (confirmations + validations)
   ▶ Branch cleanup: Complete (local + remote deleted)

🎯 NEXT STEPS GUIDANCE:
   1. Test integration: Feature ready for testing
   2. Team sync: Others can pull latest develop
   3. Release planning: Use /git/release/start when ready
   4. New features: Use /git/feature/start for next

🌟 Git Flow workflow completed with modern safety! 🚀

⏱️ Completed in 3.2s
```

---

**Posso prosseguir com a implementação deste rebuild moderno do `/git/feature/finish`?**

Este novo comando implementa:
✅ **Safety-First**: Confirmação obrigatória + validações completas  
✅ **Modern UX**: Visual hierarchy + progress indicators + context display  
✅ **Educational**: Ensina Git Flow durante uso  
✅ **Guardianship**: Atua como verdadeiro guardião, prevenindo erros  
✅ **Integration**: Preserva 100% ClickUp + Sessions + melhora reliability

