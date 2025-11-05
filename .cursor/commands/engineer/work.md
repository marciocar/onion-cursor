
# Engineer Work

Estamos atualmente trabalhando em uma funcionalidade que está especificada na seguinte pasta:

<folder>
#$ARGUMENTS
</folder>

Para trabalhar nisso, você deve:

- Ler todos os arquivos markdown na pasta
- Revisar o arquivo plan.md e identificar qual Fase está atualmente em progresso
- Apresentar ao usuário um plano para abordar a próxima fase

## 🔄 **Auto-Update ClickUp**

Este comando **automaticamente atualiza** a task ClickUp durante desenvolvimento:

### **✅ Updates Automáticos A CADA FASE:**
- **Comentário de progresso** quando fase é completada
- **SUBTASK STATUS UPDATE** - Atualiza status da subtask correspondente para "done"
- **Atualização do plan.md** com status e decisões
- **Progresso % estimado** baseado nas fases concluídas
- **Timestamp de atividade** para tracking temporal

### **🔗 CRITICAL: Phase→Subtask Mapping**
**OBRIGATÓRIO**: Quando uma fase é completada, o sistema deve:
1. **Identificar subtask correspondente** via mapeamento estabelecido no context.md
2. **Atualizar status da subtask** para "done" automaticamente
3. **Documentar conclusão** com timestamp e métricas da fase

### **💬 Estratégia DUAL de Comentários:**

**IMPORTANTE**: Padrões de comentários centralizados em `.cursor/docs/strategies/clickup-comment-patterns.md`

Ao completar uma fase, o sistema automaticamente:

1. **Cria comentário DETALHADO na SUBTASK** (Padrão 1: Fase Completada)
   - Referência: Padrão 1 em clickup-comment-patterns.md
   - Use abstração: `commentPhaseCompletion()` de clickup-mcp-wrappers.md

2. **Cria comentário RESUMIDO na TASK PRINCIPAL** (Padrão 2: Progress Update)
   - Referência: Padrão 2 em clickup-comment-patterns.md
   - Use abstração: `commentProgressUpdate()` de clickup-mcp-wrappers.md

Para templates exatos, consulte:
- `.cursor/docs/strategies/clickup-comment-patterns.md` (padrões + exemplos)
- `.cursor/utils/clickup-mcp-wrappers.md` (abstrações MCP)

### **📋 Identificação da Task:**
1. **Context.md**: Lê task-id do arquivo de contexto da sessão
2. **Sessão ativa**: Detecta automaticamente a sessão em `.cursor/sessions/`
3. **🆕 PHASE-SUBTASK MAPPING**: Lê mapeamento de context.md para correlacionar fases→subtasks

### **🗺️ SUBTASK MAPPING STRUCTURE (context.md):**
```markdown
## 📋 Phase-Subtask Mapping
- **Phase 1**: "Template Consolidation" → Subtask ID: [subtask-id-1]
- **Phase 2**: "Feature Commands" → Subtask ID: [subtask-id-2] 
- **Phase 3**: "Release Commands" → Subtask ID: [subtask-id-3]
- **Phase 4**: "Hotfix Commands" → Subtask ID: [subtask-id-4]
```

### **⚡ AUTOMATIC EXECUTION (Estratégia Dual):**
Quando uma fase é marcada como "Completada ✅" no plan.md, o sistema deve **EXECUTAR NESTA ORDEM**:

1. **Ler mapeamento** do context.md (Phase→Subtask)
2. **Identificar subtask** correspondente àquela fase
3. **Comentário DETALHADO na SUBTASK**:
   ```typescript
   await mcp_clickup_create_task_comment({
     task_id: subtaskId,  // ← ID da SUBTASK
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
   ```
4. **Atualizar STATUS da SUBTASK**:
   ```typescript
   await mcp_clickup_update_task({
     task_id: subtaskId,  // ← ID da SUBTASK
     workspace_id: workspaceId,
     status: 'Done'
   });
   ```
5. **Comentário RESUMIDO na TASK PRINCIPAL**:
   ```typescript
   await mcp_clickup_create_task_comment({
     task_id: mainTaskId,  // ← ID da TASK PRINCIPAL
     workspace_id: workspaceId,
     comment_text: generateSummaryComment({
       phaseNum,
       totalPhases,
       phaseName,
       subtaskId,
       nextPhaseName
     })
   });
   ```

**📚 Documentação completa**: `.cursor/docs/clickup/clickup-dual-comment-strategy.md`

## Importante:

Quando você desenvolver o código para a fase atual, use os sub-agentes de desenvolvimento, code-review e teste quando apropriado para preservar o máximo possível do seu contexto.
Toda vez que completar uma fase do plano:
- **AUTO-UPDATE**: Adicione comentário de progresso no ClickUp automaticamente
- **RASTREAMENTO**: Marque checkboxes na description correspondentes aos critérios completados
  * Os checkboxes são **interativos** - clique para marcar `[x]`
  * Atualiza description com progresso visual
  * Facilita visão geral da completude
- Pause e peça ao usuário para validar seu código.
- Faça as mudanças necessárias até ser aprovado
- Atualize a fase correspondente no arquivo plan.md marcando o que foi feito e adicionando comentários úteis para o desenvolvedor que abordará as próximas fases, especialmente sobre questões, decisões, etc.
- Apenas inicie a próxima fase após o usuário concordar que você deve começar. Quando iniciar a próxima fase, atualize o arquivo plan.md marcando a nova fase como em progresso.

Agora, veja a fase atual de desenvolvimento e forneça um plano ao usuário sobre como abordá-la. 

