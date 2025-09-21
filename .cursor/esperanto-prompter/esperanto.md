Esperanto é uma biblioteca para interagir com múltiplos provedores de modelos de IA através de uma interface comum

## Como Funciona

```python
from esperanto import AIFactory

# Primeira chamada - cria nova instância do modelo
model1 = AIFactory.create_language("openai", "gpt-4", {"temperature": 0.7})

# Segunda chamada com mesma config - retorna instância cached (instantâneo!)
model2 = AIFactory.create_language("openai", "gpt-4", temperature=0.7)

# São exatamente o mesmo objeto
assert model1 is model2  # True!

# Configuração diferente - cria nova instância
model3 = AIFactory.create_language("openai", "gpt-4", temperature=0.9)
assert model1 is not model3  # True - configuração diferente
```

```python
# Criar instâncias de modelo
model = AIFactory.create_language(
    "openai", 
    "gpt-3.5-turbo",
    structured={"type": "json"}
)  # Modelo de linguagem

messages = [
    {"role": "system", "content": "You are a helpful assistant."},
    {"role": "user", "content": "What's the capital of France?"},
]
response = model.chat_complete(messages)
print(response.content)

embedder = AIFactory.create_embedding("openai", "text-embedding-3-small")  # Modelo de embedding
texts = ["Hello, world!", "Another text"]
# Uso síncrono
embeddings = embedder.embed(texts)
# Uso assíncrono
embeddings = await embedder.aembed(texts)

transcriber = AIFactory.create_speech_to_text("openai", "whisper-1")  # Modelo speech-to-text
transcriber.transcribe(path_to_file)

speaker = AIFactory.create_text_to_speech("openai", "tts-1")  # Modelo text-to-speech
response = speaker.generate_speech(
    text="This audio will be processed further",
    voice="shimmer"
)
```

## Respostas Padronizadas
Todos os provedores no Esperanto retornam objetos de resposta padronizados, facilitando trabalhar com diferentes modelos sem alterar seu código.

```python
Respostas LLM
from esperanto import AIFactory

model = AIFactory.create_language(
    "openai", 
    "gpt-3.5-turbo",
    structured={"type": "json"}
)
messages = [{"role": "user", "content": "Hello!"}]

# Todas as respostas LLM seguem esta estrutura
response = model.chat_complete(messages)
print(response.choices[0].message.content)  # O texto da resposta real
print(response.choices[0].message.role)     # 'assistant'
print(response.model)                       # O modelo usado
print(response.usage.total_tokens)          # Informação de uso de tokens
print(response.content)          # Atalho para response.choices[0].message.content

# Para respostas streaming
for chunk in model.chat_complete(messages):
    print(chunk.choices[0].delta.content, end="", flush=True)

# Streaming assíncrono
async for chunk in model.achat_complete(messages):
    print(chunk.choices[0].delta.content, end="", flush=True)
Respostas de Embedding
from esperanto import AIFactory

model = AIFactory.create_embedding("openai", "text-embedding-3-small")
texts = ["Hello, world!", "Another text"]

# Todas as respostas de embedding seguem esta estrutura
response = model.embed(texts)
print(response.data[0].embedding)     # Vetor para o primeiro texto
print(response.data[0].index)         # Índice do texto (0)
print(response.model)                 # O modelo usado
print(response.usage.total_tokens)    # Informação de uso de tokens
```
