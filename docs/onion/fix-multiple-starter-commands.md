# 🎯 Correção - Múltiplos Comandos Starter

## ❌ Problema Identificado

O wizard estava criando **apenas o comando `help.md`** para cada contexto, fazendo com que o Cursor reconhecesse poucos comandos.

## ✅ Solução Implementada

### Comandos Criados Por Contexto

#### **Business Context** (`/.cursor/commands/business/`)
1. **`help.md`** - Ajuda do contexto
2. **`spec.md`** - Criar especificação de feature
3. **`task.md`** - Criar task no task manager

#### **Technical Context** (`/.cursor/commands/technical/`)
1. **`help.md`** - Ajuda do contexto
2. **`plan.md`** - Planejar implementação técnica
3. **`work.md`** - Iniciar desenvolvimento

#### **Customer Success Context** (`/.cursor/commands/customer-success/`)
1. **`help.md`** - Ajuda do contexto
2. **`guide.md`** - Criar guia para cliente

### Código Implementado

```javascript
async createStarterCommands(context, commandsPath) {
  const starterCommands = {
    business: [
      { name: 'help', ...},
      { name: 'spec', ...},
      { name: 'task', ...}
    ],
    technical: [
      { name: 'help', ...},
      { name: 'plan', ...},
      { name: 'work', ...}
    ],
    'customer-success': [
      { name: 'help', ...},
      { name: 'guide', ...}
    ]
  };
  
  // Gera cada comando com conteúdo completo
  for (const cmd of commands) {
    await fs.writeFile(...);
  }
}
```

## 📊 Resultado Esperado

Após executar `onion init`, o Cursor vai reconhecer:

### Business Context
- ✅ `/business/help`
- ✅ `/business/spec "feature-name"`
- ✅ `/business/task "task-title"`

### Technical Context
- ✅ `/technical/help`
- ✅ `/technical/plan "feature-name"`
- ✅ `/technical/work "feature-name"`

## 🚀 Teste Agora

```bash
cd ~/openspec
rm -rf .cursor .onion .onion-config.yml docs/
onion init
# Seguir wizard: Monorepo → business,technical → Cursor → None,None

# Verificar comandos criados
ls -la .cursor/commands/business/
ls -la .cursor/commands/technical/

# Testar no Cursor
/business/help
/business/spec "minha-feature"
/technical/plan "minha-feature"
```

---

**Status**: ✅ CORRIGIDO  
**Próximo**: Testar no Cursor IDE 🎉

