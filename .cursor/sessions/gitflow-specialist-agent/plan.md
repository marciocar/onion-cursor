# 📋 Plano de Implementação - GitFlow Specialist Agent

## 🎯 **Visão Geral**

Implementação de agente especialista em GitFlow seguindo o padrão do Sistema Onion, com foco em workflows colaborativos, automação de releases e padronização de versionamento.

---

## 📅 **Fase 1: Core Agent Structure** ⏱️ 1-2h

### **1.1 Estrutura Base do Agente**
```yaml
# .cursor/agents/development/gitflow-specialist.md
---
name: "GitFlow Specialist"
description: "Expert em fluxo de trabalho GitFlow - branching model para equipes colaborativas"
color: "lightgreen"
model: "claude-3-5-sonnet-20241022"
tools: [read_file, write, search_replace, run_terminal_cmd, grep, codebase_search, web_search]
specialties:
  - "branch-management"
  - "release-management" 
  - "hotfix-workflow"
  - "team-collaboration"
---
```

### **1.2 Definição de Especialidades**
- **branch-management**: Criação, navegação e merge de branches GitFlow
- **release-management**: Processos de release, tags e versionamento semântico
- **hotfix-workflow**: Correções críticas emergenciais que bypassam develop
- **team-collaboration**: Setup inicial, onboarding e workflows colaborativos

### **1.3 Configuração de Ferramentas**
- `run_terminal_cmd`: Execução de comandos git e git-flow
- `codebase_search`: Análise de estrutura de repositório
- `read_file`/`write`: Manipulação de arquivos de configuração
- `web_search`: Busca por soluções de problemas específicos

---

## 📅 **Fase 2: GitFlow Workflows** ⏱️ 2-3h

### **2.1 Feature Development Workflow**
```bash
# Templates de comandos feature
git flow feature start feature-name
git flow feature finish feature-name

# Com validações automáticas
- Verificar se develop está atualizada
- Validar nome da feature (kebab-case)
- Checar conflitos antes do merge
```

### **2.2 Release Management Automation**
```bash
# Processo de release completo (flexível master/main)
git flow release start v1.2.0
git flow release finish v1.2.0

# Com semantic versioning e detecção automática
- Detectar automaticamente se repo usa master ou main
- Análise de commits para determinar MAJOR.MINOR.PATCH
- Geração automática de changelogs
- Criação de tags anotadas na branch principal correta
```

### **2.3 Hotfix Emergency Procedures**
```bash
# Hotfix crítico bypassing develop (master/main aware)
git flow hotfix start hotfix-critical-bug
git flow hotfix finish hotfix-critical-bug

# Com validações de emergência e flexibilidade
- Verificar se realmente é hotfix vs feature
- Detectar branch principal (master ou main)
- Merge automático para master/main E develop
- Comunicação para equipe sobre hotfix
```

### **2.4 Branch Navigation Helpers**
- Comandos para listar branches por tipo
- Status atual do GitFlow no repositório
- Visualização gráfica do flow atual

---

## 📅 **Fase 3: Advanced Features** ⏱️ 1-2h

### **3.1 Semantic Versioning Automation**
```typescript
// Análise automática de commits para versioning
interface VersionBump {
  major: boolean; // BREAKING CHANGES
  minor: boolean; // feat: new features
  patch: boolean; // fix: bug fixes
}

// Sugestão automática baseada em conventional commits
```

### **3.2 Changelog Generation**
- Parser de commits seguindo Conventional Commits
- Agrupamento por tipos: Features, Fixes, Breaking Changes
- Links automáticos para issues/PRs
- Formatação markdown padronizada

### **3.3 Conflict Resolution Strategies**
- Detecção automática de tipos de conflito
- Sugestões de estratégias de resolução
- Templates para merge messages
- Backup automático antes de merges complexos

### **3.4 Team Onboarding Guides**
- Setup inicial para novos desenvolvedores
- Explicação do flow para diferentes tipos de mudança
- Boas práticas e convenções do projeto
- Troubleshooting de problemas comuns

---

## 📅 **Fase 4: Integration & Testing** ⏱️ 1h

### **4.1 Integração Sistema Onion**
- Teste de invocação via `@gitflow-specialist`
- Integração com outros agentes (`@code-reviewer`, `@product-agent`)
- Validação de documentação em `.cursor/agents/README.md`

### **4.2 Testes em Repositório Real**
```bash
# Cenários de teste
1. Setup GitFlow em repo limpo
2. Ciclo completo: feature → develop → release → master
3. Hotfix emergencial com merge duplo
4. Resolução de conflitos em release
5. Versionamento automático baseado em commits
```

### **4.3 Documentação e Exemplos**
- Exemplos práticos de cada workflow
- Troubleshooting guide para problemas comuns
- Integration guide com outros agentes
- Templates reutilizáveis

### **4.4 Update Documentação Geral**
- Adicionar agente em `.cursor/agents/README.md`
- Atualizar contador de agentes (16º agente)
- Documentar cases de uso específicos
- Links para documentação GitFlow oficial

---

## 🧪 **Validação e Testes**

### **Teste Scenarios**
1. **Repo Setup**: `git flow init` em repositório limpo
2. **Feature Flow**: `feature/new-component` → `develop` → `release/v1.1.0` → `master`
3. **Hotfix Flow**: `hotfix/critical-security` → `master` + `develop`
4. **Conflict Resolution**: Merge com conflitos + resolução guiada
5. **Team Onboarding**: Setup completo para novo desenvolvedor

### **Acceptance Criteria**
- [ ] ✅ Todos os comandos git flow essenciais funcionando
- [ ] ✅ Semantic versioning automático preciso
- [ ] ✅ Changelog generation functional
- [ ] ✅ Conflict resolution helpers efetivos
- [ ] ✅ Team onboarding documentation completa

---

## 🚀 **Estratégia de Deploy**

### **Rollout Plan**
1. **Alpha**: Teste interno com repositório de exemplo
2. **Beta**: Teste com projeto real do Sistema Onion
3. **Production**: Disponibilização para todos os projetos
4. **Documentation**: Update completo da documentação

### **Success Metrics**
- Redução de 80% em erros de GitFlow manual
- Onboarding time reduzido de 2h para 30min
- 100% compliance com semantic versioning
- Zero erros críticos em hotfixes

---

## 📝 **Checklist de Conclusão**

### **Phase 1** ⏳
- [ ] Estrutura YAML criada
- [ ] Especialidades definidas
- [ ] Ferramentas configuradas
- [ ] Cor e modelo definidos

### **Phase 2** ⏳
- [ ] Feature workflow templates
- [ ] Release automation
- [ ] Hotfix procedures
- [ ] Branch navigation helpers

### **Phase 3** ⏳
- [ ] Semantic versioning
- [ ] Changelog generation
- [ ] Conflict resolution
- [ ] Team onboarding guides

### **Phase 4** ⏳
- [ ] Sistema Onion integration
- [ ] Repository testing
- [ ] Documentation complete
- [ ] Agent README updated

---

**Próximo Passo**: Executar `/engineer/start gitflow-specialist-agent` para iniciar Fase 1
