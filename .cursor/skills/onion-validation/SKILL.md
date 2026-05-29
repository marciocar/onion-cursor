---
name: onion-validation
description: >
  Regras de validação para componentes do Sistema Onion. Use ao criar, revisar,
  auditar ou debuggar comandos, agentes e skills. Cobre campos YAML obrigatórios,
  categorias válidas, checklists de qualidade, limites de linhas, detecção de
  duplicações e scoring. Ative ao validar artefatos em `.cursor/`, mesmo sem
  o usuário mencionar "validação".
paths: [".cursor/**"]
---

## Validação de Skills (canônico)

### Frontmatter mínimo
| Campo | Constraint |
|-------|------------|
| `name` | kebab-case, igual à pasta |
| `description` | imperativa + "use quando" |
| `disable-model-invocation` | `true` em workflows explícitos |
| `paths` | contextual skills only |

### Checklist
- [ ] `name` = nome da pasta
- [ ] Description com verbo imperativo + contexto de uso
- [ ] < 500 linhas (lifecycle persistente)
- [ ] Conteúdo extenso em `references/`
- [ ] Frontmatter YAML válido

## Validação de Comandos (legado — removido)

`.cursor/commands/` não existe mais. Validar apenas skills.

## Validação de Agentes

### Campos mínimos
- `name` — kebab-case, igual ao arquivo
- `description` — gatilho de uso (quando invocar)

### Checklist de qualidade
- [ ] Nome único em kebab-case
- [ ] Descrição da especialização clara
- [ ] < 1200 linhas recomendado
- [ ] Seção "Identidade" ou "Propósito" presente
- [ ] Escopo e delegação explícitos

## Validações Automatizadas

### Detectar duplicações de nome
```bash
find .cursor/skills -name "SKILL.md" -exec grep -H "^name:" {} \; | \
  awk -F: '{print $3}' | sort | uniq -d

find .cursor/agents -name "*.md" -exec grep -l "^name:" {} \; | \
  xargs grep "^name:" | awk -F: '{print $3}' | sort | uniq -d
```

### Verificar limites de linhas
```bash
# Skills > 500 linhas
find .cursor/skills -name "SKILL.md" -exec wc -l {} \; | awk '$1 > 500'

# Agentes > 300 linhas
find .cursor/agents -name "*.md" -exec wc -l {} \; | awk '$1 > 300'
```

### Verificar name = pasta (skills)
```bash
for d in .cursor/skills/*/; do
  skill=$(basename "$d")
  name=$(grep '^name:' "$d/SKILL.md" 2>/dev/null | head -1 | awk '{print $2}')
  [ "$name" != "$skill" ] && echo "MISMATCH: $skill -> $name"
done
```

### Detectar agentes fantasmas referenciados
```bash
grep -rho "@[a-z-]\+" .cursor/skills docs/ | sort -u | while read ref; do
  name="${ref#@}"
  find .cursor/agents -name "${name}.md" -q || echo "FANTASMA: $ref"
done
```

## Score de Qualidade (0-100)

### Comando
| Critério | Pontos |
|----------|--------|
| YAML header completo | +20 |
| Categoria válida | +20 |
| Tags apropriadas (3-7) | +15 |
| < 400 linhas | +15 |
| Seções obrigatórias | +15 |
| Documentação clara | +15 |

### Agente
| Critério | Pontos |
|----------|--------|
| YAML header completo | +20 |
| Categoria válida | +20 |
| Expertise definida (3-5) | +15 |
| < 300 linhas | +15 |
| Seções obrigatórias | +15 |
| Especialização clara | +15 |

### Thresholds
- **80-100**: ✅ Aprovado
- **60-79**: ⚠️ Precisa melhorias
- **< 60**: ❌ Rejeitado

## Regras de Negócio para Geradores

### Antes de criar comando
1. Verificar se nome já existe em `.cursor/skills/`
2. Validar categoria está na lista permitida
3. Confirmar campos obrigatórios presentes
4. Verificar limite de 400 linhas

### Antes de criar agente
1. Verificar se nome já existe em `.cursor/agents/`
2. Validar categoria está na lista permitida
3. Confirmar expertise tem 3-5 itens
4. Verificar limite de 300 linhas

### Antes de criar skill
1. Verificar se pasta já existe em `.cursor/skills/`
2. Confirmar description com "use quando" para auto-trigger
3. Verificar limite de 500 linhas
4. Validar `paths` glob se especificado

## Fallback para falhas de validação

```
Se validação falhar:
1. Informar usuário sobre o problema específico
2. Sugerir correção concreta (não genérica)
3. Perguntar se deseja correção automática
4. Se não, abortar com mensagem clara do que precisa ser corrigido
```

## Integração com .env

### Variáveis críticas
- `TASK_MANAGER_PROVIDER` — obrigatório (`clickup`|`jira`|`asana`|`linear`|`none`)
- Variáveis específicas do provider (ex: `JIRA_HOST`, `JIRA_API_TOKEN`)

### Verificação de configuração
```bash
if [ -z "$TASK_MANAGER_PROVIDER" ]; then
  echo "⚠️ TASK_MANAGER_PROVIDER não configurado"
  echo "Execute /meta:setup-integration"
fi
```

## Referências

- Agente: `@metaspec-gate-keeper` (executa essas validações)
- Skill relacionada: `onion-patterns` (estrutura e nomenclatura)
- Skill relacionada: `language-standards` (idioma)
