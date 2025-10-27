# ✅ Validate Docs - Validação de Documentação

Valida a completude, consistência e qualidade de toda a documentação do projeto, garantindo que todos os arquivos essenciais existam e sigam os padrões estabelecidos.

## 🎯 Objetivo

Este comando realiza uma validação abrangente de toda a estrutura de documentação do projeto, verificando:
- Presença de arquivos obrigatórios
- Consistência entre documentos
- Links internos funcionando
- Formato e estrutura adequados
- Metadados completos

## 🎯 Funcionalidades

### Validação de Estrutura
- Verifica hierarquia de diretórios
- Confirma presença de arquivos obrigatórios
- Valida nomenclatura de arquivos
- Checa estrutura de índices

### Validação de Conteúdo
- Verifica seções obrigatórias em cada tipo de documento
- Valida formato markdown
- Checa metadados YAML (quando aplicável)
- Verifica completude de informações

### Validação de Links
- Testa links internos entre documentos
- Verifica referências a arquivos
- Valida links para código-fonte
- Identifica links quebrados

### Validação de Consistência
- Compara informações entre documentos
- Verifica sincronização de dados
- Identifica contradições
- Valida versionamento

## 🚀 Como Usar

```bash
# Validação completa
/docs/validate-docs

# Validar apenas business context
/docs/validate-docs --scope=business

# Validar apenas technical context
/docs/validate-docs --scope=technical

# Validação rápida (apenas estrutura)
/docs/validate-docs --quick

# Gerar relatório detalhado
/docs/validate-docs --detailed

# Modo strict (falha em warnings)
/docs/validate-docs --strict
```

## 📋 Processo de Validação

### 1. **Validação de Estrutura (Nível 1)**
```
docs/
├── business-context/
│   ├── ✅ index.md (obrigatório)
│   ├── ✅ CUSTOMER_PERSONAS.md
│   ├── ✅ CUSTOMER_JOURNEY.md
│   ├── ✅ PRODUCT_STRATEGY.md
│   └── ...
├── technical-context/
│   ├── ✅ index.md (obrigatório)
│   ├── ✅ project-charter.md
│   ├── ✅ CURSOR.meta.md
│   └── adr/
└── INDEX.md (obrigatório)
```

### 2. **Validação de Conteúdo (Nível 2)**
Para cada documento, verifica:
- **Headers**: Presença de título principal (H1)
- **Seções Obrigatórias**: Conforme tipo de documento
- **Metadados**: YAML frontmatter quando necessário
- **Formato**: Markdown válido
- **Completude**: Conteúdo mínimo presente

### 3. **Validação de Links (Nível 3)**
```typescript
interface LinkValidation {
  internal: {
    working: string[];    // Links funcionando
    broken: string[];     // Links quebrados
    missing: string[];    // Arquivos referenciados não existem
  };
  external: {
    checked: boolean;     // Se links externos foram verificados
    working?: string[];
    broken?: string[];
  };
}
```

### 4. **Validação de Consistência (Nível 4)**
- **Dados Duplicados**: Informações repetidas devem ser consistentes
- **Referências Cruzadas**: Documentos que se referenciam devem estar sincronizados
- **Versionamento**: Datas de "última atualização" devem fazer sentido
- **Nomenclatura**: Termos técnicos devem ser consistentes

## 📊 Checklist de Validação

### Business Context
- [ ] `business-context/index.md` existe e está completo
- [ ] `CUSTOMER_PERSONAS.md` tem pelo menos 2 personas
- [ ] `CUSTOMER_JOURNEY.md` mapeia jornada completa
- [ ] `PRODUCT_STRATEGY.md` define visão e missão
- [ ] `COMPETITIVE_LANDSCAPE.md` lista concorrentes
- [ ] `INDUSTRY_TRENDS.md` tem dados de mercado
- [ ] `PRODUCT_METRICS.md` define KPIs
- [ ] `CUSTOMER_COMMUNICATION.md` tem guidelines
- [ ] `VOICE_OF_CUSTOMER.md` captura feedback
- [ ] Todos os arquivos têm data de atualização

### Technical Context
- [ ] `technical-context/index.md` existe e está completo
- [ ] `project-charter.md` define visão e objetivos
- [ ] `CURSOR.meta.md` otimizado para IA
- [ ] `CODEBASE_GUIDE.md` navega estrutura
- [ ] `BUSINESS_LOGIC.md` documenta domínio
- [ ] `API_SPECIFICATION.md` especifica APIs
- [ ] `CONTRIBUTING.md` define workflows
- [ ] `TROUBLESHOOTING.md` resolve problemas
- [ ] `ARCHITECTURE_CHALLENGES.md` identifica desafios
- [ ] `adr/` tem ADRs numerados

### Meta Documentation
- [ ] `docs/INDEX.md` lista toda documentação
- [ ] `docs/ESPERANTO.md` documenta workflows
- [ ] `docs/onion/consolidated-project-documentation.md` existe
- [ ] Links entre documentos funcionam
- [ ] Estrutura de navegação clara

### Sistema Esperanto
- [ ] `.cursor/agents/` tem todos os agentes listados
- [ ] `.cursor/commands/` organizado por categoria
- [ ] Cada comando tem documentação clara
- [ ] README em cada categoria de comandos

## 🤖 Integração com Agentes

Este comando convoca automaticamente:
- **@metaspec-gate-keeper**: Valida conformidade com meta-specs
- **@branch-documentation-writer**: Sugere melhorias na documentação
- **@research-agent**: Identifica gaps de informação

## 📈 Output Esperado

### Validação Bem-Sucedida
```bash
✅ Validação de Documentação - PASSOU

📊 Resumo:
  ✅ Estrutura: 100% (todos os diretórios presentes)
  ✅ Arquivos Obrigatórios: 28/28
  ✅ Links Internos: 145/145 funcionando
  ✅ Formato Markdown: Válido em todos os arquivos
  ✅ Metadados: Completos

📚 Estatísticas:
  • Total de Documentos: 50
  • Business Context: 9 arquivos
  • Technical Context: 9 arquivos
  • Guidelines: 5 arquivos
  • Comandos Esperanto: 51
  • AI Agents: 22

✨ Documentação está completa e consistente!
```

### Validação com Problemas
```bash
⚠️ Validação de Documentação - AVISOS ENCONTRADOS

❌ Problemas Críticos (2):
  1. docs/business-context/PRODUCT_METRICS.md - Arquivo não encontrado
  2. docs/INDEX.md - Link quebrado: [Tech Docs](technical-context/missing.md)

⚠️ Avisos (5):
  1. docs/business-context/index.md - Falta data de última atualização
  2. docs/technical-context/CURSOR.meta.md - Seção "Examples" vazia
  3. docs/business-context/CUSTOMER_PERSONAS.md - Apenas 1 persona (mínimo 2)
  4. docs/technical-context/adr/003-*.md - Numeração pulada (001, 002, 005)
  5. docs/ESPERANTO.md - Link externo não verificado

📊 Resumo:
  ⚠️ Estrutura: 95% (1 diretório faltando)
  ❌ Arquivos Obrigatórios: 27/28
  ⚠️ Links Internos: 143/145 funcionando (2 quebrados)
  ✅ Formato Markdown: Válido
  ⚠️ Metadados: 80% completos

🔧 Ações Recomendadas:
  1. Criar arquivo faltante: PRODUCT_METRICS.md
  2. Corrigir link em INDEX.md
  3. Adicionar datas de atualização
  4. Adicionar mais 1 persona em CUSTOMER_PERSONAS.md
  5. Renumerar ADRs sequencialmente
```

## ⚙️ Opções de Validação

### Scopes Disponíveis
```bash
--scope=business      # Apenas business context
--scope=technical     # Apenas technical context
--scope=esperanto     # Apenas sistema Esperanto
--scope=all          # Tudo (padrão)
```

### Níveis de Profundidade
```bash
--quick              # Apenas estrutura (rápido)
--standard           # Estrutura + conteúdo (padrão)
--deep               # Estrutura + conteúdo + links
--complete           # Tudo + links externos (lento)
```

### Modos de Execução
```bash
--strict             # Falha em warnings também
--fix                # Tenta corrigir problemas automaticamente
--detailed           # Relatório detalhado com sugestões
--json               # Output em JSON para CI/CD
```

## 🔧 Auto-Fix Capabilities

Com flag `--fix`, o comando pode corrigir automaticamente:
- ✅ Adicionar datas de atualização faltantes
- ✅ Criar arquivos de índice básicos
- ✅ Renumerar ADRs sequencialmente
- ✅ Adicionar metadados YAML padrão
- ✅ Corrigir links relativos quebrados (quando óbvio)

## ⚠️ Resolução de Problemas

### **Problema 1: Muitos links quebrados**
- **Causa**: Arquivos foram movidos ou renomeados
- **Solução**: Execute `--fix` para tentar correção automática
- **Manual**: Use find & replace para atualizar links

### **Problema 2: Metadados inconsistentes**
- **Causa**: Arquivos editados manualmente sem padrão
- **Solução**: Execute `--fix` para adicionar metadados padrão
- **Template**: Use templates em `.cursor/commands/common/templates/`

### **Problema 3: ADRs fora de ordem**
- **Causa**: ADRs criados/deletados sem renumeração
- **Solução**: Execute `--fix` para renumerar sequencialmente
- **Prevenção**: Use comando `/docs/create-adr` para criar ADRs

## 📋 Regras de Validação

### Arquivos Obrigatórios
```yaml
docs/:
  - INDEX.md                    # Índice central
  - ESPERANTO.md               # Workflows
  
business-context/:
  - index.md                   # Índice business
  - CUSTOMER_PERSONAS.md       # Mínimo 2 personas
  - CUSTOMER_JOURNEY.md        # Jornada completa
  - PRODUCT_STRATEGY.md        # Visão e missão
  
technical-context/:
  - index.md                   # Índice technical
  - project-charter.md         # Charter do projeto
  - CURSOR.meta.md            # Guia IA
  - CODEBASE_GUIDE.md         # Navegação código
  - adr/README.md             # Índice ADRs
```

### Estrutura de Documento
```markdown
# Título (obrigatório H1)

## Seção 1 (pelo menos 2 H2 obrigatórios)
Conteúdo...

## Seção 2
Conteúdo...

---
Última Atualização: YYYY-MM-DD (obrigatório no final)
```

### Metadados YAML (quando aplicável)
```yaml
---
title: "Título do Documento"
description: "Descrição breve"
last_updated: "YYYY-MM-DD"
status: "draft|review|approved"
---
```

## 🔗 Comandos Relacionados

- `/docs/sync-sessions` - Sincroniza sessões
- `/docs/docs-health` - Health check completo
- `/docs/build-index` - Reconstrói índice
- `/docs/build-business-docs` - Gera business docs
- `/docs/build-tech-docs` - Gera technical docs

## 📊 Integração CI/CD

### Uso em Pipeline
```yaml
# .github/workflows/docs-validation.yml
name: Validate Documentation

on: [push, pull_request]

jobs:
  validate:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v2
      - name: Validate Docs
        run: /docs/validate-docs --strict --json > validation-report.json
      - name: Upload Report
        uses: actions/upload-artifact@v2
        with:
          name: validation-report
          path: validation-report.json
```

### Output JSON
```json
{
  "status": "warning",
  "summary": {
    "total_files": 50,
    "structure": { "score": 95, "status": "warning" },
    "required_files": { "present": 27, "total": 28, "status": "error" },
    "links": { "working": 143, "broken": 2, "status": "warning" },
    "format": { "valid": true, "status": "pass" }
  },
  "errors": [
    {
      "file": "docs/business-context/PRODUCT_METRICS.md",
      "type": "missing_file",
      "severity": "error",
      "message": "Required file not found"
    }
  ],
  "warnings": [
    {
      "file": "docs/INDEX.md",
      "type": "broken_link",
      "severity": "warning",
      "message": "Link to 'technical-context/missing.md' is broken"
    }
  ]
}
```

## 🎯 Casos de Uso

### Caso 1: Antes de Merge
```bash
# Validar documentação antes de merge
/docs/validate-docs --strict

# Se passar, fazer merge
# Se falhar, corrigir problemas
```

### Caso 2: Após Refactoring
```bash
# Verificar se refactoring quebrou links
/docs/validate-docs --deep

# Corrigir links automaticamente
/docs/validate-docs --fix
```

### Caso 3: Auditoria Periódica
```bash
# Health check mensal completo
/docs/validate-docs --complete --detailed

# Gerar relatório para stakeholders
/docs/validate-docs --json > monthly-report.json
```

### Caso 4: Onboarding Check
```bash
# Verificar se documentação está pronta para novo dev
/docs/validate-docs --scope=technical --detailed
```

## 📝 Best Practices

1. **Execute Regularmente**: Valide documentação a cada PR
2. **Use --strict em CI/CD**: Garante qualidade mínima
3. **Corrija Warnings**: Não deixe warnings acumularem
4. **Mantenha Consistência**: Use templates padrão
5. **Documente Exceções**: Se algo não pode ser corrigido, documente o porquê

---

**Agente Responsável**: @metaspec-gate-keeper  
**Validador**: @branch-documentation-writer  
**Categoria**: Documentação / Qualidade  
**Prioridade**: Alta  
**Última Atualização**: Outubro 2025

