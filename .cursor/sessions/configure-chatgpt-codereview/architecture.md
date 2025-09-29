# Architecture - ChatGPT CodeReview Integration

## 🎯 **Visão Geral**

Criar um **comando Sistema Onion** `/git/code-review` que gerencie inteligentemente o ChatGPT-CodeReview, seguindo os padrões de automação e validação do framework.

### **🔄 Fluxo Before → After**

#### **BEFORE (Situação Atual)**
- Arquivo `.github/workflows/code-review.yml` existe mas não gerenciado
- Sem validação automática de configuração
- Sem integração com Sistema Onion 
- Sem comando para criar/atualizar arquivo

#### **AFTER (Solução Proposta)**  
- Comando `/git/code-review` integrado ao Sistema Onion
- Detecção inteligente: criar quando não existe, validar quando existe
- Auto-update ClickUp com progresso e status
- Configuração otimizada para stack específico do projeto

---

## 🏗️ **Componentes da Solução**

### **1. 🧅 Comando Sistema Onion Principal**
**Arquivo**: `.cursor/commands/git/code-review.md`

```bash
/git/code-review        # Auto-detecta e executa ação apropriada
/git/code-review setup  # Força criação/reconfiguração  
/git/code-review validate  # Força validação do arquivo existente
/git/code-review status    # Mostra status atual do ChatGPT-CodeReview
```

### **2. 🎯 Lógica de Detecção Inteligente**
```mermaid
flowchart TD
    A[/git/code-review] --> B{Arquivo existe?}
    B -->|Não| C[CREATE MODE]
    B -->|Sim| D[VALIDATE MODE]
    
    C --> E[Criar workflow otimizado]
    E --> F[Configurar secrets guide]
    E --> G[ClickUp update: Created]
    
    D --> H[Validar configuração]
    H --> I{Válida?}
    I -->|Sim| J[ClickUp update: Validated ✅]
    I -->|Não| K[ClickUp update: Issues found]
    K --> L[Sugestões de melhoria]
```

### **3. 📋 Templates Inteligentes por Stack**

#### **Template Base (Nx + ZenStack + Fastify + React Query)**
```yaml
# .github/workflows/code-review.yml
name: Code Review GPT
on:
  pull_request:
    types: [opened, synchronize, reopened]  
    branches: [main, develop, 'release/**']
permissions:
  contents: read
  pull-requests: write
  issues: write
env:
  MODEL: gpt-4o
  LANGUAGE: pt-BR
  MAX_TOKENS: 12000
```

#### **Prompt Especializado Dinâmico**
```yaml
PROMPT: |
  Você é um revisor de código sênior especializado no stack:
  {{DETECTED_STACK_TECHNOLOGIES}}
  
  Diretrizes específicas:
  {{STACK_SPECIFIC_GUIDELINES}}
  
  Categorize feedback: 🔴 crítico, 🟡 importante, 🔵 sugestão, ✅ bom.
```

### **4. 🔍 Validador Inteligente**

#### **Validações Críticas**
- **YAML Syntax**: Validação de sintaxe
- **Action Version**: Verificar se usa versão mais recente `@main`
- **Model Configuration**: GPT-4o + pt-BR obrigatório
- **File Filtering**: Verificar padrões corretos para monorepo
- **Stack Awareness**: Prompt deve mencionar tecnologias detectadas
- **Security**: Secrets configurados corretamente

#### **Detecção Automática de Stack**
```typescript
interface StackDetection {
  monorepo: 'nx' | 'lerna' | 'rush' | null
  backend: 'fastify' | 'express' | 'nestjs' | null  
  orm: 'zenstack' | 'prisma' | 'typeorm' | null
  frontend: 'react' | 'vue' | 'angular' | null
  dataFetching: 'react-query' | 'swr' | 'apollo' | null
  packageManager: 'pnpm' | 'npm' | 'yarn'
}
```

---

## 🚀 **Implementação Técnica**

### **Fluxo CREATE MODE**

#### **1. Stack Detection**
```bash
# Detectar tecnologias no projeto
- package.json analysis → tecnologias principais
- nx.json presente? → Nx monorepo  
- schema.prisma/schema.zmodel? → ORM type
- tsconfig paths → path aliases validation
```

#### **2. Template Generation**
```bash
# Gerar template otimizado
- Base template + stack-specific customizations
- Prompt personalizado com tecnologias detectadas  
- File filters otimizados para estrutura do projeto
- Configurações específicas (timeout, tokens, etc)
```

#### **3. File Creation**
```bash
# Criar arquivo com validações
- Verificar se pasta .github/workflows/ existe
- Criar arquivo com permissões corretas
- Validar YAML gerado
- Criar backup se arquivo existir
```

### **Fluxo VALIDATE MODE**

#### **1. Configuration Analysis**
```bash
# Analisar configuração existente  
- Parse YAML e extrair configurações
- Comparar com template otimizado  
- Identificar discrepâncias e melhorias
- Verificar versões das actions
```

#### **2. Recommendations Generation**
```bash
# Gerar recomendações específicas
- Stack mismatch → sugerir prompt updates
- Performance optimizations → timeout, cache
- Security improvements → permissions, secrets  
- File filter optimizations → monorepo patterns
```

#### **3. Auto-Fix Options**
```bash
# Opções de correção automática
- Update prompt with detected stack
- Fix action versions to latest
- Optimize file filtering patterns  
- Update model to gpt-4o if outdated
```

---

## 🔗 **Integração Sistema Onion**

### **ClickUp Auto-Update Strategy**
```yaml
# Automático (sem confirmação)
- Comment com status atual (CREATE/VALIDATE)
- Progress updates com detalhes técnicos
- Tags: 'code-review-active', 'github-actions'
- Attachment com arquivo gerado/validado

# Confirmação necessária  
- Backup de arquivo existente antes de sobrescrever
- Mudanças críticas de configuração
- Setup de secrets no GitHub (manual step)
```

### **Integration com Outros Comandos**
```bash
/engineer/pr    # Auto-verifica se code-review está ativo
/git/sync       # Considera code-review no workflow  
/git/init       # Oferece setup opcional de code-review
```

---

## 📊 **Padrões e Melhores Práticas**

### **Template Patterns**

#### **Monorepo Nx Optimizations**
```yaml
files: |
  apps/**/*.ts
  apps/**/*.tsx
  libs/**/*.ts  
  libs/**/*.tsx
  **/*.json
  **/*.prisma
  schema.zmodel
  nx.json
  project.json
```

#### **ZenStack-Specific Patterns** 
```yaml
PROMPT: |
  Padrões ZenStack-First:
  - schema.zmodel como única fonte de verdade
  - Generated client usage patterns
  - Database schema security
  - Query optimization patterns
```

#### **Performance Optimizations**
```yaml
timeout-minutes: 15
MAX_PATCH_LENGTH: 10000  # Skip huge files  
files_ignore: |
  **/dist/**
  **/build/** 
  **/coverage/**
  **/.nx/**
  **/node_modules/**
```

### **Security Best Practices**
```yaml
permissions:
  contents: read        # Minimal required
  pull-requests: write  # For comments only
  issues: write         # For issue comments
  # NO admin permissions
```

---

## 📝 **Arquivos Gerados/Modificados**

### **Principais**
- `.cursor/commands/git/code-review.md` - Comando principal
- `.github/workflows/code-review.yml` - Workflow (criado/validado)  
- `docs/onion/code-review-integration.md` - Documentação

### **Auxiliares**  
- `.cursor/sessions/configure-chatgpt-codereview/templates/` - Templates
- `.cursor/sessions/configure-chatgpt-codereview/validation/` - Schemas
- `.cursor/sessions/configure-chatgpt-codereview/backup/` - Backups

---

## 🎯 **Success Metrics**

### **Funcional**
- ✅ Comando `/git/code-review` detecta corretamente arquivo existente/ausente
- ✅ Template gerado é válido e otimizado para stack do projeto
- ✅ Validação identifica issues reais e oferece soluções concretas
- ✅ Auto-update ClickUp funciona sem intervenção manual

### **Técnico** 
- ✅ YAML gerado passa em GitHub Actions syntax validator
- ✅ Stack detection identifica ≥80% das tecnologias principais  
- ✅ File filtering otimizado reduz arquivos processados em ≥50%
- ✅ Prompt customizado gera feedback ≥80% relevante para stack

### **UX/DX**
- ✅ Um único comando resolve setup completo
- ✅ Zero configuração manual para casos comuns
- ✅ Validação automática detecta 100% dos problemas críticos
- ✅ Documentação auto-gerada está sempre atualizada

---

## 🚀 **Ready for Development**

**Arquitetura aprovada** → **Próximo passo**: Implementação do comando `/git/code-review.md` seguindo os padrões identificados do Sistema Onion.

**Stack Detection** → **Template Generation** → **Intelligent Validation** → **ClickUp Integration**
