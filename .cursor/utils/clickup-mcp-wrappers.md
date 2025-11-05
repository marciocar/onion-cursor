# 🔧 ClickUp MCP Wrappers - Abstrações Centralizadas

## 🎯 Objetivo

Centralizar todas as chamadas MCP do ClickUp em abstrações reutilizáveis, eliminando acoplamento dos comandos e permitindo evolução independente da integração.

---

## 📋 Abstrações Disponíveis

### 1. Comentários de Fase Completada

#### `commentPhaseCompletion(subtaskId, phaseData)`

**Responsabilidade**: Criar comentário detalhado quando uma fase é completada.

**Parâmetros:**
```typescript
phaseData: {
  phaseName: string;              // Ex: "Backend Implementation"
  filesModified: string[];        // Lista de arquivos
  implementations: string[];      // Lista de implementações
  testFiles?: {                   // Testes adicionados
    file: string;
    count: number;
  }[];
  testCoverage?: number;          // Ex: 95
  technicalDecisions?: string[];  // Decisões técnicas
  nextPhase?: string;             // Próxima fase
  timestamp?: string;             // Timestamp
}
```

**Retorno:**
```typescript
{
  commentId: string;
  success: boolean;
  formattedComment: string;  // Para referência/logging
}
```

**Uso:**
```typescript
const result = await commentPhaseCompletion(
  "86abc123",  // subtaskId
  {
    phaseName: "Backend Implementation",
    filesModified: ["src/auth/service.ts", "src/auth/routes.ts"],
    implementations: ["JWT auth", "Refresh tokens"],
    testCoverage: 95
  }
);
```

---

### 2. Atualizar Status da Subtask

#### `updateSubtaskStatus(subtaskId, status)`

**Responsabilidade**: Atualizar status de uma subtask de forma confiável.

**Parâmetros:**
```typescript
subtaskId: string;      // ID da subtask
status: "to do" | "in progress" | "done" | "closed";
```

**Retorno:**
```typescript
{
  success: boolean;
  previousStatus: string;
  newStatus: string;
}
```

**Uso:**
```typescript
await updateSubtaskStatus("86abc123", "done");
```

---

### 3. Comentário Resumido na Task Principal

#### `commentProgressUpdate(mainTaskId, progressData)`

**Responsabilidade**: Criar comentário executivo na task principal.

**Parâmetros:**
```typescript
progressData: {
  currentPhase: number;      // Ex: 2
  totalPhases: number;       // Ex: 4
  phaseName: string;         // Ex: "Backend Implementation"
  subtaskId: string;         // Para referenciar
  nextPhaseName?: string;    // Ex: "Frontend Integration"
  timestamp?: string;
}
```

**Retorno:**
```typescript
{
  commentId: string;
  success: boolean;
}
```

**Uso:**
```typescript
await commentProgressUpdate(
  "86abc000",  // mainTaskId
  {
    currentPhase: 1,
    totalPhases: 4,
    phaseName: "Backend Implementation",
    subtaskId: "86abc123",
    nextPhaseName: "Frontend Integration"
  }
);
```

---

### 4. Validação de Critérios de Aceitação

#### `validateAcceptanceCriteria(taskId)`

**Responsabilidade**: Extrair e validar checkboxes de aceitação da task.

**Retorno:**
```typescript
{
  isComplete: boolean;
  coverage: number;           // Ex: 85.7
  completedCriteria: number;  // Ex: 6
  totalCriteria: number;      // Ex: 7
  criteria: {
    text: string;
    completed: boolean;
  }[];
  pendingCriteria: string[];  // Lista de critérios não completos
}
```

**Uso:**
```typescript
const validation = await validateAcceptanceCriteria("86abc000");

if (!validation.isComplete) {
  console.log(`Faltam: ${validation.pendingCriteria.join(", ")}`);
}
```

---

### 5. Comentário de Validação Pre-PR

#### `commentPrePRValidation(taskId, validationData)`

**Responsabilidade**: Adicionar comentário de validação antes do PR.

**Parâmetros:**
```typescript
validationData: {
  acceptanceCriteriaCompleted: boolean;
  criteriaCount: number;              // Ex: 7/7
  metaspecsCompliant: boolean;
  codeReviewDone: boolean;
  documentationUpdated: boolean;
  testsCoverage: number;              // Ex: 95
  lintErrors: number;
  readyForPR: boolean;
  timestamp?: string;
}
```

**Retorno:**
```typescript
{
  success: boolean;
  commentId: string;
  tagged: boolean;  // Se adicionou tag 'ready-for-pr' ou 'needs-fixes'
}
```

**Uso:**
```typescript
await commentPrePRValidation("86abc000", {
  acceptanceCriteriaCompleted: true,
  criteriaCount: 7,
  metaspecsCompliant: true,
  codeReviewDone: true,
  documentationUpdated: true,
  testsCoverage: 98,
  lintErrors: 0,
  readyForPR: true
});
```

---

### 6. Comentário de PR Criada

#### `commentPRCreated(taskId, prData)`

**Responsabilidade**: Documentar criação de PR na task.

**Parâmetros:**
```typescript
prData: {
  prUrl: string;               // Link do PR
  branch: string;              // Nome da branch
  changesDescription: string;  // Descrição das mudanças
  testsStatus: "passing" | "failing" | "not-run";
  timestamp?: string;
}
```

**Retorno:**
```typescript
{
  success: boolean;
  commentId: string;
}
```

---

### 7. Comentário de PR Atualizada

#### `commentPRUpdated(taskId, updateData)`

**Responsabilidade**: Documentar atualização de PR existente.

**Parâmetros:**
```typescript
updateData: {
  commitType: "fix" | "feat" | "docs" | "refactor" | "style" | "test" | "chore";
  commitHash: string;
  filesModified: number;
  linesAdded: number;
  linesRemoved: number;
  description: string;
  status: "ready-for-review" | "awaiting-fixes";
  timestamp?: string;
}
```

**Retorno:**
```typescript
{
  success: boolean;
  commentId: string;
}
```

---

## 🔄 Fluxo de Integração

### Como Usar Nos Comandos

#### Antes (Acoplado):
```markdown
# /engineer/work.md

const detailedComment = `🔧 FASE COMPLETADA: ...`;
await mcp_clickup_create_task_comment({...});
```

#### Depois (Desacoplado):
```markdown
# /engineer/work.md

Ao completar uma fase, o wrapper automaticamente:
- Cria comentário detalhado na subtask
- Atualiza status para "done"
- Cria comentário resumido na task principal

Chamada simples:
\`\`\`
commentPhaseCompletion(subtaskId, phaseData)
\`\`\`
```

---

## 📊 Benefícios de Usar Wrappers

### ✅ Quando MCP muda:
```
ANTES (Acoplado):
- Altera engineer/work.md ❌
- Altera engineer/pr.md ❌
- Altera engineer/pre-pr.md ❌
- Altera engineer/pr-update.md ❌
- Altera product/task.md ❌
- Risco altíssimo de inconsistência!

DEPOIS (Centralizado):
- Altera APENAS: clickup-mcp-wrappers.md ✅
- Todos os comandos automaticamente usam nova versão
- Sem risco de inconsistência
```

### ✅ Quando descobre novo padrão:
```
ANTES:
- Precisa atualizar em 4+ lugares
- Risco de deixar algum para trás

DEPOIS:
- Atualiza apenas na fonte
- Todos os comandos herdam mudança
```

### ✅ Testabilidade:
```
ANTES:
- Testar padrão de comentário em 5 comandos

DEPOIS:
- Testar uma vez na abstração
- Confiança que todos os comandos usam padrão testado
```

---

## 🧪 Testes de Validação

### Teste 1: Formato Consistente

Validar que todos os comentários seguem padrão:

```typescript
test("Todos os comentários têm separadores consistentes", () => {
  const comment = generateDetailedPhaseComment({...});
  expect(comment).toMatch(/━━━━━━━━━━━━━━/);  // Novo tamanho
  expect(comment).not.toMatch(/━{34}/);       // Não usa tamanho antigo
});
```

### Teste 2: Integridade dos Dados

Validar que informações não são perdidas:

```typescript
test("Todas as informações de fase são incluídas", () => {
  const phaseData = {
    phaseName: "Backend",
    filesModified: ["file1.ts", "file2.ts"],
    implementations: ["impl1", "impl2"],
    testCoverage: 95
  };
  const comment = await commentPhaseCompletion(...);
  expect(comment).toContain("Backend");
  expect(comment).toContain("file1.ts");
  expect(comment).toContain("95%");
});
```

---

## 🎯 Próximos Passos

1. **Criar abstrações** - Implementar em `.cursor/utils/clickup-mcp-wrappers.md`
2. **Refatorar comandos** - Remover acoplamento de cada comando
3. **Atualizar documentação** - Remover exemplos de implementação
4. **Validar** - Testar que tudo funciona
5. **Documentar padrões** - Colocar em `.cursor/docs/strategies/`

---

## 📚 Relacionado

- [Acoplamento ClickUp - Análise](./acoplamento-clickup-problema-analise.md)
- [Estratégias de Comentários](../docs/strategies/clickup-comment-patterns.md)
- [Dual Comment Strategy](../docs/clickup/clickup-dual-comment-strategy.md)

---

**Status**: Definição de arquitetura de wrappers  
**Prioridade**: ALTA  
**Impacto**: Reduz acoplamento, melhora manutenibilidade  
**Esforço**: Médio (3-5 horas para implementação)

