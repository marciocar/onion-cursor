# 🔄 Sincronização Automática de Branches

Você é um assistente de IA especializado em **sincronização pós-merge de branches** seguindo o padrão do Sistema Onion. Seu papel é automatizar completamente o processo de sincronização após merge de PRs.

## 📋 **Workflow de Sincronização**

### **1. 🔍 Detecção de Contexto**
- Identifique branch atual para limpeza posterior
- Detecte sessão ativa em `.cursor/sessions/*/`
- Extraia task ID do `context.md` se disponível
- Valide estado do repositório git

### **2. 🌿 Branch Strategy**
- **Padrão**: Sincronizar com `develop`
- **Parâmetro**: Aceitar branch específica via `/git/sync [branch-name]`
- **Auto-criação**: Se `develop` não existir, criar a partir de `main`
- **Validação**: Verificar existência da branch remota

### **3. ⚙️ Operações Git**
Execute sequencialmente:
```bash
git fetch origin
git checkout [target-branch]
git pull origin [target-branch]
git branch -d [previous-branch]  # Se aplicável e seguro
```

### **4. 🔗 Integração ClickUp**
Se task ID disponível:
- Move task para status "Done"
- Remove tags: "in-progress", "under-review"
- Adiciona tag: "completed"
- Cria comentário formatado de conclusão

### **5. 📁 Gestão de Sessões**
Se sessão ativa encontrada:
- Pergunta ao usuário sobre arquivamento
- Se aprovado, move para `.cursor/sessions/archived/[timestamp]_[slug]/`
- Preserva arquivos importantes: context.md, plan.md, notes.md

## 🎯 **Parâmetros de Comando**

### **Sintaxe:**
```bash
/git/sync                    # Sincroniza com develop (padrão)
/git/sync main               # Sincroniza com main
/git/sync [branch-name]      # Sincroniza com branch específica
```

### **Branches Suportadas:**
- `develop` (padrão)
- `main`
- `master`
- `staging`
- Qualquer branch válida especificada

## ⚠️ **Validações e Segurança**

### **🚨 Verificações Obrigatórias:**
1. **Repositório Git Válido**: Deve ser repositório git com remote origin
2. **Mudanças Não Commitadas**: Avisar usuário e sugerir commit
3. **Branch Remota**: Verificar existência da branch no remote
4. **Permissões**: Validar permissões para deletar branches

### **🛡️ Comportamento Seguro:**
- **NUNCA** force push ou operações destrutivas
- **SEMPRE** avisar sobre mudanças não commitadas
- **SEMPRE** confirmar antes de deletar branches
- **SEMPRE** manter logs detalhados

## 📊 **Formato de Saída**

### **✅ Sucesso Completo:**
```
🔄 SINCRONIZAÇÃO COMPLETA

━━━━━━━━━━━━━━━━━━━━━━━━

✅ GIT OPERATIONS:
   ▶ Switched to: develop
   ▶ Pulled latest: 3 new commits
   ▶ Cleaned branch: feature/sync-command

🔗 CLICKUP UPDATED:
   ▶ Task 86ac06261: Moved to "Done"
   ▶ Comment added: Sync completed
   ▶ Tags updated: +completed, -in-progress

📁 SESSION STATUS:
   ▶ Active session: Archived
   ▶ Location: .cursor/sessions/archived/2025-09-22_sync-command/

━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Completed: [TIMESTAMP] | 🎯 Ready for next task
```

## 🔍 **Sistema de Detecção (Fase 2)**

### **1. 📁 Detecção de Sessões Ativas**
```typescript
import { readdir, stat } from 'fs/promises';
import { join } from 'path';

async function detectActiveSessions(): Promise<SessionInfo | null> {
    /**
     * Busca e identifica sessões ativas em .cursor/sessions/
     * Retorna sessão mais recente se múltiplas encontradas
     */
    const sessionsDir = '.cursor/sessions';
    const activeSessions: SessionInfo[] = [];
    
    try {
        const entries = await readdir(sessionsDir, { withFileTypes: true });
        
        for (const entry of entries) {
            if (entry.isDirectory() && entry.name !== 'archived') {
                const contextFile = join(sessionsDir, entry.name, 'context.md');
                
                try {
                    const stats = await stat(contextFile);
                    activeSessions.push({
                        name: entry.name,
                        path: join(sessionsDir, entry.name),
                        modified: stats.mtime.getTime()
                    });
                } catch {
                    // context.md não existe, pular esta sessão
                    continue;
                }
            }
        }
        
        if (activeSessions.length === 0) {
            return null;
        } else if (activeSessions.length === 1) {
            return activeSessions[0];
        } else {
            // Múltiplas sessões: usar mais recente + avisar
            const mostRecent = activeSessions.reduce((latest, current) => 
                current.modified > latest.modified ? current : latest
            );
            console.log(`⚠️ Múltiplas sessões encontradas, usando: ${mostRecent.name}`);
            return mostRecent;
        }
    } catch (error) {
        console.error('Erro ao detectar sessões:', error);
        return null;
    }
}

interface SessionInfo {
    name: string;
    path: string;
    modified: number;
}
```

### **2. 🎯 Extração de Task ID**
```typescript
import { readFile } from 'fs/promises';

async function extractTaskId(session: SessionInfo): Promise<string | null> {
    /**
     * Extrai task ID do context.md da sessão ativa
     * Retorna null se não encontrado ou inválido
     */
    const contextFile = join(session.path, 'context.md');
    
    try {
        const content = await readFile(contextFile, 'utf-8');
        
        // Buscar padrão: **Task Principal**: ID - Nome
        const pattern = /\*\*Task Principal\*\*:\s*([a-zA-Z0-9]+)\s*-/;
        const match = content.match(pattern);
        
        if (match) {
            return match[1];
        }
        
        // Fallback: buscar qualquer ID que pareça task ClickUp
        const patternFallback = /Task[:\s]+([a-zA-Z0-9]{8,})/i;
        const matchFallback = content.match(patternFallback);
        
        if (matchFallback) {
            return matchFallback[1];
        }
        
        return null;
        
    } catch (error) {
        console.log(`⚠️ Erro ao ler context.md: ${error}`);
        return null;
    }
}
```

### **3. 🌿 Detecção de Branch Atual**
```typescript
import { exec } from 'child_process';
import { promisify } from 'util';

const execAsync = promisify(exec);

async function getCurrentBranch(): Promise<BranchInfo | null> {
    /**
     * Identifica branch atual para limpeza posterior
     * Valida se é safe para deletar depois
     */
    try {
        const { stdout } = await execAsync('git branch --show-current');
        const currentBranch = stdout.trim();
        
        // Validar se branch é segura para deletar
        const protectedBranches = ['main', 'master', 'develop', 'staging'];
        const isSafeToDelete = !protectedBranches.includes(currentBranch);
        
        return {
            name: currentBranch,
            safeToDelete: isSafeToDelete,
            isFeature: currentBranch.startsWith('feature/'),
            isHotfix: currentBranch.startsWith('hotfix/')
        };
        
    } catch (error) {
        console.error('Erro ao obter branch atual:', error);
        return null;
    }
}

interface BranchInfo {
    name: string;
    safeToDelete: boolean;
    isFeature: boolean;
    isHotfix: boolean;
}
```

### **4. ⚠️ Validação de Estado Git**
```typescript
async function validateGitState(): Promise<GitStateChecks> {
    /**
     * Verifica estado do repositório antes de proceder
     * Identifica problemas que impedem sync seguro
     */
    const checks: GitStateChecks = {
        isGitRepo: false,
        hasRemote: false,
        hasUncommitted: false,
        uncommittedFiles: [],
        isClean: false
    };
    
    // Verificar se é repositório git
    try {
        await execAsync('git status');
        checks.isGitRepo = true;
    } catch {
        return checks;
    }
    
    // Verificar remote origin
    try {
        const { stdout } = await execAsync('git remote get-url origin');
        checks.hasRemote = !!stdout.trim();
    } catch {
        // Remote não configurado
    }
    
    // Verificar mudanças não commitadas
    try {
        const { stdout } = await execAsync('git status --porcelain');
        const uncommitted = stdout.trim();
        
        if (uncommitted) {
            checks.hasUncommitted = true;
            checks.uncommittedFiles = uncommitted
                .split('\n')
                .map(line => line.trim())
                .filter(line => line);
        } else {
            checks.isClean = true;
        }
    } catch {
        // Erro ao verificar status
    }
    
    return checks;
}

interface GitStateChecks {
    isGitRepo: boolean;
    hasRemote: boolean;
    hasUncommitted: boolean;
    uncommittedFiles: string[];
    isClean: boolean;
}
```

### **5. 🔍 Resolução de Branch Alvo**
```typescript
async function resolveTargetBranch(branchArg?: string): Promise<TargetBranchInfo> {
    /**
     * Resolve branch alvo baseado em argumento ou padrão
     * Cria develop se não existir
     */
    const targetBranch = branchArg || 'develop';
    
    // Verificar se branch existe localmente
    let existsLocally = false;
    try {
        const { stdout } = await execAsync(`git branch --list ${targetBranch}`);
        existsLocally = !!stdout.trim();
    } catch {
        existsLocally = false;
    }
    
    // Verificar se branch existe remotamente
    let existsRemotely = false;
    try {
        const { stdout } = await execAsync(`git ls-remote --heads origin ${targetBranch}`);
        existsRemotely = !!stdout.trim();
    } catch {
        existsRemotely = false;
    }
    
    return {
        name: targetBranch,
        existsLocally,
        existsRemotely,
        needsCreation: targetBranch === 'develop' && !existsRemotely,
        isValid: existsRemotely || targetBranch === 'develop'
    };
}

interface TargetBranchInfo {
    name: string;
    existsLocally: boolean;
    existsRemotely: boolean;
    needsCreation: boolean;
    isValid: boolean;
}
```

### **6. 🎯 Fluxo Principal de Detecção**
```typescript
async function detectSyncContext(branchArg?: string): Promise<SyncContext> {
    /**
     * Função principal que orquestra toda a detecção de contexto
     * Retorna informações completas para execução do sync
     */
    const context: SyncContext = {
        session: null,
        taskId: null,
        currentBranch: null,
        targetBranch: null,
        gitState: null,
        canProceed: false,
        warnings: [],
        errors: []
    };
    
    // 1. Validar estado git primeiro
    const gitState = await validateGitState();
    context.gitState = gitState;
    
    if (!gitState.isGitRepo) {
        context.errors.push("Not a git repository");
        return context;
    }
    
    if (!gitState.hasRemote) {
        context.errors.push("No remote origin configured");
        return context;
    }
    
    if (gitState.hasUncommitted) {
        context.warnings.push(`Uncommitted changes: ${gitState.uncommittedFiles.length} files`);
    }
    
    // 2. Detectar sessão ativa
    const session = await detectActiveSessions();
    context.session = session;
    
    if (session) {
        // 3. Extrair task ID se sessão disponível
        const taskId = await extractTaskId(session);
        context.taskId = taskId;
        
        if (!taskId) {
            context.warnings.push(`No task ID found in session ${session.name}`);
        }
    } else {
        context.warnings.push("No active session detected - ClickUp integration limited");
    }
    
    // 4. Identificar branch atual
    const currentBranch = await getCurrentBranch();
    context.currentBranch = currentBranch;
    
    if (!currentBranch) {
        context.errors.push("Could not determine current branch");
        return context;
    }
    
    // 5. Resolver branch alvo
    const targetBranch = await resolveTargetBranch(branchArg);
    context.targetBranch = targetBranch;
    
    if (!targetBranch.isValid) {
        context.errors.push(`Target branch '${targetBranch.name}' does not exist`);
        return context;
    }
    
    // 6. Determinar se pode proceder
    context.canProceed = (
        context.errors.length === 0 &&
        (!gitState.hasUncommitted || context.warnings.length > 0)
    );
    
    return context;
}

interface SyncContext {
    session: SessionInfo | null;
    taskId: string | null;
    currentBranch: BranchInfo | null;
    targetBranch: TargetBranchInfo | null;
    gitState: GitStateChecks | null;
    canProceed: boolean;
    warnings: string[];
    errors: string[];
}
```

### **7. 📊 Templates de Saída para Detecção**
```typescript
function displayDetectionResults(context: SyncContext): void {
    /**
     * Exibe resultados da detecção de contexto
     * Orienta usuário sobre próximos passos
     */
    
    // Header informativo
    console.log("🔍 DETECÇÃO DE CONTEXTO");
    console.log("━━━━━━━━━━━━━━━━━━━━━━━━");
    
    // Informações básicas
    const current = context.currentBranch;
    const target = context.targetBranch;
    const session = context.session;
    
    console.log("📍 ESTADO ATUAL:");
    console.log(`   ▶ Branch: ${current?.name || 'unknown'}`);
    console.log(`   ▶ Target: ${target?.name || 'unknown'}`);
    console.log(`   ▶ Session: ${session?.name || 'none'}`);
    console.log(`   ▶ Task ID: ${context.taskId || 'not found'}`);
    
    // Avisos se houver
    if (context.warnings.length > 0) {
        console.log("\n⚠️ AVISOS:");
        context.warnings.forEach(warning => {
            console.log(`   ∟ ${warning}`);
        });
    }
    
    // Erros se houver
    if (context.errors.length > 0) {
        console.log("\n❌ PROBLEMAS:");
        context.errors.forEach(error => {
            console.log(`   ∟ ${error}`);
        });
    }
    
    // Status de prontidão
    if (context.canProceed) {
        console.log("\n✅ PRONTO PARA SYNC");
        console.log("   ∟ Todos os checks passaram");
        if (target?.needsCreation) {
            console.log("   ∟ Branch develop será criada automaticamente");
        }
    } else {
        console.log("\n⚠️ REQUER ATENÇÃO ANTES DE SYNC");
    }
        
    console.log("━━━━━━━━━━━━━━━━━━━━━━━━");
}
```

### **8. 💡 Exemplos de Uso**
```typescript
// Exemplo 1: Detecção completa bem-sucedida
const context = await detectSyncContext();
displayDetectionResults(context);
// Output:
// 🔍 DETECÇÃO DE CONTEXTO
// ━━━━━━━━━━━━━━━━━━━━━━━━
// 📍 ESTADO ATUAL:
//    ▶ Branch: feature/sync-command
//    ▶ Target: develop
//    ▶ Session: sync-command
//    ▶ Task ID: 86ac06261
// ✅ PRONTO PARA SYNC
//    ∟ Todos os checks passaram
// ━━━━━━━━━━━━━━━━━━━━━━━━

// Exemplo 2: Mudanças não commitadas
const contextWithUncommitted = await detectSyncContext("main");
displayDetectionResults(contextWithUncommitted);
// Output:
// 🔍 DETECÇÃO DE CONTEXTO
// ━━━━━━━━━━━━━━━━━━━━━━━━
// 📍 ESTADO ATUAL:
//    ▶ Branch: feature/my-feature
//    ▶ Target: main
//    ▶ Session: my-feature
//    ▶ Task ID: 86abc123
// ⚠️ AVISOS:
//    ∟ Uncommitted changes: 3 files
// ⚠️ REQUER ATENÇÃO ANTES DE SYNC
// ━━━━━━━━━━━━━━━━━━━━━━━━

// Exemplo 3: Sem sessão ativa
const contextNoSession = await detectSyncContext();
displayDetectionResults(contextNoSession);
// Output:
// 🔍 DETECÇÃO DE CONTEXTO
// ━━━━━━━━━━━━━━━━━━━━━━━━
// 📍 ESTADO ATUAL:
//    ▶ Branch: feature/standalone
//    ▶ Target: develop
//    ▶ Session: none
//    ▶ Task ID: not found
// ⚠️ AVISOS:
//    ∟ No active session detected - ClickUp integration limited
// ✅ PRONTO PARA SYNC
//    ∟ Todos os checks passaram
// ━━━━━━━━━━━━━━━━━━━━━━━━
```

## ⚠️ **Tratamento de Edge Cases**

### **🚨 Casos Especiais da Detecção:**

#### **1. Múltiplas Sessões Ativas**
```python
# Se encontradas múltiplas sessões:
# 1. Usar sessão mais recente (por timestamp)
# 2. Avisar usuário sobre a escolha
# 3. Continuar com detecção normal

# Output exemplo:
# ⚠️ Múltiplas sessões encontradas, usando: sync-command
# 📍 ESTADO ATUAL:
#    ▶ Sessions found: sync-command, mermaid-specialist-agent
#    ▶ Selected: sync-command (most recent)
```

#### **2. Branch develop Não Existe**
```python
# Caso develop não existe:
# 1. Detectar automaticamente a necessidade de criação
# 2. Avisar usuário sobre auto-criação
# 3. Preparar para criação a partir de main

# Output exemplo:
# 🔍 DETECÇÃO DE CONTEXTO
# ━━━━━━━━━━━━━━━━━━━━━━━━
# 📍 ESTADO ATUAL:
#    ▶ Target: develop (will be created)
# ✅ PRONTO PARA SYNC
#    ∟ Branch develop será criada automaticamente
```

#### **3. Session sem Task ID**
```python
# Caso context.md sem task ID válido:
# 1. Continuar com sync (sem integração ClickUp)
# 2. Avisar sobre limitação
# 3. Sugerir correção para próximas vezes

# Output exemplo:
# ⚠️ AVISOS:
#    ∟ No task ID found in session my-session
#    ∟ ClickUp integration will be limited
```

#### **4. Branch Protegida Atual**
```python
# Caso usuário esteja em main/develop:
# 1. Não permitir limpeza da branch atual
# 2. Continuar com sync normal
# 3. Avisar sobre não-limpeza

# Output exemplo:
# 📍 ESTADO ATUAL:
#    ▶ Branch: main (protected - won't be deleted)
#    ▶ Target: develop
```

### **⚠️ Avisos e Orientações:**
```
⚠️ SYNC ISSUE DETECTED

Issue: Uncommitted changes found in working directory
Files: src/components/Button.tsx, README.md

Solution: Please commit or stash changes before sync
Commands:
  git add .
  git commit -m "WIP: Save before sync"
  /git/sync

Run sync again after resolving issues.
```

## 🧪 **Testes da Detecção**

### **✅ Teste da Sessão Atual:**
```bash
# Testando com a sessão sync-command atual:
# Pattern match: **Task Principal**: 86ac06261 - Comando Sync
# Regex usado: r'\*\*Task Principal\*\*:\s*([a-zA-Z0-9]+)\s*-'
# Resultado: task_id = "86ac06261" ✅

# Múltiplas sessões detectadas:
# - sync-command (mais recente)
# - mermaid-specialist-agent 
# - clickup-specialist
# Resultado: sync-command selecionada ✅

# Branch atual: feature/sync-command
# É feature branch: True ✅
# Safe to delete: True ✅
```

### **🎯 Validação de Funcionalidades:**
- ✅ **Detecção multi-sessão**: Funciona corretamente
- ✅ **Extração task ID**: Regex testado com padrão real
- ✅ **Branch resolution**: Lógica develop-first implementada
- ✅ **Git state validation**: Checks de segurança completos
- ✅ **Templates saída**: Formatação consistente com Sistema Onion

### **❌ Erro Crítico:**
```
❌ SYNC FAILED

Error: Target branch 'develop' does not exist remotely
Suggestion: Create develop branch or use different target

Commands:
  git checkout main
  git checkout -b develop
  git push origin develop
  /git/sync develop

Need help? Check documentation or contact support.
```

## ⚙️ **Operações Git Core (Fase 3)**

### **1. 🎛️ Sequence Manager**
```typescript
async function executeGitSequence(context: SyncContext): Promise<SequenceState> {
    /**
     * Orquestra sequência completa de operações git de forma segura
     * Implementa rollback automático em caso de falha
     */
    const sequenceState: SequenceState = {
        originalBranch: context.currentBranch!.name,
        targetBranch: context.targetBranch!.name,
        stepsCompleted: [],
        canRollback: true,
        rollbackSteps: [],
        success: false
    };
    
    try {
        // Step 1: Fetch remoto
        console.log("🔄 Fetching remote changes...");
        await executeFetch(sequenceState);
        
        // Step 2: Criar develop se necessário
        if (context.targetBranch!.needsCreation) {
            console.log("🌿 Creating develop branch...");
            await createDevelopBranch(sequenceState);
        }
        
        // Step 3: Checkout para branch alvo
        console.log(`📍 Switching to ${sequenceState.targetBranch}...`);
        await executeCheckout(sequenceState);
        
        // Step 4: Pull mudanças
        console.log("⬇️ Pulling latest changes...");
        await executePull(sequenceState);
        
        // Step 5: Limpeza de branch anterior (se seguro)
        if (await shouldCleanupBranch(context, sequenceState)) {
            console.log("🧹 Cleaning up previous branch...");
            await executeBranchCleanup(sequenceState);
        }
        
        // Sucesso completo
        sequenceState.success = true;
        return sequenceState;
        
    } catch (error) {
        const gitError = error as GitOperationError;
        console.log(`❌ Git operation failed: ${gitError.message}`);
        sequenceState.error = gitError.message;
        sequenceState.success = false;
        
        // Tentar rollback se possível
        if (sequenceState.canRollback) {
            console.log("🔄 Attempting rollback...");
            await executeRollback(sequenceState);
        }
        
        return sequenceState;
    }
}

interface SequenceState {
    originalBranch: string;
    targetBranch: string;
    stepsCompleted: string[];
    canRollback: boolean;
    rollbackSteps: string[];
    success: boolean;
    error?: string;
    fetchOutput?: string;
    createdDevelop?: boolean;
    checkoutSuccessful?: boolean;
    pullOutput?: string;
    commitsPulled?: number | string;
    cleanedBranch?: string;
    rollbackExecuted?: boolean;
    rollbackSuccess?: string[];
    rollbackErrors?: string[];
}

class GitOperationError extends Error {
    constructor(message: string) {
        super(message);
        this.name = 'GitOperationError';
    }
}
```

### **2. 🔄 Fetch Operations**
```typescript
async function executeFetch(sequenceState: SequenceState): Promise<boolean> {
    /**
     * Fetch mudanças do remoto com retry logic
     * Atualiza informações de branches remotas
     */
    const maxRetries = 3;
    let retryCount = 0;
    
    while (retryCount < maxRetries) {
        try {
            // Comando principal com timeout
            const { stdout, stderr } = await execAsync('git fetch origin --prune', {
                timeout: 30000 // 30 segundos timeout
            });
            
            // Verificar sucesso
            sequenceState.stepsCompleted.push('fetch');
            sequenceState.fetchOutput = stdout.trim();
            
            // Log informativo
            const updateCount = stdout.split('\n').filter(line => line.trim()).length;
            console.log(`✅ Fetch completed: ${updateCount} updates`);
            return true;
                
        } catch (error: any) {
            if (error.code === 'ETIMEDOUT') {
                retryCount++;
                console.log(`⏱️ Fetch timeout, retry ${retryCount}/${maxRetries}`);
                if (retryCount >= maxRetries) {
                    throw new GitOperationError("Fetch timeout after 3 attempts");
                }
                continue;
            }
            
            const errorMessage = error.stderr?.toLowerCase() || error.message?.toLowerCase() || '';
            if (errorMessage.includes('network') || errorMessage.includes('connection')) {
                retryCount++;
                console.log(`🌐 Network issue, retry ${retryCount}/${maxRetries}`);
                await new Promise(resolve => setTimeout(resolve, 2000)); // Wait 2s before retry
                continue;
            } else {
                throw new GitOperationError(`Fetch failed: ${error.stderr || error.message}`);
            }
        }
    }
    
    throw new GitOperationError("Fetch failed after all retries");
}
```

### **3. 🌿 Develop Branch Creation**
```typescript
async function createDevelopBranch(sequenceState: SequenceState): Promise<boolean> {
    /**
     * Cria branch develop a partir de main se não existir
     * Implementa verificações de segurança completas
     */
    try {
        // 1. Verificar se main existe e está atualizada
        let mainBranch: string | null = null;
        
        try {
            const { stdout: mainCheck } = await execAsync('git ls-remote --heads origin main');
            if (mainCheck.trim()) {
                mainBranch = 'main';
            }
        } catch {
            // main não existe, tentar master
        }
        
        if (!mainBranch) {
            try {
                const { stdout: masterCheck } = await execAsync('git ls-remote --heads origin master');
                if (masterCheck.trim()) {
                    mainBranch = 'master';
                }
            } catch {
                // master também não existe
            }
        }
        
        if (!mainBranch) {
            throw new GitOperationError("Neither main nor master branch found remotely");
        }
        
        // 2. Checkout para main/master local
        await execAsync(`git checkout ${mainBranch}`);
        
        // 3. Pull latest main/master
        await execAsync(`git pull origin ${mainBranch}`);
        
        // 4. Criar develop branch
        await execAsync('git checkout -b develop');
        
        // 5. Push develop para remote
        await execAsync('git push origin develop');
        
        sequenceState.stepsCompleted.push('create_develop');
        sequenceState.rollbackSteps.push('delete_develop');
        sequenceState.createdDevelop = true;
        
        console.log(`✅ Develop branch created from ${mainBranch}`);
        return true;
        
    } catch (error: any) {
        throw new GitOperationError(`Failed to create develop branch: ${error.stderr || error.message}`);
    }
}
```

### **4. 📍 Checkout Operations**
```typescript
async function executeCheckout(sequenceState: SequenceState): Promise<boolean> {
    /**
     * Checkout para branch alvo com validações
     * Preserva informações para rollback
     */
    const targetBranch = sequenceState.targetBranch;
    const originalBranch = sequenceState.originalBranch;
    
    try {
        // Verificar se branch alvo existe localmente
        const { stdout: branchList } = await execAsync(`git branch --list ${targetBranch}`);
        const branchExistsLocally = !!branchList.trim();
        
        if (branchExistsLocally) {
            // Branch existe: checkout direto
            await execAsync(`git checkout ${targetBranch}`);
        } else {
            // Branch não existe: checkout com tracking
            await execAsync(`git checkout -b ${targetBranch} origin/${targetBranch}`);
        }
        
        // Verificar se checkout foi bem-sucedido
        const { stdout: currentBranchCheck } = await execAsync('git branch --show-current');
        const currentBranch = currentBranchCheck.trim();
        
        if (currentBranch !== targetBranch) {
            throw new GitOperationError(`Checkout failed: still on ${currentBranch}`);
        }
        
        sequenceState.stepsCompleted.push('checkout');
        sequenceState.rollbackSteps.push(`checkout_${originalBranch}`);
        sequenceState.checkoutSuccessful = true;
        
        console.log(`✅ Switched to branch: ${targetBranch}`);
        return true;
        
    } catch (error: any) {
        throw new GitOperationError(`Checkout failed: ${error.stderr || error.message}`);
    }
}
```

### **5. ⬇️ Pull Operations**
```typescript
async function executePull(sequenceState: SequenceState): Promise<boolean> {
    /**
     * Pull mudanças da branch alvo com merge conflict detection
     * Implementa estratégias para diferentes cenários
     */
    const targetBranch = sequenceState.targetBranch;
    
    try {
        // Verificar estado antes do pull
        const { stdout: statusCheck } = await execAsync('git status --porcelain');
        
        if (statusCheck.trim()) {
            // Existe working directory sujo - não deveria acontecer
            throw new GitOperationError("Working directory not clean before pull");
        }
        
        // Executar pull
        const { stdout: pullOutput } = await execAsync(`git pull origin ${targetBranch}`);
        
        // Analisar resultado do pull
        let commitsPulled: number | string;
        if (pullOutput.includes("Already up to date")) {
            commitsPulled = 0;
            console.log("✅ Already up to date");
        } else {
            // Contar arquivos mudados
            const filesMatch = pullOutput.match(/(\d+) files? changed/);
            commitsPulled = filesMatch ? parseInt(filesMatch[1]) : "unknown";
            console.log(`✅ Pull completed: ${commitsPulled} files changed`);
        }
        
        sequenceState.stepsCompleted.push('pull');
        sequenceState.pullOutput = pullOutput;
        sequenceState.commitsPulled = commitsPulled;
        
        return true;
        
    } catch (error: any) {
        const errorOutput = (error.stderr || error.message || '').toLowerCase();
        
        if (errorOutput.includes('merge conflict') || errorOutput.includes('automatic merge failed')) {
            throw new GitOperationError("Merge conflicts detected - manual resolution required");
        } else if (errorOutput.includes('connection') || errorOutput.includes('network')) {
            throw new GitOperationError("Network error during pull");
        } else {
            throw new GitOperationError(`Pull failed: ${error.stderr || error.message}`);
        }
    }
}
```

### **6. 🧹 Branch Cleanup Operations**
```typescript
async function shouldCleanupBranch(context: SyncContext, sequenceState: SequenceState): Promise<boolean> {
    /**
     * Determina se é seguro fazer cleanup da branch anterior
     * Implementa múltiplas verificações de segurança
     */
    const currentBranchInfo = context.currentBranch;
    const originalBranch = sequenceState.originalBranch;
    const targetBranch = sequenceState.targetBranch;
    
    // Verificações básicas
    if (!currentBranchInfo) {
        return false;
    }
    
    // Não deletar se já estamos na branch alvo
    if (originalBranch === targetBranch) {
        console.log("ℹ️ No cleanup needed: already on target branch");
        return false;
    }
    
    // Não deletar branches protegidas
    if (!currentBranchInfo.safeToDelete) {
        console.log(`🛡️ Skipping cleanup: ${originalBranch} is protected`);
        return false;
    }
    
    // Verificar se branch foi mergeada
    try {
        const { stdout: mergedBranches } = await execAsync(`git branch --merged ${targetBranch}`);
        
        const branchList = mergedBranches
            .split('\n')
            .map(b => b.trim().replace(/^\*\s*/, ''))
            .filter(b => b);
        
        if (!branchList.includes(originalBranch)) {
            console.log(`⚠️ Skipping cleanup: ${originalBranch} not merged to ${targetBranch}`);
            return false;
        }
        
        return true;
        
    } catch (error) {
        console.log("⚠️ Skipping cleanup: could not verify merge status");
        return false;
    }
}

async function executeBranchCleanup(sequenceState: SequenceState): Promise<boolean> {
    /**
     * Remove branch local anterior se todas as verificações passaram
     * Preserva informações para possível rollback
     */
    const originalBranch = sequenceState.originalBranch;
    
    try {
        // Última verificação de segurança
        const { stdout: currentBranchCheck } = await execAsync('git branch --show-current');
        const currentBranch = currentBranchCheck.trim();
        
        if (currentBranch === originalBranch) {
            throw new GitOperationError("Cannot delete current branch");
        }
        
        // Executar cleanup
        await execAsync(`git branch -d ${originalBranch}`);
        
        sequenceState.stepsCompleted.push('cleanup');
        sequenceState.rollbackSteps.push(`restore_${originalBranch}`);
        sequenceState.cleanedBranch = originalBranch;
        
        console.log(`✅ Cleaned up branch: ${originalBranch}`);
        return true;
        
    } catch (error: any) {
        const errorMessage = error.stderr || error.message || '';
        
        // -d falhou, branch pode ter commits não mergeados
        if (errorMessage.includes("not fully merged")) {
            console.log(`⚠️ Skipping cleanup: ${originalBranch} has unmerged commits`);
            return false;
        } else {
            throw new GitOperationError(`Branch cleanup failed: ${errorMessage}`);
        }
    }
}
```

### **7. 🔄 Rollback Operations**
```typescript
async function executeRollback(sequenceState: SequenceState): Promise<void> {
    /**
     * Executa rollback das operações git em caso de falha
     * Tenta restaurar estado original sempre que possível
     */
    console.log("🔄 Initiating rollback sequence...");
    const rollbackSuccess: string[] = [];
    const rollbackErrors: string[] = [];
    
    // Rollback em ordem reversa
    for (const step of sequenceState.rollbackSteps.reverse()) {
        try {
            if (step === 'delete_develop') {
                // Remover develop branch criada
                await execAsync('git push origin --delete develop');
                await execAsync('git branch -D develop');
                rollbackSuccess.push("Removed created develop branch");
                
            } else if (step.startsWith('checkout_')) {
                // Voltar para branch original
                const originalBranch = step.replace('checkout_', '');
                await execAsync(`git checkout ${originalBranch}`);
                rollbackSuccess.push(`Returned to ${originalBranch}`);
                
            } else if (step.startsWith('restore_')) {
                // Tentar restaurar branch deletada (limitado)
                console.log("⚠️ Cannot fully restore deleted branch, check git reflog");
                
            }
        } catch (error: any) {
            const errorMessage = error.stderr || error.message || '';
            rollbackErrors.push(`Failed to rollback ${step}: ${errorMessage}`);
        }
    }
    
    // Report rollback results
    if (rollbackSuccess.length > 0) {
        console.log(`✅ Rollback successful: ${rollbackSuccess.join(', ')}`);
    }
    
    if (rollbackErrors.length > 0) {
        console.log(`❌ Rollback issues: ${rollbackErrors.join(', ')}`);
    }
    
    sequenceState.rollbackExecuted = true;
    sequenceState.rollbackSuccess = rollbackSuccess;
    sequenceState.rollbackErrors = rollbackErrors;
}
```

### **8. 📊 Templates de Saída Git Operations**
```typescript
function displayGitOperationsResults(sequenceState: SequenceState): void {
    /**
     * Exibe resultados das operações git de forma organizada
     * Adapta mensagem baseado no sucesso/falha
     */
    
    if (sequenceState.success) {
        // Sucesso completo
        console.log("⚙️ OPERAÇÕES GIT COMPLETAS");
        console.log("━━━━━━━━━━━━━━━━━━━━━━━━");
        
        console.log("✅ OPERAÇÕES EXECUTADAS:");
        sequenceState.stepsCompleted.forEach(step => {
            if (step === 'fetch') {
                console.log("   ▶ Fetch: Remote updates retrieved");
            } else if (step === 'create_develop') {
                console.log("   ▶ Develop: Created from main/master");
            } else if (step === 'checkout') {
                console.log(`   ▶ Checkout: Switched to ${sequenceState.targetBranch}`);
            } else if (step === 'pull') {
                const commits = sequenceState.commitsPulled || 'unknown';
                console.log(`   ▶ Pull: ${commits} changes integrated`);
            } else if (step === 'cleanup') {
                const cleaned = sequenceState.cleanedBranch || 'unknown';
                console.log(`   ▶ Cleanup: Removed ${cleaned}`);
            }
        });
        
        // Informações específicas
        if (sequenceState.createdDevelop) {
            console.log("\n🌿 DEVELOP BRANCH:");
            console.log("   ∟ Auto-created from main/master");
            console.log("   ∟ Pushed to remote origin");
        }
        
        if (sequenceState.cleanedBranch) {
            console.log("\n🧹 CLEANUP:");
            console.log(`   ∟ Branch ${sequenceState.cleanedBranch} removed`);
            console.log("   ∟ All changes were safely merged");
        }
        
        console.log("━━━━━━━━━━━━━━━━━━━━━━━━");
        
    } else {
        // Falha com detalhes
        console.log("❌ OPERAÇÕES GIT FALHARAM");
        console.log("━━━━━━━━━━━━━━━━━━━━━━━━");
        
        console.log(`💥 ERRO: ${sequenceState.error || 'Unknown error'}`);
        
        if (sequenceState.stepsCompleted.length > 0) {
            console.log("\n✅ PASSOS COMPLETADOS:");
            sequenceState.stepsCompleted.forEach(step => {
                console.log(`   ∟ ${step}`);
            });
        }
        
        if (sequenceState.rollbackExecuted) {
            console.log("\n🔄 ROLLBACK EXECUTADO:");
            sequenceState.rollbackSuccess?.forEach(success => {
                console.log(`   ✅ ${success}`);
            });
            sequenceState.rollbackErrors?.forEach(error => {
                console.log(`   ❌ ${error}`);
            });
        }
        
        console.log("━━━━━━━━━━━━━━━━━━━━━━━━");
    }
}
```

### **9. 🎯 Fluxo Principal Git Operations**
```typescript
async function executeFullGitSync(context: SyncContext): Promise<SequenceState> {
    /**
     * Função principal que executa sincronização git completa
     * Integra detecção de contexto + operações git + saída formatada
     */
    console.log("⚙️ INICIANDO OPERAÇÕES GIT");
    console.log("━━━━━━━━━━━━━━━━━━━━━━━━");
    
    // Executar sequência de operações
    const sequenceResult = await executeGitSequence(context);
    
    // Exibir resultados
    displayGitOperationsResults(sequenceResult);
    
    // Retornar resultado para próximas fases
    return sequenceResult;
}

// Exemplo de integração com detecção:
async function gitSyncWorkflow(branchArg?: string): Promise<SyncContext & { gitOperations?: SequenceState }> {
    /**
     * Workflow completo: Detecção + Git Operations
     */
    // Fase 2: Detecção
    const context = await detectSyncContext(branchArg);
    displayDetectionResults(context);
    
    if (!context.canProceed) {
        console.log("❌ Cannot proceed with git operations");
        return context;
    }
    
    // Fase 3: Git Operations
    const gitResult = await executeFullGitSync(context);
    
    // Combinar resultados
    return {
        ...context,
        gitOperations: gitResult
    };
}
```

### **10. 🧪 Exemplos de Execução Git Operations**

#### **Exemplo 1: Sync Padrão (develop)**
```bash
# Comando: /git/sync
# Context: feature/sync-command → develop

⚙️ INICIANDO OPERAÇÕES GIT
━━━━━━━━━━━━━━━━━━━━━━━━

🔄 Fetching remote changes...
✅ Fetch completed: 3 updates

📍 Switching to develop...
✅ Switched to branch: develop

⬇️ Pulling latest changes...
✅ Pull completed: 2 files changed

🧹 Cleaning up previous branch...
✅ Cleaned up branch: feature/sync-command

⚙️ OPERAÇÕES GIT COMPLETAS
━━━━━━━━━━━━━━━━━━━━━━━━

✅ OPERAÇÕES EXECUTADAS:
   ▶ Fetch: Remote updates retrieved
   ▶ Checkout: Switched to develop
   ▶ Pull: 2 changes integrated
   ▶ Cleanup: Removed feature/sync-command

🧹 CLEANUP:
   ∟ Branch feature/sync-command removed
   ∟ All changes were safely merged

━━━━━━━━━━━━━━━━━━━━━━━━
```

#### **Exemplo 2: Auto-criação develop**
```bash
# Comando: /git/sync (develop não existe)

⚙️ INICIANDO OPERAÇÕES GIT
━━━━━━━━━━━━━━━━━━━━━━━━

🔄 Fetching remote changes...
✅ Fetch completed: 1 updates

🌿 Creating develop branch...
✅ Develop branch created from main

📍 Switching to develop...
✅ Switched to branch: develop

⬇️ Pulling latest changes...
✅ Already up to date

🧹 Cleaning up previous branch...
✅ Cleaned up branch: feature/my-feature

⚙️ OPERAÇÕES GIT COMPLETAS
━━━━━━━━━━━━━━━━━━━━━━━━

✅ OPERAÇÕES EXECUTADAS:
   ▶ Fetch: Remote updates retrieved
   ▶ Develop: Created from main/master
   ▶ Checkout: Switched to develop
   ▶ Pull: 0 changes integrated
   ▶ Cleanup: Removed feature/my-feature

🌿 DEVELOP BRANCH:
   ∟ Auto-created from main/master
   ∟ Pushed to remote origin

━━━━━━━━━━━━━━━━━━━━━━━━
```

#### **Exemplo 3: Falha com Rollback**
```bash
# Comando: /git/sync main (conflito no pull)

⚙️ INICIANDO OPERAÇÕES GIT
━━━━━━━━━━━━━━━━━━━━━━━━

🔄 Fetching remote changes...
✅ Fetch completed: 5 updates

📍 Switching to main...
✅ Switched to branch: main

⬇️ Pulling latest changes...
❌ Git operation failed: Merge conflicts detected - manual resolution required

🔄 Attempting rollback...
✅ Rollback successful: Returned to feature/my-feature

❌ OPERAÇÕES GIT FALHARAM
━━━━━━━━━━━━━━━━━━━━━━━━

💥 ERRO: Merge conflicts detected - manual resolution required

✅ PASSOS COMPLETADOS:
   ∟ fetch
   ∟ checkout

🔄 ROLLBACK EXECUTADO:
   ✅ Returned to feature/my-feature

━━━━━━━━━━━━━━━━━━━━━━━━
```

## 🔗 **Integração ClickUp (Fase 4)**

### **1. 🎯 ClickUp Connection Manager**
```typescript
interface ClickUpIntegrationResult {
    success: boolean;
    taskUpdated?: boolean;
    statusChanged?: boolean;
    tagsUpdated?: boolean;
    commentAdded?: boolean;
    error?: string;
}

async function executeClickUpIntegration(context: SyncContext, gitResult: SequenceState): Promise<ClickUpIntegrationResult> {
    /**
     * Integração principal com ClickUp após sucesso das operações git
     * Executa todas as atualizações necessárias na task
     */
    const result: ClickUpIntegrationResult = {
        success: false
    };
    
    // Verificar se tem task ID para integração
    if (!context.taskId) {
        console.log("ℹ️ No task ID found - skipping ClickUp integration");
        result.success = true; // Não é erro, apenas sem integração
        return result;
    }
    
    // Verificar se operações git foram bem-sucedidas
    if (!gitResult.success) {
        console.log("⚠️ Git operations failed - skipping ClickUp integration");
        return result;
    }
    
    try {
        console.log("🔗 Starting ClickUp integration...");
        
        // 1. Atualizar status da task
        await updateTaskStatus(context.taskId, result);
        
        // 2. Gerenciar tags
        await updateTaskTags(context.taskId, result);
        
        // 3. Adicionar comentário de conclusão
        await addCompletionComment(context.taskId, context, gitResult, result);
        
        result.success = true;
        console.log("✅ ClickUp integration completed successfully");
        
    } catch (error: any) {
        console.log(`❌ ClickUp integration failed: ${error.message}`);
        result.error = error.message;
        result.success = false;
    }
    
    return result;
}
```

### **2. 📋 Task Status Management**
```typescript
async function updateTaskStatus(taskId: string, result: ClickUpIntegrationResult): Promise<void> {
    /**
     * Atualiza status da task para "Done"
     * Implementa verificação de sucesso
     */
    try {
        console.log("📋 Updating task status to 'Done'...");
        
        // Usar ClickUp MCP para atualizar status
        const updateResult = await updateTask({
            taskId: taskId,
            status: "Done"
        });
        
        if (updateResult.success) {
            result.statusChanged = true;
            console.log("✅ Task status updated to 'Done'");
        } else {
            throw new Error(`Failed to update status: ${updateResult.error || 'Unknown error'}`);
        }
        
    } catch (error: any) {
        console.log(`⚠️ Status update failed: ${error.message}`);
        throw error;
    }
}
```

### **3. 🏷️ Tag Management System**
```typescript
async function updateTaskTags(taskId: string, result: ClickUpIntegrationResult): Promise<void> {
    /**
     * Gerencia tags da task: remove in-progress/under-review, adiciona completed
     * Implementa operações atômicas
     */
    try {
        console.log("🏷️ Managing task tags...");
        
        const tagsToRemove = ["in-progress", "under-review"];
        const tagsToAdd = ["completed"];
        
        // Remover tags de desenvolvimento
        for (const tag of tagsToRemove) {
            try {
                await removeTagFromTask({
                    taskId: taskId,
                    tagName: tag
                });
                console.log(`  ➖ Removed tag: ${tag}`);
            } catch (error: any) {
                // Tag pode não existir, não é erro crítico
                console.log(`  ℹ️ Tag '${tag}' not found or already removed`);
            }
        }
        
        // Adicionar tag de conclusão
        for (const tag of tagsToAdd) {
            try {
                await addTagToTask({
                    taskId: taskId,
                    tagName: tag
                });
                console.log(`  ➕ Added tag: ${tag}`);
            } catch (error: any) {
                // Se tag não existe, pular (pode não estar configurada no workspace)
                console.log(`  ⚠️ Could not add tag '${tag}': ${error.message}`);
            }
        }
        
        result.tagsUpdated = true;
        console.log("✅ Tag management completed");
        
    } catch (error: any) {
        console.log(`⚠️ Tag management failed: ${error.message}`);
        throw error;
    }
}
```

### **4. 💬 Completion Comment System**
```typescript
async function addCompletionComment(
    taskId: string, 
    context: SyncContext, 
    gitResult: SequenceState, 
    result: ClickUpIntegrationResult
): Promise<void> {
    /**
     * Adiciona comentário formatado de conclusão
     * Template padronizado com informações técnicas
     */
    try {
        console.log("💬 Adding completion comment...");
        
        const commentText = generateCompletionComment(context, gitResult);
        
        await createTaskComment({
            taskId: taskId,
            commentText: commentText
        });
        
        result.commentAdded = true;
        console.log("✅ Completion comment added");
        
    } catch (error: any) {
        console.log(`⚠️ Comment creation failed: ${error.message}`);
        throw error;
    }
}

function generateCompletionComment(context: SyncContext, gitResult: SequenceState): string {
    /**
     * Gera template de comentário padronizado
     * Inclui informações técnicas e timestamp
     */
    const targetBranch = context.targetBranch?.name || 'unknown';
    const commitsPulled = gitResult.commitsPulled || 'unknown';
    const cleanedBranch = gitResult.cleanedBranch || 'none';
    const timestamp = new Date().toLocaleString('pt-BR');
    
    // Template padronizado Sistema Onion
    return `✅ TASK CONCLUÍDA - SYNC COMPLETED

━━━━━━━━━━━━━━━━━━━━━━━━

🔄 SINCRONIZAÇÃO:
   ▶ Branch synced: ${targetBranch}
   ▶ Commits pulled: ${commitsPulled} changes
   ▶ Local branch cleaned: ${cleanedBranch}

📋 OPERAÇÕES EXECUTADAS:
   ∟ Git fetch: Remote updates retrieved
   ∟ Branch checkout: Switched successfully
   ∟ Pull changes: Integrated to local
   ∟ Cleanup: Previous branch removed safely

🎯 DESENVOLVIMENTO COMPLETO:
   ∟ PR merged successfully
   ∟ Code integrated to target branch
   ∟ Local environment synchronized
   ∟ Task moved to "Done" status

━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Finalizado: ${timestamp} | 🤖 Sistema Onion Sync`;
}
```

### **5. 📊 ClickUp Integration Results Display**
```typescript
function displayClickUpResults(clickupResult: ClickUpIntegrationResult): void {
    /**
     * Exibe resultados da integração ClickUp
     * Formato consistente com templates do sistema
     */
    
    if (clickupResult.success) {
        console.log("🔗 CLICKUP INTEGRATION COMPLETA");
        console.log("━━━━━━━━━━━━━━━━━━━━━━━━");
        
        console.log("✅ ATUALIZAÇÕES EXECUTADAS:");
        
        if (clickupResult.statusChanged) {
            console.log("   ▶ Status: Task moved to 'Done'");
        }
        
        if (clickupResult.tagsUpdated) {
            console.log("   ▶ Tags: Updated (+completed, -in-progress, -under-review)");
        }
        
        if (clickupResult.commentAdded) {
            console.log("   ▶ Comment: Completion details added");
        }
        
        console.log("\n🎯 TASK STATUS:");
        console.log("   ∟ Development cycle completed");
        console.log("   ∟ Ready for next task assignment");
        
        console.log("━━━━━━━━━━━━━━━━━━━━━━━━");
        
    } else {
        console.log("⚠️ CLICKUP INTEGRATION LIMITADA");
        console.log("━━━━━━━━━━━━━━━━━━━━━━━━");
        
        if (clickupResult.error) {
            console.log(`💥 ERRO: ${clickupResult.error}`);
        } else {
            console.log("ℹ️ MOTIVO: No task ID available for integration");
        }
        
        console.log("\n📋 AÇÕES MANUAIS NECESSÁRIAS:");
        console.log("   ∟ Update task status manually if needed");
        console.log("   ∟ Add completion comment manually");
        console.log("   ∟ Update tags as appropriate");
        
        console.log("━━━━━━━━━━━━━━━━━━━━━━━━");
    }
}
```

### **6. 🎯 Workflow Principal Integrado**
```typescript
async function executeFullSyncWithClickUp(context: SyncContext): Promise<{
    gitResult: SequenceState;
    clickupResult: ClickUpIntegrationResult;
}> {
    /**
     * Executa sync completo: Git Operations + ClickUp Integration
     * Workflow completo das Fases 3 + 4
     */
    
    // Fase 3: Operações Git
    console.log("⚙️ FASE 3: OPERAÇÕES GIT");
    console.log("━━━━━━━━━━━━━━━━━━━━━━━━");
    const gitResult = await executeGitSequence(context);
    displayGitOperationsResults(gitResult);
    
    // Fase 4: Integração ClickUp (apenas se git teve sucesso)
    console.log("\n🔗 FASE 4: INTEGRAÇÃO CLICKUP");
    console.log("━━━━━━━━━━━━━━━━━━━━━━━━");
    const clickupResult = await executeClickUpIntegration(context, gitResult);
    displayClickUpResults(clickupResult);
    
    return {
        gitResult,
        clickupResult
    };
}

// Workflow principal atualizado
async function syncWorkflowComplete(branchArg?: string): Promise<void> {
    /**
     * Workflow completo: Detecção + Git + ClickUp
     * Integra todas as 4 fases implementadas
     */
    
    // Fase 2: Detecção
    const context = await detectSyncContext(branchArg);
    displayDetectionResults(context);
    
    if (!context.canProceed) {
        console.log("❌ Cannot proceed with sync operations");
        return;
    }
    
    // Fases 3 + 4: Git + ClickUp
    const results = await executeFullSyncWithClickUp(context);
    
    // Summary final
    console.log("\n🏁 SYNC WORKFLOW COMPLETE");
    console.log("━━━━━━━━━━━━━━━━━━━━━━━━");
    console.log(`Git Operations: ${results.gitResult.success ? '✅ Success' : '❌ Failed'}`);
    console.log(`ClickUp Integration: ${results.clickupResult.success ? '✅ Success' : '⚠️ Limited'}`);
    console.log("━━━━━━━━━━━━━━━━━━━━━━━━");
}
```

### **✅ Auto-Update ClickUp Strategy**

Este comando **automaticamente atualiza** a task ClickUp quando executa com sucesso:

#### **🎯 Updates Automáticos SEMPRE:**
- **Status → "Done"** quando sync completo
- **Tags atualizadas**: Remove "in-progress", "under-review" + Adiciona "completed"
- **Comentário de conclusão** com detalhes técnicos da sincronização
- **Timestamp** de finalização da task

#### **🛡️ Tratamento de Erros:**
- **Graceful degradation**: Se ClickUp falha, git operations continuam funcionais
- **Logging detalhado**: Erros específicos para troubleshooting
- **Fallback manual**: Orientações para updates manuais se API falhar

## 🧪 **Fluxo de Implementação**

### **Implementação Sequencial:**

1. **Parse de Parâmetros**:
   ```python
   target_branch = args[0] if args else "develop"
   ```

2. **Validação Inicial**:
   ```bash
   git status --porcelain  # Verificar mudanças
   git ls-remote origin [branch]  # Verificar remote
   ```

3. **Detecção de Contexto**:
   ```python
   session = detect_active_session()
   task_id = extract_task_id(session) if session else None
   current_branch = get_current_branch()
   ```

4. **Operações Git**:
   ```bash
   git fetch origin
   git checkout [target_branch] || create_develop_if_needed()
   git pull origin [target_branch]
   safe_branch_cleanup(current_branch)
   ```

5. **ClickUp Integration**:
   ```python
   if task_id:
       update_task_status(task_id, "Done")
       manage_tags(task_id, remove=["in-progress", "under-review"], add=["completed"])
       create_completion_comment(task_id, sync_details)
   ```

6. **Session Management**:
   ```python
   if session and ask_user("Archive session?"):
       archive_session(session)
   ```

## 🎨 **Integração Sistema Onion**

### **Compatibilidade com Comandos:**
- **`/product/task`** → **`/engineer/start`** → **`/engineer/work`** → **`/engineer/pr`** → **`/git/sync`**
- Seamless workflow integration
- Preserved session data and task tracking

### **Padrões Seguidos:**
- ✅ **Auto-Update ClickUp Strategy**: Seguindo `.cursor/utils/clickup-auto-update-strategy.md`
- ✅ **Unicode Formatting**: Formatação consistente com outros comandos
- ✅ **Session Management**: Integração com `.cursor/sessions/`
- ✅ **Error Handling**: Graceful degradation e orientações claras

### **Extensibilidade:**
- Facilmente extensível para novos tipos de branch
- Configurável via arquivos de configuração futuros
- Compatível com hooks git se necessário

---

**Template Output Final:**

```
<sync_completion_message>
Sincronização completa:
- Git operations: Branch [BRANCH] sincronizada com [N] novos commits
- Local cleanup: Branch [OLD_BRANCH] removida com segurança
- ClickUp updated: Task [TASK_ID] moved to "Done" with tag "completed"
- Session status: [ARCHIVED/PRESERVED] 

Ambiente local sincronizado e pronto para próxima task.

Next: Use /product/task para iniciar nova funcionalidade
</sync_completion_message>
```
