# Task Context - Configurar ChatGPT-CodeReview

## 📋 ClickUp Structure
**Task ID**: 86ac55z0c  
**Task URL**: https://app.clickup.com/t/86ac55z0c  
**Estimation**: 6-8 story points / 3-4 dias

### **🔧 Subtasks Criadas**
1. **86ac55z1c** - 🔧 Setup GitHub Action e Configuração Base
2. **86ac55z1b** - 🎯 Personalização de Prompt para Stack do Projeto  
3. **86ac55z1d** - ✅ Testes de Integração e Validação

## 🏗️ Decomposition Overview
**Pattern Used**: Feature Development (automação de code review)  
**Subtasks**: 3 componentes funcionais  
**Action Items**: Implementados via checklists nativos do ClickUp  
**Dependencies**: Setup → Customization → Testing (sequencial)

## 🎯 Success Metrics
- GitHub Action funcional em novos PRs
- 100% feedback em português brasileiro  
- Zero falsos positivos no file filtering
- Performance impact < 2 minutos no CI/CD
- Stack awareness (Nx + ZenStack + Fastify + React Query)

## 🔧 Technical Context
**Affected Components**: 
- `.github/workflows/code-review.yml` (novo)
- GitHub repository secrets e permissions
- `docs/onion/code-review-integration.md` (documentação)

**Stack/Technologies**: 
- GitHub Actions + anc95/ChatGPT-CodeReview@main  
- OpenAI API (GPT-4o model)
- File filtering: TS, TSX, JS, JSX, JSON, Prisma
- Monorepo Nx 21 + pnpm + ZenStack + Fastify

**Integration Points**:
- CI/CD workflow existente
- Sistema Onion commands `/engineer/*`
- Fluxo de desenvolvimento com branches e PRs

## 📝 Implementation Strategy
**Phase 1**: Setup Infrastructure (Subtask 86ac55z1c)
- Criar workflow YAML otimizado
- Configurar secrets e permissions
- Implementar file filtering para monorepo

**Phase 2**: Prompt Customization (Subtask 86ac55z1b)  
- Desenvolver prompt especializado no stack
- Configurar parâmetros GPT (pt-BR, temperature, tokens)
- Implementar diretrizes específicas (Nx boundaries, ZenStack patterns)

**Phase 3**: Testing & Validation (Subtask 86ac55z1d)
- Bateria de testes sistemáticos
- PRs de exemplo para diferentes cenários  
- Documentação completa e team training
- Performance benchmarking

## 🗺️ **PHASE-SUBTASK MAPPING**
**Sistema automático de correlação entre fases de desenvolvimento e subtasks ClickUp:**

### **Phase 1 → Subtask 86ac55z1c** 
- **Nome**: 🔧 Setup GitHub Action e Configuração Base
- **Correlação**: CREATE MODE implementation
- **Objetivo**: Detectar stack + gerar template otimizado + criar arquivo

### **Phase 2 → Subtask 86ac55z1b**
- **Nome**: 🎯 Personalização de Prompt para Stack do Projeto  
- **Correlação**: VALIDATE MODE implementation
- **Objetivo**: Análise configuração + recomendações + auto-fix

### **Phase 3 → Subtask 86ac55z1d**
- **Nome**: ✅ Testes de Integração e Validação
- **Correlação**: STATUS MODE + documentation + testing
- **Objetivo**: Dashboard status + documentação + testes

## 🔄 **ESTRUTURA HÍBRIDA DETECTADA**
- **Task Principal**: Descrições markdown completas ✅
- **Subtasks**: Descrições markdown detalhadas ✅ 
- **Checklists Nativos**: Não implementados (usar descrições)
- **Monitoramento**: Baseado em status das subtasks individuais

## 🚀 Next Steps
1. Review structure in ClickUp ✅ (Concluído)
2. Execute: `/engineer/start configure-chatgpt-codereview` ✅ (Concluído)
3. **ARQUITETURA DEFINIDA**: Comando `/git/code-review` Sistema Onion ✅
4. **PRÓXIMO**: Implementar lógica de detecção inteligente
5. Follow implementation plan per phase-subtask mapping

## 📚 Key References
- **GitHub Repo**: https://github.com/anc95/ChatGPT-CodeReview (4.4k stars)
- **Action Marketplace**: https://github.com/marketplace/actions/chatgpt-codereviewer  
- **Documentation**: README com examples e configuração
- **Current Workflow**: `.github/workflows/code-review.yml` (base para otimização)

## 🔗 Integration Commands
- `/engineer/start configure-chatgpt-codereview` - Iniciar desenvolvimento
- `/product/task-check 86ac55z0c` - Verificar progresso da task
- `/engineer/pr` - Criar PR quando pronto
- `/git/sync` - Sincronizar após merge
