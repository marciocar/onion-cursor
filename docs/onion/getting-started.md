# 🚀 Guia de Início Rápido

Bem-vindo ao sistema Onion! Este guia vai te ajudar a começar rapidamente com os comandos `.cursor/` e integração ClickUp.

## 📋 Checklist de Setup

### **✅ Pré-requisitos**
- [ ] Cursor instalado e configurado
- [ ] ClickUp MCP instalado 
- [ ] Acesso ao workspace ClickUp configurado
- [ ] Projeto Git inicializado
- [ ] Pasta `.cursor/` presente no projeto

### **✅ Configuração ClickUp**
- [ ] `CLICKUP_WORKSPACE_ID` configurado
- [ ] `CLICKUP_SPACE_ID` configurado  
- [ ] `CLICKUP_LIST_ID` configurado
- [ ] API token com permissões adequadas

### **✅ Validação**
```bash
/all-tools  # Deve mostrar comandos disponíveis
/warm-up    # Validar conectividade ClickUp
```

---

## 🎯 Seus Primeiros 5 Minutos

### **1. Criar Sua Primeira Task (1 min)**
```bash
/product/task "Implementar página de sobre da empresa"
```

**Resultado esperado**: Task criada no ClickUp com ID (ex: ABOUT-123)

### **2. Iniciar Desenvolvimento (1 min)**
```bash
/engineer/start
```

**Input quando solicitado**: `ABOUT-123`

**Resultado**: Ambiente configurado, sessão criada, plano gerado

### **3. Desenvolver Funcionalidade (2 min)**
```bash
/engineer/work .cursor/sessions/about-page/
```

**Resultado**: Implementação guiada passo-a-passo

### **4. Criar Pull Request (1 min)**
```bash
/engineer/pr
```

**Resultado**: PR criado, ClickUp atualizado com status "under-review"

### **✨ Parabéns!** 
Você completou seu primeiro ciclo completo de desenvolvimento com integração ClickUp! 🎉

---

## 🏃‍♂️ Fluxos Rápidos por Cenário

### **🆕 Nova Funcionalidade**
```bash
/product/task "Nova funcionalidade X"      # → Task criada
/engineer/start                           # → Input: TASK-ID  
/engineer/work .cursor/sessions/feature-x/ # → Desenvolvimento
/engineer/pr                              # → PR + ClickUp update
```

### **🐛 Correção de Bug**
```bash
/product/collect "Bug: X não funciona"    # → Bug task criada
/engineer/start                           # → Fix mode ativo
/engineer/work "corrigir bug X"           # → Implementação rápida
/engineer/pr                              # → Hotfix PR
```

### **📚 Documentação**
```bash
/docs/build-tech-docs                     # → Docs técnicos
/docs/build-business-docs                 # → Docs de negócio
/docs/build-index                         # → Índice de projetos
```

### **⚡ Emergência**
```bash
/product/collect "CRÍTICO: Sistema fora do ar" # → Priority 1 automático
/engineer/start                                 # → Hotfix mode
/engineer/work "fix crítico"                    # → Solução rápida
/engineer/pr                                    # → Deploy imediato
```

---

## 🎯 Comandos Essenciais

### **📋 Mais Usados (80% dos casos)**
| Comando | Uso | Frequência |
|---------|-----|------------|
| `/product/task` | Criar nova task | 35% |
| `/engineer/start` | Iniciar desenvolvimento | 25% |
| `/engineer/work` | Desenvolver funcionalidade | 20% |
| `/engineer/pr` | Criar Pull Request | 15% |
| `/all-tools` | Ver comandos disponíveis | 5% |

### **🔧 Para Situações Específicas**
| Comando | Quando Usar |
|---------|-------------|
| `/product/collect` | Reportar bugs ou ideias rápidas |
| `/product/refine` | Melhorar especificação existente |
| `/product/light-arch` | Esboçar arquitetura inicial |
| `/engineer/pre-pr` | Validações antes do PR |
| `/docs/build-*` | Gerar documentação automática |

---

## 🤖 Agentes - Quando Usar

### **🔵 Para Desenvolvimento**
```bash
@python-developer "implementar API de usuários"    # Python backend
@react-developer "criar dashboard interativo"      # React frontend  
```

### **🧪 Para Testes**
```bash
@test-engineer "adicionar testes para função X"    # Testes unitários
@test-planner "estratégia de testes para módulo Y" # Plano de testes
```

### **🔍 Para Pesquisa**
```bash
@research-agent "melhores práticas OAuth2 2024"    # Pesquisa tecnológica
@code-reviewer "revisar qualidade do código Z"     # Code review
```

---

## 📊 Integração ClickUp - Visão Rápida

### **Estados Automáticos**
```mermaid
graph LR
    A[/product/task] --> B[to do]
    B --> C[/engineer/start] --> D[in progress]  
    D --> E[/engineer/pr] --> F[in progress + under-review]
    F --> G[Merge] --> H[done]
```

### **Tags Automáticas**
- **Por tipo**: `feature`, `bug`, `refactor`, `docs`
- **Por status**: `development`, `under-review`, `blocked`
- **Por prioridade**: `urgent`, `high`, `normal`, `low`

### **Comentários Automáticos**
- 🚀 Desenvolvimento iniciado
- 📊 Progresso por fase
- 🔍 PR criado com detalhes
- ✅ Conclusão com métricas

---

## 🔧 Troubleshooting Rápido

### **❌ Problema: Comando não encontrado**
```bash
# Verificar se está na pasta correta
pwd  # Deve estar na raiz do projeto com .cursor/

# Listar comandos disponíveis
/all-tools
```

### **❌ Problema: ClickUp não conecta**
```bash
# Validar configuração
/warm-up

# Se falhar, verificar variáveis:
echo $CLICKUP_WORKSPACE_ID
echo $CLICKUP_SPACE_ID
```

### **❌ Problema: Task não encontrada**
```
# Verificar formato do ID
Correto: AUTH-123, BUG-456, PROJ-789
Incorreto: 123, auth123, AUTH123
```

### **❌ Problema: PR falha**
```bash
# Executar validações antes
/engineer/pre-pr

# Se testes falharem, corrigir primeiro
npm test  # ou comando apropriado do projeto
```

---

## 💡 Dicas Pro

### **🚀 Para Eficiência Máxima**
1. **Use aliases** para comandos frequentes:
   ```bash
   alias pt="/product/task"
   alias es="/engineer/start" 
   alias ew="/engineer/work"
   alias epr="/engineer/pr"
   ```

2. **Prepare templates** para tasks comuns:
   ```bash
   pt "Feature: Nova página X com layout responsivo e formulário de contato"
   pt "Bug: Problema Y em ambiente Z com logs detalhados"
   ```

3. **Monitore métricas** no ClickUp:
   - Cycle time por feature
   - Bug rate pós-deploy
   - Review time médio

### **🎯 Para Qualidade**
1. **Sempre execute pre-pr** antes de PR crítico
2. **Use code-reviewer** para mudanças arquiteturais
3. **Documente decisões** importantes com `/docs/build-*`

### **🔄 Para Colaboração**
1. **Tags consistentes** facilitam filtros ClickUp
2. **Comentários descritivos** em PRs
3. **Sincronização regular** de workspace

---

## 📚 Próximos Passos

### **📖 Aprofundar Conhecimento**
1. **[Guia de Comandos](commands-guide.md)** - Documentação completa
2. **[Fluxos de Engenharia](engineering-flows.md)** - Workflows detalhados  
3. **[Integração ClickUp](clickup-integration.md)** - Configuração avançada

### **🎯 Cenários Avançados**
1. **[Exemplos Práticos](practical-examples.md)** - Casos reais de uso
2. **[Referência de Agentes](agents-reference.md)** - Especialistas disponíveis

### **🔧 Personalização**
1. Configurar webhooks ClickUp
2. Customizar templates de PR
3. Criar dashboards específicos
4. Ajustar notificações

---

## 🆘 Suporte e Ajuda

### **📞 Onde Buscar Ajuda**
1. **Comandos**: `/all-tools` lista tudo disponível
2. **Status**: `/warm-up` valida configuração
3. **Documentação**: Arquivos nesta pasta `docs/`
4. **ClickUp**: Interface web para validar dados

### **🐛 Reportar Problemas**
Se algo não funciona:
1. Execute `/warm-up` e cole o resultado
2. Descreva o comando executado
3. Inclua mensagem de erro completa
4. Mencione ID da task ClickUp se aplicável

### **💬 Comunidade**
- Compartilhe workflows que funcionam
- Suggira melhorias nos comandos
- Documente casos especiais descobertos

---

## 🎉 Você Está Pronto!

Agora você tem tudo para ser produtivo com o sistema Onion:

- ✅ **Setup validado** e funcionando
- ✅ **Primeiros comandos** executados com sucesso  
- ✅ **Fluxos principais** compreendidos
- ✅ **Integração ClickUp** ativa
- ✅ **Troubleshooting** na ponta da língua

**Comece pequeno, pratique os fluxos básicos, e gradualmente explore funcionalidades mais avançadas!**

---

**Sistema Onion** - Desenvolvimento inteligente com IA 🧅 🚀
