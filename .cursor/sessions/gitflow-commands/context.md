# 🌿 Contexto: Comandos para Gitflow incluindo Help

## 📋 **Task Principal**
**ID ClickUp**: 86ac0ychj  
**Nome**: 🌿 Criar Comandos para Gitflow incluindo Help  
**URL**: https://app.clickup.com/t/86ac0ychj

## 🌿 **Feature Branch**
**Nome**: `feature/gitflow-commands`  
**Criada**: 2025-01-23 15:15:33  
**Status**: ✅ Ativa

## 🕒 **Timeline**
**Estimativa**: 3-4 horas de implementação  
**Início**: 2025-01-23 15:15:33  
**Expectativa de Entrega**: 2025-01-23 19:00:00

## 🎯 **Entendimento do Projeto**

### **Por que?**
O Sistema Onion atualmente possui apenas 1 comando Git (`git/sync.md`) de 28 comandos totais. Para ser um framework completo de desenvolvimento, precisamos de comandos Gitflow completos que automatizem:
- Gestão de branches (feature, release, hotfix)
- Integração com ClickUp MCP
- Help contextual e troubleshooting
- Validações automáticas de estado

### **O que?**
Implementar 8 comandos Gitflow:
1. `git/init.md` - Inicializar repositório com Gitflow
2. `git/feature/start.md` - Iniciar nova feature branch
3. `git/feature/finish.md` - Finalizar feature branch  
4. `git/release/start.md` - Iniciar release branch
5. `git/release/finish.md` - Finalizar release branch
6. `git/hotfix/start.md` - Iniciar hotfix branch
7. `git/hotfix/finish.md` - Finalizar hotfix branch
8. `git/help.md` - Sistema de ajuda contextual

### **Como?**
- Seguir padrão de comandos existente do Sistema Onion
- Integração total com ClickUp MCP para tracking automático
- Sistema de help inteligente com examples e troubleshooting
- Compatibilidade com fluxos `/engineer/*` existentes
- Validações automáticas de estado git
- Error handling robusto

## 🔍 **Subtasks Identificadas**

### **Fase 1: Estrutura Base (1h)**
- [ ] Criar estrutura de pastas em `.cursor/commands/git/`
- [ ] Implementar `git/help.md` como base
- [ ] Definir padrões e templates comuns
- [ ] Criar utilitários de validação

### **Fase 2: Comandos Core (1.5h)**
- [ ] `git/init.md` - Setup inicial do Gitflow
- [ ] `git/feature/start.md` - Iniciar features
- [ ] `git/feature/finish.md` - Finalizar features

### **Fase 3: Comandos Avançados (1h)**
- [ ] `git/release/start.md` - Gestão de releases
- [ ] `git/release/finish.md` - Finalizar releases
- [ ] `git/hotfix/start.md` - Hotfixes emergenciais
- [ ] `git/hotfix/finish.md` - Finalizar hotfixes

### **Fase 4: Integração e Testes (0.5h)**
- [ ] Testes de integração com comandos existentes
- [ ] Documentação completa
- [ ] Atualização dos índices de comandos

## ✅ **Success Metrics**
- **8 comandos Gitflow** implementados e funcionais
- **Integração ClickUp MCP** para tracking automático  
- **Sistema de help** contextual e inteligente
- **Validações automáticas** de estado git
- **70% redução** no tempo de gestão de branches
- **Compatibilidade total** com fluxos `/engineer/*`

## 🧠 **Decisões Arquiteturais**

### **Estrutura de Arquivos**
```
.cursor/commands/git/
├── README.md              # Índice de comandos Git
├── sync.md               # Existente - Sincronização
├── init.md               # NOVO - Setup Gitflow
├── help.md               # NOVO - Sistema de help
├── feature/
│   ├── start.md          # NOVO - Iniciar feature
│   └── finish.md         # NOVO - Finalizar feature
├── release/
│   ├── start.md          # NOVO - Iniciar release
│   └── finish.md         # NOVO - Finalizar release
└── hotfix/
    ├── start.md          # NOVO - Iniciar hotfix
    └── finish.md         # NOVO - Finalizar hotfix
```

### **Padrões de Integração**
- **ClickUp MCP**: Auto-update de tasks baseado no flow
- **Validações**: Verificar estado git antes de executar
- **Error Handling**: Mensagens claras e recovery automático  
- **Help System**: Contextual por comando com examples

### **Template de Comandos**
Seguir padrão existente:
- Header YAML com metadados
- Descrição funcional clara
- Workflow step-by-step
- Integração ClickUp
- Error handling
- Examples práticos

## 📚 **Recursos Disponíveis**

### **Referencias Existentes**
- `git/sync.md` - Padrão atual de comando Git
- `.cursor/commands/engineer/*` - Fluxos de desenvolvimento
- `.cursor/utils/clickup-formatting.md` - Formatação ClickUp

### **Agentes Especializados**
- `@gitflow-specialist` - Expert em workflows Git
- `@clickup-specialist` - Otimizações ClickUp MCP
- `@cursor-specialist` - Configuração Cursor IDE

### **Ferramentas ClickUp MCP**
- `create_task_comment` - Para tracking automático
- `update_task` - Para mudanças de status
- `add_tag_to_task` - Para gestão de tags

## 🎯 **Pronto para Desenvolvimento**
Contexto completo estabelecido. Executar `/engineer/start gitflow-commands` para iniciar a implementação seguindo o plano detalhado.
