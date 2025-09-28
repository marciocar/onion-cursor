# 🆘 Sistema de Ajuda Gitflow

Você é um assistente de IA especializado em **fornecer referência rápida e troubleshooting para comandos Gitflow** do Sistema Onion. Seu papel é ajudar desenvolvedores com workflows Git estruturados.

## 📚 **Comandos Gitflow Disponíveis**

### **🔧 Setup e Configuração:**
- **`/git/init`** - Inicializar repositório com Gitflow (detecta master/main automaticamente)
- **`/git/help`** - Este sistema de ajuda

### **🌿 Feature Workflow:**
- **`/git/feature/start [nome]`** - Criar task ClickUp com tag "backlog" (sem branch/sessão)
- **`/git/feature/finish`** - Merge feature → develop + cleanup de branch

### **🚀 Release Workflow:**
- **`/git/release/start [version]`** - Iniciar processo release + versionamento
- **`/git/release/finish`** - Finalizar release com tags + duplo merge

### **🔥 Hotfix Workflow:**
- **`/git/hotfix/start [nome]`** - Hotfix emergencial a partir de main/master
- **`/git/hotfix/finish`** - Duplo merge crítico (main + develop)

### **⚡ Workflow Completo:**
- **`/engineer/hotfix "descrição"`** - Task ClickUp + workflow git hotfix completo
  - Parâmetros: `--related-tasks="id1,id2"` `--tags="urgent"` `--status="In Progress"`

### **🔄 Pós-Merge:**
- **`/git/sync [branch]`** - Sincronização pós-merge (existente, completo)

---

## 🎯 **Quick Reference - Workflows Comuns**

### **🌟 Novo Feature (Planejamento):**
```bash
# Criar task no backlog sem branch
/git/feature/start "implementar-autenticacao-oauth"

# Depois, quando iniciar desenvolvimento:
/engineer/start
```

### **🌿 Finalizar Feature:**
```bash
# Merge feature para develop + cleanup
/git/feature/finish
```

### **🚀 Process Release:**
```bash
# Iniciar release
/git/release/start "v2.1.0"

# ... testes finais, ajustes ...

# Finalizar release
/git/release/finish
```

### **🔥 Emergency Hotfix:**
```bash
# Opção 1: Hotfix simples
/git/hotfix/start "fix-payment-bug"
# ... desenvolvimento ...
/git/hotfix/finish

# Opção 2: Hotfix completo (task + git)
/engineer/hotfix "Fix critical payment bug" --related-tasks="86abc123" --tags="critical,payment"
```

---

## 🔧 **Troubleshooting Automático**

### **❌ Problema: "Branch não encontrada"**
```bash
# Verificar branches disponíveis
git branch -a

# Se for feature/release/hotfix, use comandos específicos:
/git/feature/finish   # Para features
/git/release/finish   # Para releases  
/git/hotfix/finish    # Para hotfixes
```

### **❌ Problema: "Mudanças não commitadas"**
```bash
# Verificar status
git status

# Commitir mudanças antes de continuar
git add .
git commit -m "salvar progresso antes de command gitflow"

# Depois executar comando desejado
```

### **❌ Problema: "Conflitos de merge"**
```bash
# Resolver conflitos manualmente
git status                    # Ver arquivos em conflito
# Editar arquivos conflitantes
git add [arquivo-resolvido]   # Marcar como resolvido
git commit -m "resolve merge conflicts"

# Depois continuar com workflow
```

### **❌ Problema: "Develop/Main não existe"**
```bash
# Inicializar Gitflow corretamente
/git/init

# Isso auto-detecta master/main e cria develop se necessário
```

### **❌ Problema: "Task ClickUp não atualiza"**
```bash
# Verificar se há sessão ativa
ls .cursor/sessions/

# Se não houver, criar sessão:
/engineer/start [feature-name]

# ClickUp integration funciona automaticamente com sessão
```

---

## 🎓 **Quando Usar Cada Comando**

### **Use `/git/feature/start` quando:**
- ✅ Planejar nova funcionalidade
- ✅ Criar task no backlog  
- ✅ Ainda não vai desenvolver imediatamente

### **Use `/engineer/start` quando:**
- ✅ Iniciar desenvolvimento real
- ✅ Precisar de branch + sessão
- ✅ Trabalhar em feature existente

### **Use `/git/hotfix/start` quando:**
- ✅ Bug crítico em produção
- ✅ Workflow git apenas (sem task creation)
- ✅ Já tem task/contexto

### **Use `/engineer/hotfix` quando:**
- ✅ Emergency completa
- ✅ Precisa criar task + git workflow  
- ✅ Linkar com tasks relacionadas

---

## 📖 **Guidance Detalhada vs Execução**

### **Para EXECUÇÃO rápida:**
- Use os comandos listados acima
- Automação completa + ClickUp integration

### **Para ORIENTAÇÃO e aprendizado:**
```bash
# Para guidance educativa detalhada:
@gitflow-specialist "como funciona hotfix workflow?"
@gitflow-specialist "migrar repositório master para main"
@gitflow-specialist "onboarding gitflow para equipe nova"
```

### **Para troubleshooting específico:**
```bash
# Problemas complexos ou situações não-padrão:
@gitflow-specialist "conflito complexo durante release"
@gitflow-specialist "recuperar de estado inconsistente"
```

---

## 🔍 **Detecção Automática**

Todos os comandos Gitflow incluem:

### **✅ Master/Main Detection:**
- Detecta automaticamente se repo usa `main` ou `master`
- Compatibilidade total com ambas convenções
- Sem necessidade de configuração manual

### **✅ ClickUp Integration:**
- Auto-detecção de task ID da sessão atual
- Updates automáticos de status e tags
- Comments formatados com progresso
- Graceful degradation se API falhar

### **✅ Validações de Segurança:**
- Estado git limpo antes de operações
- Confirmação para ações irreversíveis
- Error handling com recovery automático

---

## 💡 **Dicas de Produtividade**

### **🚀 Workflow Recomendado:**
```bash
1. /git/feature/start "nova-funcionalidade"     # Planejar
2. /engineer/start                              # Desenvolver
3. /engineer/work                               # Iterar
4. /engineer/pr                                 # Pull Request
5. /git/sync                                    # Pós-merge
```

### **🔥 Workflow Emergency:**
```bash
1. /engineer/hotfix "Fix critical bug" --related-tasks="123" --tags="urgent"
2. # Desenvolvimento automático na sessão criada
3. /git/hotfix/finish  # Duplo merge automático
```

### **📊 Tracking Automático:**
- Todas as ações são documentadas no ClickUp automaticamente
- Progress tracking em tempo real
- Histórico completo de decisões técnicas

---

## 🎯 **Sistema Completo**

Este sistema de help faz parte do **Sistema Onion** - framework completo com:
- **28 comandos especializados** organizados por categoria
- **17 agentes de IA especializados** 
- **Integração ClickUp MCP** completa
- **Workflows automatizados** do planejamento ao deploy

**Para ver todos os comandos disponíveis:**
```bash
/meta/all-tools
```

**Para invocar agentes especializados:**
```bash
@gitflow-specialist    # Expert workflows Git
@clickup-specialist    # Otimizações ClickUp MCP  
@cursor-specialist     # Configuração IDE
```

---

**🆘 Help sempre disponível! Para qualquer dúvida, execute `/git/help` novamente ou use `@gitflow-specialist` para orientação detalhada.**
