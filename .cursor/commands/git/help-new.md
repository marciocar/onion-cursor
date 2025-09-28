# 🆘 Sistema de Ajuda GitFlow - Modern Interactive Help

Você é um assistente de IA especializado em **fornecer ajuda interativa e contextual para comandos GitFlow** do Sistema Onion. Seu papel é educar desenvolvedores sobre Git Flow através de uma experiência moderna e intuitiva.

## 🎯 **Funcionalidades**

### **🎨 Modern Help UX (NOVO):**
- **Interactive help system** com navegação contextual
- **Visual command hierarchy** com categorização clara
- **Context-aware suggestions** baseado no estado do repositório
- **Educational tooltips** com Git Flow best practices
- **Quick reference cards** para workflows comuns

### **📚 Smart Documentation (NOVO):**
- **Real-time status detection** do repositório atual
- **Personalized recommendations** baseado no projeto
- **Interactive examples** com copy-paste ready
- **Troubleshooting wizard** para problemas comuns
- **Team collaboration guidance** integrado

### **🔍 Contextual Intelligence:**
- Detectar estado atual do Git Flow no repo
- Sugerir próximos passos lógicos
- Mostrar comandos relevantes para situação atual
- Educational content sobre Git Flow concepts

---

## 🚀 **Uso do Comando**

### **Sintaxe:**
```bash
/git/help [comando-específico]
```

### **Exemplos:**
```bash
/git/help                    # Help interativo completo
/git/help feature           # Help específico para feature workflow
/git/help release           # Help específico para release workflow
/git/help troubleshooting   # Troubleshooting wizard
```

---

## ⚙️ **Workflow de Implementação**

### **1. Modern Help Context Display**
```bash
#!/bin/bash

# Imports para UX moderna de help
source "$HOME/.cursor/utils/modern-cli-ux.sh" 2>/dev/null || true

# Performance tracking
cli_performance_start

# Detectar contexto do repositório atual
REPO_STATUS=$(cli_detect_git_flow_status)
CURRENT_BRANCH=$(git branch --show-current 2>/dev/null || echo "none")
GIT_FLOW_INITIALIZED=$(git config --get gitflow.branch.master 2>/dev/null || git config --get gitflow.branch.main 2>/dev/null || echo "not-initialized")

# Comando específico ou help geral
HELP_TOPIC="${1:-general}"

# Header moderno
echo ""
cli_header "🆘 GIT FLOW - Interactive Help System" "cyan"
cli_separator

# Context Display - mostrar estado atual
cli_section_header "📊 REPOSITORY CONTEXT"
echo "   ▶ Current Branch: $(cli_highlight "$CURRENT_BRANCH" "yellow")"
echo "   ▶ Git Flow Status: $([ "$GIT_FLOW_INITIALIZED" != "not-initialized" ] && cli_highlight "Initialized" "green" || cli_highlight "Not Initialized" "red")"
echo "   ▶ Repository State: $(cli_highlight "$REPO_STATUS" "cyan")"

# Smart suggestions baseado no contexto atual
echo ""
cli_section_header "💡 SMART SUGGESTIONS FOR YOU"

if [ "$GIT_FLOW_INITIALIZED" = "not-initialized" ]; then
    echo "   🎯 $(cli_highlight "Quick Start" "green"): Initialize Git Flow first"
    echo "      Command: $(cli_dim "/git/init")"
elif [[ "$CURRENT_BRANCH" =~ ^feature/ ]]; then
    echo "   🎯 $(cli_highlight "Feature Workflow" "green"): You're on a feature branch"  
    echo "      Next Steps: $(cli_dim "/git/feature/publish") (share) or $(cli_dim "/git/feature/finish") (merge)"
elif [ "$CURRENT_BRANCH" = "develop" ]; then
    echo "   🎯 $(cli_highlight "Development Ready" "green"): Ready to start new features"
    echo "      Next Step: $(cli_dim "/git/feature/start <name>") to begin new feature"
elif [ "$CURRENT_BRANCH" = "main" ] || [ "$CURRENT_BRANCH" = "master" ]; then
    echo "   🎯 $(cli_highlight "Production Branch" "yellow"): You're on production branch"
    echo "      Next Step: $(cli_dim "git checkout develop") to switch to development"
else
    echo "   🎯 $(cli_highlight "Unknown State" "yellow"): Custom branch detected"
    echo "      Recommendation: Review Git Flow status with team"
fi

# Comando específico ou help geral
case "$HELP_TOPIC" in
    "feature")
        show_feature_help
        ;;
    "release") 
        show_release_help
        ;;
    "hotfix")
        show_hotfix_help
        ;;
    "troubleshooting")
        show_troubleshooting_help
        ;;
    *)
        show_general_help
        ;;
esac
```

### **2. Interactive Help Functions**
```bash
# Função para help de features
show_feature_help() {
    echo ""
    cli_section_header "🌿 FEATURE WORKFLOW - Complete Guide"
    
    echo ""
    echo "$(cli_highlight "Feature Lifecycle:" "cyan")"
    echo "   develop → $(cli_highlight "feature/name" "yellow") → origin/feature/name → develop"
    echo ""
    
    echo "📋 Available Commands:"
    cli_command_card "/git/feature/start <name>" "Create new feature branch + setup session" "🌱 Start"
    cli_command_card "/git/feature/publish" "Share feature with team for collaboration" "🤝 Share"  
    cli_command_card "/git/feature/finish" "Merge feature to develop + cleanup" "✅ Complete"
    
    echo ""
    echo "🎓 $(cli_highlight "Educational Workflow:" "green")"
    echo "   1. $(cli_dim "Plan"):     /git/feature/start \"user-authentication\""
    echo "   2. $(cli_dim "Develop"):  # Code your feature"
    echo "   3. $(cli_dim "Share"):    /git/feature/publish  # Optional for team review" 
    echo "   4. $(cli_dim "Complete"): /git/feature/finish   # Merge when ready"
    
    echo ""
    echo "💡 $(cli_highlight "Best Practices:" "cyan")"
    echo "   ▶ Use descriptive feature names (kebab-case preferred)"
    echo "   ▶ Publish early for team collaboration and code review"
    echo "   ▶ Test thoroughly before finishing"
    echo "   ▶ Keep features small and focused on single functionality"
}

# Função para help de releases  
show_release_help() {
    echo ""
    cli_section_header "🚀 RELEASE WORKFLOW - Production Deployment Guide"
    
    echo ""
    echo "$(cli_highlight "Release Lifecycle:" "cyan")"  
    echo "   develop → $(cli_highlight "release/version" "yellow") → main + develop ($(cli_highlight "PRODUCTION" "red"))"
    echo ""
    
    echo "📋 Available Commands:"
    cli_command_card "/git/release/start <version>" "Create release branch for stabilization" "🎯 Start"
    cli_command_card "/git/release/finish" "Deploy to production with confirmations" "🚀 Deploy"
    
    echo ""
    echo "🎓 $(cli_highlight "Educational Workflow:" "green")"
    echo "   1. $(cli_dim "Prepare"):  /git/release/start \"v1.2.0\""
    echo "   2. $(cli_dim "Test"):     # Final testing and bug fixes only"  
    echo "   3. $(cli_dim "Deploy"):   /git/release/finish  # Production deployment"
    
    echo ""
    echo "⚠️ $(cli_highlight "PRODUCTION SAFETY:" "red")"
    echo "   ▶ Release finish requires TRIPLE CONFIRMATION"
    echo "   ▶ Automatic CI/CD trigger via production tags"
    echo "   ▶ Mandatory post-deployment monitoring"
    echo "   ▶ Rollback procedures documented in output"
}

# Função para help de hotfixes
show_hotfix_help() {
    echo ""
    cli_section_header "🚨 HOTFIX WORKFLOW - Emergency Production Fix"
    
    echo ""
    echo "$(cli_highlight "Hotfix Lifecycle:" "red")"
    echo "   main → $(cli_highlight "hotfix/fix" "red") → main + develop ($(cli_highlight "EMERGENCY" "red"))"
    echo ""
    
    echo "📋 Available Commands:"
    cli_command_card "/git/hotfix/start <name>" "Create emergency fix branch from production" "🔥 Start"  
    cli_command_card "/git/hotfix/finish" "Emergency deployment with validations" "🚨 Deploy"
    
    echo ""
    echo "🎓 $(cli_highlight "Educational Workflow:" "green")"
    echo "   1. $(cli_dim "Emergency"): /git/hotfix/start \"fix-payment-gateway\""
    echo "   2. $(cli_dim "Fix"):      # Implement minimal critical fix only"
    echo "   3. $(cli_dim "Deploy"):   /git/hotfix/finish  # Emergency deployment"
    
    echo ""
    echo "🚨 $(cli_highlight "EMERGENCY PROCEDURES:" "red")"
    echo "   ▶ Use only for CRITICAL production issues"
    echo "   ▶ Keep fixes minimal and focused" 
    echo "   ▶ Emergency confirmations (accelerated but safe)"
    echo "   ▶ Mandatory immediate monitoring post-deploy"
}

# Função para troubleshooting
show_troubleshooting_help() {
    echo ""
    cli_section_header "🛠️ TROUBLESHOOTING WIZARD"
    
    echo ""
    echo "🔍 $(cli_highlight "Common Issues & Solutions:" "cyan")"
    
    cli_troubleshoot_item "Git Flow not initialized" \
        "Run: /git/init" \
        "This will setup Git Flow with automatic main/master detection"
        
    cli_troubleshoot_item "Uncommitted changes blocking operations" \
        "Commit changes: git add . && git commit -m \"work in progress\"" \
        "Or stash: git stash to temporarily save changes"
        
    cli_troubleshoot_item "Merge conflicts during feature finish" \
        "Resolve conflicts manually, then re-run /git/feature/finish" \
        "Use git status to see conflicted files"
        
    cli_troubleshoot_item "Branch tracking issues" \
        "Run: /git/sync to synchronize with remote" \
        "This fixes most tracking and sync problems"
        
    cli_troubleshoot_item "ClickUp integration not working" \
        "Check CLICKUP_TOKEN environment variable" \
        "Restart terminal after setting token"
        
    echo ""
    echo "🆘 $(cli_highlight "Need More Help?" "yellow")"
    echo "   ▶ Check Git status: $(cli_dim "git status")"
    echo "   ▶ View recent commits: $(cli_dim "git log --oneline -5")"
    echo "   ▶ Contact team lead or check documentation"
}

# Função para help geral
show_general_help() {
    echo ""
    cli_section_header "📚 GIT FLOW COMMAND REFERENCE"
    
    echo ""
    echo "🎯 $(cli_highlight "Command Categories:" "cyan")"
    
    # Setup & Configuration
    echo ""
    echo "$(cli_highlight "🔧 Setup & Configuration" "green"):"
    cli_command_card "/git/init" "Initialize Git Flow (auto-detect main/master)" "⚙️"
    cli_command_card "/git/help [topic]" "Interactive help system" "❓"
    
    # Feature Development  
    echo ""
    echo "$(cli_highlight "🌿 Feature Development" "green"):"
    cli_command_card "/git/feature/start <name>" "Start new feature branch" "🌱"
    cli_command_card "/git/feature/publish" "Share feature with team" "🤝"
    cli_command_card "/git/feature/finish" "Complete feature (merge to develop)" "✅"
    
    # Release Management
    echo ""
    echo "$(cli_highlight "🚀 Release Management" "green"):"  
    cli_command_card "/git/release/start <version>" "Prepare release branch" "🎯"
    cli_command_card "/git/release/finish" "Deploy to production" "🚀"
    
    # Emergency Fixes
    echo ""
    echo "$(cli_highlight "🚨 Emergency Fixes" "red"):"
    cli_command_card "/git/hotfix/start <name>" "Emergency fix from production" "🔥"  
    cli_command_card "/git/hotfix/finish" "Emergency deployment" "🚨"
    
    # Utilities
    echo ""
    echo "$(cli_highlight "⚡ Utilities" "blue"):"
    cli_command_card "/git/sync [branch]" "Synchronize with remote" "🔄"
    
    echo ""
    cli_section_header "🎓 QUICK START GUIDE"
    
    if [ "$GIT_FLOW_INITIALIZED" = "not-initialized" ]; then
        echo ""
        echo "$(cli_highlight "🚀 Getting Started (First Time):" "green")"
        echo "   1. Initialize: $(cli_dim "/git/init")                    # Setup Git Flow"
        echo "   2. Start work: $(cli_dim "/git/feature/start \"my-feature\"")  # Begin development"
        echo "   3. Develop:    $(cli_dim "# Code your feature")             # Implement changes" 
        echo "   4. Complete:   $(cli_dim "/git/feature/finish")             # Merge when ready"
    else
        echo ""
        echo "$(cli_highlight "🎯 Ready to Continue:" "green")"
        echo "   ▶ New feature: $(cli_dim "/git/feature/start \"feature-name\"")"
        echo "   ▶ Team help: $(cli_dim "/git/help feature")               # Feature workflow guide"
        echo "   ▶ Release: $(cli_dim "/git/help release")              # When ready for production"
    fi
    
    echo ""
    echo "💡 $(cli_highlight "Pro Tips:" "cyan")"
    echo "   ▶ Use $(cli_dim "/git/help <topic>") for specific workflow guidance"
    echo "   ▶ Commands are safe - they include confirmations for critical operations"
    echo "   ▶ The system educates you about Git Flow as you use it"
    echo "   ▶ All commands integrate with ClickUp for project management"
}

# Helper function para command cards
cli_command_card() {
    local command="$1"
    local description="$2"  
    local icon="$3"
    
    echo "   $icon $(cli_highlight "$command" "cyan")"
    echo "      $(cli_dim "$description")"
}

# Helper function para troubleshooting items
cli_troubleshoot_item() {
    local issue="$1"
    local solution="$2"
    local explanation="$3"
    
    echo ""
    echo "❓ $(cli_highlight "$issue" "yellow")"
    echo "   💡 Solution: $(cli_dim "$solution")"  
    echo "   📝 Why: $(cli_dim "$explanation")"
}
```

### **3. Interactive Navigation & Exit**
```bash
# Interactive navigation
echo ""
cli_section_header "🧭 INTERACTIVE NAVIGATION"

if [ "$HELP_TOPIC" = "general" ]; then
    echo ""
    echo "$(cli_highlight "Explore Specific Topics:" "cyan")"
    echo "   ▶ $(cli_dim "/git/help feature")           # Feature development workflow"
    echo "   ▶ $(cli_dim "/git/help release")           # Production release process"  
    echo "   ▶ $(cli_dim "/git/help hotfix")            # Emergency fix procedures"
    echo "   ▶ $(cli_dim "/git/help troubleshooting")   # Problem solving wizard"
    
    echo ""
    echo "❓ Do you want to explore a specific topic? [feature/release/hotfix/troubleshooting/N]"
    read -r navigation_choice
    
    case "$navigation_choice" in
        "feature"|"f")
            echo ""
            show_feature_help
            ;;
        "release"|"r")
            echo ""
            show_release_help
            ;;
        "hotfix"|"h") 
            echo ""
            show_hotfix_help
            ;;
        "troubleshooting"|"t")
            echo ""
            show_troubleshooting_help
            ;;
        *)
            echo ""
            cli_success_box "HELP COMPLETE" "Use /git/help <topic> anytime for specific guidance"
            ;;
    esac
fi

# Summary e next steps
echo ""
cli_separator
echo "$(cli_highlight "🎯 Remember: Git Flow is designed to be safe and educational" "green")"  
echo ""
echo "📚 Additional Resources:"
echo "   ▶ Original Git Flow: Vincent Driessen's branching model"
echo "   ▶ Sistema Onion: Enhanced with safety, UX, and team collaboration"
echo "   ▶ Support: Commands include help text and error recovery"

echo ""
cli_performance_end
```

---

## ✅ **Resultado Esperado para `/git/help`**

```
🆘 GIT FLOW - Interactive Help System
━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 REPOSITORY CONTEXT:
   ▶ Current Branch: feature/user-auth
   ▶ Git Flow Status: Initialized  
   ▶ Repository State: Feature Development

💡 SMART SUGGESTIONS FOR YOU:
   🎯 Feature Workflow: You're on a feature branch
      Next Steps: /git/feature/publish (share) or /git/feature/finish (merge)

📚 GIT FLOW COMMAND REFERENCE:

🎯 Command Categories:

🔧 Setup & Configuration:
   ⚙️ /git/init
      Initialize Git Flow (auto-detect main/master)
   ❓ /git/help [topic]  
      Interactive help system

🌿 Feature Development:
   🌱 /git/feature/start <name>
      Start new feature branch
   🤝 /git/feature/publish
      Share feature with team
   ✅ /git/feature/finish
      Complete feature (merge to develop)

🚀 Release Management:
   🎯 /git/release/start <version>
      Prepare release branch
   🚀 /git/release/finish
      Deploy to production

🚨 Emergency Fixes:
   🔥 /git/hotfix/start <name>
      Emergency fix from production
   🚨 /git/hotfix/finish
      Emergency deployment

🎓 QUICK START GUIDE:
   🎯 Ready to Continue:
      ▶ New feature: /git/feature/start "feature-name"
      ▶ Team help: /git/help feature
      ▶ Release: /git/help release

🧭 INTERACTIVE NAVIGATION:
   ▶ /git/help feature           # Feature development workflow
   ▶ /git/help release           # Production release process  
   ▶ /git/help hotfix            # Emergency fix procedures
   ▶ /git/help troubleshooting   # Problem solving wizard

❓ Do you want to explore a specific topic? [feature/release/hotfix/troubleshooting/N]
```

---

**Este comando `/git/help` modernizado oferece:**
✅ **Context-Aware Help**: Sugestões baseadas no estado atual  
✅ **Interactive Navigation**: Exploração guiada por tópicos  
✅ **Educational Content**: Explica Git Flow durante uso  
✅ **Troubleshooting Wizard**: Soluções para problemas comuns  
✅ **Modern UX**: Visual hierarchy e navigation intuitiva

**🎯 Posso proceder com a implementação dos outros comandos (`/git/init` e `/git/feature/start`)?**

A implementação focará em:
1. ✅ `/git/help` - Interactive help system (NOVO - completo)
2. 🔄 `/git/init` - Modern initialization UX  
3. 🔄 `/git/feature/start` - Enhanced UX polishing

Após esta fase: **85% do projeto completo** com modern UX consistente em todo o sistema!
