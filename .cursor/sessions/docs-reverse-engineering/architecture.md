# Architecture - Sistema de Engenharia Reversa Universal

## 🎯 **Visão Geral de Alto Nível**

### **Before (Estado Atual)**
- Usuários aplicam Sistema Onion em seus projetos
- Para gerar documentação técnica, precisam executar `/docs/build-tech-docs` manualmente
- Build-tech-docs faz descoberta do zero (Fase 1 completa)
- Processo lento e repetitivo para cada projeto

### **After (Com Sistema de Engenharia Reversa)**
- Sistema faz engenharia reversa automática de **qualquer projeto**
- Gera documento pré-processado otimizado
- Build-tech-docs recebe input estruturado, acelerando processo
- Aplicável universalmente: React, Node.js, Python, Django, etc.

## 🏗️ **Componentes Arquiteturais**

### **1. @docs-reverse-engineer (Agente Universal)**
**Responsabilidade**: Análise inteligente de qualquer estrutura de projeto

**Capacidades**:
- **Project Type Detection**: Identifica automaticamente tipo de projeto (React SPA, API Node.js, Django, etc.)
- **Universal Parsing**: Analisa package.json, requirements.txt, Cargo.toml, composer.json
- **Directory Structure Analysis**: Mapeia hierarquia de arquivos de forma agnóstica
- **Dependency Graph**: Extrai dependências e integrações sem assumption de stack
- **Code Pattern Recognition**: Identifica padrões arquiteturais universais (MVC, microserviços, etc.)

**Algoritmo de Detecção**:
```typescript
interface ProjectDetection {
  // Frontend Frameworks
  detectReactProject(): boolean     // package.json + react dependency
  detectVueProject(): boolean       // package.json + vue dependency  
  detectAngularProject(): boolean   // angular.json + @angular/core
  
  // Backend Frameworks  
  detectNodeAPI(): boolean          // package.json + express/fastify/nestjs
  detectPythonProject(): boolean    // requirements.txt ou pyproject.toml
  detectDjangoProject(): boolean    // manage.py + Django in requirements
  detectRustProject(): boolean      // Cargo.toml
  
  // Full-stack
  detectNextJS(): boolean           // next.config.js + next dependency
  detectNuxtJS(): boolean           // nuxt.config.js + nuxt dependency
  
  // Architecture Patterns
  detectMonorepo(): boolean         // workspace packages ou lerna.json
  detectMicroservices(): boolean    // docker-compose + múltiplos services
}
```

### **2. /docs/reverse-consolidate (Comando Orquestrador)**
**Responsabilidade**: Coordena todo processo de engenharia reversa

**Workflow Sequencial Hierárquico**:
1. **Project Scanning**: Escaneia estrutura completa do projeto alvo
2. **Type Detection**: Identifica stack e arquitetura
3. **Hierarchical Analysis**: Processa sequencialmente por categoria:
   - Configuração (package.json, etc.)
   - Estrutura de diretórios  
   - Arquivos principais (main, index, app.py)
   - Componentes/módulos
   - Testes
   - Configurações (CI/CD, Docker, etc.)
4. **Dependency Mapping**: Mapeia dependências internas e externas
5. **Pattern Recognition**: Identifica padrões arquiteturais
6. **Template Application**: Aplica template adequado ao tipo de projeto
7. **Consolidation**: Gera documento único estruturado

### **3. Template Engine Adaptativo**
**Responsabilidade**: Gera documento compatível com build-tech-docs para qualquer projeto

**Templates por Tipo de Projeto**:
```yaml
# React SPA Template
react_spa:
  sections:
    - project_overview
    - component_structure  
    - state_management
    - routing_architecture
    - build_configuration
    - testing_strategy

# Node.js API Template  
nodejs_api:
  sections:
    - project_overview
    - api_endpoints
    - middleware_stack
    - database_integration
    - authentication_flow
    - deployment_config

# Full-stack Template
fullstack:
  sections:
    - project_overview
    - frontend_architecture
    - backend_architecture
    - database_design
    - api_contracts
    - deployment_pipeline
```

**Formato de Output Híbrido**:
```markdown
---
# Metadados Estruturados para IA
project_type: "react_spa"
stack: ["React", "TypeScript", "Vite"]  
architecture_pattern: "Component-Based SPA"
dependencies_count: 45
last_analysis: "2025-01-29T19:45:00Z"
---

# [Projeto] - Documentação Consolidada

## 📋 Project Overview
[Gerado dinamicamente baseado no projeto específico]

## 🏗️ Architecture Analysis  
[Padrões identificados automaticamente]

## 📚 Technology Stack
[Stack detection results]

## 🔧 Component Structure
[Hierarquia específica do projeto]

## 🔗 Integration Points
[APIs, serviços externos, etc.]

## 📊 Dependencies & Infrastructure
[Análise de dependências do projeto específico]
```

### **4. Integration Layer com build-tech-docs**
**Responsabilidade**: Compatibilidade perfeita com sistema existente

**Como Complementa build-tech-docs**:
- **Input Pré-estruturado**: Fornece análise inicial já processada
- **Accelerated Phase 1**: Substitui descoberta manual por análise automática
- **Enhanced Phase 2**: Perguntas mais contextuais e específicas
- **Same Output**: Mantém geração dos 9 arquivos finais inalterada

## 🔧 **Padrões e Melhores Práticas**

### **Padrões Mantidos do Sistema Onion**
1. **Cursor Commands Pattern**: Comando executável via chat
2. **Agent-Based Architecture**: Especialização via agentes
3. **YAML Headers**: Configuração padronizada  
4. **ClickUp Integration**: Auto-updates e tracking
5. **Session Management**: Arquivos de contexto e progresso

### **Padrões Introduzidos**
1. **Universal Detection**: Algoritmos agnósticos de stack
2. **Hierarchical Processing**: Análise sequencial organizada
3. **Adaptive Templates**: Templates que se adaptam ao projeto
4. **Metadata Enrichment**: Enriquecimento com metadados estruturados

## 🚀 **Dependências e Integrações**

### **Dependências Externas**
- **Nenhuma nova**: Usa apenas ferramentas já disponíveis no Sistema Onion
- **Filesystem**: `read_file`, `list_dir`, `glob_file_search`, `codebase_search`
- **Processing**: `write`, `MultiEdit`, `search_replace`
- **Web Research**: `web_search` para melhores práticas quando necessário

### **Integrações Internas**
- **build-tech-docs**: Target principal de integração
- **@documentation-writer**: Para formatação e refinamento
- **@research-agent**: Para contexto sobre tecnologias desconhecidas
- **@metaspec-gate-keeper**: Para validação final da documentação

## ⚖️ **Trade-offs e Alternativas**

### **Trade-offs Aceitos**
1. **Processamento Sequencial vs Paralelo**: 
   - ✅ Escolhido: Sequencial (mais confiável, organizado)
   - ❌ Rejeitado: Paralelo (mais rápido, mas menos estruturado)

2. **Detecção Automática vs Manual**:
   - ✅ Escolhido: Automática (universal, escalável)
   - ❌ Rejeitado: Manual (precisa, mas não escalável)

3. **Template Adaptativo vs Fixo**:
   - ✅ Escolhido: Adaptativo (funciona com qualquer projeto)
   - ❌ Rejeitado: Fixo (simples, mas limitado)

### **Alternativas Consideradas**
1. **AST Parsing**: Análise de Abstract Syntax Tree
   - Pros: Precisão máxima
   - Contras: Complexidade, dependência de parsers por linguagem
   - Decisão: Não implementar no MVP

2. **AI-Based Analysis**: Usar LLM para análise de código
   - Pros: Inteligência contextual
   - Contras: Custo, latência, variabilidade
   - Decisão: Usar apenas para casos específicos

## ⚠️ **Restrições e Suposições**

### **Restrições**
1. **Filesystem Access**: Projeto deve estar acessível via filesystem
2. **Standard Structure**: Projeto deve seguir convenções mínimas (package.json, etc.)
3. **Text-Based**: Análise apenas de arquivos texto/código
4. **Memory Limits**: Projetos muito grandes (>10k arquivos) podem precisar otimização

### **Suposições**
1. **Conventional Naming**: Projetos seguem convenções padrão de nomenclatura
2. **Documented Dependencies**: Dependências declaradas em arquivos padrão
3. **Git Repository**: Projeto tem histórico git para análise temporal
4. **UTF-8 Encoding**: Arquivos são UTF-8 compatíveis

## 🚫 **Consequências Negativas**

### **Riscos Identificados**
1. **False Detection**: Classificação incorreta de tipo de projeto
   - **Mitigação**: Sistema de fallback para "Generic Project"
   
2. **Large Codebase Performance**: Projetos >5k arquivos podem ser lentos
   - **Mitigação**: Filtering inteligente + progress reporting
   
3. **Unusual Architecture**: Projetos com arquiteturas não-convencionais
   - **Mitigação**: Template "Custom" + human validation

4. **Version Compatibility**: Mudanças em frameworks podem quebrar detecção
   - **Mitigação**: Detecção baseada em patterns, não versões específicas

## 📁 **Principais Arquivos**

### **Arquivos a Serem Criados**
```
.cursor/agents/development/
└── docs-reverse-engineer.md           # Agente universal de análise

.cursor/commands/docs/  
└── reverse-consolidate.md              # Comando orquestrador

docs/onion/templates/
├── project-analysis-templates/         # Templates por tipo de projeto  
│   ├── react-spa.md
│   ├── nodejs-api.md  
│   ├── fullstack.md
│   └── generic.md
└── consolidated-output-format.md       # Formato padrão de saída
```

### **Arquivos de Output (Temporários)**
```
docs/onion/
└── consolidated-project-documentation.md    # Output final para build-tech-docs
```

## 🧪 **Estratégia de Teste**

### **Testes de Compatibilidade**
1. **React SPA**: Testar com projeto Create React App
2. **Node.js API**: Testar com Express/Fastify API
3. **Full-stack**: Testar com Next.js application
4. **Python**: Testar com Django/FastAPI project
5. **Edge Cases**: Projeto sem package.json, monorepo, etc.

### **Validação de Integração**
```bash
# Workflow completo de teste
/docs/reverse-consolidate /path/to/target/project
# → Deve gerar consolidated-project-documentation.md

/docs/build-tech-docs docs/onion/consolidated-project-documentation.md  
# → Deve acelerar drasticamente e gerar 9 arquivos finais
```

## 🎯 **Success Metrics**

### **Performance Targets**
- **Detection Accuracy**: >95% para tipos de projeto comuns
- **Processing Speed**: <2min para projetos de tamanho médio (1k arquivos)
- **Integration Success**: 100% compatibilidade com build-tech-docs
- **Universal Coverage**: Funciona com 80%+ dos projetos JavaScript/TypeScript

### **Quality Metrics**
- **Human Readability**: Documento gerado é clara para desenvolvedores
- **AI Optimization**: Metadados aceleram processamento IA
- **Completeness**: 90%+ das informações relevantes capturadas
- **Maintenance**: Sistema pode ser re-executado para updates

---

## 🚀 **Implementação Next Steps**

Esta arquitetura estabelece a base para:
1. **Fase 1**: Criar @docs-reverse-engineer com detecção universal
2. **Fase 2**: Implementar /docs/reverse-consolidate com workflow sequencial  
3. **Fase 3**: Desenvolver templates adaptativos por tipo de projeto
4. **Fase 4**: Testar integração end-to-end com build-tech-docs

**Arquitetura aprovada para prosseguir com implementação?**
