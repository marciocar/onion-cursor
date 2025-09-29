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

## 🚀 Next Steps
1. ✅ Environment setup (branch + session) - CONCLUÍDO
2. 🔄 Remover arquivos backup e desnecessários - EM PROGRESSO
3. ⏳ Refatorar comandos individuais seguindo padrão
4. ⏳ Testing e validation
5. ⏳ Final cleanup e documentation
