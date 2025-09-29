# Development Notes - ChatGPT CodeReview

## 🧠 **Decision Log**

### **Technology Choice: anc95/ChatGPT-CodeReview**
**Date**: 29/09/2025  
**Decision**: Usar anc95/ChatGPT-CodeReview@main como base
**Rationale**: 
- 4.4k stars, mantido ativamente (último update agosto 2025)
- Suporta GPT-4o e configuração customizada  
- Marketplace verified action
- Documentação completa e community support
- Suporte nativo para GitHub Models (futuro)

**Alternatives Considered**:
- ChatGPT GitHub Actions (menos stars)
- Custom implementation (muito tempo de desenvolvimento)
- **Winner**: anc95 pela maturidade e suporte

---

### **Model Choice: GPT-4o**  
**Date**: 29/09/2025
**Decision**: GPT-4o em vez de GPT-3.5-turbo
**Rationale**:
- Melhor compreensão de contexto arquitetural  
- Qualidade superior em português brasileiro
- Melhor performance em code analysis
- Worth extra cost para quality of reviews

**Configuration**:
```yaml
MODEL: gpt-4o
temperature: 0.7    # Balanced creativity
max_tokens: 12000   # Detailed reviews
top_p: 1           # Full diversity
LANGUAGE: pt-BR    # Mandatory Portuguese
```

---

### **File Filtering Strategy**
**Date**: 29/09/2025  
**Decision**: Conservative approach - only relevant files
**Include**: TS, TSX, JS, JSX, JSON, Prisma
**Exclude**: Tests, docs, configs, generated files

**Rationale**:
- Avoid noise from irrelevant files
- Focus on business logic and architecture
- Reduce API costs by filtering early
- Better signal-to-noise ratio

**Special Considerations**:
- JSON included for package.json, tsconfig.json changes
- Prisma included for schema changes (ZenStack integration)
- Tests excluded to avoid review noise (focus on implementation)

---

## 🎯 **Implementation Decisions**

### **Sequential Subtask Approach**  
**Decision**: Setup → Customization → Testing (não paralelo)
**Rationale**: 
- Infrastructure must exist before customization  
- Testing requires both setup and customization complete
- Clear dependencies and validation points  
- Easier debugging and rollback

### **Portuguese-First Strategy**
**Decision**: 100% Portuguese feedback obrigatório
**Implementation**: 
- LANGUAGE: pt-BR in environment
- Prompt explicitly requests Portuguese
- Test validation for language compliance
- No fallback to English accepted

### **Monorepo Optimization**
**Decision**: Nx-aware file filtering and boundaries detection
**Implementation**:
- File patterns optimized for Nx structure
- Prompt includes Nx boundary concepts  
- Specific guidance for apps vs libs
- Path alias validation included

---

## 🔍 **Technical Considerations**

### **Performance Targets**
- **Total Time**: < 2 minutos additional per PR
- **API Calls**: Single call per changed file (efficient)
- **GitHub Actions**: < 5 minutes per PR (reasonable)
- **Rate Limiting**: Respect OpenAI limits (monitoring needed)

### **Error Handling Strategy**  
- **API Failures**: Graceful degradation, don't block PR
- **Timeout**: 15 minutes max (protection against hangs)
- **Large Files**: Skip files > MAX_PATCH_LENGTH (configurable)  
- **Network**: Retry logic for transient failures

### **Security Considerations**
- **Secrets**: OPENAI_API_KEY as GitHub secret only
- **Permissions**: Minimal required (read contents, write PRs)
- **Data**: No sensitive data in logs or comments
- **API**: HTTPS only, no data persistence in OpenAI

---

## 📝 **Development Notes**

### **Testing Strategy**  
1. **Unit-level**: Individual components (workflow syntax, etc)
2. **Integration**: Full PR scenarios with different file types
3. **User Acceptance**: Real-world scenarios with team feedback
4. **Performance**: Baseline vs post-implementation comparison

### **Rollback Plan**
- **Quick Disable**: Comment out workflow trigger
- **Gradual Rollback**: Revert to branch filtering (only specific branches)  
- **Full Rollback**: Delete workflow file  
- **Monitoring**: GitHub Actions logs + OpenAI usage dashboard

### **Future Enhancements** 
- **Custom Model**: Train on codebase patterns (future)
- **Integration**: Link with ClickUp for automated task updates
- **Analytics**: Track review effectiveness and team adoption
- **A/B Testing**: Compare review quality with different prompts

---

## 🎨 **Prompt Engineering Notes**

### **Prompt Structure**
1. **Role Definition**: Senior reviewer with specific expertise
2. **Stack Context**: Explicit technology stack listing
3. **Review Guidelines**: Specific areas of focus 
4. **Output Format**: Structured feedback with categorization
5. **Language**: Explicit Portuguese requirement

### **Stack-Specific Patterns**
- **Nx**: Boundary violations, proper imports, workspace structure
- **ZenStack**: Schema patterns, generated client usage, security  
- **Fastify**: Plugin architecture, validation, performance
- **React Query**: Cache management, state synchronization, error handling

### **Review Categories**  
- **🔴 Critical**: Security, data corruption, runtime errors
- **🟡 Important**: Performance, architecture, maintainability  
- **🔵 Suggestion**: Refactoring, optimization, best practices
- **✅ Positive**: Good implementations worth highlighting

---

## 🚀 **Ready for Implementation**

**Status**: ✅ Planning Complete  
**Next Step**: `/engineer/start configure-chatgpt-codereview`  
**Implementation Order**: 
1. GitHub Action setup (infrastructure)  
2. Prompt customization (intelligence)
3. Testing and validation (quality)

**Success Metrics**: 
- Setup time < 1 day
- First working review < 2 days  
- Full validation < 4 days total
