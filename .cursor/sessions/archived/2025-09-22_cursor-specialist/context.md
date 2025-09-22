# Context: Cursor Specialist Agent

## 🎯 **Por que isso está sendo construído (Contexto)**

### Problema Identificado
O Sistema Onion possui **13 agentes especializados** mas carece de um especialista técnico em **ambiente de desenvolvimento**. Embora tenhamos agentes para Python, React, testes, etc., não há um especialista focado em:
- **Otimização do ambiente Cursor IDE**
- **Configurações específicas para produtividade** 
- **Extensions e workspace settings**
- **Troubleshooting de problemas de IDE**

### Gap Atual
- **Agentes existentes** focam em linguagens específicas ou domínios (produto, testes, research)
- **Nenhum especialista** em ambiente de desenvolvimento/IDE
- **Configurações Cursor** atualmente não padronizadas no Sistema Onion
- **Produtividade bloqueada** por problemas básicos de configuração IDE

### Justificativa
**Cursor IDE é a ferramenta central** de todo o Sistema Onion. Um especialista técnico dedicado irá:
1. **Otimizar produtividade** de todos os outros agentes
2. **Padronizar configurações** do ambiente de desenvolvimento
3. **Resolver problemas técnicos** rapidamente
4. **Manter atualizações** de extensions e settings

---

## 🔍 **Qual é o resultado esperado para esta task? (Objetivo)**

### Deliverable Principal
**Criar `.cursor/agents/development/cursor-specialist.md`** - Agente especialista técnico em Cursor IDE.

### Funcionalidades Esperadas
1. **Configuração e Otimização**:
   - Settings personalizados (Chat, Models, Features)
   - Workspace settings específicos por projeto
   - Performance tuning e memory optimization

2. **Extensões e Plugins**:
   - Gestão de extensions recomendadas
   - Configuração de API keys (OpenAI, Anthropic, Google, Azure)
   - Integration com ferramentas externas

3. **Produtividade**:
   - Keybindings otimizados
   - Snippets e templates
   - Cursor Tab configuration
   - Chat e Cmd+K optimization

4. **Troubleshooting**:
   - Resolução de problemas comuns (HTTP/2, proxy, logs)
   - Debugging de configurações
   - Performance issues

### Integração no Ecossistema
- **Complementa agentes existentes** (não compete)
- **Melhora ambiente** para python-developer, react-developer, etc.
- **Integração com comandos** `/engineer/*` para setup automático

---

## 🛠️ **Como deve ser construído (Abordagem)**

### 1. Padrão Estabelecido
Seguir **exatamente** a estrutura dos agentes existentes:
- **YAML header** com name, description, model, tools, color, priority, expertise
- **Seções Markdown** estruturadas
- **Modelo**: `sonnet` (eficiência para operações IDE)
- **Cor**: `purple` (categoria produtividade/ferramentas)

### 2. Ferramentas Específicas
Baseado na pesquisa da documentação Cursor:
- **`read_file`, `write`, `MultiEdit`**: Para modificar settings
- **`run_terminal_cmd`**: Para operations de CLI
- **`codebase_search`, `list_dir`, `glob_file_search`**: Para descobrir configurações
- **`web_search`**: Para pesquisar extensions e troubleshooting

### 3. Especialidades Técnicas
Com base na documentação oficial Cursor:
- **`cursor-settings`**: Chat, Models, Features, Beta configurations
- **`workspace-optimization`**: .cursorrules, .cursorignore, project-specific
- **`extensions-management`**: VSCode extensions compatíveis
- **`api-integrations`**: OpenAI, Anthropic, Google, Azure keys
- **`performance-tuning`**: HTTP/2, memory, context windows
- **`troubleshooting`**: Logs, connectivity, proxy issues
- **`productivity-enhancement`**: Keybindings, snippets, automation

---

## 🔧 **APIs/Ferramentas necessárias**

### Ferramentas de Sistema
- **File operations**: Para modificar settings.json, .cursorrules, etc.
- **Terminal commands**: Para instalar extensions, restart Cursor, etc.
- **Directory exploration**: Para descobrir configurações existentes

### Conhecimento Específico Cursor
- **Settings paths**: `~/.cursor/`, workspace-specific settings
- **Configuration files**: settings.json, .cursorrules, .cursorignore
- **API integrations**: Chaves para different model providers
- **Extensions ecosystem**: Compatible VSCode extensions

### Não precisa de novas APIs
- **Usar ferramentas existentes** do Sistema Onion
- **Sem dependency** em Cursor-specific APIs

---

## 🧪 **Como deve ser testado?**

### 1. Testes de Integração
- **Verificar estrutura** do agent file segue padrão
- **Testar ferramentas** declaradas funcionam
- **Validar YAML header** está correto

### 2. Testes Funcionais
- **Capability de configurar** settings básicos
- **Troubleshoot** problemas simulados
- **Recommend extensions** relevantes

### 3. Testes de Ecosystem
- **Não conflicts** com agentes existentes
- **Integration** com comandos `/engineer/*`
- **Documentation** atualizada corretamente

---

## 📋 **Dependências**

### Sistema Existente
- **Sistema Onion** funcionando
- **Estrutura .cursor/agents/** presente
- **Padrão de agentes** estabelecido (modelo dos 13 agentes atuais)

### Ambiente
- **Cursor IDE** rodando (óbvio, mas necessário para testes)
- **Acesso a filesystem** para modificar configurações
- **Terminal access** para operações CLI

### Documentação
- **agents-reference.md** para atualização
- **README.md** para nova contagem de agentes

---

## ⚠️ **Restrições**

### Técnicas
- **Não modificar** agentes existentes
- **Seguir padrão rigoroso** estabelecido
- **Sonnet model** (não Opus - economia de custo)
- **Mesmo formato** YAML + Markdown dos outros agentes

### Funcionais
- **Não overlap** com especialidades existentes
- **Foco específico** em Cursor IDE (não editores gerais)
- **Complementar**, não competir com outros agentes

### Procedurais
- **Feature branch** específica
- **Documentation** completa obrigatória
- **Testes de integração** antes do PR

---

## 🎯 **Success Criteria**

### Implementação
- [ ] Agent file criado em `.cursor/agents/development/cursor-specialist.md`
- [ ] Estrutura YAML + Markdown seguindo padrão exato
- [ ] 6-8 especialidades técnicas bem definidas
- [ ] Ferramentas apropriadas declaradas
- [ ] Exemplos práticos de uso incluídos

### Integração
- [ ] `docs/onion/agents-reference.md` atualizado
- [ ] `README.md` badge atualizado (13 → 14 agentes)
- [ ] Sem conflitos com agentes existentes
- [ ] Integration com comandos atuais

### Qualidade
- [ ] Passa validação de linting
- [ ] Commit message seguindo padrão
- [ ] PR criado seguindo template
- [ ] Task ClickUp atualizada com progresso
