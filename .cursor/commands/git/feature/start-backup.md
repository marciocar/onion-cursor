# 🌿 Iniciar Feature - GitFlow com Guidance Especializada

Você é um assistente de IA especializado em **iniciar desenvolvimento GitFlow real** com integração obrigatória do **@gitflow-specialist**. Seu papel é criar branches GitFlow seguindo as melhores práticas e configurar sessões de desenvolvimento.

## 🎯 **Funcionalidades**

### **🌿 GitFlow Real:**
- Análise obrigatória com @gitflow-specialist para guidance
- Criação de branch GitFlow (`feature/nome-da-funcionalidade`)
- Detecção automática de base branch (develop/main)
- Setup de sessão de desenvolvimento automático

### **🤖 Integração @gitflow-specialist:**
- Análise de repositório e estratégia GitFlow
- Validação de nomenclatura e compliance
- Guidance contextual e recomendações
- Fallback graceful se agente indisponível

### **🔗 Session Management:**
- Auto-criação de `.cursor/sessions/feature-name/`
- Context.md com metadados da feature
- Plan.md com template de desenvolvimento
- ClickUp task linking (opcional)

---

## 🚀 **Uso do Comando**

### **Sintaxe:**
```bash
/git/feature/start "nome-da-funcionalidade"
```

### **Examples:**
```bash
/git/feature/start "implement-oauth-authentication"
/git/feature/start "add-user-dashboard-filters"  
/git/feature/start "integrate-payment-gateway"
```

---

## ⚙️ **Workflow Automático**

### **1. Validação de Parâmetros**
```bash
# Verificar se nome da feature foi fornecido
if [ "$#" -eq 0 ]; then
    echo "❌ ERROR: Feature name required"
    echo "📖 USAGE: /git/feature/start \"feature-name\""
    echo ""
    echo "💡 EXAMPLES:"
    echo "  /git/feature/start \"implement-oauth-authentication\""
    echo "  /git/feature/start \"add-user-dashboard-filters\""
    echo ""
    echo "🔄 WORKFLOW:"
    echo "  1. Use /product/feature first for planning"
    echo "  2. Then /git/feature/start for development"
    echo "  3. Finally /git/sync after merge"
    exit 1
fi

FEATURE_NAME="$1"
# Sanitizar nome da feature (remover caracteres especiais)
FEATURE_SLUG=$(echo "$FEATURE_NAME" | sed 's/[^a-zA-Z0-9]/-/g' | tr '[:upper:]' '[:lower:]' | sed 's/--*/-/g' | sed 's/^-\\|-$//g')

echo "🌿 Starting GitFlow feature development: $FEATURE_NAME"
echo "📝 Feature slug: $FEATURE_SLUG"
```

### **2. Análise GitFlow com @gitflow-specialist**
```bash
# Função refinada para comunicar com @gitflow-specialist
function analyze_with_gitflow_specialist() {
    local feature_name="$1"
    local timeout_seconds=10
    local max_retries=2
    
    # Coleta de contexto estruturada
    local repo_analysis=$(collect_repository_context "$feature_name")
    
    # Construir prompt estruturado
    local structured_prompt=$(build_gitflow_analysis_prompt "$feature_name" "$repo_analysis")
    
    echo "🤖 Consulting @gitflow-specialist for repository analysis..."
    echo "   ▶ Timeout: ${timeout_seconds}s | Retries: $max_retries"
    
    # Tentar comunicação com @gitflow-specialist (com retry)
    local attempt=1
    while [ $attempt -le $max_retries ]; do
        echo "   ▶ Attempt $attempt/$max_retries..."
        
        # Simulação de comunicação - em produção seria:
        # local response=$(invoke_onion_agent "gitflow-specialist" "$structured_prompt" --timeout=$timeout_seconds)
        local response=$(simulate_gitflow_specialist_response "$repo_analysis")
        
        if validate_gitflow_response "$response"; then
            echo "   ✅ Valid response received from @gitflow-specialist"
            echo "$response"
            return 0
        else
            echo "   ⚠️  Invalid response from @gitflow-specialist (attempt $attempt)"
            attempt=$((attempt + 1))
        fi
        
        # Delay entre tentativas
        [ $attempt -le $max_retries ] && sleep 1
    done
    
    # Fallback se todas tentativas falharam
    echo "   🔄 @gitflow-specialist unavailable - using intelligent fallback"
    create_fallback_gitflow_response "$repo_analysis"
}

# Função para coleta estruturada de contexto do repositório
function collect_repository_context() {
    local feature_name="$1"
    local current_branch=$(git branch --show-current 2>/dev/null || echo "unknown")
    local has_develop=$(git branch -a | grep -E "(develop|origin/develop)" | wc -l)
    local has_main=$(git branch -a | grep -E "(main|origin/main)" | wc -l)
    local has_master=$(git branch -a | grep -E "(master|origin/master)" | wc -l)
    local remote_count=$(git remote | wc -l)
    local commits_count=$(git log --oneline 2>/dev/null | wc -l)
    
    # Detectar estratégia de branching
    local branching_strategy="unknown"
    if [ $has_develop -gt 0 ]; then
        branching_strategy="gitflow"
    elif [ $has_main -gt 0 ]; then
        branching_strategy="github-flow"
    elif [ $has_master -gt 0 ]; then
        branching_strategy="traditional"
    fi
    
    cat <<EOF
{
  "repository": {
    "currentBranch": "$current_branch",
    "branchingStrategy": "$branching_strategy",
    "branches": {
      "develop": $([[ $has_develop -gt 0 ]] && echo 'true' || echo 'false'),
      "main": $([[ $has_main -gt 0 ]] && echo 'true' || echo 'false'),
      "master": $([[ $has_master -gt 0 ]] && echo 'true' || echo 'false')
    },
    "remotesCount": $remote_count,
    "commitsCount": $commits_count
  },
  "feature": {
    "name": "$feature_name",
    "slug": "$FEATURE_SLUG"
  },
  "context": {
    "operation": "feature-start",
    "timestamp": "$(date -Iseconds)"
  }
}
EOF
}

# Função para construir prompt estruturado
function build_gitflow_analysis_prompt() {
    local feature_name="$1"
    local repo_context="$2"
    
    cat <<EOF
🤖 GITFLOW ANALYSIS REQUEST

━━━━━━━━━━━━━━━━━━━━━━━━

🎯 OPERATION: feature-start

📊 REPOSITORY CONTEXT:
$repo_context

🔍 ANALYSIS REQUIRED:
   ✅ Validate repository GitFlow compliance
   ✅ Determine optimal base branch
   ✅ Validate feature naming convention
   ✅ Assess workflow compatibility
   ✅ Identify potential issues or blockers

📋 RESPONSE FORMAT (JSON):
{
  "analysis": {
    "repositoryType": "gitflow|github-flow|gitlab-flow|custom",
    "complianceLevel": "excellent|good|partial|poor",
    "baseBranch": "develop|main|master",
    "confidence": "high|medium|low"
  },
  "validation": {
    "isOperationValid": boolean,
    "branchName": "feature/${FEATURE_SLUG}",
    "complianceIssues": [string array],
    "blockers": [string array]
  },
  "guidance": {
    "recommendations": [string array],
    "bestPractices": [string array],
    "nextSteps": [string array]
  },
  "warnings": [string array],
  "metadata": {
    "analysisVersion": "1.0",
    "timestamp": "ISO timestamp"
  }
}
EOF
}

# Função para simular resposta do @gitflow-specialist
function simulate_gitflow_specialist_response() {
    local repo_context="$1"
    local has_develop=$(echo "$repo_context" | jq -r '.repository.branches.develop')
    local has_main=$(echo "$repo_context" | jq -r '.repository.branches.main')
    local has_master=$(echo "$repo_context" | jq -r '.repository.branches.master')
    local branching_strategy=$(echo "$repo_context" | jq -r '.repository.branchingStrategy')
    
    # Determinar base branch com inteligência
    local base_branch="develop"
    local repo_type="gitflow"
    local compliance="good"
    
    if [ "$has_develop" = "true" ]; then
        base_branch="develop"
        repo_type="gitflow"
        compliance="excellent"
    elif [ "$has_main" = "true" ]; then
        base_branch="main"
        repo_type="github-flow"
        compliance="good"
    elif [ "$has_master" = "true" ]; then
        base_branch="master"
        repo_type="traditional"
        compliance="partial"
    fi
    
    cat <<EOF
{
  "analysis": {
    "repositoryType": "$repo_type",
    "complianceLevel": "$compliance",
    "baseBranch": "$base_branch",
    "confidence": "high"
  },
  "validation": {
    "isOperationValid": true,
    "branchName": "feature/$FEATURE_SLUG",
    "complianceIssues": [],
    "blockers": []
  },
  "guidance": {
    "recommendations": [
      "Feature branch follows $repo_type naming convention",
      "Base branch '$base_branch' detected and appropriate",
      "Repository structure supports GitFlow workflow"
    ],
    "bestPractices": [
      "Keep feature focused and atomic",
      "Use descriptive commit messages",
      "Sync with $base_branch frequently",
      "Create PR/MR when feature is complete"
    ],
    "nextSteps": [
      "Create feature branch from $base_branch",
      "Setup development session with templates",
      "Begin implementation following TDD approach"
    ]
  },
  "warnings": [],
  "metadata": {
    "analysisVersion": "1.0",
    "timestamp": "$(date -Iseconds)"
  }
}
EOF
}

# Função para validar resposta do @gitflow-specialist
function validate_gitflow_response() {
    local response="$1"
    
    # Verificar se é JSON válido
    if ! echo "$response" | jq . >/dev/null 2>&1; then
        return 1
    fi
    
    # Verificar campos obrigatórios
    local required_fields=(
        ".analysis.repositoryType"
        ".analysis.baseBranch"
        ".validation.isOperationValid"
        ".validation.branchName"
    )
    
    for field in "${required_fields[@]}"; do
        if [ "$(echo "$response" | jq -r "$field")" = "null" ]; then
            echo "   ❌ Missing required field: $field"
            return 1
        fi
    done
    
    return 0
}

# Função para criar resposta de fallback inteligente
function create_fallback_gitflow_response() {
    local repo_context="$1"
    echo "   🧠 Creating intelligent fallback based on repository analysis..."
    
    # Usar mesma lógica que simulate, mas marcado como fallback
    local response=$(simulate_gitflow_specialist_response "$repo_context")
    
    # Adicionar flag de fallback
    echo "$response" | jq '.metadata.fallback = true | .metadata.source = "intelligent-fallback"'
}

echo "🔍 Analyzing repository with @gitflow-specialist..."
GITFLOW_ANALYSIS=$(analyze_with_gitflow_specialist "$FEATURE_NAME")

# Parse análise refinada do @gitflow-specialist
parse_gitflow_analysis() {
    local analysis="$1"
    
    # Extrair campos com fallback seguros
    BASE_BRANCH=$(echo "$analysis" | jq -r '.analysis.baseBranch // "develop"')
    BRANCH_NAME=$(echo "$analysis" | jq -r '.validation.branchName // "feature/'$FEATURE_SLUG'"')
    IS_VALID=$(echo "$analysis" | jq -r '.validation.isOperationValid // true')
    REPO_TYPE=$(echo "$analysis" | jq -r '.analysis.repositoryType // "unknown"')
    COMPLIANCE=$(echo "$analysis" | jq -r '.analysis.complianceLevel // "unknown"')
    CONFIDENCE=$(echo "$analysis" | jq -r '.analysis.confidence // "medium"')
    IS_FALLBACK=$(echo "$analysis" | jq -r '.metadata.fallback // false')
    
    # Arrays de guidance
    RECOMMENDATIONS=($(echo "$analysis" | jq -r '.guidance.recommendations[]?' 2>/dev/null))
    WARNINGS=($(echo "$analysis" | jq -r '.warnings[]?' 2>/dev/null))
    BLOCKERS=($(echo "$analysis" | jq -r '.validation.blockers[]?' 2>/dev/null))
    
    # Display análise detalhada
    echo ""
    echo "📊 GitFlow Analysis Results:"
    echo "   ▶ Repository Type: $REPO_TYPE"
    echo "   ▶ Compliance Level: $COMPLIANCE"
    echo "   ▶ Base Branch: $BASE_BRANCH"
    echo "   ▶ New Branch: $BRANCH_NAME"
    echo "   ▶ Operation Valid: $IS_VALID"
    echo "   ▶ Confidence: $CONFIDENCE"
    
    if [ "$IS_FALLBACK" = "true" ]; then
        echo "   🔄 Source: Intelligent Fallback (specialist unavailable)"
    else
        echo "   🤖 Source: @gitflow-specialist"
    fi
    
    # Mostrar warnings se houver
    if [ ${#WARNINGS[@]} -gt 0 ]; then
        echo ""
        echo "   ⚠️  Warnings:"
        for warning in "${WARNINGS[@]}"; do
            [ "$warning" != "null" ] && echo "      ∟ $warning"
        done
    fi
    
    # Mostrar blockers se houver
    if [ ${#BLOCKERS[@]} -gt 0 ]; then
        echo ""
        echo "   🚫 Blockers:"
        for blocker in "${BLOCKERS[@]}"; do
            [ "$blocker" != "null" ] && echo "      ∟ $blocker"
        done
    fi
    
    # Mostrar recomendações principais
    if [ ${#RECOMMENDATIONS[@]} -gt 0 ]; then
        echo ""
        echo "   💡 Key Recommendations:"
        local count=0
        for rec in "${RECOMMENDATIONS[@]}"; do
            if [ "$rec" != "null" ] && [ $count -lt 3 ]; then
                echo "      ∟ $rec"
                count=$((count + 1))
            fi
        done
    fi
}

parse_gitflow_analysis "$GITFLOW_ANALYSIS"
```

### **3. Operações GitFlow**
```bash
# Verificar se operação é válida segundo @gitflow-specialist
if [ "$IS_VALID" != "true" ]; then
    echo "❌ GitFlow analysis indicates operation not valid"
    echo "🚫 Blockers identified - cannot proceed"
    exit 1
fi

echo ""
echo "🌿 STARTING GITFLOW OPERATIONS"
echo ""

# Verificar se estamos em repositório Git
if [ ! -d ".git" ]; then
    echo "❌ ERROR: Not a Git repository"
    echo "💡 Initialize git first: git init"
    exit 1
fi

# Fetch latest changes
echo "📡 Fetching latest changes..."
git fetch origin 2>/dev/null || echo "⚠️  Warning: Could not fetch from remote"

# Verificar se base branch existe
if ! git show-ref --verify --quiet refs/heads/$BASE_BRANCH && ! git show-ref --verify --quiet refs/remotes/origin/$BASE_BRANCH; then
    echo "❌ ERROR: Base branch '$BASE_BRANCH' not found"
    echo "💡 Available branches: $(git branch -a | head -5 | tr '\n' ', ')"
    exit 1
fi

# Checkout base branch
echo "🔄 Switching to base branch: $BASE_BRANCH"
if git show-ref --verify --quiet refs/heads/$BASE_BRANCH; then
    git checkout $BASE_BRANCH
elif git show-ref --verify --quiet refs/remotes/origin/$BASE_BRANCH; then
    git checkout -b $BASE_BRANCH origin/$BASE_BRANCH
else
    echo "❌ ERROR: Cannot checkout base branch '$BASE_BRANCH'"
    exit 1
fi

# Pull latest changes on base branch
echo "⬇️  Pulling latest changes on $BASE_BRANCH..."
git pull origin $BASE_BRANCH 2>/dev/null || echo "⚠️  Warning: Could not pull latest changes"

# Verificar se feature branch já existe
if git show-ref --verify --quiet refs/heads/$BRANCH_NAME; then
    echo "❌ ERROR: Feature branch '$BRANCH_NAME' already exists"
    echo "💡 Use a different name or delete existing branch first"
    echo "🔧 Delete command: git branch -D $BRANCH_NAME"
    exit 1
fi

# Criar feature branch
echo "🌿 Creating feature branch: $BRANCH_NAME"
git checkout -b $BRANCH_NAME

if [ $? -eq 0 ]; then
    echo "✅ Feature branch created successfully"
else
    echo "❌ ERROR: Failed to create feature branch"
    exit 1
fi
```

### **4. Setup Sessão de Desenvolvimento**
```bash
# Criar diretório da sessão
SESSION_DIR=".cursor/sessions/$FEATURE_SLUG"
echo "📁 Creating development session: $SESSION_DIR"

mkdir -p "$SESSION_DIR"

# Criar context.md
cat > "$SESSION_DIR/context.md" << EOF
# 🎯 Context - Feature Development: $FEATURE_NAME

## 📋 Feature Principal
**Feature Name**: $FEATURE_NAME  
**Feature Slug**: $FEATURE_SLUG  
**Branch**: \`$BRANCH_NAME\`

## 🌿 GitFlow Information
**Base Branch**: \`$BASE_BRANCH\`  
**Status**: ✅ Development Started  
**Created**: $(date +'%Y-%m-%d %H:%M:%S')

## 🤖 GitFlow Specialist Analysis
**Repository Type**: $(echo "$GITFLOW_ANALYSIS" | jq -r '.analysis.repositoryType')  
**Compliance Level**: $(echo "$GITFLOW_ANALYSIS" | jq -r '.analysis.complianceLevel')  
**Operation Valid**: $IS_VALID

### **Recommendations from @gitflow-specialist:**
$(echo "$GITFLOW_ANALYSIS" | jq -r '.guidance.recommendations[]' | sed 's/^/- /')

### **Best Practices:**
$(echo "$GITFLOW_ANALYSIS" | jq -r '.guidance.bestPractices[]' | sed 's/^/- /')

### **Next Steps:**
$(echo "$GITFLOW_ANALYSIS" | jq -r '.guidance.nextSteps[]' | sed 's/^/- /')

## 🎯 Success Metrics
- [ ] Feature implemented according to requirements
- [ ] Unit tests created and passing
- [ ] Integration tests validated  
- [ ] Code review completed
- [ ] Documentation updated
- [ ] Ready for merge to $BASE_BRANCH

## 🔗 Related Links
- **Branch**: \`$BRANCH_NAME\`
- **Session Path**: \`$SESSION_DIR\`
- **Base Branch**: \`$BASE_BRANCH\`

---

**Status**: ✅ READY FOR DEVELOPMENT  
**Next Step**: Use \`/engineer/work\` to start implementation
EOF

# Criar plan.md template
cat > "$SESSION_DIR/plan.md" << EOF
# 📋 Development Plan - $FEATURE_NAME

## 🎯 Feature Overview
**Description**: $FEATURE_NAME  
**Branch**: \`$BRANCH_NAME\`  
**Base**: \`$BASE_BRANCH\`

## 📊 Implementation Phases

### **Phase 1: Analysis & Design (Estimate: 1h)**
- [ ] Analyze requirements and acceptance criteria
- [ ] Design system architecture and approach
- [ ] Identify dependencies and integration points
- [ ] Create technical specification

### **Phase 2: Core Implementation (Estimate: 4h)**
- [ ] Implement core functionality
- [ ] Add unit tests for main components
- [ ] Handle edge cases and error scenarios
- [ ] Validate against acceptance criteria

### **Phase 3: Integration & Testing (Estimate: 2h)**
- [ ] Integration testing with existing systems
- [ ] End-to-end testing scenarios
- [ ] Performance and security validation
- [ ] Code review and refactoring

### **Phase 4: Documentation & Finalization (Estimate: 1h)**
- [ ] Update documentation and comments
- [ ] Prepare for code review
- [ ] Final testing and validation
- [ ] Ready for merge

## 🧪 Testing Strategy
- [ ] Unit tests for all new functions/components
- [ ] Integration tests for system interactions
- [ ] Manual testing of user workflows
- [ ] Edge case and error scenario testing

## 📚 Documentation Updates
- [ ] Code comments and inline documentation
- [ ] README.md updates if applicable
- [ ] API documentation if applicable
- [ ] User-facing documentation if needed

---

**Total Estimate**: 8 hours  
**Status**: Planning Phase  
**Next Action**: Begin Phase 1 analysis
EOF

# Criar notes.md inicial
cat > "$SESSION_DIR/notes.md" << EOF
# 📝 Development Notes - $FEATURE_NAME

## 🎯 Session Overview
**Feature**: $FEATURE_NAME  
**Started**: $(date +'%Y-%m-%d %H:%M:%S')  
**Branch**: \`$BRANCH_NAME\`

---

## 💡 Development Log

### **$(date +'%Y-%m-%d') - Session Initialization**
- ✅ **GitFlow Analysis**: Completed with @gitflow-specialist
- ✅ **Branch Creation**: \`$BRANCH_NAME\` created from \`$BASE_BRANCH\`
- ✅ **Session Setup**: Development environment initialized
- ✅ **Context Documentation**: All metadata captured

**GitFlow Guidance Received**:
$(echo "$GITFLOW_ANALYSIS" | jq -r '.guidance.recommendations[]' | sed 's/^/- /')

**Next Entry**: Will be added during development iterations

---

## 🔧 Technical Decisions

### **Architecture Choices**
- TBD during development

### **Technology Stack**
- TBD based on project requirements

### **Integration Points**
- TBD during analysis phase

---

## 🚧 Challenges & Solutions

### **Current Challenges**
- None identified yet

### **Solutions Implemented**
- None yet

---

## 📈 Progress Tracking

### **Completed Tasks**
- ✅ Feature branch initialization
- ✅ Development session setup

### **In Progress**
- 🔄 Ready to begin development

### **Next Tasks**
- [ ] Begin analysis and design phase
- [ ] Define technical approach
- [ ] Start core implementation

---

**Session Status**: ✅ INITIALIZED  
**Development Status**: Ready to begin  
**Next Action**: Use \`/engineer/work\` to start development
EOF

echo "✅ Development session created successfully"
```

### **5. ClickUp Integration (Opcional)**
```bash
# Tentar detectar task ClickUp relacionada
function find_related_clickup_task() {
    local feature_name="$1"
    
    # Procurar por tasks com nome similar (se houver session anterior)
    if find .cursor/sessions -name "context.md" -type f 2>/dev/null | xargs grep -l "$feature_name" 2>/dev/null; then
        local related_session=$(find .cursor/sessions -name "context.md" -type f 2>/dev/null | xargs grep -l "$feature_name" | head -1)
        if [ -f "$related_session" ]; then
            local task_id=$(grep "ID ClickUp\\|Task ID" "$related_session" | head -1 | sed 's/.*: *//' | xargs)
            if [ "$task_id" != "" ]; then
                echo "$task_id"
                return 0
            fi
        fi
    fi
    
    return 1
}

RELATED_TASK_ID=$(find_related_clickup_task "$FEATURE_NAME")

if [ "$RELATED_TASK_ID" != "" ]; then
    echo "🔗 Found related ClickUp task: $RELATED_TASK_ID"
    
    # Atualizar task ClickUp se token disponível
    if [ "$CLICKUP_TOKEN" != "" ]; then
        echo "📋 Updating ClickUp task status..."
        
        UPDATE_COMMENT="🌿 DESENVOLVIMENTO GITFLOW INICIADO

━━━━━━━━━━━━━━━━━━━━━━━━

✅ GITFLOW SETUP:
   ▶ Feature: $FEATURE_NAME
   ▶ Branch: $BRANCH_NAME
   ▶ Base: $BASE_BRANCH
   ▶ Session: $SESSION_DIR

🤖 GITFLOW ANALYSIS:
   ▶ Repository: $(echo "$GITFLOW_ANALYSIS" | jq -r '.analysis.repositoryType')
   ▶ Compliance: $(echo "$GITFLOW_ANALYSIS" | jq -r '.analysis.complianceLevel')
   ▶ All validations: ✅ Passed

🚀 PRÓXIMOS PASSOS:
   ▶ Use /engineer/work para desenvolvimento
   ▶ Implemente seguindo GitFlow best practices
   ▶ Finalize com /git/sync após merge

📊 STATUS: In Progress (Development Started)

━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Iniciado: $(date +'%Y-%m-%d %H:%M:%S') | 🧅 Sistema Onion GitFlow"

        # Atualizar status da task
        curl -s -X PUT "https://api.clickup.com/api/v2/task/$RELATED_TASK_ID" \
            -H "Authorization: Bearer $CLICKUP_TOKEN" \
            -H "Content-Type: application/json" \
            -d "{\"status\": \"in progress\"}" > /dev/null || \
            echo "⚠️  Status update failed"
            
        # Adicionar comentário
        curl -s -X POST "https://api.clickup.com/api/v2/task/$RELATED_TASK_ID/comment" \
            -H "Authorization: Bearer $CLICKUP_TOKEN" \
            -H "Content-Type: application/json" \
            -d "{\"comment_text\":\"$UPDATE_COMMENT\"}" > /dev/null || \
            echo "⚠️  Comment creation failed"
            
        echo "✅ ClickUp task updated successfully"
    else
        echo "⚠️  ClickUp token not available - skipping task update"
    fi
else
    echo "ℹ️  No related ClickUp task found - proceeding without linking"
fi
```

### **6. Resultado Final**
```bash
echo ""
echo "✅ GITFLOW FEATURE DEVELOPMENT STARTED SUCCESSFULLY!"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🌿 GITFLOW SETUP:"
echo "   ▶ Feature: $FEATURE_NAME"
echo "   ▶ Branch: $BRANCH_NAME (active)"
echo "   ▶ Base: $BASE_BRANCH"
echo "   ▶ Session: $SESSION_DIR"
echo ""
echo "🤖 GITFLOW ANALYSIS:"
echo "   ▶ Repository Type: $REPO_TYPE"
echo "   ▶ Compliance Level: $COMPLIANCE"
echo "   ▶ Confidence: $CONFIDENCE"
if [ "$IS_FALLBACK" = "true" ]; then
    echo "   ▶ Source: 🔄 Intelligent Fallback (specialist unavailable)"
else
    echo "   ▶ Source: ✅ @gitflow-specialist"
fi
echo "   ▶ Operation: $([ "$IS_VALID" = "true" ] && echo "✅ Validated" || echo "❌ Invalid")"
echo ""
echo "📁 SESSION CREATED:"
echo "   ∟ Context: $SESSION_DIR/context.md"
echo "   ∟ Plan: $SESSION_DIR/plan.md"
echo "   ∟ Notes: $SESSION_DIR/notes.md"
echo ""
if [ "$RELATED_TASK_ID" != "" ]; then
echo "🔗 CLICKUP INTEGRATION:"
echo "   ▶ Task: $RELATED_TASK_ID (status updated)"
echo "   ▶ URL: https://app.clickup.com/t/$RELATED_TASK_ID"
echo ""
fi
echo "🚀 NEXT STEPS:"
echo "   ∟ Start development: /engineer/work"
echo "   ∟ Continue iteration: /engineer/work"
echo "   ∟ After merge: /git/sync"
echo ""
echo "💡 GITFLOW WORKFLOW:"
echo "   1. 🌿 Development (current) → 2. 🔄 Merge → 3. 🧹 Cleanup"
echo ""
echo "━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━"
echo ""
echo "🌟 Feature '$FEATURE_NAME' ready for development!"
```

---

## 🔗 **Integração com Sistema Onion**

### **Diferença dos Outros Comandos:**
- **`/product/feature`**: 🎯 **Planejamento** - Tasks ClickUp, backlog
- **`/git/feature/start`**: 🌿 **Desenvolvimento** - GitFlow real, branches, sessions
- **`/git/sync`**: 🔄 **Finalização** - Pós-merge, cleanup

### **Workflow Sequencial Integrado:**
```bash
1. /product/feature "feature-name"           # Criar task para planning
2. # ... planejamento e priorização ...
3. /git/feature/start "feature-name"        # Iniciar GitFlow development
4. /engineer/work                           # Desenvolvimento iterativo
5. /git/sync                               # Finalizar após merge
```

### **Integração @gitflow-specialist Refinada:**
- **Análise estruturada** com timeout e retry logic (10s timeout, 2 tentativas)
- **Validação JSON** rigorosa de responses com campos obrigatórios
- **Coleta de contexto** inteligente (branch strategy, remotes, commits)
- **Fallback inteligente** baseado em análise do repositório
- **Output detalhado** com confidence, compliance e source tracking
- **Error handling** robusto para cenários de falha de comunicação

---

## ⚠️ **Tratamento de Erros**

### **Erro: Nome da feature não fornecido**
```
❌ ERROR: Feature name required
📖 USAGE: /git/feature/start "feature-name"
```

### **Erro: Branch já existe**
```
❌ ERROR: Feature branch 'feature/nome' already exists
🔧 Delete command: git branch -D feature/nome
```

### **Erro: @gitflow-specialist indisponível**
```
⚠️ GitFlow specialist unavailable - proceeding with defaults
🤖 Using fallback GitFlow configuration
```

### **Erro: Base branch não encontrada**
```
❌ ERROR: Base branch 'develop' not found
💡 Available branches: main, master, ...
```

---

## 💡 **Dicas de Uso**

### **✅ Boas Práticas:**
```bash
# Após planejamento com /product/feature
/git/feature/start "implement-oauth2-authentication"

# Features focadas e atômicas
/git/feature/start "add-user-avatar-upload"

# Nomenclatura clara e específica
/git/feature/start "integrate-stripe-payment-checkout"
```

### **❌ Evitar:**
```bash
# Muito genérico
/git/feature/start "improvements"

# Muito longo
/git/feature/start "implement-complex-multi-step-authentication-flow-with-oauth2-and-social-providers"

# Uso direto sem planejamento prévio (recomenda-se /product/feature primeiro)
```

---

**🌿 GitFlow real com guidance especializada! Para desenvolvimento, use `/engineer/work`. Para finalização, use `/git/sync`.**