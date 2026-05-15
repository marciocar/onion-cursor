# 🔄 Estratégia Dual de Comentários - Task vs Subtask

## 🎯 Objetivo

Manter **contexto técnico detalhado nas subtasks** e **resumo executivo na task principal**, garantindo rastreabilidade completa e comunicação eficiente para diferentes audiências.

---

## 📋 Problema Identificado

### Comportamento Anterior (❌ Incorreto):
```
📋 Task Principal (ID: 123)
└── 💬 Comentário detalhado aqui (na task principal)
    - Arquivos modificados
    - Decisões técnicas
    - Testes implementados

├── 🔧 Subtask 1: Backend Implementation (ID: 456)
│   └── (Sem comentário) ❌
```

**Problemas:**
- ❌ Contexto técnico perdido na task principal
- ❌ Subtask não tem histórico de implementação
- ❌ Difícil rastrear decisões específicas por componente
- ❌ Product Owners veem detalhes técnicos desnecessários

---

## ✅ Solução Implementada

### Comportamento Correto:

```
📋 Task Principal (ID: 123)
└── 💬 Comentário RESUMIDO (nota executiva)
    "✅ Fase 1/4 completada - Backend Implementation
     🎯 Próximo: Fase 2 - Frontend Integration"

├── 🔧 Subtask 1: Backend Implementation (ID: 456)
│   └── 💬 Comentário DETALHADO (técnico completo)
│       - Arquivos modificados: 15 arquivos
│       - Decisões técnicas: JWT, bcrypt, etc
│       - Testes: 20 testes, 95% cobertura
│       - Status: Done ✅
```

**Benefícios:**
- ✅ Contexto técnico preservado na subtask
- ✅ Visão executiva clara na task principal
- ✅ Rastreabilidade completa por componente
- ✅ Comunicação eficiente para diferentes audiências

---

## 📚 Quando Usar Cada Tipo

### 💬 Comentário DETALHADO (Subtask)

**Quando:**
- Fase/componente específico completado
- Implementação técnica realizada
- Decisões de arquitetura tomadas
- Testes adicionados
- Refatoração executada

**Audiência:**
- Desenvolvedores
- Tech Leads
- Code Reviewers

**Conteúdo:**
- Arquivos modificados (lista completa)
- Implementações realizadas (detalhes técnicos)
- Testes adicionados (cobertura, arquivos)
- Decisões técnicas (justificativas)
- Próximos passos (ações específicas)

---

### 📝 Comentário RESUMIDO (Task Principal)

**Quando:**
- Progresso geral da feature
- Milestone alcançado
- Status update executivo
- Mudança de fase

**Audiência:**
- Product Owners
- Stakeholders
- Project Managers

**Conteúdo:**
- Fase completada (número e nome)
- Link para subtask (onde estão os detalhes)
- Próxima fase (o que vem a seguir)
- Timestamp

---

## 🔧 Templates de Implementação

### Template 1: Comentário DETALHADO (Subtask)

```typescript
const detailedComment = `🔧 FASE COMPLETADA: ${phaseName}

━━━━━━━━━━━━━━━━

📁 ARQUIVOS MODIFICADOS:
   ∟ ${file1}
   ∟ ${file2}
   ∟ ${file3}
   ${moreFiles ? `∟ ... e mais ${moreFiles.length} arquivos` : ''}

🔧 IMPLEMENTAÇÕES:
   ▶ ${implementation1}
   ▶ ${implementation2}
   ▶ ${implementation3}

✅ TESTES ADICIONADOS:
   ∟ ${testFile1} (${testCount1} testes)
   ∟ ${testFile2} (${testCount2} testes)
   ∟ Cobertura: ${coverage}%

💡 DECISÕES TÉCNICAS:
   ∟ ${decision1}
   ∟ ${decision2}
   ∟ ${decision3}

🚀 PRÓXIMOS PASSOS:
   ∟ ${nextPhase}
   ∟ ${nextAction1}
   ∟ ${nextAction2}

━━━━━━━━━━━━━━━━

⏰ Completado: ${timestamp} | 🎯 Status: Done`;
```

### Template 2: Comentário RESUMIDO (Task Principal)

```typescript
const summaryComment = `📝 PROGRESSO: Fase ${phaseNum}/${totalPhases} Completada

✅ ${phaseName} - Concluída
   ∟ Subtask: #${subtaskId}
   ∟ Detalhes: Ver comentário na subtask

🎯 Próximo: Fase ${nextPhaseNum} - ${nextPhaseName}

⏰ ${timestamp}`;
```

---

## 📊 Fluxo de Atualização

### Sequência Correta:

```typescript
// 1. Comentário DETALHADO na SUBTASK
await mcp_clickup_create_task_comment({
  task_id: subtaskId,
  workspace_id: workspaceId,
  comment_text: generateDetailedComment({
    phaseName,
    filesModified,
    implementations,
    tests,
    decisions,
    nextSteps
  })
});

// 2. Atualizar STATUS da SUBTASK
await mcp_clickup_update_task({
  task_id: subtaskId,
  workspace_id: workspaceId,
  status: 'Done'
});

// 3. Comentário RESUMIDO na TASK PRINCIPAL
await mcp_clickup_create_task_comment({
  task_id: mainTaskId,
  workspace_id: workspaceId,
  comment_text: generateSummaryComment({
    phaseNum,
    totalPhases,
    phaseName,
    subtaskId,
    nextPhaseNum,
    nextPhaseName
  })
});
```

---

## 🗺️ Mapeamento Fase → Subtask

### Estrutura Necessária no `context.md`:

```markdown
## 🗺️ Phase → Subtask Mapping

**Main Task ID**: 86abc000

| Fase | Subtask ID | Subtask Name | Status |
|------|------------|--------------|--------|
| 1 | 86abc123 | Backend Implementation | done |
| 2 | 86abc124 | Frontend Integration | in progress |
| 3 | 86abc125 | Testing & QA | to do |
| 4 | 86abc126 | Documentation | to do |
```

### Como Usar no Código:

```typescript
// Ler mapeamento do context.md
const mapping = parsePhaseSubtaskMapping(contextMd);

// Obter subtask da fase atual
const currentPhase = identifyCurrentPhase(planMd);
const subtaskInfo = mapping[currentPhase];

// Usar IDs corretos
const subtaskId = subtaskInfo.subtaskId;
const mainTaskId = mapping.mainTaskId;
```

---

## 📝 Comandos Afetados

### 1. `/engineer/work` (CRÍTICO)

**Mudança:**
- ❌ Antes: Comentário na task principal
- ✅ Depois: Comentário detalhado na subtask + resumo na task principal

**Implementação:**
```typescript
// Ao completar fase
await updateSubtaskWithDetails(subtaskId, phaseDetails);
await updateMainTaskWithSummary(mainTaskId, phaseSummary);
```

---

### 2. `/engineer/start` (Opcional)

**Mudança:**
- Comentário inicial pode ir na task principal (é setup, não implementação)
- Se houver subtasks pré-criadas, adicionar comentário de início em cada uma

**Implementação:**
```typescript
// Comentário de início na task principal
await create_task_comment({
  task_id: mainTaskId,
  comment_text: `🚀 DESENVOLVIMENTO INICIADO
  
  ━━━━━━━━━━━━━━━━━━━━━━━━
  
  🏗️ SESSÃO ATIVADA:
     ▶ Branch: ${branch}
     ▶ Sessão: ${sessionPath}
     ▶ Arquitetura: Definida
  
  📋 PLANO: ${totalPhases} fases
  
  ━━━━━━━━━━━━━━━━━━━━━━━━
  
  ⏰ ${timestamp}`
});
```

---

### 3. `/engineer/pr` (Manter Atual)

**Comportamento:**
- Comentário vai na task principal (é ação global da feature)
- Não precisa mudar

---

### 4. `/product/task-check` (Novo Comportamento)

**Mudança:**
- Verificação de subtask → comentário na subtask
- Resumo geral → comentário na task principal

---

## 🎨 Exemplos Práticos

### Exemplo 1: Completar Fase de Backend

**Subtask (86abc123) - Comentário Detalhado:**
```
🔧 FASE COMPLETADA: Backend Implementation

━━━━━━━━━━━━━━━━

📁 ARQUIVOS MODIFICADOS:
   ∟ src/services/auth.service.ts
   ∟ src/controllers/auth.controller.ts
   ∟ src/middleware/jwt.middleware.ts
   ∟ src/models/user.model.ts
   ∟ src/routes/auth.routes.ts

🔧 IMPLEMENTAÇÕES:
   ▶ JWT generation e validation
   ▶ Refresh token mechanism
   ▶ Password hashing com bcrypt
   ▶ Error handling e logging
   ▶ Rate limiting para endpoints

✅ TESTES ADICIONADOS:
   ∟ auth.service.spec.ts (12 testes)
   ∟ auth.controller.spec.ts (8 testes)
   ∟ jwt.middleware.spec.ts (6 testes)
   ∟ Cobertura: 95%

💡 DECISÕES TÉCNICAS:
   ∟ Usamos jsonwebtoken v9.0.0 (mais recente)
   ∟ Access token: 15min, Refresh: 7 dias
   ∟ Bcrypt rounds: 10 (balanceamento perf/segurança)
   ∟ Rate limit: 5 tentativas/15min por IP

🚀 PRÓXIMOS PASSOS:
   ∟ Fase 2: Frontend Integration
   ∟ Criar AuthContext no React
   ∟ Implementar token storage seguro

━━━━━━━━━━━━━━━━

⏰ Completado: 2025-11-05 16:45 | 🎯 Status: Done
```

**Task Principal (86abc000) - Comentário Resumido:**
```
📝 PROGRESSO: Fase 1/4 Completada

✅ Backend Implementation - Concluída
   ∟ Subtask: #86abc123
   ∟ Detalhes: Ver comentário na subtask

🎯 Próximo: Fase 2 - Frontend Integration

⏰ 2025-11-05 16:45
```

---

### Exemplo 2: Completar Fase de Frontend

**Subtask (86abc124) - Comentário Detalhado:**
```
🔧 FASE COMPLETADA: Frontend Integration

━━━━━━━━━━━━━━━━

📁 ARQUIVOS MODIFICADOS:
   ∟ src/contexts/AuthContext.tsx
   ∟ src/hooks/useAuth.ts
   ∟ src/pages/Login.tsx
   ∟ src/components/ProtectedRoute.tsx
   ∟ src/services/api.service.ts

🔧 IMPLEMENTAÇÕES:
   ▶ AuthContext com React Context API
   ▶ useAuth hook customizado
   ▶ Login page com validação
   ▶ ProtectedRoute component
   ▶ Interceptor axios para token refresh

✅ TESTES ADICIONADOS:
   ∟ AuthContext.test.tsx (10 testes)
   ∟ useAuth.test.ts (8 testes)
   ∟ Login.test.tsx (12 testes)
   ∟ Cobertura: 92%

💡 DECISÕES TÉCNICAS:
   ∟ Token storage: localStorage (com encryption)
   ∟ Auto-refresh: 1min antes de expirar
   ∟ Redirect após login: dashboard
   ∟ Error handling: toast notifications

🚀 PRÓXIMOS PASSOS:
   ∟ Fase 3: Testing & QA
   ∟ E2E tests com Cypress
   ∟ Security audit

━━━━━━━━━━━━━━━━

⏰ Completado: 2025-11-06 10:30 | 🎯 Status: Done
```

**Task Principal (86abc000) - Comentário Resumido:**
```
📝 PROGRESSO: Fase 2/4 Completada

✅ Frontend Integration - Concluída
   ∟ Subtask: #86abc124
   ∟ Detalhes: Ver comentário na subtask

🎯 Próximo: Fase 3 - Testing & QA

⏰ 2025-11-06 10:30
```

---

## ✅ Benefícios por Audiência

### Para Desenvolvedores:
- ✅ Contexto técnico completo na subtask
- ✅ Histórico de decisões preservado
- ✅ Fácil code review (tudo documentado)
- ✅ Rastreabilidade de mudanças

### Para Product Owners:
- ✅ Visão executiva clara na task principal
- ✅ Progresso objetivo e mensurável
- ✅ Sem sobrecarga de detalhes técnicos
- ✅ Fácil comunicação com stakeholders

### Para Tech Leads:
- ✅ Visão completa em ambos os níveis
- ✅ Pode revisar detalhes técnicos quando necessário
- ✅ Pode reportar progresso executivo facilmente
- ✅ Melhor gestão de conhecimento

---

## 🔍 Troubleshooting

### Problema: Subtask ID não encontrado

**Causa:** Mapeamento fase→subtask não existe no context.md

**Solução:**
```typescript
// Verificar se mapeamento existe
if (!mapping[currentPhase]) {
  console.warn(`Mapeamento não encontrado para fase ${currentPhase}`);
  // Fallback: comentar apenas na task principal
  await create_task_comment({
    task_id: mainTaskId,
    comment_text: detailedComment
  });
}
```

---

### Problema: Task principal não tem ID

**Causa:** Context.md não tem mainTaskId

**Solução:**
```typescript
// Extrair do context.md
const mainTaskId = extractMainTaskId(contextMd);
if (!mainTaskId) {
  throw new Error('Main task ID not found in context.md');
}
```

---

## 📊 Métricas de Sucesso

### Indicadores de que está funcionando:

- ✅ Subtasks têm comentários detalhados
- ✅ Task principal tem comentários resumidos
- ✅ Desenvolvedores encontram contexto técnico facilmente
- ✅ POs conseguem reportar progresso sem detalhes técnicos
- ✅ Histórico completo de implementação preservado

---

## 🚀 Implementação

### Checklist de Comandos:

- [ ] `/engineer/work` - Implementar estratégia dual
- [ ] `/engineer/start` - Ajustar comentário inicial
- [ ] `/product/task-check` - Implementar estratégia dual
- [ ] Documentar em `.claude/docs/clickup/clickup-auto-update-strategy.md`
- [ ] Testar com task real
- [ ] Validar comentários em ambos os níveis

---

**Última atualização**: 2025-11-05  
**Status**: Documentado e pronto para implementação  
**Prioridade**: ALTA - Melhora significativa de UX

