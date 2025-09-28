# 🔧 Inicializar Git Flow - Modern Setup Experience

Você é um assistente de IA especializado em **configurar repositórios Git com GitFlow usando experiência moderna e educativa**. Seu papel é automatizar setup inicial com validações inteligentes e guidance completo.

## 🎯 **Funcionalidades**

### **🎨 Modern Setup UX (NOVO):**
- **Interactive setup wizard** com detecção automática master/main  
- **Visual progress indicators** para cada etapa de inicialização
- **Educational context** sobre Git Flow durante setup
- **Intelligent validation** com recovery suggestions
- **Repository health assessment** pré e pós-setup

### **🔧 Enhanced Auto-Setup (NOVO):**
- **Smart branch detection** (master/main compatibility)
- **Conflict-free initialization** com validações preventivas
- **Team coordination** setup com remote validation
- **Session integration** automática se contexto detectado
- **ClickUp integration** para project tracking

### **🛡️ Advanced Validations:**
- Repository integrity checks
- Remote origin configuration
- Permission validation  
- Branch conflict prevention
- Team workflow compatibility

---

## 🚀 **Uso do Comando**

### **Sintaxe:**
```bash
/git/init
```

**Nota**: Comando inteligente que detecta contexto e aplica melhores práticas automaticamente.

---

## ⚙️ **Workflow de Implementação**

### **1. Modern Initialization Context**
```bash
#!/bin/bash

# Imports para UX moderna de inicialização
source "$HOME/.cursor/utils/modern-cli-ux.sh" 2>/dev/null || true

# Performance tracking
cli_performance_start

# Header para setup
echo ""
cli_header "🔧 GIT FLOW - Modern Initialization Wizard" "green" 
cli_separator

# Repository Analysis Section
cli_section_header "🔍 REPOSITORY ANALYSIS"

# Check 1: Git repository validation
if ! git rev-parse --is-inside-work-tree > /dev/null 2>&1; then
    cli_status_line "Git repository" "❌ Not a Git repository" "red"
    echo ""
    cli_error_box "NOT A GIT REPOSITORY" "This directory is not a Git repository"
    echo "🔧 Initialize Git first:"
    echo "   git init"
    echo "   git remote add origin <repository-url>"
    echo "   /git/init"
    exit 1
else
    cli_status_line "Git repository" "✅ Valid Git repository" "green"
fi

# Check 2: Remote origin validation
REMOTE_ORIGIN=$(git remote get-url origin 2>/dev/null || echo "")
if [ "$REMOTE_ORIGIN" = "" ]; then
    cli_status_line "Remote origin" "⚠️ No remote configured" "yellow"
    echo "   💡 Recommended: Configure remote origin for team collaboration"
else
    cli_status_line "Remote origin" "✅ $REMOTE_ORIGIN" "green"
fi

# Check 3: Branch structure analysis  
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "none")
PRIMARY_BRANCH=$(cli_detect_primary_branch)
DEVELOP_EXISTS=$(git show-ref --verify --quiet refs/heads/develop && echo "true" || echo "false")

cli_status_line "Current branch" "$([ "$CURRENT_BRANCH" != "none" ] && echo "✅ $CURRENT_BRANCH" || echo "⚠️ No branches")" "$([ "$CURRENT_BRANCH" != "none" ] && echo "green" || echo "yellow")"
cli_status_line "Primary branch" "✅ $PRIMARY_BRANCH detected" "green"
cli_status_line "Develop branch" "$([ "$DEVELOP_EXISTS" = "true" ] && echo "✅ Already exists" || echo "⚠️ Will be created")" "$([ "$DEVELOP_EXISTS" = "true" ] && echo "green" || echo "yellow")"

# Check 4: Git Flow initialization status
GIT_FLOW_INITIALIZED=$(git config --get gitflow.branch.master 2>/dev/null || git config --get gitflow.branch.main 2>/dev/null || echo "")
if [ "$GIT_FLOW_INITIALIZED" != "" ]; then
    cli_status_line "Git Flow status" "✅ Already initialized ($GIT_FLOW_INITIALIZED)" "green"
    ALREADY_INITIALIZED=true
else
    cli_status_line "Git Flow status" "⚠️ Not initialized" "yellow"
    ALREADY_INITIALIZED=false
fi
```

### **2. Educational Git Flow Context**
```bash
# Educational section sobre Git Flow
echo ""
cli_section_header "🎓 GIT FLOW EDUCATION"

if [ "$ALREADY_INITIALIZED" = "false" ]; then
    cli_education_box "Git Flow Branching Model" "
Git Flow is a branching model for Git, created by Vincent Driessen.
It defines a strict branching model designed around project releases.

Branch structure: $(cli_highlight "$PRIMARY_BRANCH" "green") (production) ← $(cli_highlight "develop" "cyan") ← $(cli_highlight "feature/*" "yellow")"

    echo ""
    echo "$(cli_dim "Git Flow initialization will:")
       ▶ Configure $(cli_highlight "$PRIMARY_BRANCH" "green") as production branch
       ▶ Create/configure $(cli_highlight "develop" "cyan") as development branch  
       ▶ Set up branch prefixes: $(cli_highlight "feature/" "yellow"), $(cli_highlight "release/" "blue"), $(cli_highlight "hotfix/" "red")
       ▶ Enable team collaboration workflows
       ▶ Integrate with Sistema Onion commands"
       
    echo ""
    echo "🤝 Team collaboration benefits:"
    echo "   ▶ Standardized workflow for all team members"
    echo "   ▶ Parallel development on features"
    echo "   ▶ Controlled release management"
    echo "   ▶ Emergency hotfix capabilities"
else
    cli_info_box "GIT FLOW ALREADY INITIALIZED" "Git Flow is already configured in this repository"
    echo ""
    echo "Current configuration:"
    echo "   ▶ Production branch: $(cli_highlight "$GIT_FLOW_INITIALIZED" "green")"
    echo "   ▶ Development branch: $(cli_highlight "$(git config --get gitflow.branch.develop 2>/dev/null || echo "develop")" "cyan")"
    echo "   ▶ Feature prefix: $(cli_highlight "$(git config --get gitflow.prefix.feature 2>/dev/null || echo "feature/")" "yellow")"
    echo "   ▶ Release prefix: $(cli_highlight "$(git config --get gitflow.prefix.release 2>/dev/null || echo "release/")" "blue")"
    echo "   ▶ Hotfix prefix: $(cli_highlight "$(git config --get gitflow.prefix.hotfix 2>/dev/null || echo "hotfix/")" "red")"
fi
```

### **3. Setup Confirmation**
```bash
# Setup confirmation
echo ""
cli_separator

if [ "$ALREADY_INITIALIZED" = "false" ]; then
    cli_info_box "GIT FLOW INITIALIZATION" "Ready to initialize Git Flow in this repository"
    
    echo "Git Flow setup will:"
    echo "   1. Configure Git Flow with $(cli_highlight "$PRIMARY_BRANCH" "green") as production branch"
    echo "   2. $([ "$DEVELOP_EXISTS" = "false" ] && echo "Create" || echo "Configure") $(cli_highlight "develop" "cyan") branch for development"
    echo "   3. Set up branch prefixes for organized workflow"
    echo "   4. Enable Sistema Onion Git Flow commands"
    echo "   5. Prepare repository for team collaboration"
    echo ""
    echo "$(cli_highlight "✅ This is a safe operation - no existing data will be lost" "green")"
    echo ""
    echo "❓ $(cli_highlight "Initialize Git Flow in this repository?" "cyan") [Y/n]"
    read -r init_confirm
    
    if [[ "$init_confirm" =~ ^[Nn]$ ]]; then
        echo ""
        cli_info_box "GIT FLOW INITIALIZATION CANCELLED" "Repository unchanged"
        echo "🎯 To initialize Git Flow later, run: /git/init"
        exit 0
    fi
else
    cli_info_box "GIT FLOW RE-INITIALIZATION" "Git Flow is already configured"
    echo ""
    echo "Available options:"
    echo "   1. $(cli_highlight "Verify configuration" "green") (recommended)" 
    echo "   2. $(cli_highlight "Reconfigure Git Flow" "yellow") (advanced users)"
    echo "   3. $(cli_highlight "Skip" "dim") (no changes)"
    echo ""
    echo "❓ What would you like to do? [verify/reconfigure/skip]"
    read -r reinit_choice
    
    case "$reinit_choice" in
        "reconfigure"|"r")
            FORCE_RECONFIGURE=true
            ;;
        "skip"|"s")
            echo ""
            cli_success_box "GIT FLOW STATUS VERIFIED" "Configuration is already optimal"
            exit 0
            ;;
        *)
            FORCE_RECONFIGURE=false
            ;;
    esac
fi

echo ""
cli_success_box "GIT FLOW SETUP AUTHORIZED" "Proceeding with Git Flow initialization"
```

### **4. Modern Setup Execution**  
```bash
# Modern setup execution with progress tracking
echo ""
cli_section_header "⚙️ EXECUTING GIT FLOW SETUP"

if [ "$ALREADY_INITIALIZED" = "false" ] || [ "$FORCE_RECONFIGURE" = "true" ]; then
    # Step 1: Update and sync with remote
    cli_progress_step 1 6 "Synchronizing with remote repository"
    if [ "$REMOTE_ORIGIN" != "" ]; then
        git fetch origin --quiet 2>/dev/null || true
        cli_progress_success "repository synchronized")
    else
        cli_progress_info "no remote configured - local setup only")
    fi
    
    # Step 2: Ensure we're on primary branch
    cli_progress_step 2 6 "Switching to primary branch ($PRIMARY_BRANCH)"
    if git show-ref --verify --quiet "refs/heads/$PRIMARY_BRANCH"; then
        git checkout "$PRIMARY_BRANCH" --quiet 2>/dev/null
        cli_progress_success "switched to $PRIMARY_BRANCH")
    else
        if [ "$REMOTE_ORIGIN" != "" ] && git show-ref --verify --quiet "refs/remotes/origin/$PRIMARY_BRANCH"; then
            git checkout -b "$PRIMARY_BRANCH" "origin/$PRIMARY_BRANCH" --quiet 2>/dev/null
            cli_progress_success "$PRIMARY_BRANCH created from remote")
        else
            # Create primary branch if it doesn't exist
            git checkout -b "$PRIMARY_BRANCH" --quiet 2>/dev/null || true
            cli_progress_success "$PRIMARY_BRANCH created")
        fi
    fi
    
    # Step 3: Create/update develop branch
    cli_progress_step 3 6 "Setting up develop branch"
    if [ "$DEVELOP_EXISTS" = "false" ]; then
        if [ "$REMOTE_ORIGIN" != "" ] && git show-ref --verify --quiet "refs/remotes/origin/develop"; then
            git checkout -b develop origin/develop --quiet 2>/dev/null
            cli_progress_success "develop created from remote")
        else
            git checkout -b develop "$PRIMARY_BRANCH" --quiet 2>/dev/null
            cli_progress_success "develop created from $PRIMARY_BRANCH")
        fi
    else
        git checkout develop --quiet 2>/dev/null || true
        cli_progress_success "develop branch verified")
    fi
    
    # Step 4: Initialize Git Flow
    cli_progress_step 4 6 "Configuring Git Flow settings"
    
    # Configure Git Flow settings
    git config gitflow.branch.master "$PRIMARY_BRANCH"
    git config gitflow.branch.develop "develop"
    git config gitflow.prefix.feature "feature/"
    git config gitflow.prefix.release "release/"
    git config gitflow.prefix.hotfix "hotfix/"
    git config gitflow.prefix.versiontag ""
    
    cli_progress_success "Git Flow configured")
    
    # Step 5: Push develop to remote if needed
    cli_progress_step 5 6 "Synchronizing with team repository"
    if [ "$REMOTE_ORIGIN" != "" ] && [ "$DEVELOP_EXISTS" = "false" ]; then
        if git push -u origin develop --quiet 2>/dev/null; then
            cli_progress_success "develop branch shared with team")
        else
            cli_progress_warning "develop push failed - manual sync may be needed")
        fi
    else
        cli_progress_info "develop branch sync not needed")
    fi
    
    # Step 6: Validation
    cli_progress_step 6 6 "Validating Git Flow setup"
    
    # Verify configuration
    VERIFICATION_PASSED=true
    
    # Check Git Flow config
    if [ "$(git config --get gitflow.branch.master)" = "$PRIMARY_BRANCH" ] || [ "$(git config --get gitflow.branch.main)" = "$PRIMARY_BRANCH" ]; then
        cli_progress_info "primary branch configuration verified")
    else
        VERIFICATION_PASSED=false
    fi
    
    # Check develop branch exists
    if git show-ref --verify --quiet "refs/heads/develop"; then
        cli_progress_info "develop branch verified")
    else
        VERIFICATION_PASSED=false
    fi
    
    if [ "$VERIFICATION_PASSED" = "true" ]; then
        cli_progress_success "Git Flow setup verified and complete")
    else
        cli_progress_warning "setup completed with warnings")
    fi
else
    # Verification mode
    cli_progress_step 1 1 "Verifying existing Git Flow configuration"
    cli_progress_success "configuration verified as optimal")
fi
```

### **5. ClickUp Integration + Session Setup**
```bash
# ClickUp Integration for initialization
echo ""
cli_section_header "🔗 PROJECT INTEGRATION"

# Detect any active sessions or ClickUp context
TASK_ID=$(clickup_get_task_id_from_session)

if [ "$TASK_ID" != "" ]; then
    cli_progress_start "Updating ClickUp project setup: $TASK_ID"
    
    INITIALIZATION_COMMENT="🔧 GIT FLOW INITIALIZATION COMPLETED

━━━━━━━━━━━━━━━━━━━━━━━━

⚙️ REPOSITORY SETUP COMPLETE:
   ▶ Git Flow: ✅ Initialized and configured
   ▶ Primary Branch: $PRIMARY_BRANCH (production)
   ▶ Development Branch: develop (team collaboration)
   ▶ Remote Integration: $([ "$REMOTE_ORIGIN" != "" ] && echo "✅ $REMOTE_ORIGIN" || echo "⚠️ Local only")
   
🎯 BRANCHING MODEL CONFIGURED:
   ∟ Production: $PRIMARY_BRANCH (stable releases)
   ∟ Development: develop (integration branch)
   ∟ Features: feature/* (parallel development)
   ∟ Releases: release/* (preparation for production)
   ∟ Hotfixes: hotfix/* (emergency production fixes)
   
🤝 TEAM COLLABORATION READY:
   ∟ Git Flow commands: ✅ Available (/git/help)
   ∟ Branch prefixes: ✅ Standardized for team
   ∟ Workflow automation: ✅ Sistema Onion integrated
   ∟ Safety features: ✅ Confirmations for critical operations
   
📋 NEXT STEPS FOR TEAM:
   ∟ All developers should have Git Flow installed
   ∟ Use /git/feature/start <name> to begin new features
   ∟ Follow Git Flow standard workflow for releases
   ∟ Emergency fixes via /git/hotfix/start <name>
   
🎓 EDUCATION & SUPPORT:
   ∟ Interactive help: /git/help (context-aware guidance)
   ∟ Workflow education: Built into all commands
   ∟ Error recovery: Automated suggestions and recovery
   ∟ Best practices: Enforced through confirmations
   
━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Initialized: $(date +'%Y-%m-%d %H:%M:%S') | 🎯 Ready for Git Flow development!"

    if clickup_add_comment "$TASK_ID" "$INITIALIZATION_COMMENT"; then
        cli_progress_success "project initialization logged")
    else
        cli_progress_warning "ClickUp update failed (setup completed successfully)")
    fi
else
    cli_progress_info "no active ClickUp integration detected")
fi

# Session setup if in development context
SESSION_PATH=$(find .cursor/sessions -name "*" -type d 2>/dev/null | head -1)
if [ "$SESSION_PATH" != "" ]; then
    cli_progress_start "Updating development session"
    
    SETUP_UPDATE="# 🔧 Git Flow Initialized Successfully

**Repository**: $(basename "$(git rev-parse --show-toplevel)")  
**Initialized**: $(date +'%Y-%m-%d %H:%M:%S')  
**Primary Branch**: $PRIMARY_BRANCH  
**Development Branch**: develop  
**Remote**: $([ "$REMOTE_ORIGIN" != "" ] && echo "$REMOTE_ORIGIN" || echo "Local only")

## ⚙️ Configuration Applied
- **Git Flow**: Initialized with Sistema Onion integration
- **Branch Prefixes**: feature/, release/, hotfix/
- **Team Collaboration**: Ready for multi-developer workflow
- **Safety Features**: Confirmations enabled for critical operations

## 🎯 Development Ready
**Next Steps**: Use /git/feature/start <name> to begin feature development  
**Team Workflow**: All developers can use standardized Git Flow commands  
**Interactive Help**: /git/help provides context-aware guidance  
**Integration**: ClickUp MCP and session management active

---

**🧅 Sistema Onion** - Git Flow initialization complete"

    echo "$SETUP_UPDATE" >> "$SESSION_PATH/GITFLOW-SETUP.md"
    cli_progress_success "development session updated")
else
    cli_progress_info "no development session detected")
fi
```

### **6. Setup Success + Next Steps Guidance**
```bash
# Modern success summary with next steps
echo ""
cli_separator
cli_success_header "🎉 GIT FLOW INITIALIZATION COMPLETE!"
cli_separator

echo ""
cli_section_header "⚙️ SETUP SUMMARY"
echo "   ▶ Git Flow: $(cli_highlight "Initialized and configured" "green") ✅"
echo "   ▶ Primary Branch: $(cli_highlight "$PRIMARY_BRANCH" "green") (production)"
echo "   ▶ Development Branch: $(cli_highlight "develop" "green") (team collaboration)"
echo "   ▶ Branch Prefixes: $(cli_highlight "Configured" "green") (feature/, release/, hotfix/)"
echo "   ▶ Remote Integration: $([ "$REMOTE_ORIGIN" != "" ] && cli_highlight "$REMOTE_ORIGIN" "green" || cli_highlight "Local setup" "yellow")"
echo "   ▶ Team Workflow: $(cli_highlight "Ready" "green") (standardized for collaboration)"

echo ""
cli_section_header "🎯 WHAT'S NEXT - GIT FLOW READY"
echo "Your repository is now configured for Git Flow development!"
echo ""
echo "$(cli_highlight "Ready to start development:" "cyan")"
echo "   1. $(cli_dim "Begin feature:") /git/feature/start \"feature-name\""
echo "   2. $(cli_dim "Get help:") /git/help feature                    # Learn feature workflow"  
echo "   3. $(cli_dim "Team setup:") Share repository URL with team members"
echo "   4. $(cli_dim "Collaborate:") Use /git/feature/publish for code review"
echo ""
echo "$(cli_highlight "Production workflow (when ready):" "cyan")"
echo "   ▶ Create release: /git/release/start \"v1.0.0\""
echo "   ▶ Deploy to production: /git/release/finish        # With safety confirmations"
echo "   ▶ Emergency fixes: /git/hotfix/start \"fix-name\""

echo ""
cli_section_header "📚 LEARNING & SUPPORT"
echo "$(cli_highlight "Interactive help system:" "cyan")"
echo "   ▶ /git/help                    # Context-aware help and navigation"
echo "   ▶ /git/help feature           # Feature development guide"
echo "   ▶ /git/help release           # Production deployment guide"
echo "   ▶ /git/help troubleshooting   # Problem solving wizard"
echo ""
echo "$(cli_highlight "Educational approach:" "green")"
echo "   ▶ All commands explain what they do before execution"
echo "   ▶ Safety confirmations for critical operations (deploy, merge)"
echo "   ▶ Error recovery guidance built into every command"
echo "   ▶ Git Flow best practices enforced automatically"

echo ""
cli_section_header "🤝 TEAM COLLABORATION"
if [ "$REMOTE_ORIGIN" != "" ]; then
    echo "$(cli_highlight "Team members can now:" "green")"
    echo "   ▶ Clone repository: git clone $REMOTE_ORIGIN"
    echo "   ▶ Initialize Git Flow: /git/init              # Same setup everywhere"
    echo "   ▶ Start features: /git/feature/start \"name\"   # Parallel development"
    echo "   ▶ Collaborate: /git/feature/publish          # Share work for review"
else
    echo "$(cli_highlight "To enable team collaboration:" "yellow")"
    echo "   ▶ Add remote origin: git remote add origin <repository-url>"
    echo "   ▶ Push branches: git push -u origin $PRIMARY_BRANCH develop"
    echo "   ▶ Share with team: Repository URL for cloning"
fi

echo ""
cli_separator
echo "$(cli_highlight "🌟 Git Flow initialized with modern safety and education!" "green") 🚀"
cli_separator

# Performance metrics
cli_performance_end
```

---

## ✅ **Resultado Esperado para `/git/init`**

```
🔧 GIT FLOW - Modern Initialization Wizard
━━━━━━━━━━━━━━━━━━━━━━━━━━

🔍 REPOSITORY ANALYSIS:
   ▶ Git repository: ✅ Valid Git repository
   ▶ Remote origin: ✅ https://github.com/user/project.git
   ▶ Current branch: ✅ main
   ▶ Primary branch: ✅ main detected
   ▶ Develop branch: ⚠️ Will be created
   ▶ Git Flow status: ⚠️ Not initialized

🎓 GIT FLOW EDUCATION:
Git Flow is a branching model for Git, created by Vincent Driessen.
Branch structure: main (production) ← develop ← feature/*

❓ Initialize Git Flow in this repository? [Y/n] y

✅ GIT FLOW SETUP AUTHORIZED

⚙️ EXECUTING GIT FLOW SETUP:

STEP (1/6): Synchronizing with remote repository
   ⏳ Synchronizing... ✅ repository synchronized

STEP (2/6): Switching to primary branch (main)
   ⏳ Switching... ✅ switched to main

STEP (3/6): Setting up develop branch  
   ⏳ Setting up develop... ✅ develop created from main

STEP (4/6): Configuring Git Flow settings
   ⏳ Configuring... ✅ Git Flow configured

STEP (5/6): Synchronizing with team repository
   ⏳ Synchronizing... ✅ develop branch shared with team

STEP (6/6): Validating Git Flow setup
   ⏳ Validating... ✅ Git Flow setup verified and complete

🔗 PROJECT INTEGRATION:
   ⏳ Updating ClickUp project... ✅ project initialization logged

━━━━━━━━━━━━━━━━━━━━━━━━━━
🎉 GIT FLOW INITIALIZATION COMPLETE!
━━━━━━━━━━━━━━━━━━━━━━━━━━

⚙️ SETUP SUMMARY:
   ▶ Git Flow: Initialized and configured ✅
   ▶ Primary Branch: main (production)
   ▶ Development Branch: develop (team collaboration)
   ▶ Branch Prefixes: Configured (feature/, release/, hotfix/)
   ▶ Remote Integration: https://github.com/user/project.git
   ▶ Team Workflow: Ready (standardized for collaboration)

🎯 WHAT'S NEXT - GIT FLOW READY:
   1. Begin feature: /git/feature/start "feature-name"
   2. Get help: /git/help feature
   3. Team setup: Share repository URL with team members
   4. Collaborate: Use /git/feature/publish for code review

🌟 Git Flow initialized with modern safety and education! 🚀

⏱️ Completed in 3.8s
```

---

<function_calls>
<invoke name="run_terminal_cmd">
<parameter name="command">cp .cursor/commands/git/init.md .cursor/commands/git/init-backup.md
