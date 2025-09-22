# 🌿 Git Commands - Sistema Onion

Comandos especializados para operações Git integradas ao workflow do Sistema Onion.

---

## 📋 **Comandos Disponíveis**

### **🔄 `/git/sync [branch-name]`**
**Finalidade**: Sincronização automática pós-merge de branches  
**Descrição**: Automatiza o processo completo de sincronização após merge de PRs, incluindo checkout, pull, limpeza de branches e atualização ClickUp.

#### **Uso:**
```bash
/git/sync                    # Sincroniza com develop (padrão)
/git/sync main               # Sincroniza com main
/git/sync staging            # Sincroniza com staging
```

#### **O que faz:**
- ✅ Checkout automático para branch alvo
- ✅ Pull das mudanças mais recentes
- ✅ Limpeza segura de branch anterior
- ✅ Atualização automática da task ClickUp
- ✅ Gestão inteligente de sessões

#### **Quando usar:**
- Após merge bem-sucedido de PR
- Para manter ambiente local atualizado
- Ao finalizar desenvolvimento de feature
- Para limpeza de branches obsoletas

---

## 🎯 **Workflow Integrado**

### **Fluxo Completo do Sistema Onion:**
```mermaid
flowchart LR
    A[/product/task] --> B[/engineer/start]
    B --> C[/engineer/work]
    C --> D[/engineer/pr]
    D --> E[PR Merge]
    E --> F[/git/sync]
    F --> G[Next Task Ready]
```

### **Integração com Comandos:**
| Comando Anterior | Comando Git | Resultado |
|------------------|-------------|-----------|
| `/engineer/pr` | `/git/sync` | Workflow completo finalizado |
| Manual merge | `/git/sync main` | Sincronização com main |
| Hotfix merge | `/git/sync develop` | Volta para develop |

---

## 🛠️ **Funcionalidades Técnicas**

### **Branch Strategy**
- **Padrão**: `develop` (GitFlow)
- **Auto-criação**: Cria `develop` a partir de `main` se não existir
- **Flexibilidade**: Aceita qualquer branch válida
- **Validação**: Verifica existência remota antes de sincronizar

### **Detecção Inteligente**
- **Contexto Automático**: Detecta task ativa via sessões
- **Branch Atual**: Identifica branch para limpeza
- **Estado Repositório**: Valida git status antes de proceder
- **Múltiplas Sessões**: Usa sessão mais recente automaticamente

### **Operações Git Seguras**
- **Fetch First**: Sempre busca mudanças remotas primeiro
- **Validação**: Verifica estado antes de cada operação
- **Rollback**: Possível reverter operações em caso de erro
- **Logs**: Detalhamento completo para debugging

### **ClickUp Integration**
- **Auto-Status**: Move task para "Done" automaticamente
- **Tag Management**: Remove "in-progress", adiciona "completed"
- **Comentários**: Formatação Unicode consistente
- **Fallback**: Continue git ops mesmo se ClickUp falhar

### **Session Management**
- **Detecção**: Identifica sessões ativas automaticamente
- **Arquivamento**: Opcional, controlado pelo usuário
- **Preservação**: Mantém arquivos importantes (context, plan, notes)
- **Organização**: Estrutura temporal para histórico

---

## ⚠️ **Segurança e Validações**

### **Verificações Automáticas:**
- ✅ **Repositório válido**: Deve ser git repo com remote origin
- ✅ **Mudanças não commitadas**: Avisa e orienta usuário
- ✅ **Branch remota**: Verifica existência antes de checkout
- ✅ **Permissões**: Valida direitos para operações git

### **Proteções Implementadas:**
- 🛡️ **Nunca force push**: Operações sempre seguras
- 🛡️ **Backup implícito**: Git mantém reflog para recovery
- 🛡️ **Confirmações**: Pede confirmação para operações críticas
- 🛡️ **Graceful failure**: Falha de forma controlada

### **Edge Cases Tratados:**
- **Conflitos de merge**: Orientação para resolução manual
- **Network issues**: Retry logic e fallback gracioso
- **Branch inexistente**: Auto-criação ou erro informativo
- **Múltiplas sessões**: Usa mais recente, avisa usuário

---

## 📊 **Formatos de Saída**

### **Saída de Sucesso:**
```
🔄 SINCRONIZAÇÃO COMPLETA

━━━━━━━━━━━━━━━━━━━━━━━━

✅ GIT OPERATIONS:
   ▶ Switched to: develop
   ▶ Pulled latest: 3 new commits  
   ▶ Cleaned branch: feature/my-feature

🔗 CLICKUP UPDATED:
   ▶ Task 86abc123: Moved to "Done"
   ▶ Tags updated: +completed, -in-progress
   ▶ Comment added: Sync completed

📁 SESSION STATUS:
   ▶ Session archived: .cursor/sessions/archived/2025-09-22_1743_my-feature/

━━━━━━━━━━━━━━━━━━━━━━━━

⏰ Completed: 22/09/2025 16:30 | 🎯 Ready for next task
```

### **Tratamento de Erros:**
```
⚠️ SYNC ISSUE DETECTED

Issue: Uncommitted changes in working directory
Files: src/app.ts, package.json

Solution: Commit or stash changes before sync
Commands:
  git add .
  git commit -m "WIP: save before sync"
  /git/sync

Alternative: Use git stash to temporarily save changes
```

### **Orientações Contextuais:**
```
💡 SYNC TIPS

Current situation: First time using /git/sync
Recommendation: develop branch will be created from main

This follows GitFlow best practices:
- main: Production-ready code
- develop: Integration branch for features
- feature/*: Individual feature branches

Next time: /git/sync will use existing develop branch
```

---

## 🎨 **Padrões e Convenções**

### **Nomenclatura de Branches:**
```
feature/task-slug        # Features normais
hotfix/critical-fix      # Correções urgentes  
release/v1.2.0          # Preparação de releases
bugfix/issue-123        # Correções de bugs
```

### **Estratégia de Tags ClickUp:**
```
Adicionadas:     completed, synced
Removidas:       in-progress, under-review, needs-fix
Preservadas:     feature, bug, improvement, research
```

### **Formato de Comentários:**
- **Header**: `✅ TASK CONCLUÍDA - SYNC COMPLETED`
- **Separador**: `━━━━━━━━━━━━━━━━━━━━━━━━`
- **Seções**: Git Operations, Development Status, Final Status
- **Footer**: `⏰ Timestamp | 🤖 Sistema Onion Sync`

### **Estrutura de Arquivamento:**
```
.cursor/sessions/archived/
├── 2025-09-22_1747_sync-command/
│   ├── context.md           # Contexto preservado
│   ├── plan.md             # Plano de implementação
│   ├── notes.md            # Notas de desenvolvimento
│   └── task-86ac06261.md   # Link para task ClickUp
```

---

## 🚀 **Roadmap Futuro**

### **Versão Atual (1.0)**
- ✅ Sync básico com develop/main
- ✅ ClickUp integration completa
- ✅ Session management
- ✅ Error handling robusto

### **Versões Futuras**
- **1.1**: Integração com CI/CD pipelines
- **1.2**: Sync com múltiplas branches simultaneamente
- **1.3**: Configuração personalizada via `.onion-config`
- **1.4**: Hooks git para automação adicional
- **2.0**: Integração com outros sistemas de task (Jira, Linear, etc.)

### **Melhorias Planejadas**
- 📈 **Performance**: Cache de operações git para speed up
- 🔧 **Configurabilidade**: Arquivo de config para branches padrão
- 🌐 **Multi-repo**: Sync em monorepos com múltiplos projetos
- 📱 **Notifications**: Integração com Slack/Teams para notificações

---

## 🆘 **Troubleshooting**

### **Problemas Comuns:**

#### **"Branch develop não existe"**
```bash
# Solução automática (comando faz isso)
git checkout main
git checkout -b develop  
git push origin develop
/git/sync
```

#### **"Mudanças não commitadas"**
```bash
# Commit temporário
git add .
git commit -m "WIP: save before sync"
/git/sync

# Ou usar stash
git stash push -m "WIP before sync"
/git/sync
git stash pop  # Para recuperar depois
```

#### **"ClickUp não atualizou"**
- Verifique credenciais ClickUp MCP
- Operações git continuam normalmente
- ClickUp pode ser atualizado manualmente depois

#### **"Sessão não foi detectada"**
- Comando funciona sem sessão
- ClickUp integration fica limitada
- Crie sessão com `/product/task` para próximas tasks

### **Logs de Debug:**
```bash
# Ver logs detalhados
git reflog --oneline -10    # Últimas 10 operações git
git log --oneline -5        # Últimos 5 commits
git status                  # Estado atual do repo
```

---

**Sistema Onion Git Commands v1.0**  
**Documentação atualizada**: 22/09/2025  
**Próxima revisão**: Após implementação completa
