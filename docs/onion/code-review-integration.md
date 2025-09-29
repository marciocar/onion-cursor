# 🤖 ChatGPT Code Review - Sistema Onion Integration

## 📋 **Visão Geral**

O Sistema Onion agora inclui gerenciamento inteligente e automático do ChatGPT-CodeReview através do comando `/git/code-review`. Esta integração oferece setup automático, validação contínua e otimização baseada no stack específico do projeto.

---

## ⚡ **Como Usar**

### **🎮 Comando Principal**
```bash
/git/code-review           # AUTO: detecta e executa ação apropriada
/git/code-review setup     # FORCE: criar/reconfigurar arquivo  
/git/code-review validate  # FORCE: validar configuração existente
/git/code-review status    # INFO: dashboard completo do estado atual
```

### **🔄 Funcionamento Automático**
O comando detecta automaticamente se o arquivo `.github/workflows/code-review.yml` existe:
- **❌ Não existe**: **CREATE MODE** - cria arquivo otimizado para o stack
- **✅ Existe**: **VALIDATE MODE** - analisa e sugere melhorias

---

## 🆕 **CREATE MODE - Criação Inteligente**

### **📊 Stack Detection Automática**
Analisa automaticamente o projeto e detecta:
- **Monorepo**: Nx, Lerna, Rush
- **Backend**: Fastify, Express, NestJS  
- **ORM**: ZenStack, Prisma, TypeORM
- **Frontend**: React, Vue, Angular
- **Data Fetching**: React Query, SWR, Apollo
- **Package Manager**: pnpm, npm, yarn

### **📝 Template Otimizado**
Gera configuração personalizada baseada no stack detectado:

```yaml
name: Code Review GPT
on:
  pull_request:
    types: [opened, synchronize, reopened]
    branches: [main, develop, 'release/**']
    
permissions:
  contents: read
  pull-requests: write
  issues: write

jobs:
  code-review:
    runs-on: ubuntu-latest  
    timeout-minutes: 15
    steps:
      - name: Code Review with GPT
        uses: anc95/ChatGPT-CodeReview@main
        env:
          MODEL: gpt-4o
          LANGUAGE: pt-BR  
          PROMPT: |
            # Stack-specific prompt gerado automaticamente
```

### **🎯 Personalização por Stack**

#### **Nx Monorepo**
- File patterns otimizados: `apps/**/*.ts`, `libs/**/*.ts`
- Prompt foca em boundaries e path aliases
- Ignore patterns para `.nx/`, `dist/`, `build/`

#### **ZenStack-First**  
- Inclui `schema.zmodel` nos patterns
- Prompt especializado em generated client usage
- Validação de security patterns

#### **React + React Query**
- Foco em hooks patterns e performance
- Query/mutation configuration guidelines
- Cache management best practices

---

## 🔍 **VALIDATE MODE - Validação Inteligente**

### **📋 Análises Realizadas**
- ✅ **Action Versions**: Verifica se usa versões mais recentes
- ✅ **Model Configuration**: GPT-4o + pt-BR + 12k tokens recomendados
- ✅ **File Filtering**: Patterns otimizados para monorepo  
- ✅ **Stack Awareness**: Prompt menciona tecnologias corretas
- ✅ **Security**: Permissions mínimas e secrets corretos

### **⚠️ Issues Detectados**

#### **🔴 Críticos**
- Model diferente de `gpt-4o`
- Language diferente de `pt-BR`
- Permissions excessivas
- YAML syntax errors
- Action versions deprecated

#### **🟡 Importantes**  
- File patterns não otimizados
- Timeout inadequado (< 10min ou > 20min)
- Max tokens baixo (< 8000)  
- Prompt sem stack awareness
- Missing ignore patterns críticos

#### **🔵 Sugestões**
- Temperature não otimizada (recomendado: 0.7)
- Prompt pode ser mais específico
- Summary comment melhorable

### **🔧 Auto-Fix Automático**
Para cada issue detectado, oferece correção automática:
```bash
ISSUE: Model = "gpt-3.5-turbo" (should be "gpt-4o")
FIX: Atualizar MODEL para gpt-4o para melhor qualidade  
ACTION: Aplicar correção automaticamente? [Y/n]
```

---

## 📊 **STATUS MODE - Dashboard Completo**

### **🎯 Informações Exibidas**
```bash
🤖 CHATGPT-CODEREVIEW STATUS

📁 Configuration:
   ▶ File: .github/workflows/code-review.yml ✅ EXISTS
   ▶ Status: ✅ ACTIVE | 🔍 VALIDATED
   ▶ Last Modified: 2 days ago

🧠 AI Configuration:  
   ▶ Model: gpt-4o ✅ | Language: pt-BR ✅
   ▶ Max Tokens: 12000 ✅ | Temperature: 0.7 ✅

🎯 Stack Detection:
   ▶ Monorepo: Nx 21.4.0 ✅
   ▶ Backend: Fastify + ZenStack ✅
   ▶ Frontend: React 18+ + React Query ✅

📋 Recent Activity:
   ▶ Last PR Review: 3 hours ago
   ▶ Files Reviewed: 12 | Comments: 8  
   ▶ Quality Score: 4.2/5 ⭐

🔐 Security & Performance:
   ▶ Permissions: Minimal ✅
   ▶ Timeout: 15min ✅ | Filtering: Optimized ✅
```

---

## 🔗 **Integração Sistema Onion**

### **✅ ClickUp Auto-Update**
Todos os comandos fazem update automático no ClickUp:

**CREATE MODE Success:**
```
🤖 CODE REVIEW SETUP CONCLUÍDO

🆕 ARQUIVO CRIADO:
   ▶ Template otimizado para stack detectado
   ▶ GPT-4o + pt-BR + 12k tokens

🎯 STACK DETECTADO:  
   ▶ Nx + ZenStack + Fastify + React Query
   ▶ File filtering otimizado para monorepo

📋 PRÓXIMOS PASSOS:
   1. Configurar OPENAI_API_KEY no GitHub Secrets  
   2. Testar em PR de exemplo
```

**VALIDATE MODE Issues:**
```  
🤖 CODE REVIEW VALIDATION COMPLETA

⚠️ ISSUES ENCONTRADOS:
   ▶ Model: gpt-3.5-turbo → should be gpt-4o
   ▶ File patterns: não otimizados para Nx

📊 SCORE ATUAL: 75/100
   ▶ Funcionalidade: 25/30 ✅
   ▶ Performance: 15/25 ⚠️  
   ▶ Stack Awareness: 10/20 ⚠️

💡 Execute /git/code-review novamente para correções
```

### **🏷️ Tags Automáticas**
- `code-review-active` - Quando configurado e funcionando
- `needs-optimization` - Quando validation encontra issues  
- `github-actions` - Para tracking de automações
- `ai-integration` - Para categorização de features IA

### **🔄 Integração com Outros Comandos**
- **`/engineer/pr`**: Verifica se code review está ativo antes de criar PR
- **`/git/sync`**: Considera code review no workflow de sincronização
- **`/git/init`**: Oferece setup opcional de code review durante init

---

## 🎯 **Configuração Manual (Se Necessária)**

### **GitHub Secrets**
Configurar no GitHub Repository Settings → Secrets:
```bash
OPENAI_API_KEY = "sk-..." # Sua API key da OpenAI
```

### **Stack-Specific Customizations**
Personalizações podem ser feitas editando diretamente o arquivo gerado:

#### **Para Nx Monorepo**
```yaml
files: |  
  apps/**/*.{ts,tsx,js,jsx}
  libs/**/*.{ts,tsx,js,jsx}
  tools/**/*.{ts,js}
  **/*.json
```

#### **Para ZenStack Projects**
```yaml
files: |
  **/*.{ts,tsx,js,jsx}
  **/*.prisma
  schema.zmodel
  **/*.json
```

---

## 🚀 **Workflows Recomendados**

### **Setup Inicial**
```bash
# 1. Executar comando
/git/code-review

# 2. Se CREATE MODE → configurar secrets
# GitHub → Settings → Secrets → OPENAI_API_KEY

# 3. Testar com PR pequeno
# Fazer mudança simples → criar PR → verificar review automático
```

### **Manutenção Periódica**
```bash  
# Mensal: validar configuração
/git/code-review validate

# Após updates: verificar status
/git/code-review status

# Troubleshooting: recriar com otimizações
/git/code-review setup
```

### **Troubleshooting Comum**

#### **Code Review não executa**
1. Verificar se `OPENAI_API_KEY` está configurada
2. Validar branches no workflow (main, develop, release/**)
3. Confirmar que PR modifica arquivos relevantes
4. Executar `/git/code-review validate` para diagnóstico

#### **Reviews de baixa qualidade**  
1. Executar `/git/code-review validate` 
2. Verificar se prompt inclui stack technologies
3. Confirmar model = `gpt-4o` (não gpt-3.5-turbo)
4. Atualizar max_tokens para 12000+

#### **Performance lenta**
1. Otimizar file filtering patterns  
2. Ajustar timeout (15min recomendado)
3. Configurar MAX_PATCH_LENGTH para arquivos grandes
4. Revisar ignore patterns (node_modules, dist, build)

---

## 📚 **Links Úteis**

- **Comando Principal**: `.cursor/commands/git/code-review.md`
- **GitHub Action**: [anc95/ChatGPT-CodeReview](https://github.com/anc95/ChatGPT-CodeReview)
- **OpenAI API**: [Platform OpenAI](https://platform.openai.com/docs/models)
- **GitHub Actions Secrets**: [GitHub Docs](https://docs.github.com/en/actions/security-guides/encrypted-secrets)

---

**🎯 O ChatGPT Code Review agora é parte integrante do Sistema Onion, oferecendo automação completa com zero configuração manual para a maioria dos casos de uso!**
