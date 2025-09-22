
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
- **Atualização do plan.md** com status e decisões
- **Progresso % estimado** baseado nas fases concluídas
- **Timestamp de atividade** para tracking temporal

### **💬 Formato do Comentário de Progresso:**
```
🔧 PROGRESSO DE DESENVOLVIMENTO

━━━━━━━━━━━━━━━━━━━━━━━━

📋 FASE COMPLETADA:
   ▶ [Nome da Fase]
   ▶ Arquivos modificados: [N] arquivos
   ▶ Funcionalidades: [Lista implementada]
   ▶ Testes: [Testes adicionados/atualizados]

✅ DECISÕES TÉCNICAS:
   ∟ [Decisões importantes tomadas]
   ∟ [Patterns utilizados]
   ∟ [Bibliotecas adicionadas]

🚀 PRÓXIMA FASE:
   ▶ [Nome da próxima fase]
   ▶ Estimativa: [Tempo estimado]
   ▶ Bloqueadores: [Se houver]

📊 PROGRESSO GERAL: [X]% completo ([Y]/[Z] fases)

━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Atualização: [TIMESTAMP] | 🎯 Próximo: [Próxima ação]
```

### **📋 Identificação da Task:**
1. **Context.md**: Lê task-id do arquivo de contexto da sessão
2. **Sessão ativa**: Detecta automaticamente a sessão em `.cursor/sessions/`

## Importante:

Quando você desenvolver o código para a fase atual, use os sub-agentes de desenvolvimento, code-review e teste quando apropriado para preservar o máximo possível do seu contexto.
Toda vez que completar uma fase do plano:
- **AUTO-UPDATE**: Adicione comentário de progresso no ClickUp automaticamente
- Pause e peça ao usuário para validar seu código.
- Faça as mudanças necessárias até ser aprovado
- Atualize a fase correspondente no arquivo plan.md marcando o que foi feito e adicionando comentários úteis para o desenvolvedor que abordará as próximas fases, especialmente sobre questões, decisões, etc.
- Apenas inicie a próxima fase após o usuário concordar que você deve começar. Quando iniciar a próxima fase, atualize o arquivo plan.md marcando a nova fase como em progresso.

Agora, veja a fase atual de desenvolvimento e forneça um plano ao usuário sobre como abordá-la. 

