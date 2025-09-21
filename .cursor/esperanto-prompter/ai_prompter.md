
AI Prompter (pip install ai-prompter) é uma biblioteca Python simples de usar, baseada em jinja, para criar prompts para interagir com modelos LLM.
A melhor prática é manter uma pasta prompts com os arquivos jinja para facilitar manutenção e controle de versão.

## Usando arquivo jinja baseado em arquivo (preferível)

```python
from ai_prompter import Prompter

# Inicializar com um nome de template
# Este exemplo assume que existe um arquivo prompts/my_template.jinja
prompter = Prompter(prompt_template='my_template')

# Renderizar um prompt com variáveis
prompt = prompter.render({'variable': 'value'})
print(prompt)
```

## Usando Templates de Texto Bruto

```python
from ai_prompter import Prompter

**Usando parâmetro template_text**
prompter = Prompter(template_text="Hello, {{ name }}!")
result = prompter.render({"name": "World"})
print(result)  # Output: Hello, World!

**Usando método de classe from_text**
prompter = Prompter.from_text("Hi, {{ person }}!", model="gpt-4")
result = prompter.render({"person": "Alice"})
print(result)  # Output: Hi, Alice!
template = """Write an article about {{ topic }}."""
prompter = Prompter(template_text=template)
prompt = prompter.render({"topic": "AI"})
print(prompt)  # Write an article about AI.
```

## Integração com LangChain
Você pode converter prompts para o formato ChatPromptTemplate do LangChain para uso em workflows do LangChain. 
Isto funciona tanto para templates baseados em texto quanto baseados em arquivo.

```python
from ai_prompter import Prompter

# Com template baseado em texto
text_prompter = Prompter(template_text="Hello, {{ name }}!")
lc_text_prompt = text_prompter.to_langchain()

# Com template baseado em arquivo
file_prompter = Prompter(prompt_template="greet")
lc_file_prompt = file_prompter.to_langchain()
```

## Incluindo Outros Templates
Você pode incluir outros arquivos de template dentro de um template usando a diretiva {% include %} do Jinja2. Isto permite construir templates modulares.

```jinja
# outer.jinja
This is the outer file

{% include 'inner.jinja' %}

This is the end of the outer file
# inner.jinja
This is the inner file

{% if type == 'a' %}
    You selected A
{% else %}
    You didn't select A
{% endif %}
```

## Usando Variáveis
Templates podem usar variáveis que você passa através do método render(). Você pode usar filtros e condicionais do Jinja2 para controlar a saída baseada nos seus dados.

```python
from ai_prompter import Prompter

prompter = Prompter(prompt_text="Hello {{name|default('Guest')}}!")
prompt = prompter.render()  # Nenhum dado fornecido, usa padrão
print(prompt)  # Hello Guest!
prompt = prompter.render({"name": "Alice"})  # Dados fornecidos
print(prompt)  # Hello Alice!
```

Você também pode usar ifs e for loops do Jinja. 

A biblioteca também fornece automaticamente uma variável current_time com o timestamp atual no formato "YYYY-MM-DD HH:MM:SS".

prompter = Prompter(template_text="Current time: {{current_time}}")
prompt = prompter.render()
print(prompt)  # Current time: 2025-04-19 23:28:00