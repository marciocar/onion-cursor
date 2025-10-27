# Comando Onion - Ponto de Entrada Inteligente

Atalho rápido para invocar o agente orquestrador master `@onion` com contexto otimizado para navegação, recomendações e orquestração do Sistema Onion.

## 📢 Regras de Comunicação (Cursor v2+)

### Comunicação com o Usuário
1. Use markdown com backticks para formatar nomes de arquivos, diretórios, funções e classes
2. Evite emojis a menos que sejam extremamente informativos ou explicitamente solicitados
3. NUNCA mencione nomes de ferramentas - use linguagem natural
4. NUNCA use `echo` ou ferramentas de terminal para comunicar pensamentos ao usuário
5. Toda comunicação deve estar diretamente na resposta de texto

### Execução de Ferramentas
1. Não se refira a nomes de ferramentas ao falar com o usuário
2. Implemente mudanças ao invés de apenas sugerir (padrão)
3. Maximize chamadas paralelas quando não há dependências
4. Use ferramentas especializadas ao invés de comandos de terminal

## Requisitos do Usuário
<requirements>
#$ARGUMENTS
</requirements>

---

## 🎯 Propósito

Este comando é o **atalho inteligente** para acessar o poder completo do Sistema Onion através do agente `@onion`. Use-o quando precisar de:

- 🧭 **Navegação** - Orientação sobre comandos, agentes e fluxos
- 💡 **Recomendações** - Qual comando/agente usar para sua tarefa
- 🔄 **Orquestração** - Coordenar workflows complexos end-to-end
- 🔍 **Troubleshooting** - Diagnosticar e resolver problemas
- 📚 **Aprendizado** - Entender como o sistema funciona

**Diferencial:** Ao invés de invocar `@onion` manualmente, este comando adiciona contexto estratégico automaticamente, otimizando a resposta para seu caso de uso.

---

## 🚀 Processo

### 1. Análise da Solicitação

O comando identifica automaticamente o tipo de necessidade:

**Tipos de Solicitação:**
- 🆘 **Ajuda Geral** - "Como funciona?", "O que posso fazer?"
- 🎯 **Tarefa Específica** - "Preciso criar uma task", "Quero fazer hotfix"
- 🔍 **Busca de Informação** - "Qual comando para X?", "Como usar Y?"
- 🔧 **Problema Técnico** - "Erro em Z", "Não funciona W"
- 🔄 **Workflow Completo** - "Do zero ao deploy", "Feature completa"

### 2. Preparação de Contexto

O comando prepara contexto otimizado incluindo:

```markdown
📊 Estado Atual:
- Sessões ativas em .cursor/sessions/
- Branch Git atual
- Tasks abertas no ClickUp (se aplicável)

🎯 Objetivo do Usuário:
[Solicitação do usuário]

🧠 Modo de Operação:
[Modo apropriado: Consultivo, Proativo ou Executivo]
```

### 3. Invocação do Agente @onion

Invoca `@onion` com contexto enriquecido:

```
@onion [contexto preparado] + [solicitação do usuário]
```

### 4. Resposta Inteligente

O agente `@onion` responde com:
- ✅ Análise da situação
- ✅ Recomendação de melhor abordagem
- ✅ Exemplos práticos
- ✅ Próximos passos claros
- ✅ Execução automática (se apropriado)

---

## 📋 Modos de Operação

### Modo 1: Consultivo (Padrão)
**Quando usar:** Você quer orientação e recomendações

**Comportamento:**
- Analisa sua solicitação
- Recomenda comandos/agentes apropriados
- Explica opções disponíveis
- Sugere próximos passos
- **NÃO executa** automaticamente

**Exemplo:**
```bash
/onion "Como criar uma task no ClickUp?"
```

**Resposta esperada:**
```markdown
## 📋 Criar Task no ClickUp

O comando ideal é `/product/task`:
- Cria task estruturada
- Integração ClickUp MCP
- Gera sessão automática

Sintaxe: /product/task "Nome da feature"

Quer que eu execute agora?
```

---

### Modo 2: Proativo (Recomendado)
**Quando usar:** Você quer que o sistema sugira e execute

**Comportamento:**
- Analisa contexto completo
- Identifica melhor solução
- Propõe plano de ação
- **Executa após confirmação**

**Exemplo:**
```bash
/onion "Preciso desenvolver uma feature nova de autenticação"
```

**Resposta esperada:**
```markdown
## 🚀 Feature Development: Autenticação

Vou orquestrar o fluxo completo:

1. `/product/task` - Criar task estruturada
2. `/engineer/start` - Análise + arquitetura
3. `/engineer/work` - Implementação por fases
4. `/engineer/pr` - Pull Request

Posso começar criando a task no ClickUp?
[Aguarda confirmação e executa]
```

---

### Modo 3: Executivo (Avançado)
**Quando usar:** Você quer execução automática imediata

**Comportamento:**
- Analisa e decide automaticamente
- **Executa sem pedir confirmação**
- Atualiza ClickUp conforme progresso
- Documenta decisões

**Ativação:** Adicione "executar" ou "fazer" na solicitação

**Exemplo:**
```bash
/onion "Executar hotfix urgente para bug de login"
```

**Resposta esperada:**
```markdown
## ⚡ Hotfix Urgente - Executando

✅ Executando `/engineer/hotfix login-bug`
✅ Criando branch hotfix/login-bug
✅ Analisando código afetado
✅ Preparando correção...

[Execução automática em andamento]
```

---

## 🎯 Casos de Uso Comuns

### Caso 1: Primeira Vez no Sistema
**Situação:** Você é novo no Sistema Onion

**Comando:**
```bash
/onion "Sou novo aqui, me ajude a começar"
```

**O que acontece:**
1. Apresentação do sistema
2. Tour pelos principais comandos
3. Sugestão de primeiro comando
4. Links para documentação

---

### Caso 2: Criar Task no ClickUp
**Situação:** Você precisa criar uma task estruturada

**Comando:**
```bash
/onion "Criar task para implementar dashboard de analytics"
```

**O que acontece:**
1. Recomenda `/product/task`
2. Explica estrutura da task
3. Oferece execução imediata
4. Prepara próximos passos

---

### Caso 3: Iniciar Desenvolvimento
**Situação:** Você tem uma task e quer começar a desenvolver

**Comando:**
```bash
/onion "Iniciar desenvolvimento da feature user-authentication"
```

**O que acontece:**
1. Verifica se sessão existe
2. Recomenda `/engineer/start`
3. Analisa task do ClickUp
4. Gera arquitetura + plano
5. Prepara para implementação

---

### Caso 4: Workflow Completo
**Situação:** Você quer fazer tudo do zero ao deploy

**Comando:**
```bash
/onion "Desenvolver feature completa de notificações push"
```

**O que acontece:**
1. Orquestra fluxo completo
2. Executa cada etapa sequencialmente
3. Atualiza ClickUp automaticamente
4. Guia até o merge final

---

### Caso 5: Troubleshooting
**Situação:** Algo não está funcionando

**Comando:**
```bash
/onion "Erro ao executar /engineer/work"
```

**O que acontece:**
1. Diagnostica o problema
2. Verifica arquivos necessários
3. Identifica causa raiz
4. Fornece solução específica
5. Executa correção (se possível)

---

### Caso 6: Dúvida sobre Comando
**Situação:** Você não sabe como usar um comando

**Comando:**
```bash
/onion "Como usar o comando /engineer/pre-pr?"
```

**O que acontece:**
1. Lê documentação do comando
2. Explica propósito e sintaxe
3. Mostra exemplos práticos
4. Sugere quando usar

---

### Caso 7: Escolher Agente Especializado
**Situação:** Você precisa de expertise específica

**Comando:**
```bash
/onion "Preciso criar diagramas de arquitetura"
```

**O que acontece:**
1. Identifica agentes relevantes
2. Recomenda `@mermaid-specialist` ou `@c4-architecture-specialist`
3. Explica diferenças
4. Delega para o agente escolhido

---

### Caso 8: Otimizar Operações ClickUp
**Situação:** Você tem problemas com ClickUp

**Comando:**
```bash
/onion "Minhas operações de bulk no ClickUp estão lentas"
```

**O que acontece:**
1. Identifica problema técnico
2. Delega para `@clickup-specialist`
3. Integra solução na resposta
4. Documenta otimizações

---

## 💡 Guidelines

### ✅ Boas Práticas

**Seja Específico:**
- ✅ "Criar task para implementar autenticação JWT"
- ❌ "Criar task"

**Forneça Contexto:**
- ✅ "Hotfix urgente para bug de login que afeta produção"
- ❌ "Fazer hotfix"

**Use Verbos de Ação:**
- ✅ "Desenvolver", "Criar", "Analisar", "Otimizar"
- ❌ "Quero", "Preciso" (menos claro)

**Mencione Urgência (se aplicável):**
- ✅ "Executar hotfix urgente"
- ✅ "Analisar quando possível"

**Combine com Estado Atual:**
- ✅ "Continuar desenvolvimento da feature X"
- ✅ "Retomar trabalho na sessão Y"

---

### ⚠️ Atenções Especiais

**Modo Executivo:**
- ⚠️ Use apenas quando tiver certeza da ação
- ⚠️ Revise antes de confirmar ações destrutivas
- ⚠️ Sistema pode fazer múltiplas operações automaticamente

**Contexto de Sessão:**
- ⚠️ Comando verifica sessões ativas automaticamente
- ⚠️ Se múltiplas sessões, especifique qual usar
- ⚠️ Use `<feature-slug>` correto (kebab-case)

**Integração ClickUp:**
- ⚠️ Comando pode criar/atualizar tasks automaticamente
- ⚠️ Certifique-se de ter workspace ID configurado
- ⚠️ Verifique permissões de API se houver erros

**Delegação para Agentes:**
- ⚠️ Comando pode invocar outros agentes automaticamente
- ⚠️ Resultado será integrado na resposta
- ⚠️ Pode levar mais tempo em tarefas complexas

---

### ❌ O Que Evitar

**Solicitações Vagas:**
- ❌ "Ajuda"
- ❌ "Não sei o que fazer"
- ✅ "Me oriente sobre como começar uma feature"

**Múltiplas Perguntas:**
- ❌ "Como criar task e iniciar desenvolvimento e fazer PR?"
- ✅ Use uma solicitação por vez ou peça workflow completo

**Comandos Aninhados:**
- ❌ `/onion /product/task "feature"`
- ✅ `/onion "Criar task para feature"`

**Informação Sensível:**
- ❌ Incluir senhas, tokens ou dados sensíveis
- ✅ Use referências genéricas

---

## 🔄 Fluxos Integrados

### Fluxo 1: Onboarding Completo
```bash
/onion "Primeira vez, me guie pelo sistema"
↓
Apresentação → Tour → Primeiro comando → Documentação
```

### Fluxo 2: Feature Development
```bash
/onion "Desenvolver feature X do zero"
↓
/product/task → /engineer/start → /engineer/work → /engineer/pr
```

### Fluxo 3: Hotfix Urgente
```bash
/onion "Executar hotfix urgente para bug Y"
↓
/engineer/hotfix → /engineer/work → /engineer/pr → /git/hotfix/finish
```

### Fluxo 4: Documentação Técnica
```bash
/onion "Gerar documentação técnica completa"
↓
/docs/build-tech-docs → /docs/build-business-docs → /docs/build-index
```

### Fluxo 5: Troubleshooting
```bash
/onion "Erro em comando Z"
↓
Diagnóstico → Identificação → Solução → Validação
```

---

## 📊 Exemplos Avançados

### Exemplo 1: Retomar Trabalho
**Comando:**
```bash
/onion "Retomar desenvolvimento da feature user-authentication"
```

**Resposta:**
```markdown
## 🔄 Retomando: user-authentication

Sessão encontrada: .cursor/sessions/user-authentication/

📋 Estado Atual:
- Plan.md: Fase 2 de 4 em progresso
- Architecture.md: Completo
- Branch: feature/user-authentication

🎯 Próximo Passo:
Continuar implementação da Fase 2: "Criar endpoints de autenticação"

Executar `/engineer/work user-authentication` agora?
```

---

### Exemplo 2: Comparar Opções
**Comando:**
```bash
/onion "Qual a diferença entre /engineer/start e /product/task?"
```

**Resposta:**
```markdown
## 🔍 Comparação: /engineer/start vs /product/task

### /product/task
- **Quando:** Você ainda não tem task no ClickUp
- **Faz:** Cria task estruturada + sessão
- **Output:** Task no ClickUp + .cursor/sessions/
- **Próximo:** `/engineer/start`

### /engineer/start
- **Quando:** Você já tem task no ClickUp
- **Faz:** Análise + arquitetura + plano
- **Output:** architecture.md + plan.md
- **Próximo:** `/engineer/work`

### Fluxo Recomendado:
/product/task → /engineer/start → /engineer/work

Qual você precisa agora?
```

---

### Exemplo 3: Orquestração Multi-Agente
**Comando:**
```bash
/onion "Criar documentação técnica com diagramas C4 e Mermaid"
```

**Resposta:**
```markdown
## 📚 Documentação Técnica + Diagramas

Vou orquestrar 3 agentes especializados:

1. @system-documentation-orchestrator
   - Análise da arquitetura
   - Estrutura de documentação

2. @c4-architecture-specialist
   - Context diagram
   - Container diagram
   - Component diagram

3. @mermaid-specialist
   - Sequence diagrams
   - Flowcharts
   - State diagrams

Executar orquestração completa?
[Aguarda confirmação]
```

---

### Exemplo 4: Análise de Contexto
**Comando:**
```bash
/onion "Qual meu status atual no projeto?"
```

**Resposta:**
```markdown
## 📊 Status Atual do Projeto

### 🗂️ Sessões Ativas:
1. user-authentication (Fase 2/4)
2. payment-integration (Fase 1/3)

### 🌿 Git:
- Branch atual: feature/user-authentication
- Commits pendentes: 3
- Status: Clean

### 📋 ClickUp:
- Tasks em progresso: 2
- Tasks pendentes: 5
- Próximo deadline: 2 dias

### 🎯 Recomendação:
Completar user-authentication (50% pronto) antes de iniciar novas features.

Executar `/engineer/work user-authentication`?
```

---

## 🔧 Integração com Outros Comandos

### Comandos que Podem Invocar /onion:
- `/warm-up` - Pode chamar `/onion` para contexto inicial
- `/help` - Redireciona para `/onion` para ajuda específica
- Qualquer comando com erro pode sugerir `/onion` para troubleshooting

### Comandos que /onion Pode Invocar:
- **Todos os 54 comandos** do Sistema Onion
- Qualquer dos **38 agentes** especializados
- Workflows completos coordenados

---

## 🎯 Checklist de Validação

Após usar `/onion`, verifique:

### Resposta Recebida
- [ ] Resposta clara e estruturada
- [ ] Recomendações específicas fornecidas
- [ ] Exemplos práticos incluídos
- [ ] Próximos passos definidos

### Ação Apropriada
- [ ] Comando/agente recomendado faz sentido
- [ ] Contexto foi considerado corretamente
- [ ] Modo de operação apropriado (Consultivo/Proativo/Executivo)

### Execução (se aplicável)
- [ ] Ação executada conforme esperado
- [ ] ClickUp atualizado (se aplicável)
- [ ] Documentação gerada (se aplicável)
- [ ] Próximos passos claros

### Qualidade
- [ ] Solução resolve o problema
- [ ] Padrões do sistema seguidos
- [ ] Nomenclatura correta (`<feature-slug>`)
- [ ] Integração com ecossistema funcional

---

## 📚 Comandos Relacionados

### Comandos de Entrada:
- `/warm-up` - Carregar contexto geral
- `/help` - Ajuda sobre comandos específicos
- `/status` - Status atual do projeto

### Comandos de Produto:
- `/product/task` - Criar task estruturada
- `/product/spec` - Especificação técnica
- `/product/warm-up` - Contexto de produto

### Comandos de Engenharia:
- `/engineer/start` - Iniciar desenvolvimento
- `/engineer/work` - Implementar fases
- `/engineer/pr` - Criar Pull Request

### Comandos Meta:
- `/meta/create-agent` - Criar novo agente
- `/meta/create-command` - Criar novo comando
- `/meta/all-tools` - Ver todas as ferramentas

---

## 🔍 Troubleshooting

### Problema: Resposta muito genérica
**Causa:** Solicitação vaga ou sem contexto

**Solução:**
```bash
# Ruim
/onion "Ajuda"

# Bom
/onion "Como criar uma task no ClickUp para feature de autenticação?"
```

---

### Problema: Comando não executa automaticamente
**Causa:** Modo Consultivo ativo (padrão)

**Solução:**
```bash
# Para execução automática, use palavras-chave:
/onion "Executar hotfix para bug X"
/onion "Fazer deploy da feature Y"
```

---

### Problema: Agente @onion não encontrado
**Causa:** Agente não está no path correto

**Solução:**
Verificar que existe: `.cursor/agents/meta/onion.md`

---

### Problema: Contexto de sessão não detectado
**Causa:** Sessão não existe ou nome incorreto

**Solução:**
```bash
# Verificar sessões existentes
ls .cursor/sessions/

# Especificar sessão explicitamente
/onion "Trabalhar na sessão user-authentication"
```

---

### Problema: Integração ClickUp falha
**Causa:** Workspace ID não configurado ou permissões

**Solução:**
1. Verificar workspace ID em configuração
2. Validar token de API do ClickUp
3. Testar com comando direto: `/product/task "teste"`

---

## 💡 Dicas e Truques

### Dica 1: Use como Ponto de Entrada
Sempre que não souber qual comando usar, comece com `/onion`:
```bash
/onion "Preciso fazer X"
```

### Dica 2: Combine com Estado Atual
Mencione o que você já fez:
```bash
/onion "Já criei a task, agora quero começar desenvolvimento"
```

### Dica 3: Peça Comparações
```bash
/onion "Qual a diferença entre comando X e Y?"
```

### Dica 4: Use para Aprendizado
```bash
/onion "Me ensine sobre o fluxo de feature development"
```

### Dica 5: Troubleshooting Rápido
```bash
/onion "Erro: [copie a mensagem de erro aqui]"
```

### Dica 6: Orquestração Completa
```bash
/onion "Do zero ao deploy: feature de notificações"
```

### Dica 7: Contexto de Urgência
```bash
/onion "URGENTE: hotfix para bug crítico em produção"
```

---

## 📖 FAQ

**P: Qual a diferença entre `/onion` e `@onion`?**  
R: `/onion` é o comando (atalho otimizado), `@onion` é o agente (invocação direta). Use `/onion` para conveniência.

**P: Posso usar `/onion` para qualquer coisa?**  
R: Sim! É o ponto de entrada universal do Sistema Onion.

**P: O comando executa ações automaticamente?**  
R: Depende do modo. Consultivo (padrão) pede confirmação. Executivo executa automaticamente.

**P: Como ativar modo Executivo?**  
R: Use palavras como "executar", "fazer", "realizar" na solicitação.

**P: O comando pode invocar outros agentes?**  
R: Sim, o agente `@onion` pode delegar para qualquer dos 38 agentes especializados.

**P: Funciona com ClickUp?**  
R: Sim, tem integração completa com ClickUp MCP.

**P: Posso usar em qualquer etapa do desenvolvimento?**  
R: Sim, desde planejamento até deploy e manutenção.

**P: Como saber se minha solicitação foi bem interpretada?**  
R: A resposta sempre inclui análise da solicitação e próximos passos claros.

---

## 🎉 Resumo de Uso

### Sintaxe Básica:
```bash
/onion [sua solicitação]
```

### Exemplos Rápidos:
```bash
# Ajuda geral
/onion "Como funciona o sistema?"

# Criar task
/onion "Criar task para feature X"

# Iniciar desenvolvimento
/onion "Começar desenvolvimento de Y"

# Workflow completo
/onion "Desenvolver feature Z do zero ao deploy"

# Troubleshooting
/onion "Erro em comando W"

# Comparação
/onion "Diferença entre X e Y?"
```

### O Que Acontece:
1. ✅ Análise inteligente da solicitação
2. ✅ Preparação de contexto otimizado
3. ✅ Invocação do agente `@onion`
4. ✅ Resposta estruturada com recomendações
5. ✅ Execução (se apropriado)
6. ✅ Próximos passos claros

---

## 🚀 Comece Agora!

**Primeira vez?**
```bash
/onion "Sou novo no Sistema Onion, me ajude a começar"
```

**Tem uma tarefa específica?**
```bash
/onion "Preciso [descreva sua tarefa]"
```

**Quer explorar?**
```bash
/onion "Quais são as principais funcionalidades do sistema?"
```

---

**O Sistema Onion está pronto para orquestrar seu desenvolvimento! 🧅**

Use `/onion` como seu guia inteligente para navegar, aprender e executar com maestria.

