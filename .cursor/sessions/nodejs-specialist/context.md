# NodeJS Specialist Agent - Contexto de Desenvolvimento

## 📋 **Entendimento da Task**

### **Objetivo Principal**
Criar o **3º e último agente especializado** dos agentes complementares do Sistema Onion: um **NodeJS Specialist Agent** que complemente o ecossistema existente com expertise específica em desenvolvimento backend JavaScript/TypeScript.

### **Contexto da Task Pai**
- **Task Principal**: Implementar 3 Agentes Especialistas Complementares (`86abztwyp`)
- **Status**: Esta é a última subtask de 3 (ClickUp ✅ | Cursor ✅ | **NodeJS** 🔄)
- **Posição no Ecossistema**: Agente #15 de 15 total (expandindo de 12→15)

---

## 🎯 **Por que está sendo construído**

### **Gap Identificado**
- **Limitação atual**: `python-developer` cobre AI/ML, mas falta especialista backend JavaScript
- **Demanda crescente**: Muitos projetos Sistema Onion usam Node.js/TypeScript backend
- **Complementaridade**: Junto com `react-developer` (frontend) completa stack JavaScript

### **Valor Estratégico**
- ✅ **Cobertura completa**: Frontend (React) + Backend (Node.js)  
- ✅ **Especialização técnica**: Performance, TypeScript, moderne APIs
- ✅ **Integração natural**: NPM ecosystem, package.json management
- ✅ **Padrões modernos**: Express/Fastify, Jest/Vitest, GraphQL/REST

---

## 🚀 **Resultado Esperado**

### **Deliverables Técnicos**
1. **Agent File**: `.cursor/agents/development/nodejs-specialist.md`
   - YAML header completo (name, description, model, tools, color, priority, expertise)
   - Especialidades bem definidas (7 áreas técnicas)
   - Exemplos práticos de uso
   - Integração com comandos existentes

2. **Documentação Atualizada**:
   - Seção específica em `docs/onion/agents-reference.md`
   - Badge atualizada em `README.md` (15 agentes)
   - Referências em `.cursorrules` (se aplicável)

### **Características Funcionais**
- **Delegação automática**: Reconhecido pelos comandos `/engineer/*`
- **Especialização técnica**: 7 expertise areas bem definidas
- **Integração proativa**: Uso proativo para tarefas Node.js complexas
- **Ferramentas completas**: read, write, MultiEdit, terminal, search, web_search

---

## 🛠️ **Abordagem Técnica**

### **Padrão de Implementação**
Seguir **exatamente** o padrão dos agentes existentes:
- **Estrutura**: Mesmo YAML header format dos outros agents
- **Ferramentas**: Conjunto padrão + web_search para packages/practices  
- **Color**: Escolher cor única não usada (candidatas: `green`, `teal`, `indigo`)
- **Priority**: `alta` (mesmo padrão dos especialistas técnicos)
- **Model**: `sonnet` (padrão para desenvolvimento)

### **Especialidades Definidas** (7 áreas)
1. **nodejs**: Runtime, performance, ecosystem
2. **typescript-backend**: Configuração, types, compilation  
3. **api-development**: REST/GraphQL, Express/Fastify patterns
4. **npm-ecosystem**: Package management, dependencies, scripts
5. **testing-frameworks**: Jest/Vitest, unit/integration tests
6. **performance-optimization**: Memory, CPU, profiling
7. **security-best-practices**: Vulnerabilities, authentication, validation

---

## 🔧 **APIs/Ferramentas Necessárias**

### **Ferramentas Padrão** (confirmadas nos outros agents)
- `read_file`, `write`, `search_replace`, `MultiEdit` - Edição de código
- `run_terminal_cmd` - NPM commands, builds, tests  
- `read_lints`, `todo_write`, `codebase_search` - Development workflow
- `web_search` - **Específico**: Research packages, best practices

### **Knowledge Base**
- ✅ **Fastify**: Performance-first framework (561 code snippets, Trust 10)
- ✅ **Express**: Standard framework patterns  
- ✅ **TypeScript**: Backend configuration, strict typing
- ✅ **NPM Ecosystem**: Package.json, dependency management
- ✅ **Testing**: Jest/Vitest modern patterns
- ✅ **Performance**: Profiling, optimization techniques

---

## 📐 **Restrições e Dependências**

### **Restrições Técnicas**
- **Padrão obrigatório**: Seguir estrutura YAML exata dos agents existentes
- **Ferramentas limitadas**: Usar apenas tools disponíveis no sistema
- **Color única**: Não conflitar com cores dos 14 agentes existentes
- **Expertise focused**: 7 áreas específicas, evitar overlap com outros agents

### **Dependências do Sistema**
- ✅ Sistema Onion funcionando (pré-requisito atendido)
- ✅ Estrutura `.cursor/agents/development/` existente
- ✅ Padrões de documentação estabelecidos  
- ✅ Pipeline de atualização (README, agents-reference)

### **Dependências Externas**
- **Context7**: Para pesquisa de libraries atualizadas
- **Web Search**: Para best practices Node.js/TypeScript 2024
- **NPM Registry**: Para validação de packages e versions

---

## 🧪 **Como deve ser testado**

### **Testes de Integração**
1. **Delegação automática**: 
   - Comandos `/engineer/*` devem reconhecer o agente
   - Invocação `@nodejs-specialist` deve funcionar
   - Contexto Node.js deve acionar automaticamente

2. **Funcionalidade técnica**:
   - Criação de APIs Express/Fastify  
   - Configuração TypeScript backend
   - Debugging de performance issues
   - Package.json management

### **Testes de Qualidade**
- ✅ **Lint validation**: YAML structure válida
- ✅ **Documentation**: Seção completa em agents-reference.md
- ✅ **Consistency**: Padrão igual aos outros 14 agents
- ✅ **No conflicts**: Color, expertise unique

---

## ❓ **Principais Clarificações Necessárias**

### **1. Color Selection**
**Pergunta**: Qual cor usar para o NodeJS Specialist Agent?
**Contexto**: Colors já usadas: blue, yellow, purple, green, cyan, orange, red, lightblue
**Sugestão**: `teal` ou `indigo` (cores Node.js-friendly não usadas)

### **2. Expertise Specificity**  
**Pergunta**: As 7 expertise areas estão bem balanceadas entre generalistas e específicas?
**Contexto**: Evitar overlap com `python-developer` (backend) e `react-developer` (JavaScript)
**Sugestão**: Focar em Node.js runtime, TypeScript backend, modern APIs

### **3. Tool Integration**
**Pergunta**: `web_search` é necessário para research de packages NPM?
**Contexto**: Node.js ecosystem muda rapidamente, precisa de info atualizada
**Sugestão**: Incluir para best practices e packages research

### **4. Proactive Usage**
**Pergunta**: Quando deve ser usado PROATIVAMENTE vs sob demanda?
**Contexto**: Outros agents têm "use PROATIVAMENTE para..." guidelines  
**Sugestão**: Proativo para APIs complexas, performance issues, TypeScript configs

### **5. Examples Complexity**
**Pergunta**: Que nível de complexidade ter nos exemplos de uso?
**Contexto**: Balancear utilidade vs readability na documentação
**Sugestão**: 3 exemplos: simples (API basic), médio (TypeScript config), complexo (performance debugging)

---

## 🎖️ **Minha Recomendação**

Prosseguir com **implementação completa** seguindo:
1. **Color**: `teal` (JavaScript ecosystem-friendly)  
2. **Expertise**: 7 areas balanceadas (nodejs, typescript-backend, apis, npm, testing, performance, security)
3. **Tools**: Padrão + web_search para packages research
4. **Proactive**: APIs complexas, performance, TypeScript backend configs
5. **Examples**: 3 níveis de complexidade para diferentes use cases

**Ready to proceed**: ✅ Entendimento completo, clarificações identificadas, próximo passo é architecture.md
