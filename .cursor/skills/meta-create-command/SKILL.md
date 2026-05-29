---
name: meta-create-command
description: Descrição do que o comando faz
disable-model-invocation: true
---
# 📝 Criar Comando Claude Code

Facilitador para criação de comandos seguindo padrões Onion v3.0.

## 🎯 Objetivo

Criar comandos que se integram ao ecossistema existente.

## ⚡ Fluxo de Execução

### Passo 1: Análise de Contexto

```bash
# Listar comandos existentes
ls .cursor/commands/*/*.md | wc -l

# Verificar categoria existe
ls .cursor/commands/{{category}}/ 2>/dev/null

# Verificar duplicação
grep -l "name: {{command_name}}" .cursor/commands/**/*.md
```

### Passo 2: Determinar Categoria

SE `{{category}}` fornecido → usar diretamente
SENÃO → inferir do propósito:

| Propósito | Categoria |
|-----------|-----------|
| Desenvolvimento, código | `engineer` |
| Tasks, specs, features | `product` |
| Git, branches, PRs | `git` |
| Documentação | `docs` |
| Comandos, agentes | `meta` |
| Validações | `validate` |

### Passo 3: Gerar Estrutura

Usar template de `references/command-template.md`:

```yaml
---
name: {{command_name}}
description: |
  [Descrição em 2 linhas]
  Use para [caso de uso principal].
model: sonnet

parameters:
  - name: param1
    description: [descrição]
    required: [true/false]

category: {{category}}
tags:
  - [tag1]
  - [tag2]

version: "3.0.0"
updated: "[data atual]"

related_commands:
  - /category/comando

related_agents:
  - agente-relacionado
---

# [Título do Comando]

[Descrição breve]

## 🎯 Objetivo

[O que este comando faz]

## ⚡ Fluxo de Execução

### Passo 1: [Nome]
[Instruções]

### Passo 2: [Nome]
[Instruções]

## 📤 Output Esperado

[Formato de saída]

## 🔗 Referências

- [Referências relevantes]

## ⚠️ Notas

- [Notas importantes]
```

### Passo 4: Validações Obrigatórias

**CRÍTICO**: Executar TODAS as validações antes de criar:

```bash
# 1. DUPLICAÇÃO - Verificar nome único
if grep -r "^name: {{command_name}}$" .cursor/commands/ 2>/dev/null; then
  echo "❌ ERRO: Comando '{{command_name}}' já existe!"
  exit 1
fi

# 2. FORMATO - Verificar kebab-case
if [[ ! "{{command_name}}" =~ ^[a-z][a-z0-9]*(-[a-z0-9]+)*$ ]]; then
  echo "❌ ERRO: Nome deve ser kebab-case (ex: my-command)"
  exit 1
fi

# 3. CATEGORIA - Verificar categoria válida
VALID_CATEGORIES="engineer product git docs meta validate quick general"
if [[ ! " $VALID_CATEGORIES " =~ " {{category}} " ]]; then
  echo "❌ ERRO: Categoria '{{category}}' inválida!"
  echo "Válidas: $VALID_CATEGORIES"
  exit 1
fi
```

**Checklist de Validação:**
- [ ] Nome único (não existe em `.cursor/commands/`)
- [ ] Nome em kebab-case válido
- [ ] Categoria válida (engineer|product|git|docs|meta|validate|quick|general)
- [ ] YAML header completo
- [ ] < 400 linhas
- [ ] Seções obrigatórias (Objetivo, Fluxo, Output)

### Passo 5: Criar Arquivo

```bash
write .cursor/commands/{{category}}/{{command_name}}.md
```

## 📤 Output Esperado

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
✅ COMANDO CRIADO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📁 Arquivo: .cursor/commands/{{category}}/{{command_name}}.md

📋 Detalhes:
∟ Nome: {{command_name}}
∟ Categoria: {{category}}
∟ Linhas: ~150

🚀 Para usar: /{{category}}/{{command_name}}
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

## 🔗 Referências

- Template: `references/command-template.md`
- Agente: @command-creator-specialist

## ⚠️ Notas

- Máximo 400 linhas por comando
- Usar prompts modulares de `common/prompts/`
- Sempre validar duplicação antes de criar
