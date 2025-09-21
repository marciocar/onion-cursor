# Contexto: Tradução Completa dos Documentos .cursor

## Visão Geral
Traduzir TODOS os documentos Markdown na estrutura `.cursor/` para PT-BR, mantendo consistência entre explicações em português e elementos técnicos em inglês.

## Objetivos
- **Primário**: Traduzir todos os textos explicativos, comentários e instruções para PT-BR
- **Secundário**: Manter códigos, variáveis, caminhos, comandos e estruturas técnicas em inglês
- **Qualidade**: Garantir consistência terminológica em todo o sistema

## Escopo Identificado

### .cursor/agents/ (12 arquivos)
- branch-code-reviewer.md
- branch-documentation-writer.md  
- branch-metaspec-checker.md
- branch-test-planner.md
- code-reviewer.md
- metaspec-gate-keeper.md
- product-agent.md
- python-developer.md
- react-developer.md
- research-agent.md
- test-engineer.md
- test-planner.md

### .cursor/commands/ (estrutura hierárquica)
- all-tools.md
- warm-up.md
- common/prompts/ (README.md, technical.md)
- common/templates/ (2 templates)
- docs/ (4 arquivos)
- engineer/ (8 arquivos) ✅ **JÁ CONCLUÍDO**
- meta/ (create-agent.md)
- product/ (6 arquivos)

## Restrições
- **NÃO alterar**: Códigos, variáveis, paths, comandos, estruturas JSON/YAML
- **NÃO alterar**: Nomes de arquivos, pastas ou referências técnicas
- **MANTER**: Formatação Markdown, estrutura de documentos
- **PRESERVAR**: Funcionalidade dos comandos e agentes

## Critérios de Sucesso
1. Todos os textos explicativos em PT-BR fluente
2. Elementos técnicos preservados em inglês
3. Terminologia consistente em todo o sistema
4. Funcionalidade mantida 100%
5. Estrutura e formatação preservadas

## Dependências
- Acesso de leitura/escrita aos arquivos .cursor/
- Conhecimento dos padrões de terminologia do projeto
- Validação manual da funcionalidade após tradução

## Contexto Técnico
Este é um sistema de comandos e agentes para desenvolvimento, baseado no padrão Cursor IDE. A tradução deve manter a funcionalidade while providenciando melhor experiência para desenvolvedores brasileiros.
