# Prompts de Geração de Documentação

Este diretório contém prompts abrangentes projetados para guiar o Claude Code na geração automática de arquiteturas completas de documentação para projetos. Estes prompts fazem engenharia reversa da estrutura de documentação multi-arquivo que desenvolvemos.

## Prompts Disponíveis

### 📋 `technical.md` - Gerador de Documentação Técnica
**Propósito**: Analisar um codebase e gerar documentação abrangente de contexto técnico

**Saída**: Documentação técnica completa seguindo a arquitetura multi-arquivo:
- Project charter e ADRs
- Guias de desenvolvimento IA e navegação do codebase
- Lógica de negócio e especificações de API  
- Workflow de desenvolvimento e guias de troubleshooting

**Melhor Para**: 
- Projetos de software precisando de documentação técnica
- Projetos open source requerendo onboarding de contribuidores
- Codebases complexos precisando de contexto otimizado para IA

### 🏢 `business.md` - Gerador de Contexto de Negócio  
**Propósito**: Analisar um produto/projeto e gerar documentação abrangente de inteligência de negócio

**Saída**: Contexto de negócio completo seguindo a arquitetura multi-arquivo:
- Personas de cliente e mapeamento de jornada
- Estratégia de produto e catálogos de funcionalidades
- Panorama competitivo e análise de mercado
- Processos de vendas e diretrizes de comunicação

**Melhor Para**:
- Produtos precisando de otimização de suporte ao cliente
- Inteligência de negócio e análise de mercado
- Sistemas de interação de IA com cliente
- Alinhamento de vendas e marketing

## Exemplos de Uso

### Geração de Documentação Técnica
```bash
# Para um projeto Python
claude-code --prompt @prompts/technical.md \
  --project-path ./my-python-project \
  --output-path ./my-python-project/docs/technical \
  --technology-stack "Python, FastAPI, PostgreSQL" \
  --focus-areas "performance,security"

# Para uma aplicação React  
claude-code --prompt @prompts/technical.md \
  --project-path ./my-react-app \
  --output-path ./docs/technical \
  --existing-docs ./current-docs \
  --focus-areas "scalability,testing"
```

### Geração de Documentação de Negócio
```bash
# Para um produto SaaS
claude-code --prompt @prompts/business.md \
  --project-path ./my-saas-product \
  --output-path ./docs/business \
  --business-model "B2B SaaS" \
  --target-market "Enterprise developers" \
  --competitive-analysis "Competitor1,Competitor2"

# For an open source project
claude-code --prompt @prompts/business.md \
  --project-path ./my-oss-project \
  --output-path ./specs/business \
  --business-model "Open Source" \
  --customer-research ./community-feedback.md
```

## Prompt Architecture

Both prompts follow a systematic approach:

1. **Analysis Phase**: Deep understanding of the project/product
2. **Research Phase**: Gathering context from multiple sources
3. **Generation Phase**: Creating the multi-file documentation structure
4. **Garantia de Qualidade**: Garantindo precisão e otimização para IA

## Funcionalidades Principais

### 🎯 **Estrutura Multi-Arquivo**
- Gera arquivos de documentação vinculados e modulares
- Cada arquivo foca em um domínio ou camada específica
- Fácil de manter e atualizar

### 🤖 **Otimizado para IA**
- Conteúdo estruturado para consumo de IA
- Inclui diretrizes específicas de interação com IA
- Permite melhor desenvolvimento e suporte assistido por IA

### 📊 **Baseado em Evidências**
- Fundamentado em dados e artefatos reais do projeto
- Evita conselhos genéricos em favor de insights específicos do projeto
- Valida afirmações com código, configurações e feedback

### 🔄 **Integração com Templates**
- Referencia os templates abrangentes em `@common/templates/`
- Garante consistência entre diferentes projetos
- Segue melhores práticas estabelecidas

## Padrões de Qualidade

### Documentação Técnica
- ✅ Arquitetura corresponde à implementação real
- ✅ Exemplos funcionam e são testados
- ✅ Afirmações de performance apoiadas por evidências
- ✅ Workflows de desenvolvimento correspondem às práticas do projeto

### Documentação de Negócio  
- ✅ Insights de cliente baseados em feedback real
- ✅ Análise competitiva atual e precisa
- ✅ Estratégia de produto alinhada com direção real
- ✅ Diretrizes de comunicação correspondem às preferências do cliente

## Personalização

Os prompts são projetados para serem flexíveis e podem ser adaptados para:

### Tipos de Projeto
- Aplicações web
- Apps mobile
- APIs e serviços backend
- Bibliotecas e frameworks
- Ferramentas de desenvolvedor
- Software empresarial

### Business Models
- B2B SaaS
- B2C applications
- Open source projects
- E-commerce platforms
- Marketplace platforms
- Developer tools

### Company Stages
- Early stage / startup
- Growth stage
- Enterprise / mature

## Integration with Templates

These prompts work in conjunction with:
- `@common/templates/technical_context_template.md`
- `@common/templates/business_context_template.md`

The templates provide the structure and frameworks, while these prompts provide the analysis methodology and execution strategy.

## Expected Outcomes

Using these prompts should result in:

### For Development Teams
- Faster onboarding of new team members
- Better AI-assisted development experience
- Consistent technical decision-making
- Improved code review efficiency

### For Business Teams  
- Enhanced AI customer support capabilities
- Aligned sales and marketing messaging
- Data-driven product decisions
- Comprehensive competitive intelligence

### For AI Systems
- Deep understanding of project context
- Ability to provide contextually appropriate assistance
- Better code generation and suggestions
- Improved customer interaction capabilities

## Meta-Documentation

These prompts represent a "meta" approach to documentation - they are prompts that generate the documentation architecture we've designed and validated. They enable scaling of high-quality, AI-optimized documentation across multiple projects while maintaining consistency and quality standards.