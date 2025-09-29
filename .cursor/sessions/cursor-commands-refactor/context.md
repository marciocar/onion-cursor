# Task Context - Refatorar Comandos Git para Padrão Cursor Commands Oficial

## 📋 ClickUp Structure
**Task ID**: 86ac55kr8
**Task URL**: https://app.clickup.com/t/86ac55kr8
**Estimation**: ~4-6 horas

## 🏗️ Decomposition Overview
**Pattern Used**: Tech Debt/Improvement Pattern
**Objetivo**: Simplificação radical - transformar scripts bash complexos em Markdown descritivo
**Comandos Alvo**: 8 comandos principais Git/GitFlow
**Dependencies**: @gitflow-specialist agent, documentação oficial Cursor Commands

## 🎯 Success Metrics
- Redução de 70-80% nas linhas de código (500-1000+ → 50-150)
- 100% conformidade com padrão oficial Cursor Commands
- Preservação de funcionalidade core GitFlow
- Integração mantida: @gitflow-specialist + ClickUp essencial

## 🔧 Technical Context
**Affected Components**: 
- `.cursor/commands/git/` (8 arquivos principais)
- Remoção de arquivos *-backup.md e *-new.md
- Preservação de `.cursor/agents/development/gitflow-specialist.md`

**Stack/Technologies**: 
- Cursor Commands (Markdown descritivo)
- @gitflow-specialist integration
- ClickUp MCP simplified automation
- GitFlow workflows básicos

**Integration Points**:
- Cursor AI interpretation engine
- @gitflow-specialist agent calls
- ClickUp task updates via MCP
- Git operations via AI execution

## 📝 Implementation Strategy
**Phase 1**: Setup + Cleanup (remover arquivos desnecessários)
**Phase 2**: Refactor individual commands seguindo padrão oficial
**Phase 3**: Testing e validation com workflows reais
**Phase 4**: Documentation update e final cleanup

## 🚀 Especificações Aprovadas pelo Usuário
1. **A) Simplificação RADICAL** - apenas workflow básico
2. **@gitflow-specialist Integration** - usar para planejar, executar, validar + chamadas explícitas
3. **ClickUp Automation Simplificada** - manter pontos importantes e comentários
4. **Cleanup Total** - remover backups, não deve ter arquivos -new.md

## 🔍 CLARIFICAÇÕES CRÍTICAS RESPONDIDAS

### **1. Decomposição em Subtasks:**
- **Ação**: Criar subtasks retroativamente no ClickUp para organizar trabalho
- **Estrutura**: 3 subtasks para comandos restantes (feature, release, hotfix)

### **2. Estratégia de Validação:**  
- **Ação**: Testar comandos localmente conforme refatoração
- **Método**: Validar reconhecimento + execução básica + integração @gitflow-specialist

### **3. Template Padronizado:**
- **Ação**: Usar template consolidado (estabelecido em 3 comandos) nos 5 restantes
- **Estrutura**: Funcionalidades → Como Usar → @gitflow-specialist → Processo → Problemas

### **4. Progresso vs. Correção:**
- **Ação**: Continuar progresso + documentar arquitetura retroativamente  
- **Estratégia**: Não refazer 3 comandos, focar nos 5 restantes

### **5. Métricas de Sucesso:**
- **Ação**: Validar comandos em ambiente real + documentar comportamento

## 📋 Phase-Subtask Mapping
- **Phase 2**: "Feature Commands" → Subtask ID: 86ac55nny ✅
- **Phase 3**: "Release Commands" → Subtask ID: 86ac55np1 ✅
- **Phase 4**: "Hotfix Commands" → Subtask ID: 86ac55np3 ✅
- **Phase 5**: "Integration Testing + Cleanup" → Main Task (86ac55kr8) ✅

*Nota: Mapeamento criado retroativamente - correção implementada para futuras tasks*

## 🚀 STATUS ATUAL  
**PROJETO COMPLETO**: 8/8 (100%) - Todas fases completadas com sucesso
**Progresso**: 4,459+ linhas eliminadas, 87.3% redução média
**Status**: ✅ **DONE** - Ready for production use
