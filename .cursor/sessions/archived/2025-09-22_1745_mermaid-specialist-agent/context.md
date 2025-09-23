# 🎨 Contexto - Mermaid Specialist Agent

**Task Principal**: 86ac03vpw - Mermaid Specialist Agent - Criação Completa  
**Feature Branch**: feature/mermaid-specialist-agent  
**Timeline**: 2-3 dias de desenvolvimento  

---

## 🎯 **Entendimento do Projeto**

### **Por que está sendo construído (CONTEXTO):**
- O Sistema Onion necessita de um **agente especialista em diagramas Mermaid** após problemas recentes de compatibilidade
- Precisa **dominar todos os tipos de diagrama** e garantir 100% compatibilidade com GitHub
- Deve **integrar perfeitamente** com os 16 agentes existentes seguindo padrões estabelecidos
- **Solucionar problemas** de renderização e sintaxe que frequentemente ocorrem

### **Qual é o resultado esperado (OBJETIVO):**
- **Agente completo** especializado em diagramas Mermaid em `.cursor/agents/development/`
- **Suporte a 9+ tipos** de diagrama: Flowchart, Sequence, Class, State, ER, Journey, Gantt, Pie, Git Graph
- **Validação e correção automática** de sintaxe Mermaid
- **100% compatibilidade** com GitHub rendering seguindo documentação oficial
- **Integração perfeita** com Sistema Onion e comandos existentes

### **Como deve ser construído (ABORDAGEM):**
- **Estrutura**: Agente em `.cursor/agents/development/mermaid-specialist.md`
- **YAML Header**: metadata, cor lightcyan, emoji 🎨, modelo claude-4-sonnet
- **7 Especialidades**: syntax-validation, github-compatibility, performance-optimization, error-diagnosis, best-practices, cross-platform, interactive-features
- **Ferramentas**: Read, Write, Edit, MultiEdit, Grep, Glob, LS, Bash, Codebase_search, WebSearch, TodoWrite
- **Templates**: Diagramas pré-definidos para casos comuns
- **Troubleshooting**: Guide completo com soluções para problemas conhecidos

### **APIs/Ferramentas Utilizadas:**
- **Mermaid.js**: Engine principal para renderização de diagramas
- **GitHub Mermaid API**: Validação de compatibilidade
- **Live Editor**: Testes em tempo real (mermaid.live)
- **Sistema Onion Tools**: Integração completa com ferramentas existentes
- **Web Search**: Consulta documentação atualizada
- **Codebase Search**: Análise de diagramas existentes no projeto

### **Como deve ser testado:**
- **Testes funcionais**: Criação de todos os 9+ tipos de diagrama
- **Testes de compatibilidade**: GitHub rendering para todos os tipos
- **Testes de performance**: Diagramas complexos com 100+ nós
- **Testes de integração**: Compatibilidade com Sistema Onion
- **Testes de correção**: Problemas conhecidos de sintaxe

### **Dependências Identificadas:**
- **Padrão existente**: Outros 16 agentes como referência
- **Documentação oficial**: GitHub e Mermaid.js
- **Sistema Onion**: Integração com comandos e workflows
- **ClickUp MCP**: Auto-updates e comentários

### **Restrições:**
- **Seguir padrões**: Estrutura idêntica aos agentes existentes
- **Compatibilidade GitHub**: 100% rendering sem erros
- **Performance**: Validação em <5 segundos
- **Integração**: Sem quebrar funcionalidades existentes

---

## 📋 **Funcionalidades Identificadas**

### **1. 🎯 Core Functionalities**
- **Criação de diagramas** a partir de descrições textuais
- **Validação automática** de sintaxe Mermaid
- **Correção de problemas** de compatibilidade GitHub
- **Otimização para performance** e legibilidade

### **2. 🔧 Tipos de Diagrama Suportados**
- **Flowchart** (graph TD, LR, BT, RL)
- **Sequence Diagrams** (sequenceDiagram)
- **Class Diagrams** (classDiagram)
- **State Diagrams** (stateDiagram-v2)
- **Entity Relationship** (erDiagram)
- **User Journey** (journey)
- **Gantt Charts** (gantt)
- **Pie Charts** (pie)
- **Git Graph** (gitgraph)

### **3. 🎨 Especialidades Técnicas**
- **Syntax Validation**: Verificação completa de sintaxe
- **GitHub Compatibility**: Garantia de renderização
- **Performance Optimization**: Diagramas otimizados
- **Error Diagnosis**: Identificação precisa de problemas
- **Best Practices**: Aplicação de melhores práticas
- **Cross-Platform**: Compatibilidade multiplataforma
- **Interactive Features**: Recursos interativos

---

## 🎯 **Success Metrics**

| Métrica | Target | Descrição |
|---------|--------|-----------|
| **GitHub Compatibility** | 100% | Todos os diagramas renderizam sem erro |
| **Validation Speed** | <5s | Tempo de validação de diagramas complexos |
| **Correction Accuracy** | 95%+ | Precisão na correção automática |
| **Diagram Types** | 9+ | Suporte completo a todos os tipos |
| **Integration** | 100% | Compatibilidade com Sistema Onion |

---

## ✅ **Decisões Arquiteturais Confirmadas**

### **Estrutura e Localização:**
- **Localização**: `.cursor/agents/development/mermaid-specialist.md`
- **Formato**: YAML header + Markdown body (padrão estabelecido)
- **Integração**: Sistema Onion completo

### **Identidade Visual:**
- **Cor**: `lightcyan` (compatível com temas)
- **Emoji**: 🎨 (representando criação visual)
- **Modelo**: `claude-4-sonnet` (máxima capacidade)

### **Especialidades Técnicas:**
- **7 especialidades**: Cobrindo todos os aspectos de diagramas Mermaid
- **Foco GitHub**: Prioridade máxima na compatibilidade
- **Performance**: Otimização para velocidade e qualidade

### **Ferramentas e Integração:**
- **Ferramentas completas**: Todas as ferramentas do Sistema Onion
- **Auto-updates**: Integração com ClickUp MCP
- **Colaboração**: Compatibilidade com outros agentes

---

**Status**: ✅ Contexto finalizado - Prosseguindo para implementação completa
