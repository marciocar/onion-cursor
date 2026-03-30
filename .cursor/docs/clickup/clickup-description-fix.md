# 🔧 Correção: Formatação de Descrições no ClickUp

## 🚨 Problema Identificado

Os comandos que criam tasks no ClickUp estão enviando descrições em **markdown puro**, mas o ClickUp **não renderiza markdown** nas descrições quando enviado via parâmetro `description`.

### Exemplo do Problema:
```markdown
## 🎯 Objetivo
Criar script para matar portas do Linux

## 📋 Escopo
### ✅ Funcionalidades:
- Feature A
```

**Resultado no ClickUp:** Texto cru com `##`, `###`, `-` visíveis (não formatado)

---

## ✅ Solução Correta

### Use `markdown_description` em vez de `description`

O ClickUp MCP suporta dois parâmetros diferentes:

| Parâmetro | Formato | Renderização |
|-----------|---------|--------------|
| `description` | Plain text | Texto puro sem formatação |
| `markdown_description` | Markdown nativo | **Renderiza markdown corretamente** ✅ |

---

## 📋 Template Correto para Task Descriptions

### Estrutura Recomendada:

```markdown
## 🎯 Objetivo da Task

[DESCRIÇÃO_DETALHADA_DO_OBJETIVO]

---

## 📋 Escopo de Implementação

### ✅ Funcionalidades:
- Feature A - [DESCRIÇÃO]
- Feature B - [DESCRIÇÃO]
- Feature C - [DESCRIÇÃO]

### 🔧 Arquitetura Técnica:
- Componente X modificado
- Integration Y implementada
- Service Z criado

### 📊 Métricas Esperadas:

| Metric | Before | After | Target |
|--------|--------|-------|--------|
| Performance | [VALOR] | [VALOR] | ✅ |
| Coverage | [VALOR] | [VALOR] | ✅ |
| Quality | [VALOR] | [VALOR] | ✅ |

---

## ✅ Critérios de Aceitação

- [ ] Funcionalidade A implementada e testada
- [ ] Testes passando com cobertura > 95%
- [ ] Documentação técnica atualizada
- [ ] Performance dentro do target estabelecido
- [ ] Code review aprovado

---

## 🔧 Componentes Afetados

- **Backend**: [COMPONENTES]
- **Frontend**: [COMPONENTES]
- **Database**: [SCHEMAS]
- **APIs**: [ENDPOINTS]

---

## 📚 Bibliotecas e Dependências

### Principais:
- [BIBLIOTECA_1] v[VERSION] - [PROPÓSITO]
- [BIBLIOTECA_2] v[VERSION] - [PROPÓSITO]

### Secundárias:
- [BIBLIOTECA_3] v[VERSION] - [PROPÓSITO]

---

## 🧪 Estratégia de Testes

### Unit Tests:
- [ ] [COMPONENTE_1] - [CENÁRIOS]
- [ ] [COMPONENTE_2] - [CENÁRIOS]

### Integration Tests:
- [ ] [FLUXO_1] - [CENÁRIOS]
- [ ] [FLUXO_2] - [CENÁRIOS]

### E2E Tests:
- [ ] [USER_FLOW_1]
- [ ] [USER_FLOW_2]

---

**🎯 Success Metric**: [MÉTRICA_PRINCIPAL]  
**🕒 Timeline**: [PRAZO_ESTIMADO]  
**👥 Stakeholders**: [STAKEHOLDERS]
```

---

## 🔧 Implementação Correta no Código

### ❌ ERRADO (não formata):
```typescript
await mcp_clickup_create_task({
  name: "Implementar autenticação JWT",
  listId: "<list_id>",
  description: `## 🎯 Objetivo
Implementar sistema de autenticação

## 📋 Funcionalidades
- Login com JWT
- Refresh tokens`
})
```

### ✅ CORRETO (formata markdown):
```typescript
await mcp_clickup_create_task({
  name: "Implementar autenticação JWT",
  listId: "<list_id>",
  markdown_description: `## 🎯 Objetivo da Task

Implementar sistema completo de autenticação usando JWT (JSON Web Tokens) com suporte a refresh tokens para renovação automática de sessões.

---

## 📋 Escopo de Implementação

### ✅ Funcionalidades:
- Login com JWT - Autenticação via email/senha
- Refresh tokens - Renovação automática de sessão
- Logout seguro - Invalidação de tokens
- Proteção de rotas - Middleware de autenticação

### 🔧 Arquitetura Técnica:
- Auth Service implementado
- JWT middleware criado
- Token storage configurado
- Security headers aplicados

### 📊 Métricas Esperadas:

| Metric | Before | After | Target |
|--------|--------|-------|--------|
| Login time | N/A | <500ms | ✅ |
| Token refresh | N/A | <200ms | ✅ |
| Security score | 6/10 | 9/10 | ✅ |

---

## ✅ Critérios de Aceitação

- [ ] Usuário consegue fazer login com email/senha
- [ ] JWT é gerado e retornado após login bem-sucedido
- [ ] Refresh token permite renovação de sessão
- [ ] Rotas protegidas bloqueiam acesso não autenticado
- [ ] Logout invalida tokens corretamente
- [ ] Testes de segurança passando
- [ ] Documentação de API atualizada

---

## 🔧 Componentes Afetados

- **Backend**: AuthService, AuthController, JWTMiddleware
- **Database**: Users table, Tokens table
- **APIs**: POST /auth/login, POST /auth/refresh, POST /auth/logout
- **Frontend**: AuthContext, LoginPage, ProtectedRoute

---

## 📚 Bibliotecas e Dependências

### Principais:
- jsonwebtoken v9.0.0 - Geração e validação de JWT
- bcrypt v5.1.0 - Hash de senhas

### Secundárias:
- express-rate-limit v6.0.0 - Proteção contra brute force
- helmet v7.0.0 - Security headers

---

## 🧪 Estratégia de Testes

### Unit Tests:
- [ ] AuthService - login, refresh, logout
- [ ] JWTMiddleware - validação de tokens

### Integration Tests:
- [ ] Fluxo completo de autenticação
- [ ] Renovação de tokens
- [ ] Proteção de rotas

### E2E Tests:
- [ ] Login → Acesso a rota protegida → Logout
- [ ] Login → Refresh automático → Acesso contínuo

---

**🎯 Success Metric**: 100% das rotas protegidas funcionando  
**🕒 Timeline**: 5-7 dias úteis  
**👥 Stakeholders**: Tech Lead, Product Owner, Security Team`
})
```

---

## 📝 Comandos que Precisam de Correção

### 1. `/product/task`
**Arquivo**: `.cursor/commands/product/task.md`

**Mudança necessária:**
```diff
- description: "[DETAILED DESCRIPTION]",
+ markdown_description: `[TEMPLATE_MARKDOWN_COMPLETO]`,
```

### 2. `/product/feature`
**Arquivo**: `.cursor/commands/product/feature.md`

**Mudança necessária:**
```diff
- description: "[FEATURE DESCRIPTION]",
+ markdown_description: `[TEMPLATE_MARKDOWN_COMPLETO]`,
```

### 3. Qualquer comando que crie tasks
**Padrão geral:**
- Sempre use `markdown_description` para descriptions
- Sempre use `commentText` (com formatação Unicode) para comments

---

## 🎨 Diferença entre Description e Comments

### 📋 DESCRIPTIONS (markdown_description)
**Quando usar:** Criar ou atualizar a descrição principal da task

**Formato:** Markdown nativo tradicional
```markdown
## Headers
### Subheaders
- Listas
| Tabelas |
**Bold** *Italic*
```

**Ferramentas:**
- `mcp_clickup_create_task({ markdown_description: "..." })`
- `mcp_clickup_update_task({ markdown_description: "..." })`

---

### 💬 COMMENTS (commentText)
**Quando usar:** Adicionar atividades/comentários na task

**Formato:** Formatação visual Unicode
```
━━━━━━━━━━━━━━━━━━━━━━━━
✅ COMPLETED:
   ∟ Item 1
   ∟ Item 2

🔄 IN PROGRESS:
   ▶ Item 3
━━━━━━━━━━━━━━━━━━━━━━━━
⏰ Updated: [TIMESTAMP]
```

**Ferramentas:**
- `mcp_clickup_create_task_comment({ commentText: "..." })`

---

## ✅ Checklist de Implementação

Para cada comando que cria tasks no ClickUp:

- [ ] Trocar `description` por `markdown_description`
- [ ] Usar template markdown estruturado
- [ ] Incluir todas as seções relevantes
- [ ] Testar renderização no ClickUp
- [ ] Validar que markdown está formatando corretamente
- [ ] Documentar template no comando
- [ ] Adicionar exemplo de uso

---

## 🧪 Como Testar

### 1. Criar task de teste:
```bash
/product/task "Teste de formatação markdown"
```

### 2. Verificar no ClickUp:
- Abrir task criada
- Verificar se headers estão formatados
- Verificar se tabelas estão renderizadas
- Verificar se listas estão indentadas
- Verificar se checkboxes funcionam

### 3. Se não estiver formatado:
- ❌ Está usando `description` (errado)
- ✅ Deve usar `markdown_description` (correto)

---

## 📚 Referências

- **Documentação oficial**: `.cursor/docs/clickup/clickup-formatting.md`
- **Estratégia de auto-update**: `.cursor/docs/clickup/clickup-auto-update-strategy.md`
- **Formatter de comments**: `.cursor/docs/clickup/clickup-comment-formatter.md`

---

## 🎯 Resultado Esperado

Após correção, as descriptions no ClickUp devem aparecer:

✅ **Headers formatados** como títulos  
✅ **Tabelas renderizadas** corretamente  
✅ **Listas com bullets** visíveis  
✅ **Checkboxes interativos** funcionando  
✅ **Bold/italic** aplicados  
✅ **Separadores `---`** como linhas horizontais  

---

**Última atualização**: 2025-11-05  
**Prioridade**: ALTA - Afeta UX no ClickUp  
**Status**: Documentado - Aguardando implementação nos comandos

