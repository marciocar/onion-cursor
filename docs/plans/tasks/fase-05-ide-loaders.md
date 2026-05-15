# 🎯 FASE 5: IDE Loaders e Compatibilidade - Planejamento

> **Story Points**: 8 SP | **Status**: 📋 Pronta para Iniciar | **Estimativa**: 1 semana

---

## 📋 Contexto

Com 71% do epic Onion v4 completo (39.5 SP de 55.5 SP), a próxima fase crítica é **IDE Loaders**, permitindo que o sistema funcione nativamente em múltiplos IDEs além do Claude Code.

### Estado Atual (Pós-FASE 4)

✅ **Infraestrutura Pronta**:
- Estrutura `.onion/` universal agnóstica de IDE
- CLI robusto com `init`, `add`, `migrate`
- Core modules reutilizáveis
- 91 arquivos migrados e classificados
- Sistema de níveis com descoberta progressiva

⚠️ **Limitação Atual**:
- **Apenas Claude Code suportado**
- Loaders de outros IDEs ainda não implementados
- `.onion/ide/` directory estruturado mas vazio

---

## 🎯 Objetivo da FASE 5

Implementar **loaders específicos** para 3 IDEs principais, permitindo que cada um descubra e utilize recursos do sistema Onion de forma nativa.

### Estratégia Multi-IDE

```
.onion/ide/
├── claude/
│   ├── onion-loader.js       # ✅ A implementar
│   ├── CLAUDE.md          # ✅ A gerar
│   └── README.md             # ✅ Documentação
│
├── windsurf/
│   ├── onion-bridge.ts       # ✅ A implementar
│   ├── windsurf.config.yml   # ✅ A gerar
│   └── README.md             # ✅ Documentação
│
├── claude/
│   ├── onion-adapter.py      # ✅ A implementar
│   ├── claude.config.json    # ✅ A gerar
│   └── README.md             # ✅ Documentação
│
└── universal/
    ├── AGENTS.md             # ✅ Fallback universal
    └── README.md             # ✅ Documentação
```

---

## 📊 Decomposição em Subfases

### SUBFASE 1: Claude Code Loader (2.5 SP)
**Duração**: 2 dias  
**Prioridade**: Alta (IDE atual)

**Entregáveis**:
- [ ] `onion-loader.js` - Script que descobre recursos
- [ ] Geração automática de `CLAUDE.md` atualizado
- [ ] Symlinks dinâmicos de `.onion/` → `.claude/`
- [ ] Detecção de comandos e agentes em tempo real
- [ ] Testes de integração no Claude Code

**Resultado Esperado**: Claude Code descobre comandos/agentes automaticamente da estrutura `.onion/`

---

### SUBFASE 2: Windsurf Loader (2.5 SP)
**Duração**: 2 dias  
**Prioridade**: Média (IDE emergente)

**Entregáveis**:
- [ ] `onion-bridge.ts` - Bridge TypeScript para Windsurf
- [ ] `windsurf.config.yml` - Config específica
- [ ] Adapter para API do Windsurf (se disponível)
- [ ] Documentação de instalação
- [ ] Testes manuais (se Windsurf disponível)

**Resultado Esperado**: Windsurf reconhece comandos Onion via config

**Nota**: Pode requerer pesquisa sobre API do Windsurf

---

### SUBFASE 3: Claude Code Loader (2.0 SP)
**Duração**: 1.5 dias  
**Prioridade**: Média (Anthropic native)

**Entregáveis**:
- [ ] `onion-adapter.py` - Adapter Python para Claude
- [ ] `claude.config.json` - Config específica
- [ ] Integração com Projects API (se disponível)
- [ ] Documentação de instalação
- [ ] Testes manuais

**Resultado Esperado**: Claude Code pode invocar comandos Onion

**Nota**: Pode usar MCP (Model Context Protocol)

---

### SUBFASE 4: Documentação e Testes (1.0 SP)
**Duração**: 1 dia  
**Prioridade**: Alta (qualidade)

**Entregáveis**:
- [ ] `docs/onion/ide-integration-complete.md` (completo)
- [ ] Guia de instalação por IDE
- [ ] Troubleshooting comum
- [ ] Testes de integração automatizados
- [ ] Vídeos/demos de cada IDE (opcional)

**Resultado Esperado**: Documentação completa e testes automatizados

---

## 🏗️ Arquitetura Proposta

### Loader Interface (Padrão)

```typescript
interface OnionLoader {
  /**
   * Descobre recursos Onion no projeto
   */
  discover(): Promise<OnionResources>;
  
  /**
   * Carrega comandos para o IDE
   */
  loadCommands(context: string): Promise<Command[]>;
  
  /**
   * Carrega agentes para o IDE
   */
  loadAgents(context: string): Promise<Agent[]>;
  
  /**
   * Carrega knowledge bases
   */
  loadKnowledgeBases(): Promise<KnowledgeBase[]>;
  
  /**
   * Atualiza IDE quando recursos mudam
   */
  watch(): void;
}

interface OnionResources {
  config: OnionConfig;
  contexts: Context[];
  commands: Command[];
  agents: Agent[];
  knowbase: KnowledgeBase[];
}
```

### Claude Code Loader (JavaScript)

```javascript
// .onion/ide/claude-code/onion-loader.js
const fs = require('fs');
const path = require('path');
const yaml = require('yaml');

class ClaudeCodeOnionLoader {
  constructor(projectRoot) {
    this.projectRoot = projectRoot;
    this.onionRoot = path.join(projectRoot, '.onion');
    this.claudeRoot = path.join(projectRoot, '.claude');
  }
  
  async discover() {
    const config = this.loadConfig();
    const contexts = this.discoverContexts();
    const commands = await this.discoverCommands(contexts);
    const agents = await this.discoverAgents(contexts);
    
    return { config, contexts, commands, agents };
  }
  
  async syncToClaudeCode() {
    // Criar/atualizar symlinks de .onion/ → .claude/
    // Atualizar CLAUDE.md com contextos disponíveis
    // Gerar index de comandos
  }
  
  watch() {
    // Watch .onion/ for changes
    fs.watch(this.onionRoot, { recursive: true }, () => {
      this.syncToClaudeCode();
    });
  }
}

module.exports = ClaudeCodeOnionLoader;
```

### Windsurf Bridge (TypeScript)

```typescript
// .onion/ide/windsurf/onion-bridge.ts
import * as fs from 'fs';
import * as path from 'path';
import * as yaml from 'yaml';

export class WindsurfOnionBridge {
  private projectRoot: string;
  private onionRoot: string;
  
  constructor(projectRoot: string) {
    this.projectRoot = projectRoot;
    this.onionRoot = path.join(projectRoot, '.onion');
  }
  
  async discover(): Promise<OnionResources> {
    // Descobrir recursos Onion
  }
  
  async generateConfig(): Promise<void> {
    // Gerar windsurf.config.yml com comandos e agentes
  }
  
  watch(): void {
    // Watch para mudanças
  }
}
```

### Claude Adapter (Python)

```python
# .onion/ide/claude/onion-adapter.py
import os
import json
import yaml
from pathlib import Path

class ClaudeOnionAdapter:
    def __init__(self, project_root: str):
        self.project_root = Path(project_root)
        self.onion_root = self.project_root / '.onion'
    
    def discover(self) -> dict:
        """Descobre recursos Onion"""
        pass
    
    def generate_config(self) -> None:
        """Gera claude.config.json"""
        pass
    
    def watch(self) -> None:
        """Watch para mudanças"""
        pass
```

---

## 🔧 Integração com CLI

### Atualizar `onion init`

```javascript
// Ao inicializar, gerar loaders para IDEs selecionados
const selectedIDEs = answers.ides; // ['claude-code', 'windsurf']

for (const ide of selectedIDEs) {
  await generateIDELoader(projectRoot, ide, {
    contexts: answers.contexts
  });
}
```

### Atualizar `onion add`

```javascript
// Ao adicionar IDE, gerar loader
if (type === 'ide') {
  await generateIDELoader(projectRoot, ideName, {
    contexts: currentContexts
  });
}
```

---

## 🧪 Testes Necessários

### Teste de Integração: Claude Code

```javascript
describe('Claude Code Loader Integration', () => {
  it('should discover all commands', async () => {
    const loader = new ClaudeCodeOnionLoader(projectRoot);
    const resources = await loader.discover();
    
    expect(resources.commands.length).toBeGreaterThan(0);
  });
  
  it('should sync to .claude/', async () => {
    await loader.syncToClaudeCode();
    
    // Verificar symlinks criados
    expect(fs.existsSync('.claude/commands/business')).toBe(true);
  });
});
```

### Teste Manual: Windsurf/Claude

1. Instalar loader no projeto
2. Abrir projeto no IDE
3. Verificar se comandos aparecem
4. Testar execução de comando
5. Verificar agentes disponíveis

---

## 📚 Documentação a Criar

### 1. `docs/onion/ide-integration-complete.md`

Estrutura:
```markdown
# IDE Integration Guide

## Supported IDEs
- Claude Code
- Windsurf
- Claude Code

## Installation

### Claude Code
```bash
onion init
# Escolher "Claude Code"
```

### Windsurf
(instruções...)

### Claude Code
(instruções...)

## Troubleshooting
...
```

### 2. READMEs por IDE

- `.onion/ide/claude-code/README.md`
- `.onion/ide/windsurf/README.md`
- `.onion/ide/claude/README.md`

---

## 🎯 Critérios de Aceitação

### SUBFASE 1: Claude Code Loader
- [ ] Loader descobre comandos automaticamente
- [ ] Loader descobre agentes automaticamente
- [ ] Symlinks criados corretamente
- [ ] `CLAUDE.md` atualizado
- [ ] Testes de integração passando
- [ ] Documentação completa

### SUBFASE 2: Windsurf Loader
- [ ] Bridge TypeScript implementado
- [ ] Config gerado corretamente
- [ ] Comandos acessíveis no Windsurf
- [ ] Documentação de instalação
- [ ] Testes manuais documentados

### SUBFASE 3: Claude Loader
- [ ] Adapter Python implementado
- [ ] Config JSON gerado
- [ ] Integração com MCP (se aplicável)
- [ ] Documentação de instalação
- [ ] Testes manuais documentados

### SUBFASE 4: Documentação
- [ ] Guide completo criado
- [ ] READMEs por IDE
- [ ] Troubleshooting documentado
- [ ] Testes automatizados criados

---

## 🚨 Riscos e Mitigações

### Risco 1: APIs de IDEs Não Disponíveis
**Probabilidade**: Média  
**Impacto**: Alto  
**Mitigação**:
- Usar fallback `AGENTS.md` universal
- Documentar limitações conhecidas
- Propor RFC para IDEs

### Risco 2: IDEs Não Suportam Loaders Dinâmicos
**Probabilidade**: Alta  
**Impacto**: Médio  
**Mitigação**:
- Gerar configs estáticos
- Usar symlinks para Claude Code
- Criar scripts de setup manual

### Risco 3: Manutenção de 3+ IDEs
**Probabilidade**: Média  
**Impacto**: Médio  
**Mitigação**:
- Interface comum `OnionLoader`
- Testes automatizados
- Comunidade mantém loaders

---

## 🎓 Dependências Técnicas

### Para Claude Code Loader
- Node.js >= 16
- `fs`, `path`, `yaml` (built-in)
- Acesso ao filesystem

### Para Windsurf Loader
- TypeScript >= 4.5
- `@types/node`
- Windsurf SDK (pesquisar)

### Para Claude Loader
- Python >= 3.8
- `pyyaml`
- Anthropic SDK (pesquisar)

---

## 📅 Timeline Sugerido

```
Dia 1-2: SUBFASE 1 - Claude Code Loader
  - Implementar loader
  - Criar testes
  - Integrar com CLI

Dia 3-4: SUBFASE 2 - Windsurf Loader
  - Pesquisar API do Windsurf
  - Implementar bridge
  - Criar config

Dia 5-6: SUBFASE 3 - Claude Loader
  - Pesquisar MCP
  - Implementar adapter
  - Criar config

Dia 7: SUBFASE 4 - Docs e Testes
  - Escrever guia completo
  - Criar testes E2E
  - Validar com usuários
```

**Total**: 7 dias úteis (~1 semana)

---

## 🚀 Próximos Passos

1. ✅ **Validar este plano** com stakeholders
2. 📋 **Criar sessão de desenvolvimento**: `.claude/sessions/fase-05-ide-loaders/`
3. 📋 **Pesquisar APIs**: Windsurf e Claude Code
4. 📋 **Iniciar SUBFASE 1**: Claude Code Loader
5. 📋 **Testes contínuos** durante implementação

---

**Criado**: 2025-12-20  
**Autor**: Sistema Onion  
**Versão**: 1.0.0  
**Status**: 📋 Pronto para Execução

