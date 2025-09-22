# 🔄 Contexto - Comando Sync

**Task Principal**: 86ac06261 - Comando Sync - Sincronização Automática de Branches  
**Feature Branch**: feature/sync-command  
**Timeline**: 1-2 dias de desenvolvimento  

---

## 🎯 **Entendimento do Projeto**

### **Por que esta task é importante?**
Atualmente, após merge de PRs no Sistema Onion, é necessário realizar manualmente:
1. Checkout para branch principal (main/develop)
2. Pull das mudanças  
3. Limpeza de branches locais
4. Atualização de tasks ClickUp para "Done"

Este processo manual é propenso a erros e quebra o fluxo de desenvolvimento otimizado.

### **O que será implementado?**
Um comando `/git/sync [branch-name]` que automatiza completamente a sincronização pós-merge:
- **Operações Git**: checkout, pull, cleanup de branches
- **Integração ClickUp**: atualização automática de status e comentários
- **Gestão de Sessões**: arquivamento opcional de sessões concluídas
- **Tratamento de Erros**: validações e orientações para resolução

### **Como se encaixa no Sistema Onion?**
Complementa o workflow existente:
- `/product/task` → `/engineer/start` → `/engineer/work` → `/engineer/pr` → **`/git/sync`**

---

## 📋 **Subtasks Identificadas**

### **1. Estrutura do Comando (2-3h)**
- ✅ Criar `.cursor/commands/git/sync.md`
- ✅ Documentar sintaxe e parâmetros
- ✅ Definir formato de saída
- ✅ Integrar com sistema de comandos

### **2. Lógica de Detecção (2-3h)**
- ✅ Identificar branch atual
- ✅ Detectar task ClickUp ativa via sessão
- ✅ Validar estado do repositório git
- ✅ Verificar mudanças não commitadas

### **3. Operações Git (3-4h)**
- ✅ Implementar sequência: fetch → checkout → pull
- ✅ Limpeza de branch anterior
- ✅ Tratamento de conflitos e erros
- ✅ Logs informativos

### **4. Integração ClickUp (2-3h)**
- ✅ Mover task para status "Done"
- ✅ Adicionar comentário formatado
- ✅ Limpar tags (in-progress, under-review)
- ✅ Timestamp de conclusão

### **5. Gestão de Sessões (1-2h)**
- ✅ Detectar sessão ativa
- ✅ Arquivar arquivos importantes
- ✅ Limpeza de temporários
- ✅ Preservar context.md, notes.md

### **6. Tratamento de Erros (2-3h)**
- ✅ Mudanças não commitadas
- ✅ Branch inexistente
- ✅ Conflitos de merge
- ✅ Problemas de rede
- ✅ Estados inconsistentes

---

## 🎯 **Success Metrics**

### **Funcionalidade**
- ✅ Comando funciona com `/git/sync` (develop padrão)
- ✅ Aceita parâmetro `/git/sync main`
- ✅ 100% de operações git executadas corretamente
- ✅ Atualização ClickUp automática

### **Usabilidade**
- ✅ Tempo total de sync < 30 segundos
- ✅ Mensagens de erro claras e acionáveis
- ✅ Logs informativos para debugging
- ✅ Experiência consistente com outros comandos

### **Integração**
- ✅ Compatibilidade total com workflow existente
- ✅ Preservação de dados importantes
- ✅ Funcionamento em diferentes cenários git
- ✅ Suporte a múltiplas branches principais

### **Qualidade**
- ✅ Código seguindo padrões do Sistema Onion
- ✅ Documentação completa
- ✅ Tratamento robusto de edge cases
- ✅ Testes manuais em cenários diversos

---

## 🏗️ **Decisões Arquiteturais**

### **Localização do Comando**
- **Decisão**: `.cursor/commands/git/sync.md`
- **Justificativa**: Agrupa comandos git relacionados
- **Alternativas consideradas**: `.cursor/commands/engineer/` (muito específico)
- **Impacto**: Facilita descoberta e organização

### **Detecção de Contexto**
- **Sessão Ativa**: Via `.cursor/sessions/*/context.md`
- **Task ID**: Extraído do context.md da sessão
- **Branch Atual**: Via `git branch --show-current`
- **Repository State**: Via `git status --porcelain`

### **Parâmetros de Comando**
- **Sintaxe**: `/git/sync [branch-name]`
- **Padrão**: `develop` se não especificado
- **Validação**: Verificar se branch existe remotamente
- **Flexibilidade**: Suporte a main, master, develop, staging

### **Auto-Update ClickUp**
- **Trigger**: Apenas quando sync completo com sucesso
- **Status**: Mover para "Done" automaticamente
- **Tags**: Remover "in-progress", "under-review"
- **Comentário**: Formato padronizado com detalhes técnicos

### **Gestão de Erros**
- **Mudanças não commitadas**: Avisar e sugerir `git stash`
- **Conflitos**: Orientar resolução manual
- **Rede**: Detectar problemas de conectividade
- **Rollback**: Não fazer mudanças destrutivas sem validação

---

## 🔧 **Tecnologias e Ferramentas**

### **Core Technologies**
- **Git CLI**: Para todas as operações git
- **ClickUp MCP**: Para integração com tasks
- **Bash Scripting**: Para lógica de comando
- **Sistema Onion**: Para padrões e integração

### **Dependências**
- **Git**: Repositório deve estar configurado
- **ClickUp**: Credenciais MCP configuradas  
- **Session**: Estrutura `.cursor/sessions/` ativa
- **Network**: Conectividade para pull/fetch

### **Ferramentas de Debug**
- **Git Status**: Validação de estado
- **Git Log**: Verificação de commits
- **ClickUp API**: Validação de updates
- **Logging**: Mensagens informativas

---

## 📝 **Notas de Desenvolvimento**

### **Prioridades de Implementação**
1. **MVP**: Operações git básicas funcionando
2. **Integração**: ClickUp updates automáticos
3. **Polish**: Tratamento de erros e edge cases
4. **Documentation**: Exemplos e troubleshooting

### **Casos de Teste**
- **Cenário 1**: Sync normal após merge bem-sucedido
- **Cenário 2**: Sync com mudanças locais não commitadas
- **Cenário 3**: Sync sem sessão ativa
- **Cenário 4**: Sync com conflitos remotos
- **Cenário 5**: Sync sem conectividade

### **Riscos e Mitigações**
- **Risco**: Perda de trabalho local → Validação antes de operações
- **Risco**: Estado inconsistente → Operações atômicas
- **Risco**: Falha ClickUp → Continuar operações git
- **Risco**: Branch inexistente → Validação prévia

---

**Status**: ✅ CONTEXTO DEFINIDO - Pronto para arquitetura técnica  
**Próximo**: Criar `architecture.md` e definir implementação detalhada
