# 🏁 Finalizar Release - Duplo Merge e Tags

Você é um assistente de IA especializado em **finalizar releases com duplo merge e versionamento** seguindo o padrão do Sistema Onion. Seu papel é automatizar o processo de finalização com validações críticas e deploy preparation.

## 🎯 **Funcionalidades**

### **🔀 Duplo Merge:**
- Merge release → main (production)
- Merge release → develop (continue development)
- Validações de conflitos antes de cada merge
- Push automático com sincronização

### **🏷️ Tag Management:**
- Criar tag de versão com metadata
- Assinatura de tag com informações de release
- Push de tags para remote
- Tag validation e conflict checking

### **🚀 Deploy Preparation:**
- Finalização de ClickUp release task
- Release notes generation
- Branch cleanup com confirmações
- Post-release validation

---

## 🚀 **Uso do Comando**

### **Sintaxe:**
```bash
/git/release/finish
```

**Nota**: Auto-detecta release branch atual - execute na release branch que deseja finalizar.

---

## ⚙️ **Workflow Automático**

### **1. Validações de Estado**
```bash
# Detectar branch atual
CURRENT_BRANCH=$(git branch --show-current)

echo "🔍 Current branch: $CURRENT_BRANCH"

# Verificar se é release branch
if [[ ! "$CURRENT_BRANCH" =~ ^release/ ]]; then
    echo "❌ ERROR: Not on a release branch"
    echo "💡 SOLUTION: Switch to release branch first"
    echo ""
    echo "📋 AVAILABLE RELEASE BRANCHES:"
    git branch -a | grep "release/" | sed 's/^/   /' | head -5
    echo ""
    echo "🔧 USAGE:"
    echo "   git checkout release/[version]"
    echo "   /git/release/finish"
    exit 1
fi

# Extrair versão da release
RELEASE_VERSION=$(echo "$CURRENT_BRANCH" | sed 's/^release\\///')
echo "📝 Release version: $RELEASE_VERSION"

# Verificar mudanças não commitadas
if [ -n "$(git status --porcelain)" ]; then
    echo "⚠️  UNCOMMITTED CHANGES DETECTED:"
    git status --short
    echo ""
    echo "🔧 COMMIT CHANGES BEFORE FINISHING:"
    echo "   git add ."
    echo "   git commit -m \"final changes for release $RELEASE_VERSION\""
    echo "   /git/release/finish"
    exit 1
fi

echo "✅ Release branch validation passed"
```

### **2. Detecção Branches e Validações**
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
if ! git branch -r | grep "origin/develop" > /dev/null; then
    echo "❌ ERROR: Branch 'develop' not found on remote"
    echo "💡 This is unusual for Gitflow - proceed with $PRIMARY_BRANCH only?"
    echo "Continue with single merge to $PRIMARY_BRANCH? (y/N)"
    read -r confirm
    if [[ ! "$confirm" =~ ^[Yy]$ ]]; then
        echo "❌ Aborting release finish"
        exit 1
    fi
    DEVELOP_EXISTS=false
else
    DEVELOP_EXISTS=true
fi

echo "📋 Target branches: $PRIMARY_BRANCH$([ "$DEVELOP_EXISTS" = "true" ] && echo ", develop" || echo " only")"
```

### **3. Verificação de Tag e Conflitos**
```bash
# Preparar tag version
TAG_VERSION="v$RELEASE_VERSION"

# Verificar se tag já existe  
if git tag | grep "^$TAG_VERSION$" > /dev/null; then
    echo "⚠️  WARNING: Tag $TAG_VERSION already exists"
    echo "🔧 SOLUTIONS:"
    echo "   1. Delete existing tag: git tag -d $TAG_VERSION"
    echo "   2. Use different version"  
    echo "   3. Skip tag creation"
    echo ""
    echo "Delete existing tag and continue? (y/N)"
    read -r confirm
    if [[ "$confirm" =~ ^[Yy]$ ]]; then
        git tag -d "$TAG_VERSION"
        # Delete remote tag if exists
        git push origin --delete "$TAG_VERSION" 2>/dev/null || true
        echo "✅ Existing tag deleted"
    else
        echo "❌ Aborting release finish"
        exit 1
    fi
fi

echo "🏷️  Tag $TAG_VERSION will be created"
```

### **4. Primeiro Merge: Release → Main**
```bash
echo "🔀 Starting first merge: $CURRENT_BRANCH → $PRIMARY_BRANCH"

# Atualizar main branch
echo "📥 Updating $PRIMARY_BRANCH..."
git checkout "$PRIMARY_BRANCH"
if ! git pull origin "$PRIMARY_BRANCH"; then
    echo "❌ ERROR: Failed to update $PRIMARY_BRANCH"
    echo "💡 Check network connectivity and permissions"
    exit 1
fi

# Merge release para main
echo "🔀 Merging $CURRENT_BRANCH into $PRIMARY_BRANCH..."
if git merge --no-ff "$CURRENT_BRANCH" -m "Release $RELEASE_VERSION

🚀 Release: $RELEASE_VERSION
🔀 Merged: $CURRENT_BRANCH → $PRIMARY_BRANCH
📋 Features: (See CHANGELOG.md for details)

✅ Production deployment ready
🏷️ Tagged as: $TAG_VERSION  

Via: /git/release/finish"; then
    echo "✅ Release merged to $PRIMARY_BRANCH successfully"
else
    echo "❌ MERGE FAILED to $PRIMARY_BRANCH - Conflicts detected"
    echo ""
    echo "🔧 RESOLVE CONFLICTS:"
    echo "   1. Fix conflicts in the listed files"
    echo "   2. git add [resolved-files]"  
    echo "   3. git commit -m \"resolve release conflicts\""
    echo "   4. /git/release/finish  # Re-run this command"
    echo ""
    echo "📋 CONFLICTED FILES:"
    git status --short | grep "^UU\\|^AA\\|^DD" | sed 's/^/   /'
    exit 1
fi

# Push main com release merge
echo "📤 Pushing $PRIMARY_BRANCH with release merge..."
if ! git push origin "$PRIMARY_BRANCH"; then
    echo "⚠️  WARNING: Push to remote $PRIMARY_BRANCH failed"
    echo "💡 Merge completed locally, manual push needed:"
    echo "   git push origin $PRIMARY_BRANCH"
fi
```

### **5. Segundo Merge: Release → Develop (se existir)**
```bash
if [ "$DEVELOP_EXISTS" = "true" ]; then
    echo "🔀 Starting second merge: $CURRENT_BRANCH → develop"
    
    # Atualizar develop branch
    echo "📥 Updating develop..."
    git checkout develop
    if ! git pull origin develop; then
        echo "❌ ERROR: Failed to update develop"
        echo "💡 Check network connectivity - continuing with local merge"
    fi
    
    # Merge release para develop
    echo "🔀 Merging $CURRENT_BRANCH into develop..."
    if git merge --no-ff "$CURRENT_BRANCH" -m "Merge release $RELEASE_VERSION into develop

🔄 Post-release merge: $CURRENT_BRANCH → develop
📈 Version: $RELEASE_VERSION now in development branch  
🔀 Includes all production-ready features

Via: /git/release/finish"; then
        echo "✅ Release merged to develop successfully"
    else
        echo "❌ MERGE FAILED to develop - Conflicts detected"
        echo ""
        echo "⚠️  CRITICAL: Main merge succeeded but develop merge failed"
        echo "🔧 MANUAL RESOLUTION REQUIRED:"
        echo "   1. Resolve conflicts manually"
        echo "   2. Complete develop merge"
        echo "   3. Continue with tag creation"
        echo ""
        echo "📋 CONFLICTED FILES:"
        git status --short | grep "^UU\\|^AA\\|^DD" | sed 's/^/   /'
        echo ""
        echo "Continue with tag creation anyway? (y/N)"
        read -r continue_confirm
        if [[ ! "$continue_confirm" =~ ^[Yy]$ ]]; then
            echo "❌ Aborting - resolve develop conflicts manually"
            exit 1
        fi
    fi
    
    # Push develop com release merge
    echo "📤 Pushing develop with release merge..."
    if ! git push origin develop; then
        echo "⚠️  WARNING: Push to remote develop failed"
        echo "💡 Manual push needed: git push origin develop"
    fi
else
    echo "ℹ️  Skipping develop merge (branch not found)"
fi
```

### **6. Tag Creation e Push**
```bash
echo "🏷️  Creating release tag: $TAG_VERSION"

# Voltar para main para criar tag
git checkout "$PRIMARY_BRANCH"

# Criar tag anotada com informações detalhadas
TAG_MESSAGE="Release $RELEASE_VERSION

🚀 Production release created $(date '+%Y-%m-%d %H:%M:%S')

📋 Release Details:
- Version: $RELEASE_VERSION
- Branch: $CURRENT_BRANCH  
- Merged to: $PRIMARY_BRANCH$([ "$DEVELOP_EXISTS" = "true" ] && echo ", develop" || echo "")
- Commit: $(git rev-parse HEAD)

🎯 Deployment Information:
- Ready for production deployment
- All tests should be passing
- Documentation updated

🔧 Technical Notes:
- Double merge completed$([ "$DEVELOP_EXISTS" = "true" ] && echo "" || echo " (single branch)")
- Release branch can be safely deleted
- Tag signed and pushed to remote

Via: Sistema Onion /git/release/finish"

if git tag -a "$TAG_VERSION" -m "$TAG_MESSAGE"; then
    echo "✅ Tag $TAG_VERSION created successfully"
else
    echo "❌ ERROR: Failed to create tag"
    echo "💡 Manual tag creation: git tag -a $TAG_VERSION -m \"Release $RELEASE_VERSION\""
fi

# Push tag para remote
echo "📤 Pushing tag to remote..."
if git push origin "$TAG_VERSION"; then
    echo "✅ Tag pushed to remote successfully"
else
    echo "⚠️  WARNING: Tag push failed"
    echo "💡 Manual tag push: git push origin $TAG_VERSION"
fi

# Listar tags recentes para confirmação
echo ""
echo "🏷️  RECENT TAGS:"
git tag | grep -E "^v?[0-9]+\\.[0-9]+\\.[0-9]+$" | sort -V | tail -3 | sed 's/^/   /'
```

### **7. Branch Cleanup**
```bash
echo "🧹 Release branch cleanup..."

# Confirmar deletion da release branch
echo ""
echo "🗑️  DELETE RELEASE BRANCH?"
echo "   Branch: $CURRENT_BRANCH"
echo "   Status: Successfully merged to $PRIMARY_BRANCH$([ "$DEVELOP_EXISTS" = "true" ] && echo " and develop" || echo "")"
echo "   Tagged: $TAG_VERSION"
echo ""
echo "⚠️  This action is irreversible!"
echo "Delete release branch? (Y/n)"
read -r confirm

if [[ "$confirm" =~ ^[Nn]$ ]]; then
    echo "📝 Keeping release branch locally"
    BRANCH_DELETED=false
else
    # Switch away from release branch before deletion
    git checkout "$PRIMARY_BRANCH"
    
    # Delete local release branch
    if git branch -d "$CURRENT_BRANCH"; then
        echo "✅ Local release branch deleted"
        BRANCH_DELETED=true
    else
        echo "⚠️  Failed to delete local branch"
        echo "💡 Force delete: git branch -D $CURRENT_BRANCH"
        BRANCH_DELETED=false
    fi
fi

# Cleanup remote release branch
if git ls-remote --heads origin "$CURRENT_BRANCH" | grep "$CURRENT_BRANCH" > /dev/null; then
    echo ""
    echo "🌐 DELETE REMOTE RELEASE BRANCH?"
    echo "   Remote: origin/$CURRENT_BRANCH"
    echo "   Status: No longer needed after successful release"
    echo ""
    echo "Delete remote release branch? (Y/n)"
    read -r confirm_remote
    
    if [[ ! "$confirm_remote" =~ ^[Nn]$ ]]; then
        if git push origin --delete "$CURRENT_BRANCH"; then
            echo "✅ Remote release branch deleted"
        else
            echo "⚠️  Failed to delete remote branch"
            echo "💡 Manual cleanup: git push origin --delete $CURRENT_BRANCH"
        fi
    fi
fi
```

### **8. ClickUp Integration e Finalização**
```bash
# Detectar task de release ClickUp
function find_release_task() {
    # Procurar por task de release com título específico
    if [ "$CLICKUP_TOKEN" != "" ]; then
        # Busca por tasks com título contendo "Release $RELEASE_VERSION"
        curl -s -H "Authorization: Bearer $CLICKUP_TOKEN" \
            "https://api.clickup.com/api/v2/team/YOUR_TEAM_ID/task?include_closed=false" 2>/dev/null | \
            jq -r ".tasks[] | select(.name | contains(\"Release $RELEASE_VERSION\")) | .id" 2>/dev/null | head -1
    fi
}

RELEASE_TASK_ID=$(find_release_task)

# Detectar também task da sessão se existir
PARENT_TASK_ID=""
if find .cursor/sessions -name "context.md" -type f 2>/dev/null | head -1 | xargs grep "ID ClickUp" 2>/dev/null; then
    PARENT_TASK_ID=$(find .cursor/sessions -name "context.md" -type f 2>/dev/null | head -1 | xargs grep "ID ClickUp" | cut -d: -f2 | xargs)
fi

if [ "$RELEASE_TASK_ID" != "" ] || [ "$PARENT_TASK_ID" != "" ]; then
    echo "🔗 Updating ClickUp tasks..."
    
    # Comentário de finalização
    COMPLETION_COMMENT="🏁 RELEASE FINALIZADA COM SUCESSO

━━━━━━━━━━━━━━━━━━━━━━━━

🚀 RELEASE COMPLETED:
   ▶ Version: $RELEASE_VERSION
   ▶ Tag created: $TAG_VERSION
   ▶ Merged to: $PRIMARY_BRANCH$([ "$DEVELOP_EXISTS" = "true" ] && echo ", develop" || echo " only")
   ▶ Branch cleanup: $([ "$BRANCH_DELETED" = "true" ] && echo "✅ Deleted" || echo "⚠️  Kept locally")

🔀 MERGE SUMMARY:
   ∟ Production: $CURRENT_BRANCH → $PRIMARY_BRANCH ✅  
   ∟ Development: $CURRENT_BRANCH → develop $([ "$DEVELOP_EXISTS" = "true" ] && echo "✅" || echo "⏭️  Skipped")
   ∟ Tag created: $TAG_VERSION ✅
   ∟ Remote sync: ✅ Pushed to origin

🎯 DEPLOYMENT STATUS:
   ∟ Production ready: ✅ Tagged and merged
   ∟ CI/CD pipeline: Ready to trigger
   ∟ Rollback plan: Previous version available
   ∟ Monitoring: Enable post-deployment checks

📊 RELEASE STATS:
   ∟ Release branch: $CURRENT_BRANCH
   ∟ Commit count: $(git rev-list --count "$TAG_VERSION"~1.."$TAG_VERSION" 2>/dev/null || echo "N/A")
   ∟ Automated via: /git/release/finish
   ∟ Double merge: $([ "$DEVELOP_EXISTS" = "true" ] && echo "Complete" || echo "Single branch")

🏷️  VERSION HISTORY:
   ∟ Current: $RELEASE_VERSION (production)
   ∟ Tag: $TAG_VERSION  
   ∟ Previous: $(git describe --tags --abbrev=0 "$TAG_VERSION~1" 2>/dev/null || echo "N/A")

━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Finalizada: $(date +'%Y-%m-%d %H:%M:%S') | 🧅 Sistema Onion"

    # Update release task se encontrada
    if [ "$RELEASE_TASK_ID" != "" ]; then
        if curl -s -X PUT "https://api.clickup.com/api/v2/task/$RELEASE_TASK_ID" \
            -H "Authorization: Bearer $CLICKUP_TOKEN" \
            -H "Content-Type: application/json" \
            -d '{"status": "done"}' > /dev/null && \
           curl -s -X POST "https://api.clickup.com/api/v2/task/$RELEASE_TASK_ID/comment" \
            -H "Authorization: Bearer $CLICKUP_TOKEN" \
            -H "Content-Type: application/json" \
            -d "{\"comment_text\":\"$COMPLETION_COMMENT\"}" > /dev/null; then
            echo "✅ Release task updated to 'Done'"
        else
            echo "⚠️  Release task update failed"
        fi
    fi
    
    # Update parent task se existir
    if [ "$PARENT_TASK_ID" != "" ]; then
        curl -s -X POST "https://api.clickup.com/api/v2/task/$PARENT_TASK_ID/comment" \
            -H "Authorization: Bearer $CLICKUP_TOKEN" \
            -H "Content-Type: application/json" \
            -d "{\"comment_text\":\"$COMPLETION_COMMENT\"}" > /dev/null || true
        echo "✅ Parent task updated with release completion"
    fi
else
    echo "ℹ️  No ClickUp tasks found - release completed successfully"
fi
```

---

## ✅ **Resultado Esperado**

```
🏁 RELEASE FINISHED SUCCESSFULLY!

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚀 RELEASE SUMMARY:
   ▶ Version: 2.1.0  
   ▶ Tag: v2.1.0 ✅ Created and pushed
   ▶ Production: release/2.1.0 → main ✅ Merged
   ▶ Development: release/2.1.0 → develop ✅ Merged
   ▶ Branch cleanup: ✅ Local and remote branches deleted

🔗 CLICKUP INTEGRATION:
   ▶ Release task: Updated to Done
   ▶ Parent task: Updated with completion details
   ▶ Comments: Detailed release summary added

🎯 DEPLOYMENT READY:
   ▶ Production branch: main (with v2.1.0)
   ▶ CI/CD trigger: Ready for automated deployment
   ▶ Rollback available: Previous version tagged
   ▶ Monitoring: Enable post-deployment checks

📊 NEXT STEPS:
   ∟ Monitor production deployment  
   ∟ Verify application health metrics
   ∟ Update documentation if needed
   ∟ Close related issues and tasks

🏷️  VERSION INFO:
   ∟ Production: v2.1.0 (current)
   ∟ Development: ready for next features  
   ∟ Tags: Available for rollback if needed

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🌟 Release 2.1.0 deployed successfully! 🎉
```

---

## ⚠️ **Tratamento de Erros**

### **Erro: Não é release branch**
```
❌ ERROR: Not on a release branch
💡 Switch to release branch first:
   git checkout release/[version]
   /git/release/finish
```

### **Erro: Conflitos de merge**
```
❌ MERGE FAILED - Conflicts detected
🔧 RESOLVE CONFLICTS:
   1. Fix conflicts in listed files
   2. git add [resolved-files]
   3. git commit
   4. /git/release/finish  # Re-run
```

### **Erro: Tag já existe**
```
⚠️  WARNING: Tag v2.1.0 already exists
🔧 Delete and continue? (y/N)
```

### **Erro: Push failed**
```
⚠️  Push to remote failed
💡 Manual push needed:
   git push origin main
   git push origin v2.1.0
```

---

## 🔗 **Integração com Sistema Onion**

### **Workflow Completo:**
```bash
1. /git/release/start "2.1.0"      # Preparar release
2. # ... final testing & approvals ...  
3. /git/release/finish             # Finalizar release (este comando)
4. /git/sync main                  # Pós-release sync
```

### **Comandos Relacionados:**
- **`/git/release/start`** - Iniciar processo de release
- **`/git/sync`** - Sincronização pós-release  
- **`/git/help`** - Referência de comandos
- **Deploy pipelines** - Triggered by tags

### **Quando Usar:**
- ✅ **Release testing completo** e aprovado
- ✅ **Ready para produção** com todas validações
- ✅ **Deploy automático** via tags
- ✅ **Processo estruturado** de release management

---

## 💡 **Dicas de Uso**

### **✅ Antes de Finalizar:**
```bash
# Na release branch, garantir tudo testado
git checkout release/2.1.0
npm test           # Todos os testes passando
npm run build      # Build sem erros
# Verificar CHANGELOG.md atualizado

# Então finalizar
/git/release/finish
```

### **🚀 Pós-Release:**
```bash
# Monitorar deployment
# Verificar logs de produção
# Confirmar métricas de aplicação
# Fechar issues relacionadas
```

---

**🏁 Finalização automática com duplo merge, tags e deploy preparation! Produção ready com tracking completo.**
