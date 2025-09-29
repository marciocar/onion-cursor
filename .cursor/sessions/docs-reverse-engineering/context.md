# Context - Sistema de Engenharia Reversa da Documentação

## 📋 ClickUp Structure
**Task ID**: 86ac571zh
**Task URL**: https://app.clickup.com/t/86ac571zh
**Status**: Backlog → Ready for /engineer/start
**Estimation**: 4-5 dias / 20-25 horas

## 📋 Phase-Subtask Mapping
- **Phase 1**: "Agente @docs-reverse-engineer" → Subtask ID: 86ac5725f (13h)
- **Phase 2**: "Comando /docs/reverse-consolidate" → Subtask ID: 86ac5727p (12h)
- **Phase 3**: "Template Engine" → Subtask ID: 86ac572cj (8h)
- **Phase 4**: "Integração End-to-End" → Subtask ID: 86ac572ey (8h)

## 🎯 Contexto e Objetivos

### **Por que isso está sendo construído**
O Sistema Onion possui documentação dispersa em múltiplos arquivos:
- 36 comandos organizados em `.cursor/commands/`
- 19 agentes especializados em `.cursor/agents/`  
- Documentação técnica em `docs/onion/`
- Precisa ser consolidado para servir como input para `/docs/build-tech-docs`

### **Resultado Esperado**
Criar um **pré-processador inteligente** que:
1. **`@docs-reverse-engineer`** - Agente que analisa toda documentação existente
2. **`/docs/reverse-consolidate`** - Comando que orquestra o processo
3. **Output**: Documento único consolidado que serve como input otimizado para `/docs/build-tech-docs`

### **Como deve ser construído (Abordagem)**
1. **Análise estrutural**: Escanear todos os arquivos de commands/, agents/, docs/
2. **Mapeamento semântico**: Identificar relacionamentos e hierarquias
3. **Consolidação inteligente**: Gerar documento único padronizado
4. **Integração**: Output compatível como input para `/docs/build-tech-docs` existente

### **Ferramentas/APIs Necessárias**
- **Análise**: `codebase_search`, `read_file`, `list_dir`, `grep`
- **Processamento**: `write`, `MultiEdit`, `search_replace`  
- **Agentes existentes**: `@documentation-writer`, `@research-agent`
- **Template engine**: Para padronização do output

### **Como será testado**
1. **Teste de cobertura**: Verificar se todos os 36 comandos + 19 agentes foram catalogados
2. **Teste de integração**: Usar output como input para `/docs/build-tech-docs`
3. **Teste de qualidade**: Validar preservação de contexto e relacionamentos
4. **Teste de formato**: Compatibilidade com sistema existente

### **Dependências**
- **Comando existente**: `/docs/build-tech-docs` (target da integração)
- **Estrutura de arquivos**: `.cursor/commands/`, `.cursor/agents/`, `docs/onion/`
- **Agentes existentes**: `@documentation-writer` para formatação final

### **Restrições**
- **Preservar estrutura**: Não alterar arquivos originais, apenas ler
- **Compatibilidade**: Output deve ser formato aceito por `build-tech-docs`
- **Performance**: Processar 60+ arquivos eficientemente
- **Manutenibilidade**: Sistema deve ser re-executável para updates

## 🚨 **Descoberta Importante: Por que Task → Start**

### **Fluxo Padrão do Sistema Onion:**
```mermaid
graph LR
    A[/product/task] --> B[Task ClickUp criada]
    B --> C[Estrutura hierárquica]
    C --> D[/engineer/start]  
    D --> E[Development session]
```

### **Vantagens do Task-First Approach:**
1. **Estrutura hierárquica**: Task → Subtasks → Action Items no ClickUp
2. **Tracking automático**: Progresso monitorado em tempo real
3. **Context rico**: `engineer/start` lê task com `subtasks=true`
4. **Phase-Subtask mapping**: Correlação automática fases ↔ subtasks
5. **Comentários estruturados**: Updates automáticos no ClickUp
6. **Visibilidade**: Stakeholders veem progresso estruturado

### **O que perdemos ao pular `/product/task`:**
- ❌ **Não há task ClickUp** para tracking de progresso
- ❌ **Não há subtasks estruturadas** para organizar trabalho  
- ❌ **Não há auto-updates** do status no ClickUp
- ❌ **Não há mapeamento fase→subtask** automático
- ❌ **Não há visibilidade** para outros stakeholders

## 🎯 **Próximas Ações Sugeridas**

### **Opção 1: Continuar sem ClickUp** 
- Trabalhar baseado neste context.md
- Desenvolver sem tracking estruturado
- Manual documentation do progresso

### **Opção 2: Voltar e criar Task primeiro**
- Executar `/product/task "Criar Sistema de Engenharia Reversa da Documentação"`  
- Aguardar criação da estrutura hierárquica no ClickUp
- Re-executar `/engineer/start` com task-id válido

### **Opção 3: Criar task manualmente agora**
- Usar ClickUp MCP para criar task durante este session
- Simular o que `/product/task` faria
- Continuar com desenvolvimento estruturado

## 🤔 **Questão para o Usuário**
**Qual abordagem prefere seguir?** O fluxo padrão Task→Start oferece muito mais estrutura e visibilidade, mas podemos continuar se preferir.
