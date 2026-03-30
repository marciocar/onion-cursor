# 🚀 Guia de Início Rápido

> **Versão**: 3.0.0 | **Última atualização**: 2025-12-02

Bem-vindo ao sistema Onion v3.0! Este guia vai te ajudar a começar rapidamente com os comandos `.cursor/` e integração com gerenciadores de tarefas através do **Task Manager Abstraction**.

## 📊 Visão Geral v3.0

| Componente | Quantidade | Descrição |
|------------|------------|-----------|
| Comandos | 56 | Organizados em 8 categorias |
| Agentes | 38 | 9 categorias especializadas |
| Regras | 4 | Padrões e validações |
| Knowledge Bases | 5 | Documentação estruturada |

## 📋 Checklist de Setup

### **✅ Pré-requisitos**
- [ ] **Node.js v22.14.0+** instalado
- [ ] Cursor IDE instalado e configurado
- [ ] Git inicializado no projeto
- [ ] Pasta `.cursor/` presente no projeto

### **✅ Configuração de Integrações**

#### **⚙️ Método Recomendado: Comando `/meta/setup-integration`**

O Sistema Onion oferece um comando interativo para configurar todas as integrações de forma segura:

```bash
# Configuração interativa (recomendado)
/meta/setup-integration

# Ou especificar integração diretamente
/meta/setup-integration task-manager  # Configurar gerenciador de tarefas
/meta/setup-integration clickup       # Configurar ClickUp especificamente
/meta/setup-integration asana        # Configurar Asana especificamente
/meta/setup-integration gamma        # Configurar Gamma.App
```

**O que o comando faz:**
- ✅ **Guia passo a passo** na configuração de cada integração
- ✅ **Cria/atualiza `.env`** automaticamente
- ✅ **Valida segurança** (verifica `.gitignore`, protege credenciais)
- ✅ **Testa conectividade** quando aplicável
- ✅ **Fornece instruções** específicas para cada provedor

**Integrações suportadas:**
- **Task Managers**: ClickUp, Asana, Linear (via Task Manager Abstraction)
- **Gamma.App**: API para apresentações
- **PostgreSQL**: Banco de dados

#### **📝 Método Alternativo: Configuração Manual**

Se preferir configurar manualmente, edite o arquivo `.env`:

```bash
# ═══════════════════════════════════════
# GERENCIADOR DE TAREFAS (escolha um)
# ═══════════════════════════════════════
TASK_MANAGER_PROVIDER=clickup  # clickup | asana | linear | none

# ClickUp
CLICKUP_API_TOKEN=pk_xxxxx
CLICKUP_DEFAULT_WORKSPACE=your_workspace_id
CLICKUP_DEFAULT_LIST=your_list_id

# Asana (alternativa)
# ASANA_ACCESS_TOKEN=1/xxxxx
# ASANA_DEFAULT_WORKSPACE=1234567890

# ═══════════════════════════════════════
# OUTRAS INTEGRAÇÕES
# ═══════════════════════════════════════
GITHUB_TOKEN=ghp_xxxxx
GAMMA_API_KEY=gm_xxxxx
```

> **💡 Dica:** Use `/meta/setup-integration` para garantir que todas as variáveis estão corretas e o `.env` está protegido no `.gitignore`.

> **Referência**: Veja `.env.example` para todas as variáveis disponíveis.

### **🔄 Task Manager Abstraction - Conceito Central**

O Sistema Onion v3.0 usa uma **camada de abstração** que permite trabalhar com múltiplos gerenciadores de tarefas sem modificar comandos ou workflows. Você escolhe o provedor e todos os comandos funcionam automaticamente.

**Como funciona:**
- ✅ **Interface unificada**: Comandos como `/product/task` funcionam com qualquer provedor
- ✅ **Troca fácil**: Mude `TASK_MANAGER_PROVIDER` no `.env` e tudo continua funcionando
- ✅ **Fallback gracioso**: Sistema funciona mesmo sem gerenciador configurado (modo offline)

**Provedores suportados:**

| Provedor | Status | Configuração | Notas |
|----------|--------|--------------|-------|
| **ClickUp** | ✅ Completo | `TASK_MANAGER_PROVIDER=clickup` | Via ClickUp MCP |
| **Asana** | ✅ Completo | `TASK_MANAGER_PROVIDER=asana` | Via Asana MCP |
| **Linear** | 📝 Stub | `TASK_MANAGER_PROVIDER=linear` | Em desenvolvimento |
| **None** | ✅ Offline | `TASK_MANAGER_PROVIDER=none` | Modo local sem sincronização |

**Vantagens da abstração:**
- 🎯 **Flexibilidade**: Escolha o gerenciador que sua equipe já usa
- 🔄 **Portabilidade**: Troque de provedor sem refatorar código
- 🛡️ **Resiliência**: Funciona mesmo se o gerenciador estiver offline
- 🚀 **Consistência**: Mesmos comandos, mesma experiência, qualquer provedor

> **📚 Documentação completa**: `docs/knowbase/concepts/task-manager-abstraction.md`

### **✅ Validação**

Após configurar o Task Manager, valide a configuração:

```bash
# Verificar comandos disponíveis
/meta/all-tools  # Deve mostrar comandos disponíveis

# Testar integração de Task Manager (se configurado)
/product/task "Task de teste do sistema"
# → Deve criar task no gerenciador configurado (ClickUp, Asana, etc)

# Validar conectividade (depende do provedor configurado)
/warm-up  # Valida conectividade do Task Manager configurado
```

**Se algo não funcionar:**
- Execute `/meta/setup-integration` novamente para revisar configuração
- Verifique se `.env` está no `.gitignore` (o comando faz isso automaticamente)
- Consulte especialistas específicos:
  - `@clickup-specialist` para problemas com ClickUp
  - Para Asana, verifique variáveis `ASANA_*` no `.env`
  - Para modo offline, certifique-se que `TASK_MANAGER_PROVIDER=none`

---

## 🎯 Seus Primeiros 5 Minutos

### **1. Criar Sua Primeira Task (1 min)**
```bash
/product/task "Implementar página de sobre da empresa"
```

**Resultado esperado**: Task criada no gerenciador configurado com ID (ex: ABOUT-123)

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

**Resultado**: PR criado, Task Manager atualizado com status "in_review"

### **✨ Parabéns!** 
Você completou seu primeiro ciclo completo de desenvolvimento com integração ao Task Manager! 🎉

---

## 🏃‍♂️ Fluxos Rápidos por Cenário

### **🆕 Nova Funcionalidade**
```bash
/product/task "Nova funcionalidade X"      # → Task criada no Task Manager
/engineer/start                           # → Input: TASK-ID  
/engineer/work .cursor/sessions/feature-x/ # → Desenvolvimento
/engineer/pr                              # → PR + Task Manager atualizado
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

## 📊 Integração com Task Manager - Visão Rápida

O Sistema Onion sincroniza automaticamente com seu Task Manager configurado (ClickUp, Asana, etc), atualizando status, comentários e tags conforme você desenvolve.

### **Estados Automáticos**
```mermaid
graph LR
    A[/product/task] --> B[to do]
    B --> C[/engineer/start] --> D[in progress]  
    D --> E[/engineer/pr] --> F[in progress + under-review]
    F --> G[Merge] --> H[done]
```

**Status normalizados** (funcionam em qualquer provedor):
- `backlog` → `todo` → `in_progress` → `in_review` → `done`
- `blocked` e `cancelled` também suportados

### **Tags Automáticas**
- **Por tipo**: `feature`, `bug`, `refactor`, `docs`
- **Por status**: `development`, `under-review`, `blocked`
- **Por prioridade**: `urgent`, `high`, `normal`, `low`

### **Comentários Automáticos**
- 🚀 Desenvolvimento iniciado
- 📊 Progresso por fase
- 🔍 PR criado com detalhes
- ✅ Conclusão com métricas

**Nota:** Todos esses recursos funcionam igualmente com ClickUp, Asana ou qualquer outro provedor suportado através da abstração.

---

## 🔧 Troubleshooting Rápido

### **❌ Problema: Comando não encontrado**
```bash
# Verificar se está na pasta correta
pwd  # Deve estar na raiz do projeto com .cursor/

# Listar comandos disponíveis
/all-tools
```

### **❌ Problema: Task Manager não conecta**
```bash
# Validar configuração
/warm-up

# Se falhar, verificar variáveis conforme o provedor:

# Para ClickUp:
echo $CLICKUP_API_TOKEN
echo $CLICKUP_WORKSPACE_ID

# Para Asana:
echo $ASANA_ACCESS_TOKEN
echo $ASANA_DEFAULT_WORKSPACE

# Verificar provedor configurado:
echo $TASK_MANAGER_PROVIDER
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

3. **Monitore métricas** no seu Task Manager:
   - Cycle time por feature
   - Bug rate pós-deploy
   - Review time médio

### **🎯 Para Qualidade**
1. **Sempre execute pre-pr** antes de PR crítico
2. **Use code-reviewer** para mudanças arquiteturais
3. **Documente decisões** importantes com `/docs/build-*`

### **🔄 Para Colaboração**
1. **Tags consistentes** facilitam filtros no Task Manager
2. **Comentários descritivos** em PRs
3. **Sincronização regular** com workspace/projeto configurado

---

## 📚 Próximos Passos

### **📖 Aprofundar Conhecimento**
1. **[Guia de Comandos](commands-guide.md)** - Documentação completa
2. **[Referência de Ferramentas](tools-reference.md)** - Todas as ferramentas disponíveis em TypeScript
3. **[Fluxos de Engenharia](engineering-flows.md)** - Workflows detalhados  
4. **[Task Manager Abstraction](../knowbase/concepts/task-manager-abstraction.md)** - Entenda como funciona a abstração
5. **[Integração ClickUp](clickup-integration.md)** - Configuração avançada do ClickUp (se usar)

### **🎯 Cenários Avançados**
1. **[Exemplos Práticos](practical-examples.md)** - Casos reais de uso
2. **[Referência de Agentes](agents-reference.md)** - Especialistas disponíveis

### **🔧 Personalização**
1. Configurar webhooks do Task Manager (ClickUp, Asana, etc)
2. Customizar templates de PR
3. Criar dashboards específicos no seu gerenciador
4. Ajustar notificações e workflows

---

## 🆘 Suporte e Ajuda

### **📞 Onde Buscar Ajuda**
1. **Comandos**: `/meta/all-tools` lista tudo disponível
2. **Status**: `/warm-up` valida configuração do Task Manager
3. **Documentação**: Arquivos nesta pasta `docs/`
4. **Task Manager**: Interface web do seu gerenciador (ClickUp, Asana, etc) para validar dados

### **🐛 Reportar Problemas**
Se algo não funciona:
1. Execute `/warm-up` e cole o resultado
2. Descreva o comando executado
3. Inclua mensagem de erro completa
4. Mencione ID da task e provedor configurado (ClickUp, Asana, etc)
5. Verifique se `TASK_MANAGER_PROVIDER` está configurado corretamente

### **💬 Comunidade**
- Compartilhe workflows que funcionam
- Suggira melhorias nos comandos
- Documente casos especiais descobertos

---

## 🎉 Você Está Pronto!

Agora você tem tudo para ser produtivo com o sistema Onion:

-  **Setup validado** e funcionando
-  **Primeiros comandos** executados com sucesso  
-  **Fluxos principais** compreendidos
-  **Task Manager configurado** e sincronizando (ClickUp, Asana ou modo offline)
-  **Troubleshooting** na ponta da língua

**Comece pequeno, pratique os fluxos básicos, e gradualmente explore funcionalidades mais avançadas!**

---

## 🛠️ Troubleshooting Node.js v22.14.0+

### **Problema**: chrome-devtools-mcp não funciona
**Erro comum**: `chrome-devtools-mcp does not support Node v20.x.x`

#### **Solução 1: Verificar versão do Node.js**
```bash
# Verificar versão atual
node --version

# Se for menor que v22.14.0, atualizar via NVM:
nvm install v22.14.0
nvm use v22.14.0
nvm alias default v22.14.0

# Confirmar atualização
node --version  # Deve mostrar v22.14.0
```

#### **Solução 2: Limpar cache do NPX**
```bash
# Limpar cache do npx
rm -rf ~/.npm/_npx/

# Testar novamente
npx chrome-devtools-mcp@latest --version
```

#### **Solução 3: Verificar instalação do Chrome**
```bash
# Ubuntu/Debian
which google-chrome || which chromium-browser

# Se não encontrar, instalar Chrome:
sudo apt update
sudo apt install google-chrome-stable
```

### **Problema**: Comandos `.cursor/` não funcionam
**Sintomas**: Comandos não são reconhecidos

#### **Solução**:
```bash
# 1. Verificar estrutura .cursor/
ls -la .cursor/commands/

# 2. Verificar se está no diretório do projeto
pwd  # Deve estar na raiz com .cursor/

# 3. Invocar agente cursor-specialist
@cursor-specialist "comandos não funcionam"
```

### **Problema**: Integração Task Manager falha
**Sintomas**: Tasks não são criadas/atualizadas

#### **Soluções**:
```bash
# 1. Verificar provedor configurado
echo $TASK_MANAGER_PROVIDER

# 2. Verificar variáveis de ambiente conforme provedor:

# Se usando ClickUp:
echo $CLICKUP_API_TOKEN
echo $CLICKUP_WORKSPACE_ID
echo $CLICKUP_DEFAULT_LIST_ID

# Se usando Asana:
echo $ASANA_ACCESS_TOKEN
echo $ASANA_DEFAULT_WORKSPACE

# 3. Testar conectividade
/warm-up

# 4. Invocar especialista conforme provedor:
@clickup-specialist "integração não funciona"  # Para ClickUp
# Para Asana, verifique documentação ou execute /meta/setup-integration asana
```

---

**Sistema Onion** - Desenvolvimento inteligente com IA 🧅 🚀
