# 🗺️ Roadmap de Desacoplamento ClickUp

## 🎯 Objetivo

Remover acoplamento dos comandos `engineer` e `product` em relação ao MCP do ClickUp, centralizando abstrações e padrões.

---

## 📊 Estado Atual

### Acoplamento Identificado:

```
Arquivos com acoplamento:
├── .claude/commands/engineer/work.md              (Alto)
├── .claude/commands/engineer/pr.md                (Alto)
├── .claude/commands/engineer/pre-pr.md            (Alto)
├── .claude/commands/engineer/pr-update.md         (Alto)
├── .claude/commands/product/task.md               (Médio)
├── .claude/commands/product/presentation.md       (Baixo)
└── .claude/commands/product/checklist-sync.md     (Baixo)

Duplicação de padrões:
├── Templates de comentários                       (5 locais)
├── Padrões de separadores                         (6 locais)
├── Exemplos de mcp_clickup_*                      (4 locais)
└── Pseudocódigo de formatação                     (3 locais)
```

---

## 🚀 Fases de Implementação

### FASE 1: Preparação (1-2 horas)

**Objetivo**: Criar infraestrutura para desacoplamento

- [ ] Criar `.claude/utils/clickup-mcp-wrappers.md`
  - Documentar abstrações necessárias
  - Definir assinatura de funções
  - Criar exemplos de uso

- [ ] Criar `.claude/docs/strategies/clickup-comment-patterns.md`
  - Centralizar TODOS os padrões de comentário
  - Remover de outros arquivos
  - Definir "source of truth"

- [ ] Criar `.claude/docs/architecture/desacoplamento-roadmap.md`
  - Este arquivo
  - Documentar progresso

**Status**: ⬜ Não iniciado

---

### FASE 2: Refatoração de Padrões (2-3 horas)

**Objetivo**: Centralizar padrões, remover duplicação

#### 2.1 - Consolidar Templates de Comentários

- [ ] **task.md** - Remover exemplos inline
  - Remover templates JavaScript
  - Remover pseudocódigo MCP
  - Referenciar estratégias centralizadas

- [ ] **work.md** - Remover templates de comentários
  - Remover exemplo de `detailedComment`
  - Remover exemplo de `summaryComment`
  - Referenciar estratégias centralizadas

- [ ] **pr.md** - Remover templates inline
  - Remover exemplo de comentário PR criada
  - Referenciar estratégias

- [ ] **pr-update.md** - Remover templates inline
  - Remover exemplo de comentário PR atualizada
  - Referenciar estratégias

- [ ] **pre-pr.md** - Remover templates inline
  - Remover exemplo de comentário de validação
  - Referenciar estratégias

#### 2.2 - Consolidar Separadores

- [ ] Verificar consistência de separadores em:
  - `work.md` ✅ (já reduzido)
  - `pr.md` ✅ (já reduzido)
  - `pre-pr.md` ✅ (já reduzido)
  - `pr-update.md` ✅ (já reduzido)
  - Documentação estratégias ✅ (já atualizado)

- [ ] Criar arquivo único de padrão visual:
  - `.claude/docs/strategies/visual-patterns.md`
  - Definir tamanho único para separadores
  - Definir paleta de emojis
  - Definir estrutura de seções

**Status**: ⬜ Não iniciado

---

### FASE 3: Criar Abstrações MCP (2-3 horas)

**Objetivo**: Implementar wrappers reutilizáveis

- [ ] Implementar abstração: `commentPhaseCompletion()`
  - Gera comentário detalhado correto
  - Usa padrões centralizados
  - Reutilizável por qualquer comando

- [ ] Implementar abstração: `updateSubtaskStatus()`
  - Abstração confiável para update
  - Tratamento de erros
  - Logging

- [ ] Implementar abstração: `commentProgressUpdate()`
  - Gera comentário resumido correto
  - Usa padrões centralizados
  - Reutilizável

- [ ] Implementar abstração: `validateAcceptanceCriteria()`
  - Valida checkboxes
  - Retorna relatório estruturado
  - Identifica pendências

- [ ] Implementar abstração: `commentPrePRValidation()`
  - Gera comentário de pré-PR
  - Adiciona tags apropriadas
  - Reutilizável

- [ ] Implementar abstração: `commentPRCreated()`
  - Documentação de PR criada
  - Padrão consistente
  - Reutilizável

- [ ] Implementar abstração: `commentPRUpdated()`
  - Documentação de PR atualizada
  - Padrão consistente
  - Reutilizável

**Status**: ⬜ Não iniciado

---

### FASE 4: Refatoração de Comandos (3-4 horas)

**Objetivo**: Remover acoplamento, usar abstrações

#### 4.1 - `/engineer/work.md`

- [ ] Remover seção de exemplos MCP
- [ ] Remover templates inline de comentários
- [ ] Referência abstrações em `clickup-mcp-wrappers.md`
- [ ] Testar que ainda funciona corretamente
- [ ] Validar comentários gerados

#### 4.2 - `/engineer/pr.md`

- [ ] Remover exemplos de `mcp_clickup_*`
- [ ] Remover template de comentário de PR
- [ ] Referência abstração `commentPRCreated()`
- [ ] Remover pseudocódigo

#### 4.3 - `/engineer/pre-pr.md`

- [ ] Remover template de comentário de validação
- [ ] Referência abstração `validateAcceptanceCriteria()`
- [ ] Referência abstração `commentPrePRValidation()`
- [ ] Focar em lógica de orquestração

#### 4.4 - `/engineer/pr-update.md`

- [ ] Remover template de comentário de update
- [ ] Referência abstração `commentPRUpdated()`
- [ ] Remover exemplos técnicos

#### 4.5 - `/product/task.md`

- [ ] Remover exemplos JavaScript de MCP
- [ ] Remover pseudocódigo de formatação
- [ ] Referência abstrações centralizadas
- [ ] Focar em lógica de criação de task

#### 4.6 - `/product/presentation.md`

- [ ] Remover exemplos de `mcp_clickup_get_task`
- [ ] Remover pseudocódigo

#### 4.7 - `/product/checklist-sync.md`

- [ ] Remover pseudocódigo Python de ClickUp
- [ ] Referência abstrações

**Status**: ⬜ Não iniciado

---

### FASE 5: Atualização de Documentação (1-2 horas)

**Objetivo**: Remover implementação, manter conceitos

- [ ] Revisar `.claude/docs/clickup/clickup-*.md`
  - Remover códigos de implementação
  - Manter conceitos e decisões
  - Referenciar wrappers quando apropriado

- [ ] Criar nova seção em documentação:
  - "Padrões Centralizados"
  - "Como Usar Abstrações"
  - "Extensibilidade"

- [ ] Atualizar READMEs:
  - `.claude/commands/engineer/README.md` - Remover referências MCP
  - `.claude/commands/product/README.md` - Remover referências MCP

**Status**: ⬜ Não iniciado

---

### FASE 6: Testes e Validação (2 horas)

**Objetivo**: Garantir funcionamento correto

- [ ] Teste cada comando refatorado
  - `/engineer/work` - Verificar comentários gerados
  - `/engineer/pr` - Verificar comentário de PR
  - `/engineer/pre-pr` - Verificar validação de critérios
  - `/engineer/pr-update` - Verificar update de PR
  - `/product/task` - Verificar criação de task

- [ ] Validar consistência
  - Separadores uniformes
  - Formatação consistente
  - Padrões aplicados corretamente

- [ ] Teste de regressão
  - Nenhum comando quebrou
  - ClickUp ainda recebe comentários corretos
  - Tasks são criadas corretamente

- [ ] Documentação
  - Todos os comandos têm instruções claras
  - Exemplos ainda funcionam
  - Sem referências obsoletas

**Status**: ⬜ Não iniciado

---

### FASE 7: Cleanup Final (1 hora)

**Objetivo**: Limpeza e finalização

- [ ] Remover arquivos obsoletos (se houver)
- [ ] Consolidar documentação duplicada
- [ ] Atualizar sumários e índices
- [ ] Commit final com resumo de mudanças
- [ ] Criar issue para monitoramento futuro

**Status**: ⬜ Não iniciado

---

## 📈 Progresso

```
Fases:
├── FASE 1: Preparação                    [████░░░░░] 0%
├── FASE 2: Refatoração de Padrões        [░░░░░░░░░] 0%
├── FASE 3: Criar Abstrações MCP          [░░░░░░░░░] 0%
├── FASE 4: Refatoração de Comandos       [░░░░░░░░░] 0%
├── FASE 5: Atualização de Docs           [░░░░░░░░░] 0%
├── FASE 6: Testes e Validação            [░░░░░░░░░] 0%
└── FASE 7: Cleanup Final                 [░░░░░░░░░] 0%

Total: [░░░░░░░░░] 0%
```

---

## 🎯 Métricas de Sucesso

### ANTES (Acoplado):
```
Linhas de código MCP espalhadas:      ~150+ linhas
Duplicação de padrões:                 5+ locais
Tempo para mudar padrão:               ~30-45 minutos
Risco de inconsistência:               🔴 ALTO
Testabilidade:                         🟡 MÉDIA
```

### DEPOIS (Desacoplado):
```
Linhas de código MCP centralizadas:   ~100 linhas
Duplicação de padrões:                 1 local (source of truth)
Tempo para mudar padrão:               ~5-10 minutos
Risco de inconsistência:               🟢 BAIXO
Testabilidade:                         🟢 ALTA
```

---

## 💰 Benefícios Esperados

### Curto Prazo (Imediato):
- ✅ Redução de duplicação
- ✅ Facilita compreensão de código
- ✅ Melhora manutenibilidade

### Médio Prazo (1-2 sprints):
- ✅ Mudanças de padrão 5x mais rápidas
- ✅ Menos bugs por inconsistência
- ✅ Facilita onboarding de novos desenvolvedores

### Longo Prazo (Contínuo):
- ✅ Código mais robusto
- ✅ Evolução de integração ClickUp sem quebrar comandos
- ✅ Fundação para novas abstrações

---

## 🚀 Como Executar

### Começar FASE 1:

```bash
# 1. Criar estrutura
mkdir -p .claude/docs/strategies

# 2. Adicionar arquivo de roadmap
git add .claude/docs/architecture/desacoplamento-roadmap.md

# 3. Criar arquivo de wrappers
git add .claude/utils/clickup-mcp-wrappers.md

# 4. Commit
git commit -m "docs: criar roadmap de desacoplamento ClickUp"

# 5. Próximo passo: Começar FASE 2
```

---

## 📚 Referências

- [Acoplamento ClickUp - Análise](./acoplamento-clickup-problema-analise.md)
- [ClickUp MCP Wrappers](../utils/clickup-mcp-wrappers.md)
- [Estratégias de Comentários](../docs/strategies/clickup-comment-patterns.md)

---

**Status**: Roadmap criado  
**Criado em**: 2025-11-05  
**Última atualização**: 2025-11-05  
**Responsável**: @user  
**Prioridade**: ALTA  
**Esforço Total**: ~12-15 horas  
**Timeline**: 2-3 sprints

