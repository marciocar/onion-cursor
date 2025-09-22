# 🧅 Sistema Onion

[![Comandos](https://img.shields.io/badge/Comandos-26-blue)](docs/onion/commands-guide.md) [![Agentes](https://img.shields.io/badge/Agentes-17-green)](docs/onion/agents-reference.md) [![ClickUp](https://img.shields.io/badge/ClickUp-Integrado-orange)](docs/onion/clickup-integration.md)

## 🎯 Visão Geral

Bem-vindo ao projeto Onion! Sistema avançado de comandos `.cursor/` com integração ClickUp e agentes especializados de IA. Documentação completa disponível em [`docs/onion/`](docs/onion/) para usar efetivamente todos os comandos, agentes e fluxos de trabalho.

## 📖 Guias Disponíveis

### 🎯 Guias Principais
- **[Guia de Comandos](docs/onion/commands-guide.md)** - Documentação completa de todos os comandos disponíveis
- **[Fluxos de Engenharia](docs/onion/engineering-flows.md)** - Workflows detalhados para desenvolvimento
- **[Integração ClickUp](docs/onion/clickup-integration.md)** - Como integrar comandos com ClickUp MCP

### 🛠️ Referências Técnicas
- **[Agentes Disponíveis](docs/onion/agents-reference.md)** - Lista e descrição de todos os agentes especializados
- **[Exemplos Práticos](docs/onion/practical-examples.md)** - Casos de uso reais com exemplos

### 🚀 Início Rápido
- **[Configuração Inicial](docs/onion/getting-started.md)** - Como configurar e começar a usar o sistema

## 🎯 Navegação Rápida

### Por Categoria de Comando
- **🔧 [Comandos de Engenharia](#comandos-de-engenharia)**: start, pr, work, pre-pr, plan, docs
- **📋 [Comandos de Produto](#comandos-de-produto)**: task, collect, refine, light-arch, spec
- **📚 [Comandos de Documentação](#comandos-de-documentacao)**: build-tech-docs, build-business-docs
- **⚙️ [Meta Comandos](#meta-comandos)**: create-agent, all-tools

### Por Fluxo de Trabalho
1. **[Criação de Task](#criacao-de-task)** → `product/task`
2. **[Desenvolvimento](#desenvolvimento)** → `engineer/start` → `engineer/work` 
3. **[Review & Deploy](#review-deploy)** → `engineer/pr`
4. **[Documentação](#documentacao)** → `docs/build-*`

## 🎪 Início Rápido

Para começar rapidamente:

```bash
# 1. Criar uma nova task
/product/task "Implementar autenticação de usuário"

# 2. Iniciar desenvolvimento
/engineer/start

# 3. Trabalhar na funcionalidade
/engineer/work

# 4. Fazer PR quando pronto
/engineer/pr
```

## 🤝 Integração ClickUp

Todos os comandos estão integrados com ClickUp MCP para:
- ✅ Criação automática de tasks
- ✅ Atualização de status de progresso
- ✅ Adição de comentários e atualizações
- ✅ Gerenciamento de tags e assignees

## 📞 Suporte

Para dúvidas ou problemas:
1. Consulte os guias específicos em cada arquivo
2. Veja exemplos práticos em `practical-examples.md`
3. Verifique a integração ClickUp se houver problemas de sincronização

---

**Sistema Onion v2.0** - Comandos inteligentes para desenvolvimento ágil com IA 🧅
