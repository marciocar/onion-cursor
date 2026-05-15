# 📦 Instalação do Onion v4.0 Beta

> **Status**: Beta Release | **Versão**: 4.0.0-beta.1 | **Data**: 2025-12-20

---

## 🎯 Pré-requisitos

Antes de instalar o Onion v4.0, certifique-se de ter:

| Requisito | Versão Mínima | Verificar |
|-----------|---------------|-----------|
| **Node.js** | >= 16.0.0 | `node --version` |
| **pnpm** | >= 8.0.0 | `pnpm --version` |
| **Git** | >= 2.20.0 | `git --version` |
| **IDE** | Claude Code (recomendado) | - |

---

## 🚀 Métodos de Instalação

### Método 1: Instalação Local (Beta)

**Recomendado para testadores beta**

```bash
# 1. Clone o repositório
git clone https://github.com/your-org/onion-v4.git
cd onion-v4

# 2. Instale dependências
pnpm install

# 3. Build o CLI
cd packages/onion-cli
pnpm install

# 4. Link globalmente
pnpm link --global

# 5. Verifique a instalação
onion --version
# Esperado: 4.0.0-beta.1
```

### Método 2: NPM (Futuro - Após Feedback Beta)

```bash
# Disponível após release estável
npm install -g @onion/cli

# Ou com pnpm
pnpm add -g @onion/cli
```

---

## ✅ Verificação da Instalação

### 1. Verificar Versão

```bash
onion --version
```

**Esperado**: `4.0.0-beta.1`

### 2. Verificar Comandos Disponíveis

```bash
onion --help
```

**Esperado**:
```
Usage: onion [options] [command]

Onion CLI - Multi-Context Development Orchestrator

Options:
  -V, --version          output the version number
  -h, --help             display help for command

Commands:
  init [options]         Initialize new Onion project
  add [options]          Add context or IDE to existing project
  migrate [options]      Migrate from Onion v3 to v4
  validate [options]     Validate Onion structure (coming soon)
  help [command]         display help for command
```

### 3. Teste Básico

```bash
# Criar diretório de teste
mkdir test-onion && cd test-onion

# Inicializar projeto
onion init

# Escolher opções no wizard:
# - Project type: Single App
# - Contexts: Business, Technical
# - IDEs: Claude Code
# - Task Manager: ClickUp (ou None)

# Verificar estrutura criada
ls -la .onion/
```

**Esperado**: Estrutura `.onion/` completa criada

---

## 🔧 Configuração de IDEs

### Claude Code (Recomendado)

**Automaticamente configurado após `onion init`**

1. Abra o projeto no Claude Code
2. Comandos disponíveis via chat (e.g., `/business/help`)
3. Agentes disponíveis via `@` (e.g., `@product-agent`)

**Verificar**:
```bash
# Comandos devem estar em:
ls .claude/commands/business/
ls .claude/commands/technical/

# Agentes devem estar em:
ls .claude/agents/
```

### Windsurf / Claude Code (Futuro - FASE 5)

Suporte planejado para próximo release beta.

---

## 🔄 Migração de Projeto v3

Se você já tem um projeto Onion v3:

```bash
# 1. Navegue até o projeto v3
cd seu-projeto-v3

# 2. Certifique-se de ter backup (opcional, mas recomendado)
git commit -am "backup before migration"

# 3. Execute migração
onion migrate

# 4. Revise o plano apresentado
# (O sistema mostra o que será migrado)

# 5. Confirme a migração
# (Digite 'y' quando solicitado)

# 6. Aguarde conclusão
# (Backup automático criado em .claude-backup/)

# 7. Verifique a migração
ls .onion/contexts/
cat docs/onion/MIGRATION-REPORT.md
```

---

## 🛠️ Configuração de Integrações (Opcional)

### ClickUp Integration

Se escolheu ClickUp no wizard:

1. **Obter API Token**:
   - Acesse: https://app.clickup.com/settings/apps
   - Gere um token pessoal

2. **Configurar no projeto**:
   ```bash
   # Crie arquivo .env na raiz
   echo "CLICKUP_API_TOKEN=seu_token_aqui" > .env
   ```

3. **Verificar**:
   ```bash
   # Comandos que usam ClickUp devem funcionar
   /business/task "criar nova feature"
   ```

### Whisper (Transcrição de Áudio)

Para habilitar transcrição de reuniões:

1. **Whisper Local** (sem API key):
   ```bash
   # Instalar whisper.cpp ou similar
   # Configurar no .onion-config.yml
   ```

2. **Whisper Cloud** (OpenAI):
   ```bash
   # Adicionar ao .env
   echo "OPENAI_API_KEY=seu_key_aqui" >> .env
   ```

---

## 📝 Primeiros Passos Após Instalação

### Para Novo Projeto

```bash
# 1. Criar e inicializar
mkdir meu-projeto && cd meu-projeto
onion init

# 2. Abrir no Claude Code
claude .

# 3. Explorar comandos
/business/help
/technical/help

# 4. Criar primeira spec
/business/spec "Sistema de autenticação"

# 5. Iniciar desenvolvimento
/technical/work
```

### Para Projeto Migrado (v3→v4)

```bash
# 1. Após migração bem-sucedida
# 2. Abrir no Claude Code
claude .

# 3. Testar comandos antigos (via symlinks)
/engineer/work

# 4. Explorar nova estrutura
/technical/work

# 5. Verificar novos helps
/business/help
/technical/help
```

---

## ❓ Troubleshooting

### Problema: `onion: command not found`

**Solução 1**: Link não funcionou
```bash
cd packages/onion-cli
pnpm link --global

# Ou adicionar ao PATH manualmente
export PATH="$PATH:$(pwd)/bin"
```

**Solução 2**: Shell não recarregou
```bash
# Recarregar shell
source ~/.bashrc  # ou ~/.zshrc
```

### Problema: `Cannot find module 'inquirer'`

**Solução**: Dependências não instaladas
```bash
cd packages/onion-cli
pnpm install
```

### Problema: `Error: EACCES: permission denied`

**Solução**: Permissões incorretas
```bash
# Usar sudo (não recomendado)
sudo pnpm link --global

# OU configurar npm prefix (recomendado)
npm config set prefix ~/.npm-global
export PATH=~/.npm-global/bin:$PATH
```

### Problema: Comandos não aparecem no Claude Code

**Solução**: `.claude/` não foi criado
```bash
# Verificar se existe
ls -la .claude/

# Se não existe, reexecutar init
onion init

# Ou criar manualmente
mkdir -p .claude/commands
mkdir -p .claude/agents
```

### Problema: Migração falhou no meio

**Solução**: Restaurar backup
```bash
# Backup automático está em .claude-backup/
rm -rf .claude/
mv .claude-backup/ .claude/

# Tentar novamente com --debug
onion migrate --debug
```

---

## 🆘 Suporte

### Reportar Problemas

Se encontrar problemas durante instalação:

1. **GitHub Issues**: https://github.com/your-org/onion-v4/issues
2. **Incluir**:
   - Sistema operacional
   - Versão do Node.js
   - Comando executado
   - Erro completo
   - Logs (se houver)

### Obter Ajuda

- **Discord**: (coming soon)
- **GitHub Discussions**: (coming soon)
- **Email**: suporte@onion-system.dev (coming soon)

---

## 🔄 Atualização

### Atualizar Beta

```bash
# 1. Ir para diretório do onion-v4
cd path/to/onion-v4

# 2. Pull latest changes
git pull origin main

# 3. Reinstalar
cd packages/onion-cli
pnpm install
pnpm link --global

# 4. Verificar nova versão
onion --version
```

### Desinstalar

```bash
# 1. Unlink global
pnpm unlink --global @onion/cli

# 2. Remover diretório (opcional)
rm -rf path/to/onion-v4
```

---

## 📚 Próximos Passos

Após instalação bem-sucedida:

1. ✅ Leia [Release Notes](../onion/RELEASE-NOTES-v4.0-beta.md)
2. ✅ Explore [Level System](../onion/levels-system.md)
3. ✅ Leia [Contributing Guide](../../CONTRIBUTING.md)
4. ✅ Junte-se à comunidade (links em breve)
5. ✅ Dê feedback sobre beta!

---

## 🎉 Parabéns!

Você instalou com sucesso o **Onion v4.0 Beta**! 🧅🚀

Agora você tem acesso a:
- ✅ CLI poderoso (`init`, `add`, `migrate`)
- ✅ Multi-context architecture
- ✅ Sistema de níveis com descoberta progressiva
- ✅ 91 comandos e agentes migrados
- ✅ Backward compatibility com v3

**Compartilhe seu feedback** para ajudar a melhorar o Onion!

---

**Última atualização**: 2025-12-20  
**Versão**: 1.0.0  
**Status**: Beta Release

