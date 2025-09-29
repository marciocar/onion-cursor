# Implementation Plan - ChatGPT CodeReview

## 🎯 **Overview**
Implementação sistemática do ChatGPT-CodeReview seguindo padrão Feature Development com 3 subtasks sequenciais.

---

## 🔧 **Subtask 1: Setup GitHub Action e Configuração Base**
**ID**: 86ac55z1c | **Status**: Pending

### **Action Items Específicos**
1. **Criar Workflow YAML**
   - Arquivo: `.github/workflows/code-review.yml`
   - Base: configuração existente + otimizações para o projeto
   - Triggers: PR opened, synchronize, reopened
   - Branches: main, develop, release/**

2. **Configurar File Detection**  
   - Usar `tj-actions/changed-files@v41`
   - Include patterns: TS, TSX, JS, JSX, JSON, Prisma
   - Exclude patterns: node_modules, dist, build, tests, .md

3. **Setup Environment**
   - GitHub Secrets: OPENAI_API_KEY 
   - Permissions: contents:read, pull-requests:write, issues:write
   - Timeout: 15 minutes (resource optimization)

4. **Dependencies Integration**
   - `anc95/ChatGPT-CodeReview@main` (action principal)
   - `actions/github-script@v7` (summary comments)
   - Error handling básico

### **Acceptance Criteria**
- [ ] Workflow YAML syntactically valid
- [ ] File filtering funcionando corretamente
- [ ] Secrets configurados e testados
- [ ] Permissions mínimas aplicadas
- [ ] No changes detected scenario handled

---

## 🎯 **Subtask 2: Personalização de Prompt para Stack do Projeto**  
**ID**: 86ac55z1b | **Status**: Pending | **Depends**: 86ac55z1c

### **Action Items Específicos**
1. **Desenvolver Prompt Customizado**
   - Contexto: Revisor sênior JavaScript/TypeScript
   - Stack awareness: Nx 21 + ZenStack + Fastify + React Query
   - Language: pt-BR obrigatório

2. **Diretrizes Específicas**
   - **Nx Architecture**: boundaries, apps vs libs, path aliases
   - **Backend (Fastify + ZenStack)**: schemas Zod, performance, security
   - **Frontend (React + React Query)**: hooks, state management, memoization  
   - **Code Quality**: nomenclature, edge cases, testing needs

3. **Output Configuration**
   - Model: GPT-4o (máxima qualidade)  
   - Temperature: 0.7 (criatividade equilibrada)
   - Max tokens: 12000 (reviews detalhados)
   - Top_p: 1 (diversidade completa)

4. **Categorização Visual**
   - 🔴 Crítico: segurança, bugs graves
   - 🟡 Importante: performance, arquitetura  
   - 🔵 Sugestão: melhorias, refactoring
   - ✅ Positivo: boa implementação

### **Acceptance Criteria**  
- [ ] Prompt reconhece padrões do stack
- [ ] Feedback 100% em português brasileiro
- [ ] Emojis categorizando por severidade
- [ ] Sugestões específicas e acionáveis
- [ ] Configuração GPT otimizada

---

## ✅ **Subtask 3: Testes de Integração e Validação**
**ID**: 86ac55z1d | **Status**: Pending | **Depends**: 86ac55z1b  

### **Action Items Específicos**

#### **Configuration Testing**
1. **Secrets & Permissions Validation**
   - Testar OPENAI_API_KEY funcionando
   - Validar write permissions no PR
   - Confirmar timeout não causing failures

2. **Workflow Syntax Testing**  
   - GitHub Actions syntax validator
   - Dry-run sem API calls
   - YAML linting passed

#### **Functional Testing**
3. **File Filter Testing**
   - Create test PR with mixed file types
   - Validate TypeScript/JavaScript reviewed
   - Confirm tests/docs/configs ignored
   - Ensure no false positives

4. **Quality Assurance Testing**
   - Stack patterns recognition test
   - pt-BR language validation
   - Emoji categorization accuracy
   - Actionable feedback verification

#### **Integration Scenarios**
5. **Backend Changes PR**
   - Modify Fastify + ZenStack files  
   - Expect security/performance feedback
   - Validate schema validation suggestions

6. **Frontend Changes PR**  
   - Modify React + React Query components
   - Expect hooks/state management review
   - Validate memoization recommendations

7. **Nx Boundaries Violation**
   - Create incorrect lib imports
   - Expect boundary violation detection
   - Validate architectural guidance

#### **Documentation & Handoff**
8. **Complete Documentation**
   - `docs/onion/code-review-integration.md`
   - Usage examples with screenshots
   - Troubleshooting common issues
   - Team training materials

9. **Performance Benchmarking**
   - Baseline CI/CD time measurement
   - Code review additional time impact
   - GitHub Actions minutes consumption
   - OpenAI API rate limits monitoring

### **Acceptance Criteria**
- [ ] Full test battery executed and documented
- [ ] Example PR with quality feedback working
- [ ] Complete documentation in docs/onion/
- [ ] Performance impact < 2 minutes additional  
- [ ] Zero false positives in file filtering
- [ ] 100% feedback in Portuguese  
- [ ] Smooth integration with existing workflow
- [ ] Team trained and process documented

---

## 🔄 **Dependencies & Flow**

```
Setup GitHub Action (86ac55z1c)
         ↓
Prompt Customization (86ac55z1b)  
         ↓
Testing & Validation (86ac55z1d)
```

## ⚡ **Key Success Factors**
1. **Incremental Testing**: Validar cada subtask antes de prosseguir
2. **Documentation First**: Documentar decisões e configurações
3. **Performance Monitoring**: Medir impacto em cada iteração  
4. **Team Feedback**: Coletar feedback early e adjust accordingly

## 🚀 **Ready for Development**
Use `/engineer/start configure-chatgpt-codereview` para iniciar implementação seguindo este plano sequencial.
