# 🧅 Contexto da Sessão: Upgrade Node.js 22.12.0

## 📋 Informações da Sessão
- **Task ID**: node-upgrade-system
- **Funcionalidade**: Upgrade do Node.js para versão 22.12.0+
- **Iniciado em**: 2025-01-28
- **Status**: 🔄 Em progresso

## 🎯 Objetivo
Fazer upgrade do Sistema Onion e ambiente Ubuntu WSL2 para usar Node.js 22.12.0 ou superior, necessário para suporte ao `chrome-devtools-mcp`.

## 📊 Estado Atual
### 🔧 Ambiente
- **SO**: Ubuntu 24.04.2 LTS (noble) - WSL2
- **Node.js**: v20.18.3 (ativo)
- **NPM**: v11.5.1
- **NVM**: v0.39.4

### 📦 Versões Disponíveis (NVM)
- v20.11.1 ✅ Instalada
- v20.18.3 ✅ Instalada (atual)
- v22.0.0 ✅ Instalada
- **v22.14.0** ✅ Instalada (LTS - Target!)
- v23.3.0 ✅ Instalada

## 🎯 Target
- **Versão necessária**: Node.js ≥ 22.12.0
- **Versão disponível**: v22.14.0 (LTS/jod) ✅ Já instalada!
- **Ação**: Switch + validação de compatibilidade

## 🚨 Motivação
```bash
ERROR: `chrome-devtools-mcp` does not support Node v20.18.3. 
Please upgrade to Node 22.12.0 or newer.
```

## 📝 Notas Técnicas
- Sistema Onion é framework de comandos `.cursor/`
- Projeto não possui package.json próprio (é tooling/documentação)
- Upgrade deve ser no sistema/ambiente, não no projeto específico
- Compatibilidade deve ser verificada com comandos existentes
