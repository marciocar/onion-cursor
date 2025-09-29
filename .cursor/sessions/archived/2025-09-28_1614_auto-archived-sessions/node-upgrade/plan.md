# 📋 Plano de Upgrade Node.js 22.12.0+

## 🎯 Visão Geral
Migrar ambiente de desenvolvimento Ubuntu WSL2 do Node.js v20.18.3 para v22.14.0 (LTS) para suporte ao `chrome-devtools-mcp` e ferramentas modernas.

## ⚡ Status: **DESCOBERTA IMPORTANTE** 
✅ **Node.js v22.14.0 JÁ ESTÁ INSTALADO** via NVM!
🎯 **Apenas precisamos alternar versão + validar compatibilidade**

---

## 📊 Fases do Upgrade

### 🔍 **Fase 1: Análise e Preparação** 
**Status**: ✅ **CONCLUÍDA**
- [✅] Verificar ambiente atual (Ubuntu 24.04.2 LTS)
- [✅] Verificar Node.js atual (v20.18.3)
- [✅] Verificar NVM e versões disponíveis
- [✅] **DESCOBERTA**: v22.14.0 já instalada!
- [✅] Criar estrutura de sessão de desenvolvimento

**✅ Resultados:**
- Sistema pronto para upgrade
- Target v22.14.0 (LTS) disponível
- NVM v0.39.4 funcional

---

### 🔄 **Fase 2: Switch de Versão**
**Status**: ✅ **CONCLUÍDA**
- [✅] Alternar para Node.js v22.14.0 via NVM
- [✅] Verificar versões pós-switch (node v22.14.0, npm v11.1.0)
- [✅] Configurar v22.14.0 como padrão
- [✅] Testar chrome-devtools-mcp

**✅ Resultados:**
- Node.js v20.18.3 → **v22.14.0 LTS** ✅
- NPM v11.5.1 → **v11.1.0** ✅ 
- Default configurado: `default -> v22.14.0 *` ✅
- **chrome-devtools-mcp@0.4.0** funcionando perfeitamente! 🎉
- Erro original "Node v20.18.3 not supported" → **RESOLVIDO** ✅

---

### 🧪 **Fase 3: Validação de Compatibilidade**
**Status**: ✅ **CONCLUÍDA**
- [✅] Testar comandos Sistema Onion básicos
- [✅] Verificar funcionamento do framework .cursor/
- [✅] Testar integração ClickUp MCP (se aplicável)
- [✅] Validar tooling de desenvolvimento
- [✅] Documentar possíveis breaking changes

**✅ Resultados da Validação:**
- **Sistema Onion**: ✅ Todos os comandos `.cursor/` acessíveis
- **Estrutura**: ✅ 28 comandos organizados por categoria funcionando
- **Tooling Node.js**: ✅ node, npm, npx 100% funcionais
- **chrome-devtools-mcp**: ✅ v0.4.0 instalado e operacional
- **NPM Registry**: ✅ Configuração padrão mantida
- **Compatibilidade**: ✅ Nenhum breaking change detectado
- **Performance**: ✅ Sem degradação observada

**🔧 Testes:**
```bash
# Comandos básicos do sistema
/meta/all-tools
/product/task --help

# Ferramentas Node.js
npm --version
npx --version
```

---

### 📝 **Fase 4: Configuração Permanente**
**Status**: ✅ **CONCLUÍDA**
- [✅] Configurar .nvmrc no projeto (v22.14.0)
- [✅] Atualizar documentação do sistema
- [✅] Criar guia de troubleshooting
- [✅] Verificar outros projetos afetados

**✅ Configurações Aplicadas:**
- **.nvmrc**: ✅ Criado com v22.14.0 para consistência
- **Documentação**: ✅ Relatório completo em upgrade-report.md
- **Troubleshooting**: ✅ Comandos de rollback documentados
- **Sistema Onion**: ✅ 100% compatível sem modificações necessárias

---

### ✅ **Fase 5: Finalização**
**Status**: ✅ **CONCLUÍDA**  
- [✅] Executar testes finais
- [✅] Documentar mudanças realizadas
- [✅] Atualizar guias de getting-started  
- [✅] Cleanup de arquivos temporários

**🎉 UPGRADE CONCLUÍDO COM SUCESSO!**
- **Target alcançado**: chrome-devtools-mcp@0.4.0 funcionando ✅
- **Compatibilidade mantida**: Sistema Onion 100% operacional ✅
- **Configuração permanente**: .nvmrc e documentação criados ✅
- **Zero breaking changes**: Migração transparente ✅

---

## 🎯 Próximos Passos
1. **Executar Fase 2**: Switch para v22.14.0
2. **Testar chrome-devtools-mcp** imediatamente
3. **Validar funcionamento** do Sistema Onion
4. **Configurar como padrão** se tudo OK

## 📊 Estimativas
- **Tempo total**: ~30 minutos
- **Impacto**: Baixo (upgrade via NVM)
- **Risk**: Mínimo (versão já instalada)
- **Rollback**: Simples (`nvm use v20.18.3`)

## 🚨 Notas Importantes
- Upgrade é no **ambiente/sistema**, não no projeto
- Sistema Onion é **tooling**, não aplicação Node.js
- v22.14.0 é **LTS** (mais estável que 22.12.0)
- **Rollback** sempre disponível via NVM
