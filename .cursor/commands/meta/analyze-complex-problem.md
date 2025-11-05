# Comando Analisar Problema Complexo

Facilita a criação de análises estruturadas e abrangentes para problemas complexos utilizando o template oficial de análise.

## Requisitos do Usuário
<requirements>
#$ARGUMENTS
</requirements>

## Processo

### 1. Identificar o Contexto da Análise

Primeiro, entenda o escopo completo:
- **Tipo de Análise**: Crítica, Implementação, Status, Migração, Arquitetura, Performance, Segurança
- **Sistema/Componente Base**: O que está sendo analisado
- **Objetivo**: Por que esta análise é necessária
- **Stakeholders**: Quem precisa das conclusões

### 2. Coletar Informações Preliminares

Execute coleta de dados antes de preencher o template:

**Para Análise de Código:**
```bash
# Buscar arquivos relevantes
codebase_search "contexto do problema"
grep "padrões específicos" caminho/

# Analisar estrutura
list_dir diretório/relevante/
```

**Para Análise de Sistema:**
```bash
# Status de serviços
run_terminal_cmd "systemctl status [serviço]"

# Logs recentes
grep "ERROR\|WARNING" /var/log/aplicacao.log

# Métricas de performance
run_terminal_cmd "top -bn1"
```

**Para Análise de Documentação:**
```bash
# Ler documentos relevantes
read_file docs/relacionado.md
read_file README.md
```

### 3. Carregar e Preparar o Template

1. **Ler Template**: Carregar `.cursor/docs/templates/analysis-template.md`
2. **Definir Nomenclatura**: `analise-[tipo]-[componente]-[YYYY-MM-DD].md`
3. **Determinar Localização**: 
   - Análises de implementação: `docs/analysis/implementation/`
   - Análises críticas: `docs/analysis/critical/`
   - Análises de status: `docs/analysis/status/`
   - Análises de migração: `docs/analysis/migration/`

### 4. Preencher Resumo Executivo

Complete a primeira seção crítica:

**Determinar Status Geral:**
- 🟢 **EXCELENTE**: >90% conforme, riscos baixos
- 🟡 **BOM**: 70-90% conforme, alguns riscos médios
- 🔴 **CRÍTICO**: <70% conforme, riscos altos ou críticos

**Identificar:**
- Principais achados (2-3 pontos mais importantes)
- Número de ações críticas necessárias
- Distribuição de riscos por severity

### 5. Executar Análise Detalhada por Categoria

Para cada categoria relevante ao problema:

#### 5.1. Identificar Subcategorias
Liste todos os aspectos que precisam ser analisados

#### 5.2. Classificar Status
Para cada subcategoria:
- 🟢 **STATUS POSITIVO**: Funcionando corretamente, completo
- 🟡 **STATUS PARCIAL**: Parcialmente implementado, gaps identificados
- 🔴 **STATUS CRÍTICO**: Problemas graves, não funcional

#### 5.3. Documentar Evidências
Para cada classificação, inclua:
- **Evidências concretas**: Arquivos, logs, métricas, testes
- **Percentuais**: Quando aplicável (ex: 75% dos testes passando)
- **Referências**: Links para código, documentação, issues

#### 5.4. Identificar Gaps e Problemas
Para status parcial ou crítico:
- Liste o que falta
- Explique o impacto
- Identifique causa raiz quando possível

### 6. Preencher Matrizes de Status e Riscos

#### Matriz de Implementação
Para cada componente:
| Componente | Status | % Completo | Prioridade | Estimativa |
|------------|--------|------------|------------|------------|
| Use estimativas realistas baseadas em complexidade |

**Diretrizes de Estimativa:**
- Simples (refactor, config): 1-4h
- Médio (feature nova, integração): 4-16h
- Complexo (arquitetura, migração): 16-40h
- Muito complexo (sistema novo): 40h+

#### Matriz de Riscos
Para cada risco identificado:
| Risco | Probabilidade | Impacto | Severity | Mitigação |

**Classificação de Severity:**
- 🔴 **CRÍTICO**: Probabilidade Alta + Impacto Crítico
- 🟡 **ALTO**: Probabilidade Média + Impacto Alto
- 🟢 **MÉDIO**: Probabilidade Baixa + Impacto Médio

### 7. Categorizar Problemas por Criticidade

Organize todos os problemas identificados:

#### PROBLEMAS CRÍTICOS 🔴
- Bloqueiam funcionalidade essencial
- Causam data loss ou security breach
- Impedem deploy ou operação
- **Prazo**: Esta semana

#### PROBLEMAS ALTOS 🟡
- Degradam performance significativamente
- Impedem features importantes
- Causam má experiência de usuário
- **Prazo**: Próximas 2 semanas

#### MELHORIAS RECOMENDADAS 🟢
- Otimizações de código
- Melhorias de UX
- Refactorings não urgentes
- **Prazo**: Próximo mês

### 8. Definir Métricas e Validação

#### Métricas Atuais vs. Esperadas
Inclua métricas mensuráveis:
- **Performance**: Tempo de resposta, throughput, latência
- **Qualidade**: Coverage de testes, bugs abertos, tech debt
- **Segurança**: Vulnerabilidades, compliance score
- **Usabilidade**: NPS, taxa de erro, tempo de conclusão

#### Critérios de Sucesso
Liste critérios **SMART**:
- **S**pecific: Específico e claro
- **M**easurable: Mensurável com métrica
- **A**chievable: Alcançável com recursos disponíveis
- **R**elevant: Relevante para o objetivo
- **T**ime-bound: Com prazo definido

#### Testes de Validação
Forneça comandos executáveis para validar:
```bash
# Exemplos
npm test
npm run build
curl -X GET https://api/health
grep -r "TODO" src/ | wc -l
```

### 9. Criar Recomendações Prioritárias

Organize ações em 3 categorias temporais:

#### AÇÕES IMEDIATAS (Esta Semana) 🔴
Para cada ação crítica:
1. **Nome da Ação** - Estimativa
   - **Por que**: Justificativa da urgência (risco, bloqueio, impacto)
   - **Como**: Passos específicos e executáveis
   - **Resultado**: Outcome mensurável esperado

#### AÇÕES CURTO PRAZO (Próximas 2 Semanas) 🟡
Liste ações importantes mas não bloqueantes

#### AÇÕES MÉDIO PRAZO (Próximo Mês) 🟢
Liste melhorias e otimizações

### 10. Elaborar Plano de Ação Detalhado

Converta recomendações em plano executável:

#### Fase 1: Correções Críticas
- [ ] **Task específica** - Responsável - Deadline
- Cada task deve ser atômica e independente quando possível
- Inclua dependências se necessário

**Critérios de Aceitação:**
- [ ] Critérios testáveis e verificáveis
- [ ] Um critério por item

#### Fases Subsequentes
Continue com Fase 2 (Melhorias) e Fase 3 (Otimizações)

### 11. Escrever Conclusão e Próximos Passos

#### Pontos Fortes
Liste o que está funcionando bem (importante para moral!)

#### Lacunas Críticas
Resuma os principais gaps identificados

#### Próximo Passo Recomendado
**Identifique A ação mais importante**: Qual é o primeiro passo crítico?

#### Expectativa de Melhoria
Quantifique melhorias esperadas:
- Status atual → Status esperado (ex: 65% → 95%)
- Riscos mitigados (ex: 5 riscos críticos resolvidos)
- Benefícios concretos (ex: deploy em 30min vs 2h)

### 12. Anexar Referências e Metodologia

**Documentos Analisados:**
- Liste todos os documentos consultados com contexto

**Ferramentas Utilizadas:**
- Liste ferramentas de análise (Lynis, Lighthouse, etc)
- Comandos executados
- Métricas coletadas

**Metodologia:**
- Explique como a análise foi conduzida
- Critérios usados
- Limitações conhecidas (ex: "não incluiu análise de X por Y")

### 13. Salvar e Compartilhar

1. **Salvar Documento**:
   - Usar nomenclatura consistente
   - Localização apropriada em `docs/analysis/`
   - Formato markdown

2. **Criar TODO Items**:
   - Usar `todo_write` para ações críticas
   - Referenciar análise nos TODOs

3. **Atualizar Memória**:
   - Registrar padrões importantes identificados
   - Armazenar decisões arquiteturais

4. **Notificar Stakeholders**:
   - Resumo executivo pode ser compartilhado separadamente
   - Destacar ações críticas que requerem decisão

## Guidelines

### ✅ Boas Práticas

**Objetividade e Evidências:**
- ✅ **SEMPRE** baseie conclusões em evidências concretas (logs, código, métricas)
- ✅ **SEMPRE** inclua referências específicas (arquivos, linhas, timestamps)
- ✅ **SEMPRE** quantifique quando possível (percentuais, números, tempo)
- ✅ Use linguagem clara e objetiva, evite ambiguidade
- ✅ Separe fatos (o que está acontecendo) de interpretação (por que está acontecendo)

**Estrutura e Organização:**
- ✅ Siga a ordem do template rigorosamente
- ✅ Use emojis de status (🟢🟡🔴) consistentemente
- ✅ Numere seções e subseções adequadamente
- ✅ Mantenha hierarquia visual clara (headers, tabelas, listas)

**Priorização e Ação:**
- ✅ Priorize por impacto × urgência
- ✅ Forneça estimativas realistas baseadas em complexidade
- ✅ Inclua próximos passos executáveis
- ✅ Defina responsáveis quando possível
- ✅ Estabeleça deadlines razoáveis

**Completude:**
- ✅ Preencha TODAS as seções do template (use "N/A" se não aplicável)
- ✅ Inclua pelo menos 2 exemplos ou evidências por problema
- ✅ Forneça comandos de validação executáveis
- ✅ Liste todas as dependências e riscos

### ⚠️ Atenções Especiais

**Severity e Criticidade:**
- ⚠️ Não abuse de classificações "CRÍTICO" - reserve para bloqueios reais
- ⚠️ 🔴 CRÍTICO: Bloqueia produção, causa perda de dados, security breach
- ⚠️ 🟡 ALTO: Degrada significativamente, impede features importantes
- ⚠️ 🟢 MÉDIO: Melhorias desejáveis, refactorings não urgentes

**Estimativas:**
- ⚠️ Considere contexto da equipe (expertise, disponibilidade)
- ⚠️ Adicione buffer para imprevistos (20-30% extra)
- ⚠️ Documente premissas das estimativas

**Escopo:**
- ⚠️ Defina claramente o que ESTÁ e NÃO ESTÁ no escopo
- ⚠️ Não expanda escopo durante análise sem justificativa
- ⚠️ Documente limitações conhecidas

**Linguagem:**
- ⚠️ Evite jargão técnico excessivo se audience é mista
- ⚠️ Explique acrônimos na primeira ocorrência
- ⚠️ Use termos do domínio do projeto consistentemente

**Dados Sensíveis:**
- ⚠️ Nunca inclua senhas, tokens, keys na análise
- ⚠️ Sanitize logs e exemplos de dados sensíveis
- ⚠️ Use dados fictícios/mock quando demonstrar problemas

### ❌ O Que Evitar

**Problemas Estruturais:**
- ❌ NUNCA pule seções do template sem justificativa
- ❌ NUNCA misture problemas de diferentes severities na mesma categoria
- ❌ NUNCA use "vários", "alguns", "muitos" - seja específico com números
- ❌ Evite análises superficiais tipo "parece bom" ou "pode melhorar"

**Problemas de Conteúdo:**
- ❌ NUNCA faça afirmações sem evidências
- ❌ NUNCA culpe indivíduos - foque em processos e sistemas
- ❌ NUNCA omita problemas por serem "óbvios" - documente tudo
- ❌ Evite soluções vagas tipo "melhorar performance" - seja específico

**Problemas de Priorização:**
- ❌ NUNCA classifique tudo como crítico
- ❌ NUNCA ignore dependências entre ações
- ❌ NUNCA crie plano de ação sem considerar capacidade da equipe
- ❌ Evite deadlines irrealistas ou arbitrários

**Problemas de Comunicação:**
- ❌ NUNCA assuma conhecimento prévio do leitor sobre contexto
- ❌ NUNCA use linguagem emotiva ou acusatória
- ❌ NUNCA termine análise sem próximos passos claros
- ❌ Evite jargão técnico desnecessário

## Exemplos

### Exemplo 1: Análise de Implementação de Feature

**Input do Usuário:**
```
/meta/analyze-complex-problem Analisar implementação da feature de autenticação OAuth
```

**Processo Executado:**

1. **Coleta de Informações:**
```bash
# Buscar código relacionado a OAuth
codebase_search "OAuth authentication implementation"

# Verificar arquivos de configuração
read_file apps/api/src/auth/oauth.config.ts

# Verificar testes
grep -r "OAuth" apps/api/src/**/*.test.ts

# Verificar documentação
read_file docs/features/authentication.md
```

2. **Criação do Documento:**
```
📄 Localização: docs/analysis/implementation/analise-implementacao-oauth-2025-10-15.md
```

3. **Conteúdo Gerado:**

```markdown
# Análise Implementação: Feature de Autenticação OAuth

**Documento de Análise de Implementação**
**Data:** 2025-10-15
**Analisado por:** AI Assistant + DevTeam
**Documento/Sistema Base:** Feature OAuth - Spec #123
**Escopo:** Implementação completa de OAuth 2.0 com Google e GitHub

---

## 🚨 **RESUMO EXECUTIVO**

- **Status Geral**: 🟡 BOM (73% implementado)
- **Principais Achados**: 
  - ✅ OAuth flow implementado corretamente para Google
  - ⚠️ GitHub OAuth parcialmente implementado (falta refresh token)
  - ❌ Testes de integração ausentes
- **Ações Críticas**: 2 ações críticas identificadas
- **Riscos Identificados**: 1 crítico, 2 altos, 1 médio

**Severity Levels:**
- 🔴 **CRÍTICO**: Bloqueia produção ou causa falha de segurança
- 🟡 **ALTO**: Degrada experiência ou dificulta manutenção
- 🟢 **MÉDIO**: Melhorias desejáveis mas não urgentes

---

## 📋 **ANÁLISE DETALHADA**

### **1. IMPLEMENTAÇÃO DE PROVIDERS**

#### **🟢 Google OAuth - STATUS POSITIVO**
**Status**: ✅ **COMPLETO** (100%)

**Componentes Analisados:**
- ✅ **Authorization Flow**: Implementado corretamente com PKCE
- ✅ **Token Management**: Access token e refresh token com storage seguro
- ✅ **User Profile**: Extração completa de dados do usuário

**Evidências:**
- apps/api/src/auth/providers/google.oauth.ts (linhas 15-89)
- Testes unitários: 12/12 passando
- Documentação completa em docs/auth/google-oauth.md

#### **🟡 GitHub OAuth - STATUS PARCIAL**
**Status**: ⚠️ **PARCIAL** (60%)

**Componentes Analisados:**
- ✅ **Authorization Flow**: Implementado
- ⚠️ **Token Management**: Falta implementar refresh token
- ✅ **User Profile**: Extração básica funcionando

**Gaps Identificados:**
- GitHub não retorna refresh token por padrão - necessário implementar re-auth
- Scope de emails não está sendo solicitado
- Rate limiting não considerado

#### **🔴 Testes de Integração - STATUS CRÍTICO**
**Status**: ❌ **FALTANDO** (0%)

**Problemas Críticos:**
- 🔴 **Ausência de Testes E2E**: Nenhum teste end-to-end implementado
  - **Impacto**: Impossível validar flow completo antes de produção
  - **Causa Raiz**: Falta de ambiente de teste com OAuth mocks
  - **Recomendação**: Implementar testes com msw (Mock Service Worker)

---

## 📊 **MATRIZ DE STATUS/PROBLEMAS**

### **Matriz de Implementação**
| Componente | Status | % Completo | Prioridade | Estimativa |
|------------|--------|------------|------------|------------|
| Google OAuth Flow | ✅ COMPLETO | 100% | - | - |
| GitHub OAuth Flow | ⚠️ PARCIAL | 60% | 🟡 ALTA | 6h |
| Token Refresh Logic | ⚠️ PARCIAL | 50% | 🟡 ALTA | 4h |
| Testes de Integração | ❌ FALTANDO | 0% | 🔴 CRÍTICA | 8h |
| Documentação API | ✅ COMPLETO | 100% | - | - |
| Error Handling | ⚠️ PARCIAL | 70% | 🟡 ALTA | 3h |

### **Matriz de Riscos**
| Risco | Probabilidade | Impacto | Severity | Mitigação |
|-------|--------------|---------|----------|-----------|
| Falha em produção sem testes E2E | Alta | Crítico | 🔴 | Implementar testes antes de deploy |
| GitHub rate limiting não tratado | Média | Alto | 🟡 | Implementar exponential backoff |
| Token expiration não detectada | Média | Alto | 🟡 | Adicionar refresh automático |
| CSRF vulnerability | Baixa | Médio | 🟢 | Validar state parameter |

---

## 🎯 **PROBLEMAS IDENTIFICADOS POR CATEGORIA**

### **1. PROBLEMAS CRÍTICOS** 🔴

#### **Ausência de Testes de Integração**
- **Problema**: Zero testes E2E para validar OAuth flow completo
- **Impacto**: Risco alto de bugs em produção, impossível fazer deploy com confiança
- **Evidência**: Pasta tests/integration/ está vazia
- **Solução**: Implementar testes com Mock Service Worker para simular providers
- **Prazo**: Antes do deploy para produção (esta semana)

### **2. PROBLEMAS ALTOS** 🟡

#### **GitHub Refresh Token não Implementado**
- **Problema**: GitHub OAuth não renova tokens automaticamente
- **Impacto**: Usuários precisarão re-autenticar frequentemente (tokens expiram em 8h)
- **Solução**: Implementar re-authentication flow ou considerar GitHub Apps

#### **Rate Limiting não Tratado**
- **Problema**: Chamadas à API do GitHub não consideram rate limits
- **Impacto**: Possível bloqueio temporário em alta demanda
- **Solução**: Implementar exponential backoff e cache de user profile

### **3. MELHORIAS RECOMENDADAS** 🟢

#### **Adicionar Mais Providers**
- **Oportunidade**: Suporte para LinkedIn, Microsoft
- **Benefício**: Maior flexibilidade para usuários corporativos
- **Implementação**: Seguir padrão do Google OAuth (4h cada)

---

## 📈 **MÉTRICAS E VALIDAÇÃO**

### **Métricas Atuais vs. Esperadas**
| Métrica | Atual | Esperado | Status | Gap |
|---------|-------|----------|--------|-----|
| Test Coverage OAuth | 68% | 90%+ | ⚠️ | 22% |
| Providers Implementados | 2/2 | 2/2 | ✅ | 0 |
| Completude GitHub OAuth | 60% | 100% | ❌ | 40% |
| Documentação API | 100% | 100% | ✅ | 0 |
| Testes E2E | 0 | 10+ | ❌ | 10 testes |

### **Critérios de Sucesso**
- [ ] **Test coverage >90%**: Incluindo unit e integration tests
- [ ] **Todos os providers 100% funcionais**: Google e GitHub completos
- [ ] **Documentação completa**: API docs + user guides atualizados
- [ ] **Zero vulnerabilidades**: Scan de segurança limpo
- [ ] **Performance <500ms**: Tempo de resposta do OAuth flow

### **Testes de Validação**
```bash
# Executar testes unitários
npm test -- auth/oauth

# Verificar coverage
npm run test:coverage

# Scan de segurança
npm audit

# Validar endpoints
curl -X GET http://localhost:3000/auth/google
curl -X GET http://localhost:3000/auth/github
```

---

## 🔧 **RECOMENDAÇÕES PRIORITÁRIAS**

### **AÇÕES IMEDIATAS** (Esta Semana) 🔴

1. **Implementar Testes de Integração** - Estimativa: 8h
   - **Por que**: Crítico para garantir qualidade antes de produção
   - **Como**: 
     1. Instalar Mock Service Worker (msw)
     2. Criar mocks para Google e GitHub OAuth responses
     3. Implementar 10+ cenários de teste (success, error, edge cases)
     4. Integrar no CI/CD pipeline
   - **Resultado**: 100% confiança no OAuth flow, zero bugs em produção

2. **Completar GitHub OAuth (Refresh Token)** - Estimativa: 6h
   - **Por que**: Usuários não devem re-autenticar a cada 8h
   - **Como**:
     1. Pesquisar estratégia de refresh para GitHub (re-auth vs GitHub Apps)
     2. Implementar solução escolhida
     3. Adicionar testes
     4. Documentar comportamento
   - **Resultado**: Experiência de usuário melhorada, menos re-autenticações

### **AÇÕES CURTO PRAZO** (Próximas 2 Semanas) 🟡

1. **Implementar Rate Limiting Handler** - Estimativa: 3h
2. **Melhorar Error Handling** - Estimativa: 3h
3. **Adicionar Monitoring e Alertas** - Estimativa: 4h

### **AÇÕES MÉDIO PRAZO** (Próximo Mês) 🟢

1. **Adicionar Provider LinkedIn** - Estimativa: 6h
2. **Implementar OAuth Analytics Dashboard** - Estimativa: 8h

---

## ✅ **PLANO DE AÇÃO DETALHADO**

### **Fase 1: Correções Críticas** (Prazo: 2025-10-22)

- [ ] **Implementar Mock Service Worker** - Backend Team - 2025-10-18
- [ ] **Criar 10 testes de integração OAuth** - Backend Team - 2025-10-20
- [ ] **Completar GitHub refresh token** - Backend Team - 2025-10-21
- [ ] **Code review e merge** - Tech Lead - 2025-10-22

**Critérios de Aceitação:**
- [ ] Test coverage OAuth ≥ 90%
- [ ] Todos os testes E2E passando no CI
- [ ] GitHub OAuth 100% funcional
- [ ] Documentação atualizada

### **Fase 2: Melhorias** (Prazo: 2025-11-05)

- [ ] **Implementar rate limiting handler** - Backend Team - 2025-10-28
- [ ] **Melhorar error handling e mensagens** - Backend Team - 2025-10-30
- [ ] **Adicionar monitoring e alertas** - DevOps - 2025-11-05

**Critérios de Aceitação:**
- [ ] Rate limiting tratado com exponential backoff
- [ ] Errors retornam mensagens user-friendly
- [ ] Alertas configurados para falhas OAuth

### **Fase 3: Otimizações** (Prazo: 2025-11-30)

- [ ] **Adicionar provider LinkedIn** - Backend Team - 2025-11-20
- [ ] **Implementar analytics dashboard** - Frontend Team - 2025-11-30

---

## 🏆 **CONCLUSÃO E PRÓXIMOS PASSOS**

### **✅ PONTOS FORTES IDENTIFICADOS**

- **Google OAuth 100% funcional**: Implementação robusta e bem testada
- **Documentação excelente**: API docs claros e completos
- **Arquitetura extensível**: Fácil adicionar novos providers

### **⚠️ LACUNAS CRÍTICAS**

- **Zero testes E2E**: Impossível validar flow completo antes de produção
- **GitHub OAuth incompleto**: Token refresh não funciona adequadamente
- **Falta de rate limiting**: Risco de bloqueio por providers

### **🎯 PRÓXIMO PASSO RECOMENDADO**

**Implementar testes de integração E2E com MSW** - Esta é a ação mais crítica pois bloqueia deploy seguro para produção. Sem testes E2E, não há garantia de que o OAuth flow funciona corretamente em todos os cenários.

### **📊 EXPECTATIVA DE MELHORIA**

Após implementar as recomendações:
- **Status esperado**: De 73% para 95% completo
- **Riscos mitigados**: 3 de 4 riscos resolvidos (crítico + 2 altos)
- **Benefícios**: 
  - Deploy seguro para produção
  - Melhor experiência de usuário
  - Manutenção mais fácil

---

## 📚 **ANEXOS E REFERÊNCIAS**

### **Documentos Analisados**
- Feature Spec #123 - OAuth Implementation
- docs/auth/google-oauth.md - Google OAuth documentation
- apps/api/src/auth/ - Implementation code

### **Ferramentas Utilizadas**
- codebase_search - Para localizar código OAuth
- grep - Para encontrar testes
- npm test - Para validar test coverage

### **Metodologia**
- **Critérios de análise**: Baseado em OAuth 2.0 best practices e security guidelines
- **Fontes de dados**: Código-fonte, testes, documentação, logs de desenvolvimento
- **Limitações**: Não incluiu análise de performance (será feita em análise separada)

---

**📅 Criado em:** 2025-10-15
**👤 Analista:** AI Assistant + Backend Team
**🔄 Próxima revisão:** 2025-10-22 (após Fase 1)
**📋 Status do documento:** Review
```

**Resultado:**
- ✅ Análise completa e estruturada
- ✅ Problemas priorizados com evidências
- ✅ Plano de ação executável
- ✅ Métricas claras de sucesso

---

### Exemplo 2: Análise de Problema de Performance

**Input do Usuário:**
```
/meta/analyze-complex-problem Sistema está lento, analisar performance da API
```

**Processo Executado:**

1. **Coleta de Métricas:**
```bash
# Logs de performance
grep "response_time" /var/log/api.log | awk '{sum+=$NF; count++} END {print sum/count}'

# Queries lentas
grep "SLOW QUERY" /var/log/postgres.log

# CPU e memória
top -bn1 | grep "api"

# Endpoints mais chamados
awk '{print $7}' /var/log/nginx/access.log | sort | uniq -c | sort -rn | head -20
```

2. **Análise de Código:**
```bash
# Buscar N+1 queries
codebase_search "database queries in loops"

# Buscar operações síncronas bloqueantes
grep -r "sync\|await" apps/api/src/ | wc -l
```

3. **Documento Gerado:**
```
📄 docs/analysis/critical/analise-critica-performance-api-2025-10-15.md
```

**Resumo Executivo:**
- Status: 🔴 CRÍTICO
- Problema: Tempo de resposta médio 3.2s (esperado: <200ms)
- Causa Raiz: N+1 queries em endpoint mais usado (/api/users)
- Ação Imediata: Implementar eager loading com Prisma include

---

### Exemplo 3: Análise de Migração de Sistema

**Input do Usuário:**
```
/meta/analyze-complex-problem Analisar migração de Express para Fastify
```

**Documentação Gerada:**
- 📄 `docs/analysis/migration/analise-migracao-express-fastify-2025-10-15.md`
- Categorias analisadas:
  - Compatibilidade de middlewares
  - Diferenças de API
  - Performance esperada
  - Esforço de migração
  - Riscos e mitigações
- Plano de ação com 3 fases
- Estimativa total: 80h

---

### Exemplo 4: Análise de Conformidade de Segurança

**Input do Usuário:**
```
/meta/analyze-complex-problem Analisar conformidade de segurança para compliance SOC2
```

**Processo:**
1. Executar auditorias automatizadas
2. Revisar políticas de acesso
3. Verificar encryption at rest e in transit
4. Analisar logs e monitoring
5. Validar backup e disaster recovery

**Documento:**
- 📄 `docs/analysis/critical/analise-critica-seguranca-soc2-2025-10-15.md`
- Matriz de conformidade com controles SOC2
- Gaps identificados por categoria
- Roadmap de remediação

## Checklist de Validação

Após criar a análise, valide:

### Completude
- [ ] Todas as seções do template preenchidas (ou marcadas N/A)
- [ ] Resumo executivo com status claro (🟢🟡🔴)
- [ ] Pelo menos 3 categorias de análise detalhada
- [ ] Matriz de implementação completa
- [ ] Matriz de riscos completa
- [ ] Problemas categorizados por severity

### Qualidade de Dados
- [ ] Todas as afirmações têm evidências concretas
- [ ] Percentuais e métricas incluídas onde aplicável
- [ ] Referências específicas (arquivos, linhas, timestamps)
- [ ] Comandos de validação executáveis fornecidos
- [ ] Estimativas realistas e justificadas

### Acionabilidade
- [ ] Problemas têm soluções específicas (não vagas)
- [ ] Plano de ação com tasks atômicas
- [ ] Deadlines razoáveis definidos
- [ ] Responsáveis identificados (quando possível)
- [ ] Critérios de aceitação mensuráveis

### Comunicação
- [ ] Linguagem clara e objetiva
- [ ] Jargão técnico explicado quando necessário
- [ ] Estrutura visual clara (headers, tabelas, listas)
- [ ] Próximos passos inequívocos
- [ ] Conclusão resumida e acionável

### Integração
- [ ] TODO items criados para ações críticas
- [ ] Memórias atualizadas se padrões identificados
- [ ] Arquivo salvo em localização apropriada
- [ ] Nomenclatura consistente seguida
- [ ] Referências a documentos relacionados

## Comandos Relacionados

- `/meta/create-task-structure` - Para quebrar plano de ação em tasks menores
- `/development/refactor-code` - Para executar refactorings identificados
- `/testing/generate-test-suite` - Para criar testes faltantes identificados
- `/documentation/update-docs` - Para atualizar documentação após correções

## Dicas e Truques

### 💡 Dica 1: Use Web Search para Benchmarks
Quando analisar performance, busque benchmarks da indústria:
```
web_search "FastifyJS response time benchmark"
web_search "PostgreSQL query optimization best practices"
```

### 💡 Dica 2: Documente Premissas
Sempre documente premissas de estimativas:
```
Estimativa: 8h
Premissas:
- Desenvolvedor com experiência em OAuth
- Ambiente de teste já configurado
- Sem bloqueios de dependências externas
```

### 💡 Dica 3: Quantifique Impacto
Sempre que possível, quantifique impacto de problemas:
- ❌ "Performance está ruim"
- ✅ "Tempo de resposta: 3.2s (16x acima do target de 200ms), afetando 85% das requisições"

### 💡 Dica 4: Use Severity Consistentemente
Mantenha critérios de severity consistentes em toda análise:
- 🔴 CRÍTICO: Bloqueia produção OU causa data loss OU security breach
- 🟡 ALTO: Degrada experiência significativamente OU impede features importantes
- 🟢 MÉDIO: Melhorias desejáveis mas não urgentes

### 💡 Dica 5: Vincule com Issues/PRs
Se projeto usa GitHub/GitLab, referencie issues e PRs:
```markdown
#### Problema: Database Connection Pool Esgotado
- **Issue**: #456
- **PR relacionado**: #478 (tentativa anterior, revertida)
```

## Troubleshooting

### Problema: Template muito extenso para problema simples
**Solução**: Use template simplificado ou apenas seções relevantes. Marque outras como "N/A"

### Problema: Falta de métricas objetivas
**Solução**: Execute coleta de dados primeiro (logs, profiling, testes) antes de preencher template

### Problema: Muitos problemas identificados
**Solução**: Crie análise separada por subsistema ou divida em múltiplos documentos

### Problema: Stakeholders querem apenas resumo
**Solução**: Resumo executivo pode ser compartilhado separadamente. Documento completo para referência técnica.

### Problema: Análise se torna obsoleta rapidamente
**Solução**: Inclua "data de validade" e agende revisões regulares (ex: semanal para análises críticas)

## FAQ

**P: Quando usar análise completa vs análise simples?**  
R: Use análise completa para:
- Problemas que afetam produção
- Decisões arquiteturais importantes
- Conformidade e auditorias
- Migrações de sistema
- Qualquer problema que requeira plano de ação multi-fases

**P: Posso adaptar o template?**  
R: Sim, mas mantenha estrutura core (Resumo → Análise → Problemas → Plano). Adapte categorias ao contexto.

**P: Como lidar com informações sensíveis?**  
R: Sanitize dados sensíveis. Use exemplos fictícios. Mantenha versão completa em local seguro se necessário.

**P: Devo incluir código na análise?**  
R: Sim para snippets curtos ilustrativos. Para código extenso, referencie arquivos e linhas.

**P: Como priorizar quando tudo parece crítico?**  
R: Use matriz impacto × urgência:
- Alto impacto + Alta urgência = 🔴 CRÍTICO
- Alto impacto + Baixa urgência = 🟡 ALTO  
- Baixo impacto = 🟢 MÉDIO

---

## Resumo de Uso

**Sintaxe**:
```
/meta/analyze-complex-problem [descrição do problema ou sistema a analisar]
```

**O que acontece**:
1. Identifica contexto e tipo de análise
2. Coleta informações e evidências
3. Carrega template oficial
4. Preenche análise estruturada completa
5. Gera plano de ação executável
6. Salva documento em `docs/analysis/`
7. Cria TODOs para ações críticas

**Output**:
- Documento markdown completo e estruturado
- Evidências e métricas objetivas
- Plano de ação com estimativas
- Próximos passos claros

---

**Use este comando sempre que enfrentar problemas complexos que requerem análise sistemática e plano de ação estruturado!** 📊🔍


