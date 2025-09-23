# 🚀 Iniciar Release - Workflow Versionamento

Você é um assistente de IA especializado em **iniciar processo de release com versionamento automático** seguindo o padrão do Sistema Onion. Seu papel é automatizar o workflow de release com detecção de versioning e preparação de branch.

## 🎯 **Funcionalidades**

### **📋 Release Workflow:**
- Criar release branch a partir de develop
- Auto-detecção e bump de versioning (semver)  
- Preparação automática de changelog
- Task ClickUp para release tracking
- Validações de estado pré-release

### **🏷️ Versionamento Inteligente:**
- Detecção automática de package.json, version files
- Bump semântico (major.minor.patch)
- Support para diferentes tipos de projeto
- Validações de tag conflicts

---

## 🚀 **Uso do Comando**

### **Sintaxe:**
```bash
/git/release/start "version"
```

### **Examples:**
```bash
/git/release/start "v2.1.0"     # Release com versão específica
/git/release/start "2.1.0"      # Sem prefixo v
/git/release/start "patch"      # Auto-bump patch (2.0.1 → 2.0.2)
/git/release/start "minor"      # Auto-bump minor (2.0.1 → 2.1.0)
/git/release/start "major"      # Auto-bump major (2.0.1 → 3.0.0)
```

---

## ⚙️ **Workflow Automático**

### **1. Validações Iniciais**
```bash
# Verificar se versão foi fornecida
if [ "$#" -eq 0 ]; then
    echo "❌ ERROR: Version required"
    echo "📖 USAGE: /git/release/start \"version\""
    echo ""
    echo "💡 EXAMPLES:"
    echo "  /git/release/start \"v2.1.0\"    # Specific version"
    echo "  /git/release/start \"patch\"     # Auto-bump patch"
    echo "  /git/release/start \"minor\"     # Auto-bump minor"
    echo "  /git/release/start \"major\"     # Auto-bump major"
    exit 1
fi

VERSION_INPUT="$1"
echo "🚀 Starting release process for: $VERSION_INPUT"

# Verificar se é repositório git
if ! git rev-parse --git-dir > /dev/null 2>&1; then
    echo "❌ ERROR: Not a git repository"
    echo "💡 Initialize with: git init && /git/init"
    exit 1
fi

# Verificar mudanças não commitadas
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  UNCOMMITTED CHANGES DETECTED:"
    git status --short
    echo ""
    echo "🔧 COMMIT CHANGES BEFORE RELEASE:"
    echo "   git add ."
    echo "   git commit -m \"prepare for release $VERSION_INPUT\""
    echo "   /git/release/start \"$VERSION_INPUT\""
    exit 1
fi

echo "✅ Repository validation passed"
```

### **2. Detecção Primary Branch + Develop**
```bash
# Detectar branch principal (master/main)
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
echo "🎯 Primary branch detected: $PRIMARY_BRANCH"

# Verificar se develop existe
if ! git branch -r | grep "origin/develop" > /dev/null && ! git branch | grep "develop" > /dev/null; then
    echo "❌ ERROR: Branch 'develop' not found"
    echo "💡 SOLUTION: Initialize Gitflow first"
    echo "   /git/init"
    exit 1
fi

# Checkout e atualizar develop
echo "📥 Updating develop branch..."
git checkout develop
if ! git pull origin develop; then
    echo "❌ ERROR: Failed to update develop"
    echo "💡 Check network connectivity and resolve conflicts"
    exit 1
fi

echo "✅ Develop branch updated"
```

### **3. Version Detection e Auto-Bump**
```bash
# Detectar versão atual
function detect_current_version() {
    # Procurar por package.json
    if [ -f "package.json" ] && grep -q "version" package.json; then
        grep '"version"' package.json | sed 's/.*"version": *"\\([^"]*\\)".*/\\1/' | head -1
    # Procurar por version files comuns
    elif [ -f "version.txt" ]; then
        cat version.txt | head -1
    elif [ -f "VERSION" ]; then
        cat VERSION | head -1
    # Procurar pela última tag git
    elif git describe --tags --abbrev=0 2>/dev/null; then
        git describe --tags --abbrev=0 | sed 's/^v//'
    else
        echo "0.1.0"  # Default version
    fi
}

CURRENT_VERSION=$(detect_current_version)
echo "📋 Current version detected: $CURRENT_VERSION"

# Processar version input
function calculate_new_version() {
    local input="$1"
    local current="$2"
    
    # Remover prefixo 'v' se presente
    input=$(echo "$input" | sed 's/^v//')
    current=$(echo "$current" | sed 's/^v//')
    
    case "$input" in
        "patch")
            echo "$current" | awk -F. '{print $1"."$2"."($3+1)}'
            ;;
        "minor")
            echo "$current" | awk -F. '{print $1"."($2+1)".0"}'
            ;;
        "major")
            echo "$current" | awk -F. '{print ($1+1)".0.0"}'
            ;;
        *)
            # Versão específica fornecida
            if [[ "$input" =~ ^[0-9]+\\.[0-9]+\\.[0-9]+$ ]]; then
                echo "$input"
            else
                echo "INVALID"
            fi
            ;;
    esac
}

NEW_VERSION=$(calculate_new_version "$VERSION_INPUT" "$CURRENT_VERSION")

if [ "$NEW_VERSION" = "INVALID" ]; then
    echo "❌ ERROR: Invalid version format: $VERSION_INPUT"
    echo "💡 Valid formats: '2.1.0', 'v2.1.0', 'patch', 'minor', 'major'"
    exit 1
fi

echo "🎯 New version calculated: $NEW_VERSION"
echo "📈 Version bump: $CURRENT_VERSION → $NEW_VERSION"
```

### **4. Verificação de Conflitos**
```bash
# Verificar se tag já existe
if git tag | grep -E "^v?$NEW_VERSION$" > /dev/null; then
    echo "❌ ERROR: Tag for version $NEW_VERSION already exists"
    echo "📋 EXISTING TAGS:"
    git tag | grep -E "^v?[0-9]+\\.[0-9]+\\.[0-9]+$" | sort -V | tail -5 | sed 's/^/   /'
    echo ""
    echo "💡 SOLUTIONS:"
    echo "   - Use different version: /git/release/start \"$(calculate_new_version "patch" "$NEW_VERSION")\""
    echo "   - Delete existing tag: git tag -d v$NEW_VERSION"
    exit 1
fi

# Verificar se release branch já existe
RELEASE_BRANCH="release/$NEW_VERSION"
if git branch -a | grep -E "(^|\\s+)$RELEASE_BRANCH(\\s+|$)" > /dev/null; then
    echo "❌ ERROR: Release branch '$RELEASE_BRANCH' already exists"
    echo "💡 SOLUTIONS:"
    echo "   - Switch to existing: git checkout $RELEASE_BRANCH"
    echo "   - Delete and recreate: git branch -D $RELEASE_BRANCH"
    echo "   - Use different version"
    exit 1
fi

echo "✅ Version validation passed"
```

### **5. Criação da Release Branch**
```bash
echo "🌿 Creating release branch: $RELEASE_BRANCH"

# Criar release branch a partir de develop
if git checkout -b "$RELEASE_BRANCH"; then
    echo "✅ Release branch created successfully"
else
    echo "❌ ERROR: Failed to create release branch"
    exit 1
fi

# Push branch para remote
echo "📤 Pushing release branch to remote..."
if git push origin "$RELEASE_BRANCH"; then
    echo "✅ Release branch pushed to remote"
    git branch --set-upstream-to=origin/"$RELEASE_BRANCH" "$RELEASE_BRANCH"
else
    echo "⚠️  WARNING: Failed to push to remote"
    echo "💡 Continue locally, push manually later: git push origin $RELEASE_BRANCH"
fi
```

### **6. Version File Updates**
```bash
echo "📝 Updating version files..."

# Atualizar package.json
if [ -f "package.json" ] && grep -q "version" package.json; then
    echo "📦 Updating package.json version..."
    sed -i "s/\\\"version\\\": *\\\"[^\\\"]*\\\"/\\\"version\\\": \\\"$NEW_VERSION\\\"/" package.json
    echo "✅ package.json updated"
fi

# Atualizar version.txt
if [ -f "version.txt" ]; then
    echo "$NEW_VERSION" > version.txt
    echo "✅ version.txt updated"
fi

# Atualizar VERSION
if [ -f "VERSION" ]; then
    echo "$NEW_VERSION" > VERSION
    echo "✅ VERSION file updated"
fi

# Commit das mudanças de versioning
if [ -n "$(git status --porcelain)" ]; then
    echo "💾 Committing version changes..."
    git add .
    git commit -m "chore: bump version to $NEW_VERSION

🚀 Release $NEW_VERSION preparation
- Updated version files
- Created release branch: $RELEASE_BRANCH
- Ready for final testing and release

Via: /git/release/start"
    echo "✅ Version changes committed"
else
    echo "ℹ️  No version files to update"
fi
```

### **7. Changelog Preparation**
```bash
echo "📋 Preparing changelog..."

# Gerar changelog básico se não existir
if [ ! -f "CHANGELOG.md" ]; then
    echo "📝 Creating CHANGELOG.md..."
    cat > CHANGELOG.md << EOF
# Changelog

All notable changes to this project will be documented in this file.

## [$NEW_VERSION] - $(date '+%Y-%m-%d')

### Added
- Release preparation for version $NEW_VERSION

### Changed
- Version bump from $CURRENT_VERSION to $NEW_VERSION

### Fixed
- (Add bug fixes here)

### Security
- (Add security improvements here)

---

For previous versions, see git history.
EOF
    git add CHANGELOG.md
    git commit -m "docs: create CHANGELOG.md for release $NEW_VERSION"
    echo "✅ CHANGELOG.md created"
else
    echo "ℹ️  CHANGELOG.md exists - manual updates may be needed"
fi
```

### **8. ClickUp Integration**
```bash
# Detectar sessão ClickUp se existir
function get_session_task_id() {
    if find .cursor/sessions -name "context.md" -type f 2>/dev/null | head -1 | xargs grep "ID ClickUp" 2>/dev/null; then
        find .cursor/sessions -name "context.md" -type f 2>/dev/null | head -1 | xargs grep "ID ClickUp" | cut -d: -f2 | xargs
    else
        echo ""
    fi
}

PARENT_TASK_ID=$(get_session_task_id)

# Criar task ClickUp para release
echo "🔗 Creating ClickUp release task..."

RELEASE_TASK_TITLE="🚀 Release $NEW_VERSION"
RELEASE_DESCRIPTION="## 🎯 **Release Process**

**Version**: $NEW_VERSION  
**Previous**: $CURRENT_VERSION  
**Branch**: $RELEASE_BRANCH  
**Created via**: /git/release/start

---

## 📋 **Release Checklist**

### **Pre-Release:**
- [x] Release branch created from develop
- [x] Version files updated
- [ ] Final testing completed
- [ ] Documentation updated
- [ ] Security review completed

### **Release Process:**
- [ ] QA approval obtained
- [ ] Staging environment tested
- [ ] Production deployment approved
- [ ] Release notes finalized

### **Post-Release:**
- [ ] Execute: /git/release/finish
- [ ] Monitor production metrics
- [ ] Update documentation
- [ ] Close related issues

---

## 🔄 **Next Steps**

### **To Finish Release:**
\`\`\`bash
# After final testing and approvals:
/git/release/finish
\`\`\`

### **Version Details:**
- **Current Branch**: $RELEASE_BRANCH
- **Target Main**: $PRIMARY_BRANCH  
- **Merge Strategy**: Double merge (main + develop)
- **Tag**: v$NEW_VERSION (auto-created on finish)

---

## 🏷️ **Version History**
- **Previous**: $CURRENT_VERSION
- **Current**: $NEW_VERSION
- **Type**: $(echo "$VERSION_INPUT" | grep -E "^(patch|minor|major)$" || echo "specific")

**Created automatically by Sistema Onion** 🧅"

# Detectar lista ClickUp
LIST_ID="901314121395"  # Lista Desenvolvimento (fallback)
if [ "$PARENT_TASK_ID" != "" ]; then
    PARENT_LIST_ID=$(curl -s -H "Authorization: Bearer $CLICKUP_TOKEN" \
        "https://api.clickup.com/api/v2/task/$PARENT_TASK_ID" | \
        jq -r '.list.id' 2>/dev/null)
    if [ "$PARENT_LIST_ID" != "" ] && [ "$PARENT_LIST_ID" != "null" ]; then
        LIST_ID="$PARENT_LIST_ID"
    fi
fi

# Criar task via API
RESPONSE=$(curl -s -X POST "https://api.clickup.com/api/v2/list/$LIST_ID/task" \
    -H "Authorization: Bearer $CLICKUP_TOKEN" \
    -H "Content-Type: application/json" \
    -d "{
        \"name\": \"$RELEASE_TASK_TITLE\",
        \"markdown_description\": \"$RELEASE_DESCRIPTION\",
        \"status\": \"in progress\",
        \"priority\": 2,
        \"tags\": [\"release\", \"version-$NEW_VERSION\", \"gitflow\"]
    }")

RELEASE_TASK_ID=$(echo "$RESPONSE" | jq -r '.id' 2>/dev/null)

if [ "$RELEASE_TASK_ID" != "" ] && [ "$RELEASE_TASK_ID" != "null" ]; then
    RELEASE_URL="https://app.clickup.com/t/$RELEASE_TASK_ID"
    echo "✅ ClickUp release task created: $RELEASE_TASK_ID"
    
    # Link com task parent se existir
    if [ "$PARENT_TASK_ID" != "" ]; then
        curl -s -X POST "https://api.clickup.com/api/v2/task/$PARENT_TASK_ID/link/$RELEASE_TASK_ID" \
            -H "Authorization: Bearer $CLICKUP_TOKEN" > /dev/null || true
        echo "🔗 Linked with parent task: $PARENT_TASK_ID"
    fi
else
    echo "⚠️  ClickUp task creation failed - release process continues"
    RELEASE_URL="Manual task creation needed"
fi
```

---

## ✅ **Resultado Esperado**

```
🚀 RELEASE STARTED SUCCESSFULLY!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 RELEASE DETAILS:
   ▶ Version: 2.1.0 (bump from 2.0.3)
   ▶ Branch: release/2.1.0  
   ▶ Base: develop (updated and clean)
   ▶ Target: main (for final merge)

📝 VERSION UPDATES:
   ▶ package.json: ✅ Updated
   ▶ version.txt: ✅ Updated
   ▶ CHANGELOG.md: ✅ Created/Ready for manual updates

🔗 CLICKUP TRACKING:
   ▶ Release task: 🚀 Release 2.1.0
   ▶ URL: https://app.clickup.com/t/abc123
   ▶ Status: In Progress  
   ▶ Checklist: Pre-release items ready

🎯 NEXT STEPS:
   ∟ Perform final testing on release/2.1.0 branch
   ∟ Update CHANGELOG.md with specific changes
   ∟ Get QA/security approvals  
   ∟ Execute: /git/release/finish when ready

📋 PRE-RELEASE CHECKLIST:
   ∟ [ ] Final testing completed
   ∟ [ ] Documentation updated
   ∟ [ ] Security review completed  
   ∟ [ ] QA approval obtained

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌟 Release 2.1.0 preparation complete! Ready for final testing.
```

---

## ⚠️ **Tratamento de Erros**

### **Erro: Versão inválida**
```
❌ ERROR: Invalid version format: abc
💡 Valid formats: '2.1.0', 'v2.1.0', 'patch', 'minor', 'major'
```

### **Erro: Tag já existe**
```
❌ ERROR: Tag for version 2.1.0 already exists
💡 SOLUTIONS:
   - Use different version
   - Delete existing tag: git tag -d v2.1.0
```

### **Erro: Mudanças não commitadas**
```
⚠️  UNCOMMITTED CHANGES DETECTED
🔧 COMMIT CHANGES BEFORE RELEASE:
   git add .
   git commit -m "prepare for release"
   /git/release/start "2.1.0"
```

### **Erro: Branch develop não existe**
```
❌ ERROR: Branch 'develop' not found
💡 SOLUTION: Initialize Gitflow first
   /git/init
```

---

## 🔗 **Integração com Sistema Onion**

### **Workflow Completo:**
```bash
1. /git/release/start "2.1.0"      # Preparar release (este comando)
2. # ... final testing & approvals ...
3. /git/release/finish             # Finalizar release (próximo comando)
4. /git/sync main                  # Pós-release sync
```

### **Comandos Relacionados:**
- **`/git/release/finish`** - Finalizar release com merges e tags
- **`/git/init`** - Setup inicial Gitflow se necessário
- **`/git/help`** - Referência de comandos
- **`/git/sync`** - Sincronização pós-release

### **Quando Usar:**
- ✅ **Preparar nova release** com versionamento
- ✅ **Features completas** em develop branch  
- ✅ **Ready para testes finais** antes produção
- ✅ **Processo estruturado** com tracking ClickUp

---

## 💡 **Dicas de Uso**

### **✅ Boas Práticas:**
```bash
# Versioning semântico
/git/release/start "patch"    # Bug fixes (2.0.1 → 2.0.2)
/git/release/start "minor"    # New features (2.0.1 → 2.1.0)  
/git/release/start "major"    # Breaking changes (2.0.1 → 3.0.0)

# Versões específicas para casos especiais
/git/release/start "v2.1.0"  # Com prefixo v
/git/release/start "2.1.0"   # Sem prefixo
```

### **🔧 Antes da Release:**
```bash
# Garantir develop atualizado e limpo
git checkout develop
git pull origin develop
git status  # Deve estar clean

# Testar se tudo funciona
npm test        # ou comando de teste do projeto
npm run build   # ou comando de build

# Então iniciar release
/git/release/start "minor"
```

---

**🚀 Preparação automática de release com versionamento inteligente! Para finalizar, use `/git/release/finish` após testing.**
