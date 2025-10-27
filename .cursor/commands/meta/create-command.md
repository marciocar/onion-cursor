# Comando Criar Comando Cursor

Facilita a criação de novos comandos Cursor utilizando o agente especializado @command-creator.

## 📢 Regras de Comunicação (Cursor v2+)

### Comunicação com o Usuário
1. Use markdown com backticks para formatar nomes de arquivos, diretórios, funções e classes
2. Evite emojis a menos que sejam extremamente informativos ou explicitamente solicitados
3. NUNCA mencione nomes de ferramentas - use linguagem natural
4. NUNCA use `echo` ou ferramentas de terminal para comunicar pensamentos ao usuário
5. Toda comunicação deve estar diretamente na resposta de texto

### Execução de Ferramentas
1. Não se refira a nomes de ferramentas ao falar com o usuário
2. Implemente mudanças ao invés de apenas sugerir (padrão)
3. Maximize chamadas paralelas quando não há dependências
4. Use ferramentas especializadas ao invés de comandos de terminal
5. Para arquivos grandes, use busca semântica ou grep ao invés de ler tudo

## Requisitos do Usuário
<requirements>
#$ARGUMENTS
</requirements>

## Processo

### 1. Invocar o Agente Command Creator
Este comando serve como wrapper/facilitador para invocar o agente @command-creator com os requisitos do usuário.

**Invocação**:
```
@command-creator "[descrição do comando desejado]"
```

### 2. Fluxo Automático do Agente
O agente @command-creator executará automaticamente:

1. **Análise de Requisitos**
   - Entenderá o que o comando deve fazer
   - Identificará tipo (simples ou complexo)
   - Determinará contexto necessário

2. **Exploração do Projeto**
   - Analisará comandos existentes similares
   - Verificará padrões do projeto
   - Identificará convenções a seguir

3. **Definição da Estrutura**
   - Nome em kebab-case
   - Categoria apropriada (meta, development, data, etc.)
   - Seções necessárias

4. **Criação do Arquivo**
   - Gerará arquivo `.md` completo
   - Localizará em `.cursor/commands/[categoria]/[nome].md`
   - Aplicará formatação consistente

5. **Validação e Confirmação**
   - Confirmará criação com resumo
   - Indicará localização do arquivo
   - Sugerirá próximos passos

## Estrutura de Comando Cursor (Padrão Oficial v2+)

Todo comando Cursor segue este padrão:

```markdown
# [Título do Comando]

[Breve descrição do propósito]

## Requisitos do Usuário
<requirements>
#$ARGUMENTS
</requirements>

## Processo

### 1. [Primeira Etapa]
[Instruções detalhadas]

### 2. [Segunda Etapa]
[Instruções detalhadas]

...

## Guidelines

### ✅ Boas Práticas
- [Boa prática 1]
- [Boa prática 2]

### ⚠️ Atenções Especiais
- [Atenção 1]
- [Atenção 2]

### ❌ O Que Evitar
- [Antipattern 1]
- [Antipattern 2]

## Exemplos

### Exemplo 1: [Cenário]
[Exemplo prático]

### Exemplo 2: [Cenário]
[Exemplo prático]

## Checklist de Validação
- [ ] [Critério 1]
- [ ] [Critério 2]
```

**IMPORTANTE (Cursor v2+):**
- Comandos são arquivos `.md` simples (SEM YAML frontmatter)
- Use `#$ARGUMENTS` dentro de `<requirements>` para capturar input
- Executados no chat com `/categoria/comando`
- Interpretados pela Cursor AI com contexto completo

## Categorias Disponíveis

Escolha a categoria apropriada para o novo comando:

**`meta/`** - Comandos sobre o próprio sistema Cursor
- Criar agentes, comandos, configurações
- Exemplos: create-agent, create-command, all-tools

**`development/`** - Comandos de desenvolvimento
- Criar componentes, refatorar, debug
- Exemplos: create-component, refactor-api, analyze-performance

**`data/`** - Comandos relacionados a dados
- Migrations, schemas, queries
- Exemplos: create-migration, seed-database, query-analyzer

**`deployment/`** - Comandos de deploy
- Build, release, CI/CD
- Exemplos: deploy-staging, rollback, health-check

**`testing/`** - Comandos de testes
- Unit, integration, e2e
- Exemplos: run-tests, generate-mocks, coverage-report

**`documentation/`** - Comandos de documentação
- Gerar, atualizar, verificar
- Exemplos: generate-docs, update-readme, check-links

**`sessions/`** - Comandos do sistema de sessions
- Gerenciar sessions de trabalho
- Exemplos: new, update, list, search

## Guidelines

### ✅ Boas Práticas para Criar Comandos

**Nomenclatura**:
- ✅ Use verbos de ação: create, update, analyze, generate
- ✅ Seja específico: `create-api-endpoint` > `create-thing`
- ✅ Use kebab-case: `generate-test-suite`
- ✅ Máximo 3-4 palavras no nome

**Estrutura**:
- ✅ Sempre inclua seção "Requisitos do Usuário" com `#$ARGUMENTS`
- ✅ Processo passo a passo numerado
- ✅ Guidelines com ✅ ⚠️ ❌ para clareza visual
- ✅ Exemplos práticos de uso
- ✅ Checklist de validação ao final

**Conteúdo**:
- ✅ Instruções acionáveis (verbos imperativos)
- ✅ Contexto específico do projeto
- ✅ Referências a padrões estabelecidos
- ✅ Tratamento de edge cases

**Exemplos**:
- ✅ Mínimo 2 exemplos (simples + complexo)
- ✅ Exemplos com input e output esperado
- ✅ Cobrir casos de uso comuns

### ⚠️ Atenções Especiais

**Placeholder ARGUMENTS (Cursor v2+)**:
- ⚠️ SEMPRE use `#$ARGUMENTS` na seção requirements
- ⚠️ Formato obrigatório: `<requirements>#$ARGUMENTS</requirements>`
- ⚠️ Este é o mecanismo oficial de captura do Cursor v2+
- ⚠️ Sem isso, comando não receberá input do usuário

**Markdown Válido**:
- ⚠️ Use syntax highlighting em code blocks
- ⚠️ Teste todos os links
- ⚠️ Valide hierarquia de headers (H1 → H2 → H3)
- ⚠️ NUNCA indente triple backticks

**Code References (Cursor v2+)**:
- ⚠️ Use `startLine:endLine:filepath` para código existente
- ⚠️ Use markdown blocks simples para código novo
- ⚠️ NUNCA misture os formatos
- ⚠️ Deve conter pelo menos 1 linha de código real

**Contexto do Projeto**:
- ⚠️ Referencie padrões existentes (ZenStack-First, Tamagui, etc.)
- ⚠️ Mantenha consistência com outros comandos
- ⚠️ Adapte para stack específica do projeto
- ⚠️ Use ferramentas especializadas ao invés de terminal commands

### ❌ O Que Evitar

**Estrutura**:
- ❌ Comandos sem seção de requisitos
- ❌ Ausência de exemplos
- ❌ Processo vago ou não sequencial
- ❌ Falta de validação/checklist
- ❌ YAML frontmatter em comandos (apenas em agentes)

**Conteúdo**:
- ❌ Instruções genéricas demais
- ❌ "Faça algo bom" (não é acionável)
- ❌ Sem tratamento de erros
- ❌ Ignorar edge cases
- ❌ Mencionar nomes de ferramentas ao usuário

**Nomenclatura**:
- ❌ Nomes genéricos: `do-thing`, `helper`, `util`
- ❌ Underscores: `create_command`
- ❌ CamelCase: `CreateCommand`
- ❌ Espaços ou caracteres especiais

**Code References (Cursor v2+)**:
- ❌ Misturar `startLine:endLine:filepath` com language tags
- ❌ Indentar triple backticks
- ❌ Blocos de código vazios
- ❌ Incluir números de linha no conteúdo do código

## Exemplos de Invocação

### Exemplo 1: Comando de Desenvolvimento Simples

**Input**:
```
/meta/create-command Criar um comando para extrair função de um bloco de código selecionado
```

**O que acontecerá**:
1. @command-creator analisa: "comando de refactoring simples"
2. Define nome: `extract-function`
3. Categoria: `development/`
4. Cria: `.cursor/commands/development/extract-function.md`
5. Gera estrutura com:
   - Processo de 3 etapas (analisar, criar, substituir)
   - Guidelines sobre naming e tipos
   - Exemplo de extração
   - Checklist de validação

**Resultado**:
```
✅ Comando criado: extract-function
📁 Localização: .cursor/commands/development/extract-function.md
🎯 Uso: /development/extract-function [bloco de código]
```

---

### Exemplo 2: Comando Complexo com Workflow

**Input**:
```
/meta/create-command Criar um comando para gerar feature completa (schema, API, UI, testes)
```

**O que acontecerá**:
1. @command-creator identifica: "comando complexo multi-etapas"
2. Define nome: `generate-feature`
3. Categoria: `development/`
4. Cria comando com:
   - 5 fases (planejar, schema, API, UI, testes)
   - Integração com ZenStack e Tamagui
   - TODO list generation
   - Validação em cada etapa

**Resultado**:
```
✅ Comando criado: generate-feature
📁 Localização: .cursor/commands/development/generate-feature.md
🎯 Uso: /development/generate-feature [nome da feature]
⚙️ Features: ZenStack-First, Tamagui, Storybook integration
```

---

### Exemplo 3: Meta-Comando

**Input**:
```
/meta/create-command Criar um comando para documentar um padrão de código recorrente
```

**O que acontecerá**:
1. @command-creator identifica: "meta-comando sobre documentação"
2. Define nome: `document-pattern`
3. Categoria: `meta/`
4. Cria comando que:
   - Identifica padrão via codebase_search
   - Extrai estrutura comum
   - Gera documentação em `docs/patterns/`
   - Registra em memória

**Resultado**:
```
✅ Comando criado: document-pattern
📁 Localização: .cursor/commands/meta/document-pattern.md
🎯 Uso: /meta/document-pattern [código do padrão]
📝 Output: docs/patterns/[nome-padrao].md
```

---

### Exemplo 4: Comando de Automação

**Input**:
```
/meta/create-command Criar um comando para rodar todos os testes e gerar report de coverage
```

**O que acontecerá**:
1. @command-creator analisa: "comando de testing com automação"
2. Define nome: `test-with-coverage`
3. Categoria: `testing/`
4. Cria comando que:
   - Executa test suite completo
   - Gera coverage report
   - Valida threshold (>80%)
   - Exibe summary formatado

**Resultado**:
```
✅ Comando criado: test-with-coverage
📁 Localização: .cursor/commands/testing/test-with-coverage.md
🎯 Uso: /testing/test-with-coverage [opcional: path específico]
📊 Features: Coverage threshold, formatted output, CI-friendly
```

---

## Workflow Completo

### Passo 1: Preparar Descrição
Antes de invocar, tenha claro:
- O que o comando deve fazer?
- Quais entradas ele precisa?
- Qual output esperado?
- Há padrões similares no projeto?

### Passo 2: Invocar Comando
```bash
/meta/create-command [descrição clara do comando]
```

### Passo 3: Agente Trabalha
@command-creator automaticamente:
- Analisa requisitos
- Explora projeto
- Define estrutura
- Cria arquivo
- Valida e confirma

### Passo 4: Revisar e Ajustar
Após criação:
1. Abrir arquivo gerado
2. Revisar conteúdo
3. Ajustar se necessário
4. Testar o comando

### Passo 5: Usar o Novo Comando
```bash
/[categoria]/[nome-do-comando] [input]
```

## Casos de Uso Comuns

### Caso 1: Automatizar Tarefa Repetitiva
**Situação**: Você faz a mesma sequência de passos repetidamente

**Solução**:
```
/meta/create-command Criar comando para [descreva a tarefa]
```

**Benefício**: Automatiza e padroniza o processo

---

### Caso 2: Capturar Padrão do Projeto
**Situação**: Há um padrão estabelecido que novos membros devem seguir

**Solução**:
```
/meta/create-command Criar comando para [aplicar o padrão X]
```

**Benefício**: Garante consistência e facilita onboarding

---

### Caso 3: Workflow Complexo
**Situação**: Tarefa requer múltiplas etapas interdependentes

**Solução**:
```
/meta/create-command Criar comando para [workflow complexo]
```

**Benefício**: Guia passo a passo, reduz erros

---

### Caso 4: Integração com Ferramentas
**Situação**: Precisa integrar múltiplas ferramentas/sistemas

**Solução**:
```
/meta/create-command Criar comando para [orquestrar ferramentas X, Y, Z]
```

**Benefício**: Abstrai complexidade, interface única

---

## Dicas e Truques

### 💡 Dica 1: Seja Específico na Descrição
**Ruim**: "Criar comando para gerar código"  
**Bom**: "Criar comando para gerar componente React com Tamagui, TypeScript e Storybook"

### 💡 Dica 2: Mencione Contexto do Projeto
**Ruim**: "Criar comando para adicionar rota"  
**Bom**: "Criar comando para adicionar rota Fastify com ZenStack hooks"

### 💡 Dica 3: Indique Complexidade
**Simples**: "Criar comando para [1 ação]"  
**Médio**: "Criar comando para [2-3 ações sequenciais]"  
**Complexo**: "Criar comando para [workflow multi-etapas com decisões]"

### 💡 Dica 4: Referencie Exemplos Existentes
Se há comando similar:
```
/meta/create-command Criar comando similar a /sessions/new mas para [outro contexto]
```

### 💡 Dica 5: Itere se Necessário
Comando criado não perfeito? Ajuste manualmente ou peça variação:
```
/meta/create-command Criar variação de [comando-existente] que [mudança]
```

## Checklist de Validação

Após comando criado, verifique:

### Estrutura
- [ ] Arquivo em `.cursor/commands/[categoria]/[nome].md`
- [ ] Nome em kebab-case
- [ ] Categoria apropriada
- [ ] Seção "Requisitos" com `#$ARGUMENTS`

### Conteúdo
- [ ] Processo passo a passo claro
- [ ] Guidelines completas (✅ ⚠️ ❌)
- [ ] Mínimo 2 exemplos práticos
- [ ] Checklist de validação incluída

### Qualidade
- [ ] Instruções acionáveis
- [ ] Contexto do projeto incluído
- [ ] Edge cases considerados
- [ ] Markdown válido

### Usabilidade
- [ ] Comando testável
- [ ] Output esperado claro
- [ ] Próximos passos definidos
- [ ] Integração com ferramentas existentes

## Comandos Relacionados

- `/meta/create-agent` - Criar agente especializado
- `/meta/create-task-structure` - Estruturar tarefas complexas
- `/meta/all-tools` - Ver todas as ferramentas disponíveis

## Troubleshooting

### Problema: Comando criado muito genérico
**Solução**: Forneça mais contexto específico do projeto na descrição

### Problema: Comando na categoria errada
**Solução**: Mova arquivo manualmente ou recrie com categoria correta

### Problema: Comando muito complexo
**Solução**: Divida em múltiplos comandos menores e mais focados

### Problema: `#$ARGUMENTS` não captura input (Cursor v2+)
**Solução**: Verifique que está dentro de `<requirements>#$ARGUMENTS</requirements>`

### Problema: Code references não funcionam
**Solução**: Use `startLine:endLine:filepath` SEM language tags para código existente

## FAQ

**P: Posso criar comando que usa outros comandos?**  
R: Sim! Comandos podem invocar outros comandos ou agentes.

**P: Comando pode ter sub-comandos?**  
R: Sim, use estrutura de diretórios: `/categoria/comando/sub-comando.md`

**P: Posso modificar comando depois de criado?**  
R: Sim, são arquivos markdown editáveis normalmente.

**P: Comando pode executar código arbitrário?**  
R: Não diretamente. Comandos são prompts para IA executar via ferramentas.

**P: Quantos comandos posso criar?**  
R: Sem limite! Organize bem em categorias.

---

## Resumo de Uso

**Sintaxe básica**:
```
/meta/create-command [descrição clara do comando desejado]
```

**O que acontece**:
1. @command-creator analisa requisitos
2. Explora contexto do projeto  
3. Define estrutura apropriada
4. Cria arquivo completo
5. Confirma com resumo

**Output**:
- Novo comando em `.cursor/commands/[categoria]/[nome].md`
- Pronto para uso imediato
- Totalmente customizável

---

## 📚 Diferenças: Comandos vs Agentes (Cursor v2+)

### Comandos (.cursor/commands/)
```markdown
✅ Arquivos .md simples (SEM YAML frontmatter)
✅ Executados com `/` no chat
✅ Usam `#$ARGUMENTS` para capturar input
✅ Workflows e instruções estruturadas
✅ Exemplo: /git/init, /engineer/work
```

### Agentes (.cursor/agents/)
```markdown
✅ Arquivos .md com YAML frontmatter
✅ Invocados com `@` no chat
✅ Especialistas em domínios específicos
✅ Têm ferramentas e permissões definidas
✅ Exemplo: @python-developer, @gitflow-specialist
```

### Quando Usar Cada Um?

**Use Comando quando:**
- Precisa de workflow estruturado passo-a-passo
- Quer automatizar sequência de ações
- Necessita capturar input específico do usuário
- Quer criar atalho para tarefa recorrente

**Use Agente quando:**
- Precisa de expertise especializada
- Tarefa requer raciocínio e decisões
- Necessita ferramentas específicas (MCP, etc.)
- Quer delegar responsabilidade completa

---

**Agora você pode criar comandos Cursor de forma rápida e estruturada!** 🚀

**Exemplo de uso**:
```
/meta/create-command Criar um comando para gerar migration de banco de dados
```

