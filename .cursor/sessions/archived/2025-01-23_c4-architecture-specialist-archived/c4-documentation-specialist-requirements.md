# C4 Documentation Specialist Agent

## POR QUE

### Necessidade de Documentação Textual Completa
- O C4 Model não é apenas diagramas visuais, mas um sistema completo que inclui documentação textual estruturada fundamental para arquitetura de software
- O agente @c4-architecture-specialist atual foca apenas em geração de diagramas, deixando uma lacuna crítica na documentação arquitetural completa
- Demanda por documentação em múltiplos níveis: descrições de sistemas, ADRs (Architecture Decision Records), especificações técnicas e análises de relacionamentos

### Casos de Uso Críticos
- **Onboarding**: Documentação estruturada para novos desenvolvedores entenderem a arquitetura
- **Architecture Reviews**: Material textual detalhado para revisões arquiteturais e tomada de decisões
- **Technical Documentation**: Especificações técnicas para implementação e manutenção
- **Decision Tracking**: Registro histórico de decisões arquiteturais com contexto e justificativas

### Complementaridade ao Agente Existente
- Completar o ciclo C4 fornecendo tanto elementos visuais (diagramas) quanto textuais (documentação)
- Manter consistência entre representações visuais e documentação textual
- Aproveitar análise já realizada pelo agente de arquitetura para gerar documentação alinhada

## O QUE

### Novo Agente Especializado
**Criar @c4-documentation-specialist** como agente independente e especializado em documentação textual C4, seguindo padrão de agentes especializados do Sistema Onion.

### Funcionalidades Core
- **Documentação Progressiva**: Iniciar com Context Level e oferecer expansão para Container, Component e Code levels
- **Templates Oficiais C4**: Utilizar estrutura padronizada do C4 Model (Simon Brown) em formato Markdown
- **Abordagem Híbrida**: Combinar geração automática com refinamento manual através de prompts específicos
- **Múltiplos Formatos**: Adaptável conforme projeto (descrições, ADRs, especificações técnicas, análises de relacionamentos)

### Integração Master-Slave Pattern
- **@c4-architecture-specialist** (Master) automaticamente invoca **@c4-documentation-specialist** (Slave) quando documentação é necessária
- Cache compartilhado de análise entre agentes para consistência e performance
- Interface unificada: usuário recebe diagramas + documentação em uma única interação

### Sistema de Comandos
```bash
# Comandos diretos
@c4-documentation-specialist "document context level only"
@c4-documentation-specialist "expand to container level" 
@c4-documentation-specialist "full documentation all levels"

# Integração automática
@c4-architecture-specialist "analyze project with full documentation"
# → Automaticamente gera diagramas + documentação
```

### Estrutura de Output
- **Localização**: `docs/c4-architecture/` como diretório padrão
- **Organização**: Por níveis C4 (context/, containers/, components/, code/)
- **Flexibilidade**: Opções de localização específica por projeto
- **Versionamento**: Tracking de mudanças na documentação

### Integrações Sistema Onion
- **@onion Meta-Agent**: Delegação automática inteligente
- **Comandos Especializados**: `.cursor/commands/architect/` para workflows específicos
- **ClickUp Integration**: Tracking de documentação e progress
- **Templates System**: `.cursor/utils/` para templates reutilizáveis

### Funcionalidades Existentes Afetadas
- **@c4-architecture-specialist**: Modificar para incluir capacidade de auto-delegação para documentação
- **@onion**: Atualizar lógica de delegação para incluir novo agente
- **Sistema de comandos**: Expandir `/architect/` commands para incluir documentação

## COMO

### Arquitetura Técnica
```typescript
interface C4DocumentationSpecialist {
  // Core Documentation Engine
  generateContextDocumentation(analysis: CachedAnalysis): Promise<ContextDoc>
  generateContainerDocumentation(analysis: CachedAnalysis): Promise<ContainerDoc>
  generateComponentDocumentation(analysis: CachedAnalysis): Promise<ComponentDoc>
  
  // Hybrid Workflow
  createBaseDocumentation(analysis: CachedAnalysis): Promise<BaseDoc>
  promptForRefinement(baseDoc: BaseDoc): Promise<RefinedDoc>
  iterativeImprovement(doc: RefinedDoc): Promise<FinalDoc>
  
  // Template Management
  loadOfficialC4Templates(): C4Templates
  adaptTemplateToProject(template: C4Template, projectType: ProjectType): AdaptedTemplate
  
  // Integration Bridge
  consumeCachedAnalysis(cacheId: string): Promise<AnalysisCache>
  coordinateWithArchitectureAgent(request: DocumentationRequest): Promise<UnifiedOutput>
}
```

### Templates Estruturados C4
Baseado nos padrões oficiais Simon Brown:

```markdown
# Software Architecture Document - [Project Name]

## 1. Context Level
### System Landscape
- **System Purpose**: [Auto-extracted + refinement]
- **Key Users**: [Identified actors]
- **External Dependencies**: [Auto-detected]

### Business Context  
- **Problem Statement**: [Template + manual input]
- **Architectural Drivers**: [Prompt-driven]

## 2. Container Level (Expandable)
### Container Catalog
- **[Container Name]**
  - Technology Stack: [Auto-detected]
  - Core Responsibilities: [Analysis + refinement]
  - API Specifications: [Extracted from code]

## 3. Component Level (Expandable)
### Internal Structure
- **[Component Name]**
  - Implementation Details: [AST analysis]
  - Dependency Mapping: [Import analysis]

## 4. Architecture Decision Records
### ADR-XXX: [Decision Title]
- **Status**: Proposed/Accepted/Deprecated
- **Context**: [Template + user prompts]
- **Decision**: [User input required]
- **Consequences**: [Analysis + user input]
```

### Workflow de Implementação
1. **Analysis Cache Integration**: Conectar com cache do @c4-architecture-specialist
2. **Template Engine**: Sistema de templates C4 oficiais adaptáveis
3. **Progressive Documentation**: Interface para controle de nível de detalhe
4. **Hybrid Refinement**: Auto-generation → templates → prompts → iteração
5. **Master-Slave Bridge**: Integração transparente entre agentes
6. **Sistema Integration**: Comandos, @onion delegation, ClickUp tracking

### Estratégia de Dados
- **Cached Analysis**: Reutilizar análise do agente de arquitetura para consistência
- **Incremental Updates**: Detectar mudanças e atualizar apenas seções afetadas  
- **Version Control**: Tracking de mudanças na documentação
- **Template Versioning**: Templates evolutivos baseado em feedback

### Performance & UX
- **Single Command Experience**: @c4-architecture-specialist produz diagramas + docs automaticamente
- **Progressive Disclosure**: Usuário controla nível de detalhe desejado
- **Interactive Refinement**: Prompts contextuais para melhorar documentação
- **Consistency Guarantee**: Documentação sempre alinhada com diagramas

### Testing Strategy
- **Template Validation**: Verificar conformidade com padrões C4
- **Integration Testing**: Master-slave coordination entre agentes
- **Real Project Testing**: Validar com diferentes tipos de projeto (SPA, API, monorepo)
- **Documentation Quality**: Métricas de completude e útilidade da documentação gerada
