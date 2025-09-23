# 🏗️ Arquitetura Técnica: Comandos Gitflow Sistema Onion

## 🎯 **Visão Geral da Arquitetura**

### **Princípios Fundamentais:**
1. **Padrão Product/Engineer**: Comandos concisos, práticos, focados na execução (não 3000+ linhas como git/sync)
2. **Separação Responsabilidades**: Git gerencia git, sessions ficam com `/engineer/start`
3. **ClickUp Integration**: Auto-detecção + updates automáticos + graceful degradation
4. **Master/Main Compatibility**: Auto-detecção integrada, sem utilitário separado
5. **Confirmações Inteligentes**: Apenas para ações irreversíveis (delete branches, merge main/master, revert)

---

## 📁 **Estrutura de Arquivos**

```
.cursor/commands/git/
├── README.md                 # ✅ Existente - Índice atualizado
├── sync.md                   # ✅ Existente - Manter inalterado  
├── help.md                   # 🆕 Cartão referência Gitflow
├── init.md                   # 🆕 Setup repositório
├── feature/
│   ├── start.md             # 🆕 Task ClickUp backlog (sem branch)
│   └── finish.md            # 🆕 Merge feature→develop + cleanup
├── release/
│   ├── start.md             # 🆕 Workflow release + versionamento
│   └── finish.md            # 🆕 Tags + duplo merge
└── hotfix/
    ├── start.md             # 🆕 Hotfix emergencial
    └── finish.md            # 🆕 Duplo merge (main + develop)

.cursor/commands/engineer/
└── hotfix.md                 # 🆕 Herda /product/task + git hotfix

.cursor/agents/development/
└── gitflow-specialist.md     # 🔄 Ajustes: referências + delegação
```

---

## 🔧 **Componentes Técnicos**

### **1. Função Utilitária Master/Main Detection**

**Implementação Padrão (todos os comandos):**
```bash
# Baseado no @gitflow-specialist.md linha 359-362
function detect_primary_branch() {
    remote_branches=$(git branch -r | grep -E "(origin/main|origin/master)")
    
    if echo "$remote_branches" | grep "origin/main" > /dev/null; then
        echo "main"
    elif echo "$remote_branches" | grep "origin/master" > /dev/null; then
        echo "master"
    else
        # Fallback: verificar local
        if git branch | grep "main" > /dev/null; then
            echo "main"
        else
            echo "master"  # Default clássico
        fi
    fi
}
```

**Uso nos Comandos:**
```bash
PRIMARY_BRANCH=$(detect_primary_branch)
echo "🔍 Detected primary branch: $PRIMARY_BRANCH"
```

### **2. ClickUp Integration Pattern**

**Auto-detecção Task ID:**
```bash
# Pattern baseado em git/sync.md
function get_session_task_id() {
    if [ -f ".cursor/sessions/*/context.md" ]; then
        grep "ID ClickUp" .cursor/sessions/*/context.md | head -1 | cut -d: -f2 | xargs
    else
        echo ""
    fi
}
```

**Auto-update Pattern:**
```bash
TASK_ID=$(get_session_task_id)
if [ "$TASK_ID" != "" ]; then
    # Create comment with progress
    clickup_comment_formatted "[OPERATION] completed successfully"
    # Update tags if needed
    update_task_status_if_appropriate
fi
```

### **3. Confirmação Inteligente System**

**Confirmation Pattern:**
```bash
function confirm_irreversible_action() {
    local action_description="$1"
    echo "⚠️  IRREVERSIBLE ACTION: $action_description"
    echo "This action cannot be easily undone. Continue? (y/N)"
    read -r confirm
    [[ "$confirm" =~ ^[Yy]$ ]]
}

# Uso:
if confirm_irreversible_action "Delete local branch feature/my-feature"; then
    git branch -d feature/my-feature
fi
```

**Ações que Requerem Confirmação:**
- Delete de branches locais
- Merge para main/master  
- Revert de commits
- Force push operations

### **4. Error Handling Simplificado**

**Pattern Product/Engineer (não como git/sync):**
```bash
function handle_git_error() {
    local error_msg="$1"
    echo "❌ Git operation failed: $error_msg"
    echo "💡 Suggested fix: [specific guidance based on error]"
    echo "🔧 Run this command to fix: [recovery command]"
    exit 1
}

# Graceful degradation para ClickUp
function safe_clickup_update() {
    if ! update_clickup_task "$1" "$2"; then
        echo "⚠️  ClickUp update failed - continuing with git operations"
        echo "Manual update may be needed later"
    fi
}
```

---

## 🚀 **Implementação dos 9 Comandos**

### **Git Core Commands (8)**

#### **1. git/help.md - Cartão de Referência**
```yaml
# Template estrutura:
- Lista todos comandos gitflow disponíveis
- Quick reference com examples
- Troubleshooting comum
- Links para @gitflow-specialist para guidance detalhada
```

**Funcionalidades:**
- Display de comandos disponíveis
- Examples de uso comum
- Troubleshooting quick fixes
- Delegação para @gitflow-specialist

#### **2. git/init.md - Setup Repositório**
```yaml
# Workflow:
1. detect_primary_branch() 
2. Verificar se gitflow já está inicializado
3. Configurar git flow init com branch correta
4. Criar develop se não existir
5. Update ClickUp se sessão ativa
```

**Validações:**
- Repositório git válido
- Remote origin configurado
- Permissões adequadas

#### **3. git/feature/start.md - Task Backlog ClickUp**
```yaml
# Entrada: Nome/descrição da feature
# Saída: Task ClickUp criada com tag "backlog"
# NÃO cria: branch, sessão

# Workflow:
1. Parse feature name/description do usuário
2. Detectar lista ClickUp atual
3. Criar task estruturada (similar /product/task)
4. Aplicar tag "backlog" 
5. Status inicial da task = backlog
```

**Template Task:**
- Nome: 🌿 [Feature Name]
- Tags: ["backlog", "feature"]  
- Status: "To Do" / "Backlog"
- Lista: Mesma da sessão atual

#### **4. git/feature/finish.md - Merge Feature**
```yaml
# Workflow:
1. Detectar branch feature atual
2. Verificar estado limpo (uncommitted changes)
3. Checkout develop + pull
4. Merge feature → develop
5. Confirmar delete branch local
6. Update ClickUp task se detectada
```

**Confirmações:**
- Delete da branch feature local (irreversível)

#### **5. git/release/start.md - Release Workflow**
```yaml
# Entrada: Version number (semver)
# Workflow:
1. Verificar develop está limpo
2. Criar release/[version] branch
3. Version bump automático (package.json, etc)
4. Create ClickUp release task  
5. Prep changelog skeleton
```

#### **6. git/release/finish.md - Release Tags**
```yaml
# Workflow:
1. Verificar release branch atual
2. Merge release → PRIMARY_BRANCH
3. Tag creation (v[version])
4. Merge release → develop  
5. Confirmar delete release branch
6. Update ClickUp tasks
```

**Confirmações:**
- Merge para main/master (production)
- Delete release branch

#### **7. git/hotfix/start.md - Hotfix Emergencial**
```yaml
# Entrada: Hotfix name/description
# Workflow:
1. PRIMARY_BRANCH=$(detect_primary_branch)
2. Checkout $PRIMARY_BRANCH + pull
3. Criar hotfix/[name] branch
4. Update ClickUp task com urgência
```

#### **8. git/hotfix/finish.md - Duplo Merge**
```yaml
# Workflow crítico:
1. PRIMARY_BRANCH=$(detect_primary_branch)
2. Merge hotfix → $PRIMARY_BRANCH (CONFIRM)
3. Tag hotfix version
4. Merge hotfix → develop (CONFIRM)
5. Confirmar delete hotfix branch
6. Update ClickUp tasks
```

**Confirmações Críticas:**
- Merge para main/master (production)
- Merge para develop (integration)
- Delete hotfix branch

### **Engineer Extension (1)**

#### **9. engineer/hotfix.md - Hybrid Command**
```yaml
# Herda lógica /product/task + git hotfix workflow

# Entrada: 
- Hotfix description (required)
- Related ClickUp task IDs (optional)
- Custom tags (optional) 
- Custom status (optional)

# Workflow:
1. **FASE PRODUCT/TASK**: 
   - Executar lógica de /product/task literalmente
   - Incluir tasks relacionadas passadas como parâmetro
   - Aplicar tags customizadas + "hotfix"
   - Status inicial customizado

2. **FASE GIT HOTFIX**:
   - Executar git/hotfix/start.md
   - Session já criada pela fase 1
   - Branch criada automaticamente

3. **INTEGRATION**:
   - Link task criada com tasks relacionadas
   - Update todas tasks com referência hotfix
   - Tracking completo no ClickUp
```

**Exemplo de Uso:**
```bash
/engineer/hotfix "Fix critical payment bug" --related-tasks="86abc123,86abc124" --tags="critical,payment" --status="In Progress"
```

---

## 🔄 **Ajustes no @gitflow-specialist.md**

### **Seções a Adicionar:**

#### **1. Referência aos Comandos**
```markdown
## 🛠️ Comandos de Execução Disponíveis

O Sistema Onion fornece comandos práticos para executar workflows GitFlow:

### Git Core Commands:
- `/git/help` - Referência rápida e troubleshooting
- `/git/init` - Setup inicial repositório GitFlow
- `/git/feature/start [name]` - Criar task backlog para feature
- `/git/feature/finish` - Merge feature para develop
- `/git/release/start [version]` - Iniciar processo release
- `/git/release/finish` - Finalizar release com tags
- `/git/hotfix/start [name]` - Hotfix emergencial
- `/git/hotfix/finish` - Duplo merge hotfix

### Engineer Extension:
- `/engineer/hotfix "description" --related-tasks="id1,id2"` - Hotfix completo com task creation

### Quando Usar:
- **Comandos**: Para EXECUTAR workflows GitFlow
- **@gitflow-specialist**: Para ORIENTAÇÃO e troubleshooting
```

#### **2. Delegação Automática**
```markdown
## 🎯 Delegação Automática

Quando invocar comandos vs guidance:

### Use Comandos Quando:
- Executar workflow padrão sem dúvidas
- Automatizar processos repetitivos  
- Integração com ClickUp necessária
- Desenvolvimento em sessão ativa

### Use @gitflow-specialist Quando:
- Aprender workflows GitFlow
- Troubleshoot problemas específicos
- Onboarding de novos desenvolvedores
- Situações não-padrão ou complexas
- Migration master → main
```

---

## 📊 **Padrões de Integração ClickUp**

### **Auto-Detection Pattern:**
```bash
# 1. Session-based detection (prioritário)
TASK_ID=$(grep "ID ClickUp" .cursor/sessions/*/context.md 2>/dev/null | head -1 | cut -d: -f2 | xargs)

# 2. Fallback: branch-based detection
if [ -z "$TASK_ID" ]; then
    BRANCH_NAME=$(git branch --show-current)
    # Logic para extrair task ID do branch name se seguir padrão
fi
```

### **Update Patterns por Comando:**

**git/feature/start:**
- Criar task ClickUp com tag "backlog"
- Status inicial = "To Do" 

**git/feature/finish:**
- Update task para "Done" se detectada
- Comment: "Feature merged to develop"

**git/release/start:**
- Criar release task
- Link com features incluídas na release

**git/release/finish:**
- Update release task para "Done"  
- Comment: "Release v[X] deployed to production"

**git/hotfix/start:**
- Update task tags + "urgent"
- Comment: "Hotfix started for critical issue"

**git/hotfix/finish:**
- Update task para "Done"
- Comment: "Hotfix deployed to production and develop"

**engineer/hotfix:**
- Criar task principal + link relacionadas
- Updates em todas tasks relacionadas
- Tracking completo do processo

---

## 🧪 **Testing & Validation Strategy**

### **Testes de Integração:**
1. **Compatibility**: Executar comandos em conjunto com `/engineer/*`
2. **ClickUp Integration**: Validar auto-updates funcionam
3. **Error Scenarios**: Testar graceful degradation
4. **Master/Main**: Validar em repos com ambas convenções

### **Success Criteria:**
- ✅ 9 comandos executam sem erro
- ✅ ClickUp auto-updates funcionam
- ✅ Confirmações aparecem em ações críticas
- ✅ Error handling claro e acionável
- ✅ Compatibilidade com workflows existentes

---

## 🎯 **Arquitetura Finalizada**

Esta arquitetura atende todos os requisitos refinados:
- **9 comandos** seguindo padrão product/engineer
- **ClickUp integration** completa e automática
- **Master/main compatibility** integrada
- **Session separation** bem definida  
- **Error handling** simplificado mas robusto
- **Confirmações** apenas para ações irreversíveis

**Pronto para implementação seguindo o plano de 5 fases.**
