# Pre-PR

Estamos nos aproximando de finalizar o trabalho nesta branch e nos preparar para um pull request. Agora, é hora de fazer verificações finais e limpezas para garantir que estamos alinhados com nossos padrões e objetivos.

## 🔄 **Auto-Update ClickUp**

Este comando **automaticamente atualiza** a task ClickUp durante preparação para PR:

### **✅ Updates Automáticos SEMPRE:**
- **Comentário de preparação** com checklist completo
- **Tag 'ready-for-pr'** quando todas verificações passam
- **Tag 'needs-fixes'** se verificações falham
- **Progresso estimado** para 90% (quase pronto)

### **💬 Formato do Comentário de Pre-PR:**
```
🔍 PREPARAÇÃO PARA PULL REQUEST

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

✅ VERIFICAÇÕES REALIZADAS:
   ◆ Meta-specs compliance: [✅/❌]
   ◆ Code review: [✅/❌]
   ◆ Documentation updated: [✅/❌]
   ◆ Tests coverage: [✅/❌]

📊 QUALIDADE DO CÓDIGO:
   ∟ Lint errors: [N] encontrados
   ∟ Test coverage: [X]%
   ∟ Documentation: [Atualizada/Pendente]

🔧 CORREÇÕES APLICADAS:
   ∟ [Lista das correções feitas]

🚀 STATUS PARA PR:
   ∟ [PRONTO/REQUER_AJUSTES]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Preparação: [TIMESTAMP] | 🎯 Próximo: Abrir Pull Request
```

### **📋 Identificação da Task:**
1. **Context.md**: Lê task-id da sessão ativa
2. **Branch atual**: Detecta automaticamente pela branch git

## Checklist de Preparação:

1. Invoque o agente `branch-metaspec-checker` para verificar se a branch está alinhada com as meta specs do projeto.
2. Invoque o agente `branch-code-reviewer` para revisar o código e garantir que está bom para lançar.
3. Invoque o agente `branch-documentation-writer` para atualizar a documentação do projeto.
4. Invoque o agente `branch-test-planner` para finalizar a escrita de testes para a branch.
5. **AUTO-UPDATE**: Adicione comentário de preparação no ClickUp automaticamente

Você também precisará lidar com todo o feedback que esses agentes fornecerem e fazer mudanças e correções conforme necessário.

Uma vez terminado, me avise e peça minha permissão para abrir o Pull Request.

