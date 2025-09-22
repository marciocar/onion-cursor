
Este é um projeto de documentação para vários projetos open source da nossa organização. A ideia para este repositório é ser a especificação única que dirige todas as outras specs, código, design e artefatos de teste. É nossa fonte canônica da verdade para todos os nossos projetos.

Cada projeto tem sua própria pasta sob a pasta @/projects/.
Dentro de cada uma dessas pastas, há um arquivo index.md que aponta para todos os outros recursos úteis no projeto.

## Usage

### /build-index

Se nenhum argumento for fornecido, o comando construirá o arquivo index.md de projetos raiz sob a pasta @/projects/
Este índice deve fornecer informações básicas sobre cada projeto, como:

- nome com link para sua pasta
- descrição curta
- id do space ClickUp
- id do workspace ClickUp
- url do repositório

Esta informação está facilmente disponível dentro dos arquivos principais dos projetos (seja index.md ou 2-project_management.md)

Não adicione nada além das informações acima.


### /build-index <project-name>

Isto é usado para reconstruir o índice do projeto após mudarmos a estrutura de diretórios e arquivos.
Por favor, percorra a estrutura de pastas do projeto, entenda quais arquivos e pastas estão lá e refine o arquivo index.md para o projeto. Se o projeto não tiver um arquivo index.md, crie um. Se tiver, edite-o para refletir a estrutura atual.

O índice deve apontar para todos os outros recursos úteis na pasta do projeto.

Argumentos fornecidos: #$ARGUMENTS
