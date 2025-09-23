# 🎯 Context - Refatoração /git/sync com GitFlow Specialist

## 📋 Task Principal
**Task Principal**: 86ac0zjnn - Refatoração GitFlow + Correção de Comandos

## 🌿 Feature Branch
**Branch**: `feature/gitflow-sync-refactor`  
**Status**: ✅ Criada e ativa

## ⏰ Timeline
**Estimativa**: 11 horas total distribuídas em 4 sprints (escopo expandido)
**Início**: 2025-01-23
**Prioridade**: Alta (Sistema Onion Core - GitFlow Ecosystem)

## 🎯 Entendimento do Projeto

### **Por que refatorar + corrigir?**
**PROBLEMA DUPLO IDENTIFICADO:**
1. `/git/sync` funcional mas sem integração @gitflow-specialist
2. `/git/feature/start` **INCORRETO** - cria tasks ClickUp em vez de GitFlow

**BENEFÍCIOS DA SOLUÇÃO INTEGRADA:**
- ✅ **Ecossistema GitFlow** completo e consistente  
- ✅ **Separação clara**: planejamento vs desenvolvimento
- ✅ **Guidance especializada** em todos comandos GitFlow
- ✅ **Workflow intuitivo** e padronizado

### **O que estamos construindo?**
**SOLUÇÃO TRIPLA INTEGRADA:**

1. **Refatoração /git/sync** (original):
   - Delegação @gitflow-specialist para guidance
   - Nova Fase 2.5 - GitFlow Analysis
   - Compatibilidade total mantida
   
2. **Correção /git/feature/start** (crítica):
   - GitFlow real (`git flow feature start` + guidance)  
   - Branch creation + session setup
   - Integração @gitflow-specialist
   
3. **Novo /product/feature** (movimentação):
   - Código atual de `/git/feature/start` preservado
   - Localização: `.cursor/commands/product/feature.md`
   - Função: Criação tasks ClickUp para planejamento

### **Como será implementado?**
**ARQUITETURA INTEGRADA:**

```mermaid
graph TD
    A[/product/feature] --> B[Task ClickUp Backlog]
    B --> C[Planejamento]
    C --> D[/git/feature/start] 
    D --> E[@gitflow-specialist]
    E --> F[Branch GitFlow + Session]
    F --> G[/git/sync com GitFlow guidance]
```

**WORKFLOW SEQUENCIAL:**
1. `/product/feature "nome"` → Cria task planejamento
2. `/git/feature/start "nome"` → Inicia GitFlow  
3. `/git/sync` → Finaliza com guidance

## 📊 Subtasks Identificadas

### **Sprint 1: Análise e Preparação (2h)**
- [ ] Análise detalhada do código atual `/git/sync`
- [ ] Mapeamento de integração com @gitflow-specialist  
- [ ] Estudo dos padrões product/engineer existentes
- [ ] Design da nova interface de comando

### **Sprint 2: Integração GitFlow (4h)**
- [ ] Implementar delegação para @gitflow-specialist
- [ ] Criar interface de comunicação agente ↔ comando
- [ ] Desenvolver análise de branch strategy automática
- [ ] Integrar validação GitFlow compliance

### **Sprint 3: Refatoração Core (3h)** 
- [ ] Adaptar operações Git para usar guidance GitFlow
- [ ] Implementar novo padrão de interface product/engineer
- [ ] Manter compatibilidade com funcionalidades existentes
- [ ] Otimizar performance das operações

### **Sprint 4: Testes e Documentação (2h)**
- [ ] Testes unitários para nova integração
- [ ] Testes de integração com @gitflow-specialist
- [ ] Atualizar documentação do comando
- [ ] Criar exemplos de uso refatorado

## 🎯 Success Metrics

### **Critérios de Sucesso**
- **Integração GitFlow**: Comando delega automaticamente e aplica validações
- **Padrão Product/Engineer**: Interface consistente e workflows organizados
- **Compatibilidade**: Todas funcionalidades existentes mantidas
- **Performance**: ≤ 5s para 95% das operações
- **Qualidade**: Testes ≥ 80%, zero linting errors

### **Indicadores de Qualidade**
- **Adoption Rate**: 100% uso da nova versão
- **Error Rate**: ≤ 2% falhas em operações
- **GitFlow Compliance**: 95% operações seguem padrões
- **User Satisfaction**: Feedback positivo em testes

## 🔄 Decisões Arquiteturais

### **1. Integração com @gitflow-specialist**
**Decisão**: Usar delegação automática em vez de importar lógica
**Rationale**: Mantém separação de responsabilidades e expertise especializada

### **2. Compatibilidade com Versão Atual**
**Decisão**: Manter 100% das funcionalidades existentes
**Rationale**: Evitar breaking changes e garantir transição suave

### **3. Padrão de Interface**
**Decisão**: Seguir padrões product/engineer estabelecidos
**Rationale**: Consistência no Sistema Onion e UX familiar

### **4. Estratégia de Testes**
**Decisão**: Testes de integração com @gitflow-specialist obrigatórios
**Rationale**: Garantir qualidade da nova funcionalidade core

## 📁 Estrutura de Arquivos

### **Arquivos Principais**
- `.cursor/commands/git/sync.md` - Versão atual (backup)
- `.cursor/commands/git/sync-refactored.md` - Nova versão
- `.cursor/agents/development/gitflow-specialist.md` - Agente (existente)

### **Sessão de Desenvolvimento**
- `.cursor/sessions/gitflow-sync-refactor/context.md` - Este arquivo
- `.cursor/sessions/gitflow-sync-refactor/plan.md` - Plano de implementação
- `.cursor/sessions/gitflow-sync-refactor/notes.md` - Notas de desenvolvimento

## 🔗 Links e Referências

- **ClickUp Task**: https://app.clickup.com/t/86ac0zjnn
- **Feature Branch**: `feature/gitflow-sync-refactor`
- **Comando Atual**: `.cursor/commands/git/sync.md`
- **Agente GitFlow**: `.cursor/agents/development/gitflow-specialist.md`

---

**Status**: ✅ PRONTO PARA DESENVOLVIMENTO  
**Próximo Passo**: Executar `/engineer/start gitflow-sync-refactor`
