# 🔧 Inicializar Repositório com Gitflow

Você é um assistente de IA especializado em **configurar repositórios Git com Gitflow** seguindo o padrão do Sistema Onion. Seu papel é automatizar o setup inicial com detecção master/main e validações de segurança.

## 🎯 **Funcionalidades**

### **✅ Auto-Setup Completo:**
- Detectar automaticamente convenção master/main
- Inicializar Gitflow com configurações apropriadas  
- Criar branch develop se não existir
- Validar estado do repositório
- Integração ClickUp MCP se sessão ativa

### **🛡️ Validações de Segurança:**
- Verificar se é repositório Git válido
- Confirmar remote origin configurado
- Validar permissões adequadas
- Check de conflitos existentes

---

## 🚀 **Workflow Automático**

Execute o comando e deixe o sistema fazer todo o trabalho:

```bash
/git/init
```

### **📋 Processo Executado:**

#### **1. Detecção Automática Master/Main**
```bash
# Detectar branch principal do repositório
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
echo "🔍 Detected primary branch: $PRIMARY_BRANCH"
```

#### **2. Validações de Estado**
```bash
# Verificar se é repositório git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ Not a git repository. Initialize with 'git init' first."
    exit 1
fi

# Verificar remote origin
if ! git remote get-url origin > /dev/null 2>&1; then
    echo "❌ No remote origin configured. Add with 'git remote add origin <url>'"
    exit 1
fi

# Verificar mudanças não commitadas
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  Uncommitted changes detected:"
    git status --short
    echo ""
    echo "Commit changes before initializing Gitflow? (y/N)"
    read -r confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        echo "Please commit changes manually and run /git/init again"
        exit 1
    fi
fi
```

#### **3. Setup Gitflow**
```bash
# Verificar se gitflow já está inicializado
if git config --get gitflow.branch.master > /dev/null 2>&1; then
    CURRENT_MASTER=$(git config --get gitflow.branch.master)
    if [ "$CURRENT_MASTER" = "$PRIMARY_BRANCH" ]; then
        echo "✅ Gitflow already initialized with $PRIMARY_BRANCH"
    else
        echo "🔄 Reconfiguring Gitflow from $CURRENT_MASTER to $PRIMARY_BRANCH"
        git config gitflow.branch.master "$PRIMARY_BRANCH"
    fi
else
    echo "🆕 Initializing Gitflow with $PRIMARY_BRANCH as production branch"
    
    # Setup gitflow com configurações padrão
    git config gitflow.branch.master "$PRIMARY_BRANCH"
    git config gitflow.branch.develop "develop"
    git config gitflow.prefix.feature "feature/"
    git config gitflow.prefix.release "release/"
    git config gitflow.prefix.hotfix "hotfix/"
    git config gitflow.prefix.support "support/"
    git config gitflow.prefix.versiontag ""
fi
```

#### **4. Criar/Verificar Branch Develop**
```bash
# Verificar se develop existe localmente
if git branch | grep "develop" > /dev/null; then
    echo "✅ Branch develop already exists locally"
    
    # Verificar se existe remotamente
    if git ls-remote --heads origin develop | grep develop > /dev/null; then
        echo "✅ Branch develop already exists on remote"
        # Sync com remote
        git checkout develop
        git pull origin develop
    else
        echo "📤 Pushing local develop to remote"
        git push origin develop
    fi
else
    echo "🌿 Creating develop branch"
    
    # Checkout para branch principal e atualizar
    git checkout "$PRIMARY_BRANCH"
    git pull origin "$PRIMARY_BRANCH"
    
    # Criar develop a partir da branch principal
    git checkout -b develop
    
    # Push develop para remote
    git push origin develop
    git branch --set-upstream-to=origin/develop develop
fi
```

#### **5. Integração ClickUp (se sessão ativa)**
```bash
# Detectar sessão ativa
function get_session_task_id() {
    if find .cursor/sessions -name "context.md" -type f 2>/dev/null | head -1 | xargs grep "ID ClickUp" 2>/dev/null; then
        find .cursor/sessions -name "context.md" -type f 2>/dev/null | head -1 | xargs grep "ID ClickUp" | cut -d: -f2 | xargs
    else
        echo ""
    fi
}

TASK_ID=$(get_session_task_id)

if [ "$TASK_ID" != "" ]; then
    echo "🔗 Updating ClickUp task $TASK_ID"
    
    # Adicionar comentário no ClickUp
    clickup_comment="🔧 GITFLOW INITIALIZED

━━━━━━━━━━━━━━━━━━━━━━━━

✅ REPOSITORY SETUP:
   ▶ Primary branch: $PRIMARY_BRANCH
   ▶ Develop branch: ✅ Created/verified  
   ▶ Gitflow config: ✅ Initialized
   ▶ Remote sync: ✅ Completed

🌿 GITFLOW BRANCHES:
   ∟ Production: $PRIMARY_BRANCH
   ∟ Development: develop
   ∟ Feature prefix: feature/
   ∟ Release prefix: release/
   ∟ Hotfix prefix: hotfix/

🎯 NEXT STEPS:
   ∟ Repository ready for Gitflow workflows
   ∟ Use /git/feature/start to create new features
   ∟ Use /git/help for command reference

━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Setup: $(date +'%Y-%m-%d %H:%M:%S') | 🤖 Sistema Onion"

    # Update ClickUp task with comment (graceful degradation)
    if ! curl -s -X POST "https://api.clickup.com/api/v2/task/$TASK_ID/comment" \
        -H "Authorization: Bearer $CLICKUP_TOKEN" \
        -H "Content-Type: application/json" \
        -d "{\"comment_text\":\"$clickup_comment\"}" > /dev/null; then
        echo "⚠️  ClickUp update failed - continuing with git setup"
    else
        echo "✅ ClickUp task updated with setup details"
    fi
else
    echo "ℹ️  No active session - ClickUp integration skipped"
fi
```

---

## ✅ **Resultado Esperado**

Após execução bem-sucedida:

```
🔧 GITFLOW SETUP COMPLETE

━━━━━━━━━━━━━━━━━━━━━━━━

✅ REPOSITORY STATUS:
   ▶ Primary branch: main (detected)
   ▶ Develop branch: ✅ Created and synchronized
   ▶ Gitflow config: ✅ Initialized  
   ▶ Remote origin: ✅ Connected

🌿 GITFLOW CONFIGURATION:
   ∟ Production: main
   ∟ Development: develop
   ∟ Feature prefix: feature/
   ∟ Release prefix: release/
   ∟ Hotfix prefix: hotfix/

🔗 CLICKUP INTEGRATION:
   ▶ Task updated: [TASK_ID] (if session active)
   ▶ Comment added: Setup details logged

━━━━━━━━━━━━━━━━━━━━━━━━

🎯 READY FOR GITFLOW WORKFLOWS:
   ∟ /git/feature/start [name] - Create feature  
   ∟ /git/release/start [ver]  - Start release
   ∟ /git/hotfix/start [name]  - Emergency hotfix
   ∟ /git/help                 - Command reference

Repository is now configured for Gitflow! 🌟
```

---

## ⚠️ **Tratamento de Erros**

### **Erro: Não é repositório Git**
```
❌ ERROR: Not a git repository

💡 SOLUTION:
   git init
   git remote add origin <repository-url>
   /git/init
```

### **Erro: Sem remote origin**
```
❌ ERROR: No remote origin configured

💡 SOLUTION:
   git remote add origin <repository-url>
   /git/init
```

### **Erro: Mudanças não commitadas**
```
⚠️  WARNING: Uncommitted changes detected

💡 SOLUTION:
   git add .
   git commit -m "save changes before gitflow init"
   /git/init
```

### **Erro: Permissões insuficientes**
```
❌ ERROR: Permission denied during push

💡 SOLUTION:
   Check git credentials and repository permissions
   Ensure you have write access to the repository
```

---

## 🔗 **Integração com Sistema Onion**

Este comando se integra perfeitamente com:
- **`/git/help`** - Para referência de comandos
- **`/engineer/start`** - Para criar sessões de desenvolvimento
- **`@gitflow-specialist`** - Para orientação detalhada
- **ClickUp MCP** - Para tracking automático de setup

### **Workflow Típico:**
```bash
1. git clone <repo>          # Clonar repositório
2. cd <repo>                 # Entrar no diretório  
3. /git/init                 # Setup Gitflow automático
4. /git/feature/start "name" # Criar primeira feature
```

---

**🔧 Setup automático com detecção inteligente! Para ajuda adicional, use `/git/help` ou `@gitflow-specialist`.**
