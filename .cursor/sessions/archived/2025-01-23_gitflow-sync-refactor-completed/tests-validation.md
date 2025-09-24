# 🧪 Suíte de Testes - GitFlow Integration

## 📋 **Testes de Validação dos Comandos**

### **Test Suite 1: /product/feature**
```bash
# T1.1 - Criação de Task ClickUp
TESTE: /product/feature "nova-funcionalidade"
ESPERADO: 
  ✅ Task criada no ClickUp com status "Backlog"
  ✅ Tag "backlog" adicionada
  ✅ Descrição formatada corretamente
  ✅ Sem branch ou sessão criada

# T1.2 - Auto-detecção de Contexto
TESTE: /product/feature dentro de sessão existente
ESPERADO:
  ✅ Detecta lista da sessão atual
  ✅ Usa contexto de projeto existente
  ✅ Mantém consistência de nomenclatura

STATUS: [ ] PENDENTE [ ] PASSED [ ] FAILED
```

### **Test Suite 2: /git/feature/start**
```bash
# T2.1 - GitFlow Branch Creation
TESTE: /git/feature/start "nova-funcionalidade"
ESPERADO:
  ✅ @gitflow-specialist chamado corretamente
  ✅ Branch feature/nova-funcionalidade criada
  ✅ Sessão .cursor/sessions/nova-funcionalidade/ criada
  ✅ Context.md com task ID (se detectado)

# T2.2 - Integration com ClickUp
TESTE: Feature start com task existente
ESPERADO:
  ✅ Detecta task ClickUp existente
  ✅ Status atualizado para "In Progress"
  ✅ Tags atualizadas (+in-progress)
  ✅ Link bidirecional sessão ↔ task

# T2.3 - GitFlow Analysis
TESTE: Diferentes tipos de repositório
ESPERADO:
  ✅ Detecta GitFlow vs GitHub-Flow vs GitLab-Flow
  ✅ Base branch correta selecionada
  ✅ Timeout/retry funciona (simulation)
  ✅ Fallback inteligente quando agente indisponível

STATUS: [ ] PENDENTE [ ] PASSED [ ] FAILED
```

### **Test Suite 3: /git/sync**
```bash
# T3.1 - Fase 2.5 GitFlow Analysis
TESTE: /git/sync após merge de feature branch
ESPERADO:
  ✅ @gitflow-specialist chamado com contexto correto
  ✅ Estratégia "feature-cleanup" aplicada
  ✅ Análise JSON validada corretamente
  ✅ Display formatado profissionalmente

# T3.2 - Performance Optimizations
TESTE: Sync com cache habilitado
ESPERADO:
  ✅ Cache hit para contexto similar (simulação)
  ✅ Operações paralelas executadas
  ✅ Network timeouts otimizados
  ✅ < 3s para 95% das operações (benchmark)

# T3.3 - Estratégias de Sync
TESTE: Diferentes tipos de branch
ESPERADO:
  feature/* → strategy: "feature-cleanup" ✅
  hotfix/* → strategy: "hotfix-sync" ✅  
  develop → strategy: "standard" ✅
  same branch → strategy: "no-op" ✅

# T3.4 - ClickUp Integration
TESTE: Sync com task ID válido
ESPERADO:
  ✅ Status movido para "Done"
  ✅ Tags atualizadas (+completed, -in-progress)
  ✅ Comentário de conclusão adicionado
  ✅ Graceful degradation se API falhar

# T3.5 - Session Management
TESTE: Sync com sessão ativa
ESPERADO:
  ✅ Detecta sessão com arquivos importantes
  ✅ Prompt de arquivamento (simulação)
  ✅ Archive para .cursor/sessions/archived/
  ✅ Metadata preservado corretamente

STATUS: [ ] PENDENTE [ ] PASSED [ ] FAILED
```

### **Test Suite 4: /engineer/pr**
```bash
# T4.1 - Workflow Completo
TESTE: /engineer/pr após desenvolvimento
ESPERADO:
  ✅ Steps 1-9 funcionam como antes
  ✅ Step 10 (auto-sync) documentado
  ✅ Template ClickUp inclui GitFlow section
  ✅ Output final com informações pós-merge

# T4.2 - Integration Pós-Merge
TESTE: Simulação de merge do PR
ESPERADO:
  ✅ /git/sync executa automaticamente
  ✅ GitFlow analysis aplicada
  ✅ Session archived se aplicável
  ✅ Task movida para "Done"

STATUS: [ ] PENDENTE [ ] PASSED [ ] FAILED
```

---

## 🔄 **Testes de Integração End-to-End**

### **Workflow Completo: Planejamento → Desenvolvimento → Finalização**
```bash
# E2E-1: Feature Completa
CENÁRIO: Nova funcionalidade do zero ao deploy
STEPS:
  1. /product/feature "user-authentication"
  2. [Planejamento manual]
  3. /git/feature/start "user-authentication"  
  4. [Desenvolvimento iterativo]
  5. /engineer/pr
  6. [Code review e merge]
  7. [Auto-sync pós-merge]

VALIDAÇÕES:
  ✅ Task criada → developed → completed
  ✅ Branch criada → merged → cleaned
  ✅ Session criada → used → archived
  ✅ GitFlow compliance em todas etapas
  ✅ Performance dentro de limites

STATUS: [ ] PENDENTE [ ] PASSED [ ] FAILED
```

---

## ⚡ **Testes de Performance**

### **Benchmarks S3.3 Optimizations**
```bash
# P1 - Cache GitFlow Analysis
TESTE: Análise repetida com contexto similar
TARGET: 70%+ cache hit rate
MEDIDA: [ ] ms primeiro call, [ ] ms cached call

# P2 - Operações Paralelas  
TESTE: Context detection simultânea
TARGET: 30% improvement vs sequencial
MEDIDA: [ ] ms paralelo vs [ ] ms sequencial

# P3 - Network Optimization
TESTE: Git operations com timeouts otimizados
TARGET: 50% faster git ops
MEDIDA: [ ] ms otimizado vs [ ] ms padrão

# P4 - Latência Total
TESTE: /git/sync completo
TARGET: < 3s para 95% das operações
MEDIDA: [ ] s médio, [ ] s p95, [ ] s p99

STATUS: [ ] PENDENTE [ ] PASSED [ ] FAILED
```

---

## 🛡️ **Testes de Regression**

### **Compatibilidade com Sistema Onion Existente**
```bash
# R1 - Comandos Não Modificados
TESTE: Comandos /engineer/* e /product/* não alterados
ESPERADO: Funcionam exatamente como antes
STATUS: [ ] PENDENTE [ ] PASSED [ ] FAILED

# R2 - Padrões Sistema Onion
TESTE: Formatação, templates, estrutura
ESPERADO: 100% aderência aos padrões
STATUS: [ ] PENDENTE [ ] PASSED [ ] FAILED

# R3 - Agentes Especializados
TESTE: @gitflow-specialist integration
ESPERADO: Não quebra outros agentes
STATUS: [ ] PENDENTE [ ] PASSED [ ] FAILED
```

---

## 📊 **Test Execution Report**

### **Summary**
- **Total Tests**: 20+ test cases
- **Test Suites**: 4 comandos + 1 E2E + Performance + Regression  
- **Estimated Time**: 1h (30min validation + 15min compatibility + 15min performance)
- **Success Criteria**: 95%+ pass rate

### **Execution Log**
```bash
# Executar testes manualmente e marcar resultados:
[ ] Test Suite 1: /product/feature (5 min)
[ ] Test Suite 2: /git/feature/start (15 min)  
[ ] Test Suite 3: /git/sync (20 min)
[ ] Test Suite 4: /engineer/pr (5 min)
[ ] E2E Workflow Test (10 min)
[ ] Performance Benchmarks (3 min)
[ ] Regression Tests (2 min)
```

---

**Test Suite Status**: 🔄 CRIADO - PRONTO PARA EXECUÇÃO
**Next Step**: Executar validações manuais conforme checklist acima
