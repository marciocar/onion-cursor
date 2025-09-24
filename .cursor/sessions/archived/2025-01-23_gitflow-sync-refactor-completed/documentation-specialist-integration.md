# 🤖 @gitflow-specialist Integration Documentation

## 📋 **Visão Geral**

O agente `@gitflow-specialist` é um componente-chave da nova integração GitFlow, fornecendo análise inteligente de workflows Git para otimizar operações de sincronização. Esta documentação detalha como a comunicação funciona, formatos de dados, e estratégias de fallback.

### **🎯 Responsabilidades do @gitflow-specialist:**
- **Análise de Workflow**: Detectar GitFlow, GitHub-Flow, GitLab-Flow
- **Strategy Selection**: Escolher estratégia de sync otimizada
- **Validation**: Verificar compliance e best practices
- **Optimization**: Sugerir otimizações baseadas no contexto
- **Guidance**: Fornecer próximos passos e recomendações

---

## 🔌 **Interface de Comunicação**

### **Request Format (Input)**
```typescript
interface GitflowSyncRequest {
  context: {
    currentBranch: string;           // e.g., "feature/user-auth"
    targetBranch: string;            // e.g., "develop"
    workflowType: WorkflowType;      // "gitflow" | "github-flow" | "gitlab-flow"
    operation: OperationType;        // "sync" | "merge" | "rebase"
  };
  repositoryState: {
    uncommittedChanges: boolean;     // true se há changes não commitados
    unpushedCommits: number;         // número de commits ahead
    unpulledCommits: number;         // número de commits behind
    conflictsDetected: boolean;      // true se há conflitos potenciais
    lastSyncTimestamp?: number;      // timestamp do último sync (opcional)
  };
  sessionContext: {
    hasActiveSession: boolean;       // true se há sessão ativa
    sessionPath?: string;            // caminho da sessão (.cursor/sessions/*)
    clickupTaskId?: string;          // ID da task ClickUp associada
    developmentPhase?: string;       // "planning" | "development" | "review" | "done"
  };
  metadata: {
    requestId: string;               // UUID único para tracking
    timestamp: number;               // timestamp da requisição
    version: string;                 // versão do integration (e.g., "2.0.0")
    cacheKey?: string;              // chave para cache (opcional)
  };
}

type WorkflowType = "gitflow" | "github-flow" | "gitlab-flow" | "custom";
type OperationType = "sync" | "merge" | "rebase" | "cleanup" | "validate";
```

### **Response Format (Output)**
```typescript
interface GitflowSyncResponse {
  analysis: {
    syncStrategy: SyncStrategy;      // Estratégia recomendada
    workflowType: WorkflowType;      // Workflow detectado/confirmado
    confidence: number;              // Confiança da análise (0-100)
    branchClassification: {
      type: BranchType;              // "feature" | "hotfix" | "release" | "develop" | "main"
      pattern: string;               // regex pattern usado
      isCompliant: boolean;          // true se segue convenções
    };
  };
  validation: {
    isOperationValid: boolean;       // true se operação é segura
    blockingIssues: ValidationIssue[]; // issues que impedem operação
    warnings: ValidationWarning[];   // avisos não-bloqueantes
    postMergeChecks: {
      branchCleanupRequired?: boolean;
      sessionArchiveRecommended?: boolean;
      clickupStatusUpdate?: string;
      deploymentReadiness?: boolean;
    };
  };
  guidance: {
    syncBestPractices: string[];     // práticas recomendadas
    nextSteps: string[];             // próximas ações sugeridas
    optimizations: OptimizationType[]; // otimizações aplicáveis
    troubleshooting?: string[];      // dicas se problemas detectados
  };
  metadata: {
    requestId: string;               // mesmo ID da request
    processingTime: number;          // tempo de processamento (ms)
    source: "specialist" | "fallback"; // fonte da resposta
    fallbackReason?: string;         // razão do fallback (se aplicável)
    cacheHit: boolean;              // true se resposta veio do cache
  };
}

type SyncStrategy = "standard" | "feature-cleanup" | "hotfix-sync" | "no-op" | "custom";
type BranchType = "feature" | "hotfix" | "release" | "develop" | "main" | "support" | "custom";
type OptimizationType = "fast-forward" | "skip-remote-check" | "parallel-operations" | "cache-enabled";

interface ValidationIssue {
  code: string;                     // e.g., "UNCOMMITTED_CHANGES"
  message: string;                  // descrição human-readable
  severity: "error" | "warning";   // severidade do issue
  actionRequired: string;           // ação necessária para resolver
}

interface ValidationWarning {
  code: string;                     // e.g., "OLD_FEATURE_BRANCH"
  message: string;                  // descrição human-readable
  impact: "low" | "medium" | "high"; // impacto potencial
  recommendation: string;           // recomendação para tratar
}
```

---

## 🚀 **Estratégias de Sync**

### **1. Standard Strategy**
```json
{
  "analysis": {
    "syncStrategy": "standard",
    "confidence": 85
  },
  "guidance": {
    "syncBestPractices": [
      "pull-before-push",
      "validate-tests", 
      "check-conflicts"
    ],
    "optimizations": ["cache-enabled"]
  }
}
```

**Usado para:**
- Branches principais (develop, main, master)
- Sync de rotina sem características especiais
- Quando não há otimizações específicas detectadas

### **2. Feature-Cleanup Strategy**
```json
{
  "analysis": {
    "syncStrategy": "feature-cleanup",
    "confidence": 95
  },
  "validation": {
    "postMergeChecks": {
      "branchCleanupRequired": true,
      "sessionArchiveRecommended": true,
      "clickupStatusUpdate": "Done"
    }
  },
  "guidance": {
    "syncBestPractices": ["fast-forward"],
    "nextSteps": [
      "archive-session",
      "update-clickup", 
      "cleanup-branch"
    ],
    "optimizations": ["fast-forward", "skip-remote-check"]
  }
}
```

**Usado para:**
- Feature branches após desenvolvimento completo  
- Quando merge para develop/main foi detectado
- Situações que requerem cleanup pós-merge

### **3. Hotfix-Sync Strategy**
```json
{
  "analysis": {
    "syncStrategy": "hotfix-sync",
    "confidence": 98
  },
  "validation": {
    "postMergeChecks": {
      "deploymentReadiness": true,
      "clickupStatusUpdate": "Ready for Deploy"
    }
  },
  "guidance": {
    "syncBestPractices": [
      "dual-merge-main-develop",
      "create-release-tags",
      "notify-stakeholders"
    ],
    "nextSteps": [
      "merge-to-main",
      "merge-to-develop", 
      "create-release-tag",
      "notify-deployment"
    ],
    "optimizations": ["parallel-operations"]
  }
}
```

**Usado para:**
- Hotfix branches para correções críticas
- Situações de emergência que requerem deploy rápido
- Workflows que afetam produção diretamente

### **4. No-Op Strategy**
```json
{
  "analysis": {
    "syncStrategy": "no-op",
    "confidence": 100
  },
  "guidance": {
    "syncBestPractices": ["status-check-only"],
    "nextSteps": ["validate-current-state"],
    "optimizations": [
      "skip-remote-check",
      "fast-forward", 
      "parallel-operations"
    ]
  }
}
```

**Usado para:**
- Quando current branch = target branch
- Otimização máxima para operações desnecessárias
- Validações rápidas de status

---

## ⚡ **Performance & Caching**

### **Cache Strategy**
```typescript
// Cache Key Generation
function generateCacheKey(request: GitflowSyncRequest): string {
  const { currentBranch, targetBranch, workflowType } = request.context;
  const { uncommittedChanges, unpushedCommits } = request.repositoryState;
  
  return `${currentBranch}-${targetBranch}-${workflowType}-${uncommittedChanges}-${unpushedCommits}`;
}

// Cache Configuration
const cacheConfig = {
  strategy: "LRU",
  maxSize: 50,              // 50 entries
  maxAge: 300000,           // 5 minutes TTL
  hitRate: 0.7,            // Target: 70%+ hit rate
  keyStrategy: "context-based"
};
```

### **Cache Hit Scenarios**
```typescript
// Cenário 1: Mesmo contexto, diferentes timestamps
const request1 = { context: { currentBranch: "feature/auth", targetBranch: "develop" }, timestamp: 1000 };
const request2 = { context: { currentBranch: "feature/auth", targetBranch: "develop" }, timestamp: 2000 };
// Result: Cache HIT (contexto idêntico dentro do TTL)

// Cenário 2: Branch similar, workflow diferente  
const request3 = { context: { currentBranch: "feature/auth", workflowType: "gitflow" } };
const request4 = { context: { currentBranch: "feature/auth", workflowType: "github-flow" } };
// Result: Cache MISS (workflowType diferente)

// Cenário 3: Estado do repositório mudou
const request5 = { repositoryState: { unpushedCommits: 0 } };
const request6 = { repositoryState: { unpushedCommits: 3 } };
// Result: Cache MISS (estado significativamente diferente)
```

### **Performance Metrics**
```typescript
interface PerformanceMetrics {
  cacheHitRate: number;           // Target: 70%+
  averageResponseTime: number;    // Target: < 8s
  fallbackUsageRate: number;      // Target: < 5%
  successRate: number;            // Target: 99%+
  timeoutRate: number;            // Target: < 1%
}

// Exemplo de métricas em produção:
const currentMetrics: PerformanceMetrics = {
  cacheHitRate: 0.73,            // 73% - ✅ Above target
  averageResponseTime: 6200,      // 6.2s - ✅ Within target  
  fallbackUsageRate: 0.03,       // 3% - ✅ Well below target
  successRate: 0.997,            // 99.7% - ✅ Above target
  timeoutRate: 0.005             // 0.5% - ✅ Well below target
};
```

---

## 🛡️ **Error Handling & Fallback**

### **Timeout & Retry Logic**
```typescript
async function invokeGitflowSpecialist(request: GitflowSyncRequest): Promise<GitflowSyncResponse> {
  const timeout_seconds = 8;
  const max_retries = 2;
  const retry_delay = 500; // ms
  
  for (let attempt = 1; attempt <= max_retries; attempt++) {
    try {
      console.log(`🤖 Invoking @gitflow-specialist (attempt ${attempt}/${max_retries})...`);
      
      const response = await Promise.race([
        callSpecialistAgent(request),
        new Promise((_, reject) => 
          setTimeout(() => reject(new Error('TIMEOUT')), timeout_seconds * 1000)
        )
      ]);
      
      if (validateResponse(response)) {
        console.log(`✅ Valid response received from @gitflow-specialist`);
        return response;
      } else {
        console.log(`⚠️ Invalid response from @gitflow-specialist (attempt ${attempt})`);
      }
    } catch (error) {
      console.log(`❌ @gitflow-specialist error: ${error.message} (attempt ${attempt})`);
      
      if (attempt < max_retries) {
        console.log(`🔄 Retrying in ${retry_delay}ms...`);
        await new Promise(resolve => setTimeout(resolve, retry_delay));
      }
    }
  }
  
  console.log(`🔄 @gitflow-specialist unavailable - using intelligent fallback`);
  return createIntelligentFallback(request);
}
```

### **Intelligent Fallback System**
```typescript
function createIntelligentFallback(request: GitflowSyncRequest): GitflowSyncResponse {
  const { currentBranch, targetBranch, workflowType } = request.context;
  
  // Determine strategy based on branch patterns
  let syncStrategy: SyncStrategy = "standard";
  let confidence = 75; // Lower confidence for fallback
  
  if (currentBranch.startsWith("feature/")) {
    syncStrategy = "feature-cleanup";
    confidence = 80;
  } else if (currentBranch.startsWith("hotfix/")) {
    syncStrategy = "hotfix-sync";
    confidence = 85;
  } else if (currentBranch === targetBranch) {
    syncStrategy = "no-op";
    confidence = 95; // High confidence for obvious case
  }
  
  return {
    analysis: {
      syncStrategy,
      workflowType: workflowType || "gitflow", // Default assumption
      confidence,
      branchClassification: {
        type: determineBranchType(currentBranch),
        pattern: getBranchPattern(currentBranch),
        isCompliant: checkBranchCompliance(currentBranch)
      }
    },
    validation: {
      isOperationValid: true, // Conservative: allow operation
      blockingIssues: [],
      warnings: [{
        code: "FALLBACK_ANALYSIS",
        message: "Analysis performed by fallback system",
        impact: "low",
        recommendation: "Consider verifying analysis manually"
      }],
      postMergeChecks: generatePostMergeChecks(syncStrategy)
    },
    guidance: {
      syncBestPractices: getStandardPractices(syncStrategy),
      nextSteps: getStandardNextSteps(syncStrategy),
      optimizations: getStandardOptimizations(syncStrategy),
      troubleshooting: [
        "If issues occur, verify @gitflow-specialist availability",
        "Check network connectivity for agent communication",
        "Review branch naming conventions for better detection"
      ]
    },
    metadata: {
      requestId: request.metadata.requestId,
      processingTime: performance.now(), 
      source: "fallback",
      fallbackReason: "AGENT_UNAVAILABLE",
      cacheHit: false
    }
  };
}
```

### **Error Categories & Recovery**
```typescript
enum ErrorCategory {
  TIMEOUT = "TIMEOUT",                    // Agent não respondeu no tempo
  NETWORK = "NETWORK",                    // Problemas de conectividade
  VALIDATION = "VALIDATION",              // Response inválida
  AGENT_ERROR = "AGENT_ERROR",           // Erro interno do agente
  PARSE_ERROR = "PARSE_ERROR"            // Erro ao parsear response
}

interface ErrorRecoveryStrategy {
  category: ErrorCategory;
  retryable: boolean;
  fallbackEnabled: boolean;
  userActionRequired: boolean;
  recoverySteps: string[];
}

const errorRecoveryStrategies: Record<ErrorCategory, ErrorRecoveryStrategy> = {
  [ErrorCategory.TIMEOUT]: {
    retryable: true,
    fallbackEnabled: true,
    userActionRequired: false,
    recoverySteps: [
      "Retry with exponential backoff",
      "Switch to intelligent fallback",
      "Continue operation with reduced confidence"
    ]
  },
  [ErrorCategory.NETWORK]: {
    retryable: true,
    fallbackEnabled: true,
    userActionRequired: false,
    recoverySteps: [
      "Check network connectivity",
      "Retry with different timeout",
      "Use fallback analysis"
    ]
  },
  [ErrorCategory.VALIDATION]: {
    retryable: false,
    fallbackEnabled: true,
    userActionRequired: false,
    recoverySteps: [
      "Log invalid response for debugging",
      "Switch to fallback immediately",
      "Report validation issue"
    ]
  }
};
```

---

## 🔧 **Advanced Configuration**

### **Environment Variables**
```bash
# Agent Communication
export GITFLOW_AGENT_TIMEOUT=8000          # 8 seconds default
export GITFLOW_AGENT_MAX_RETRIES=2         # 2 retries default
export GITFLOW_AGENT_RETRY_DELAY=500       # 500ms delay
export GITFLOW_AGENT_ENDPOINT="@gitflow-specialist"

# Cache Configuration  
export GITFLOW_CACHE_ENABLED=true          # Enable cache
export GITFLOW_CACHE_SIZE=50               # 50 entries max
export GITFLOW_CACHE_TTL=300000            # 5 minutes TTL
export GITFLOW_CACHE_STRATEGY="LRU"        # LRU eviction

# Fallback Behavior
export GITFLOW_FALLBACK_ENABLED=true       # Enable intelligent fallback
export GITFLOW_FALLBACK_CONFIDENCE=75      # Default fallback confidence
export GITFLOW_STRICT_MODE=false           # false = allow fallback

# Debug & Monitoring
export GITFLOW_DEBUG_AGENT_CALLS=false     # Log agent communication
export GITFLOW_METRICS_ENABLED=true        # Collect performance metrics
export GITFLOW_TRACE_REQUESTS=false        # Trace individual requests
```

### **Custom Strategy Configuration**
```typescript
interface CustomStrategyConfig {
  name: string;
  branchPatterns: string[];              // Regex patterns for branch matching
  syncBehavior: {
    skipRemoteCheck: boolean;
    fastForward: boolean;
    parallelOperations: boolean;
    cleanupAfterSync: boolean;
  };
  validation: {
    requireCleanWorking: boolean;
    checkConflicts: boolean;
    validateTests: boolean;
  };
  postMergeActions: {
    archiveSession: boolean;
    updateClickup: boolean;
    createTags: boolean;
    notify: string[];                    // Notification channels
  };
}

// Exemplo: Custom strategy para release branches
const releaseStrategy: CustomStrategyConfig = {
  name: "release-strategy",
  branchPatterns: ["^release/v\\d+\\.\\d+\\.\\d+$"],
  syncBehavior: {
    skipRemoteCheck: false,             // Full validation for releases
    fastForward: false,                 // Merge commits for traceability  
    parallelOperations: true,
    cleanupAfterSync: false             // Keep release branches
  },
  validation: {
    requireCleanWorking: true,          // Strict for releases
    checkConflicts: true,
    validateTests: true                 // Run full test suite
  },
  postMergeActions: {
    archiveSession: false,
    updateClickup: true,
    createTags: true,                   // Create version tags
    notify: ["slack-releases", "email-stakeholders"]
  }
};
```

---

## 📊 **Monitoring & Observability**

### **Performance Monitoring**
```typescript
interface AgentMetrics {
  totalRequests: number;
  successfulResponses: number;
  timeoutResponses: number;
  errorResponses: number;
  averageResponseTime: number;
  cacheHitRate: number;
  fallbackUsageRate: number;
  
  // Per-strategy metrics
  strategyDistribution: Record<SyncStrategy, number>;
  confidenceDistribution: {
    high: number;    // 90-100%
    medium: number;  // 70-89%
    low: number;     // < 70%
  };
  
  // Response time percentiles
  responseTimeP50: number;
  responseTimeP95: number;
  responseTimeP99: number;
}

// Example metrics collection
function collectMetrics(response: GitflowSyncResponse, responseTime: number): void {
  metrics.totalRequests++;
  
  if (response.metadata.source === "specialist") {
    metrics.successfulResponses++;
  } else {
    metrics.fallbackUsageRate = (metrics.fallbackUsageRate * metrics.totalRequests + 1) / (metrics.totalRequests + 1);
  }
  
  metrics.averageResponseTime = (metrics.averageResponseTime * (metrics.totalRequests - 1) + responseTime) / metrics.totalRequests;
  
  if (response.metadata.cacheHit) {
    metrics.cacheHitRate = (metrics.cacheHitRate * metrics.totalRequests + 1) / (metrics.totalRequests + 1);
  }
  
  // Update strategy distribution
  metrics.strategyDistribution[response.analysis.syncStrategy]++;
}
```

### **Debug Logging**
```typescript
function debugAgentCall(request: GitflowSyncRequest, response: GitflowSyncResponse): void {
  if (!process.env.GITFLOW_DEBUG_AGENT_CALLS) return;
  
  console.log("🔍 GITFLOW AGENT DEBUG:");
  console.log("├── Request ID:", request.metadata.requestId);
  console.log("├── Context:", JSON.stringify(request.context, null, 2));
  console.log("├── Processing Time:", response.metadata.processingTime + "ms");
  console.log("├── Source:", response.metadata.source);
  console.log("├── Cache Hit:", response.metadata.cacheHit);
  console.log("├── Strategy:", response.analysis.syncStrategy);
  console.log("├── Confidence:", response.analysis.confidence + "%");
  console.log("└── Optimizations:", response.guidance.optimizations.join(", "));
}
```

---

## 🎯 **Best Practices**

### **For Integration Developers**
1. **Always implement fallback**: Nunca dependa 100% do agente
2. **Cache aggressively**: Use cache para melhorar performance
3. **Validate responses**: Sempre validar JSON de resposta
4. **Monitor metrics**: Acompanhar performance e success rate
5. **Handle timeouts gracefully**: Timeouts são esperados, não errors

### **For Agent Developers**
1. **Respond quickly**: Target < 8s response time
2. **Use structured JSON**: Seguir interface definida rigorosamente
3. **Provide high confidence**: Aim for 85%+ confidence when possible
4. **Include troubleshooting**: Sempre incluir guidance útil
5. **Handle edge cases**: Contemplar cenários não-padrão

### **For Users**
1. **Trust the system**: Fallback garante funcionamento
2. **Monitor performance**: Verificar metrics ocasionalmente
3. **Report issues**: Feedback sobre análises incorretas
4. **Use standard patterns**: Branch naming conventions ajudam análise
5. **Keep sessions clean**: Manter repositório organizado melhora análise

---

**Versão**: GitFlow Integration v2.0  
**Agent Compatibility**: @gitflow-specialist v1.0+  
**Fallback**: Intelligent fallback sempre disponível  
**Performance**: < 8s response time, 70%+ cache hit rate
