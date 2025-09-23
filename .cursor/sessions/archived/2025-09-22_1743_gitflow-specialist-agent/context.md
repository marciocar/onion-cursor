# 🌿 GitFlow Specialist Agent - Contexto de Desenvolvimento

## 📋 **Task Principal**
**ID ClickUp**: `86ac0b4br`  
**Nome**: 🌿 GitFlow Specialist Agent - Expert em Fluxo de Trabalho Git  
**Prioridade**: Alta  
**Tags**: `feature`, `agents`, `gitflow`, `development`, `workflow`

## 🌿 **Feature Branch**
**Branch**: `feature/gitflow-specialist-agent`  
**Criada em**: 2025-01-22 22:00:05  
**Base**: `main` (ou branch principal atual)

## ⏱️ **Timeline**
**Estimativa Total**: 5-8 horas  
**Complexity**: Média  
**Setup Ambiente**: ✅ Concluído  
**Desenvolvimento**: 🔄 Pendente

## 🎯 **Entendimento do Projeto**

### **Por que?**
O Sistema Onion precisa de um agente especialista em **GitFlow** para:
- Padronizar workflows de versionamento em projetos colaborativos
- Automatizar processos de feature development, releases e hotfixes
- Reduzir erros humanos em operações Git críticas
- Facilitar onboarding de desenvolvedores em projetos com GitFlow
- **Suportar convenções modernas**: Tanto `master` quanto `main` como branch principal

### **O que?**
Agente especialista que domina completamente o modelo GitFlow de Vincent Driessen:
- **Branches principais**: `master`/`main` (produção) e `develop` (desenvolvimento)
- **Flexibilidade moderna**: Detecção automática de `master` vs `main`
- **Branches auxiliares**: `feature/*`, `release/*`, `hotfix/*`
- **Semantic Versioning**: MAJOR.MINOR.PATCH com git tags
- **Git-Flow Plugin**: Automatização via nvie/gitflow toolkit (suporte master/main)

### **Como?**
1. **Estrutura YAML** em `.cursor/agents/development/gitflow-specialist.md`
2. **Specialties** cobrindo: branch-management, release-management, hotfix-workflow, team-collaboration
3. **Tools** incluindo: Git commands, bash, codebase search, web search
4. **Templates** para workflows comuns e automações

## 🔍 **Subtasks Identificadas**

### **Fase 1: Core Agent Structure** (1-2h)
- [ ] Criar estrutura YAML do agente
- [ ] Definir 4 especialidades principais
- [ ] Configurar ferramentas necessárias (Git, bash, codebase_search)
- [ ] Estabelecer cor (lightgreen) e modelo (sonnet)

### **Fase 2: GitFlow Workflows** (2-3h)
- [ ] Templates para feature workflows
- [ ] Automação de release processes
- [ ] Procedimentos de emergency hotfix
- [ ] Helpers para navegação entre branches

### **Fase 3: Advanced Features** (1-2h)
- [ ] Automação de semantic versioning
- [ ] Geração automática de changelogs
- [ ] Estratégias de resolução de conflitos
- [ ] Guias de onboarding para equipes

### **Fase 4: Integration & Testing** (1h)
- [ ] Integração com Sistema Onion
- [ ] Testes em repositório real
- [ ] Documentação e exemplos
- [ ] Update da documentação geral

## 📊 **Success Metrics**

### **Critérios de Aceitação Técnicos**
- ✅ Agente criado em `.cursor/agents/development/gitflow-specialist.md`
- ✅ Invocação via `@gitflow-specialist` funcionando
- ✅ Consegue executar todos os comandos git flow essenciais
- ✅ Guia setup inicial de repositório GitFlow
- ✅ Maneja ciclo completo: feature → develop → release → master

### **Critérios de Qualidade**
- ✅ Documentação completa e exemplos práticos
- ✅ Integração fluida com outros agentes do Sistema Onion
- ✅ Troubleshooting guide para problemas comuns
- ✅ Templates reutilizáveis para workflows

## 🏗️ **Decisões Arquiteturais**

### **Localização**
- **Pasta**: `.cursor/agents/development/` (categoria development)
- **Arquivo**: `gitflow-specialist.md` (padrão kebab-case)

### **Configurações Técnicas**
- **Cor**: `lightgreen` (representa branches/growth)
- **Modelo**: `claude-3-5-sonnet-20241022` (capacidade técnica avançada)
- **Ferramentas**: Git commands, bash, codebase_search, web_search

### **Especialidades Definidas**
1. **branch-management**: Criação, merge, navegação de branches
2. **release-management**: Processo de release e versionamento
3. **hotfix-workflow**: Correções críticas emergenciais
4. **team-collaboration**: Setup e onboarding de equipes

## 📚 **Referências Base**

### **Documentação Oficial**
- [nvie/gitflow](https://github.com/nvie/gitflow) - Plugin oficial
- [GitFlow Original](https://nvie.com/posts/a-successful-git-branching-model/) - Vincent Driessen
- [Semantic Versioning 2.0.0](https://semver.org/)

### **Artigos Estudados**
- [Medium - Utilizando o fluxo Git Flow](https://medium.com/trainingcenter/utilizando-o-fluxo-git-flow-e63d5e0d5e04)
- [Alura - Git Flow: o que é, como e quando utilizar](https://www.alura.com.br/artigos/git-flow-o-que-e-como-quando-utilizar)

## 🎯 **Próximos Passos Recomendados**

1. **Iniciar Desenvolvimento**: `/engineer/start gitflow-specialist-agent`
2. **Seguir Plano**: Implementar seguindo fases em `plan.md`
3. **Testar Incrementalmente**: Validar cada fase antes de prosseguir
4. **Documentar Progressos**: Atualizar `notes.md` com decisões

---

**Status Atual**: ✅ AMBIENTE PREPARADO - PRONTO PARA DESENVOLVIMENTO  
**Última Atualização**: 2025-01-22 22:00:05  
**Sistema**: Onion v1.0
