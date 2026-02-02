# Azure OpenAI Code Patterns

Quick-start code patterns for Azure OpenAI integration in hackathons.

## Pattern 1: Basic Chat Completion

```python
import os
from openai import AzureOpenAI

# Initialize client
client = AzureOpenAI(
    azure_endpoint=os.getenv("AZURE_OPENAI_ENDPOINT"),
    api_key=os.getenv("AZURE_OPENAI_KEY"),
    api_version="2024-02-01"
)

# Simple chat
response = client.chat.completions.create(
    model="gpt-4",
    messages=[
        {"role": "system", "content": "You are a helpful AI assistant."},
        {"role": "user", "content": "Explain machine learning in simple terms."}
    ],
    temperature=0.7,
    max_tokens=500
)

print(response.choices[0].message.content)
```

## Pattern 2: Streaming Responses

```python
response = client.chat.completions.create(
    model="gpt-4",
    messages=[{"role": "user", "content": "Write a story about AI"}],
    stream=True
)

for chunk in response:
    if chunk.choices[0].delta.content:
        print(chunk.choices[0].delta.content, end="", flush=True)
```

## Pattern 3: Function Calling

```python
functions = [{
    "name": "get_weather",
    "description": "Get current weather for a location",
    "parameters": {
        "type": "object",
        "properties": {
            "location": {"type": "string", "description": "City name"},
            "unit": {"type": "string", "enum": ["celsius", "fahrenheit"]}
        },
        "required": ["location"]
    }
}]

response = client.chat.completions.create(
    model="gpt-4",
    messages=[{"role": "user", "content": "What's the weather in Sydney?"}],
    functions=functions,
    function_call="auto"
)

# Check if function was called
if response.choices[0].message.function_call:
    function_name = response.choices[0].message.function_call.name
    arguments = json.loads(response.choices[0].message.function_call.arguments)
    print(f"Function: {function_name}, Args: {arguments}")
```

## Pattern 4: Embeddings for Semantic Search

```python
# Generate embeddings
text = "Azure OpenAI provides powerful language models"
response = client.embeddings.create(
    model="text-embedding-ada-002",
    input=text
)

embedding = response.data[0].embedding  # 1536-dimensional vector

# Use for similarity search
from sklearn.metrics.pairwise import cosine_similarity
similarity = cosine_similarity([embedding1], [embedding2])[0][0]
```

## Pattern 5: Error Handling & Retries

```python
from tenacity import retry, stop_after_attempt, wait_exponential

@retry(stop=stop_after_attempt(3), wait=wait_exponential(min=1, max=10))
def call_openai_with_retry(prompt):
    try:
        response = client.chat.completions.create(
            model="gpt-4",
            messages=[{"role": "user", "content": prompt}],
            timeout=30
        )
        return response.choices[0].message.content
    except Exception as e:
        print(f"Error: {e}")
        raise

result = call_openai_with_retry("Your prompt here")
```

## Pattern 6: Token Counting

```python
import tiktoken

def count_tokens(text, model="gpt-4"):
    encoding = tiktoken.encoding_for_model(model)
    return len(encoding.encode(text))

# Check before calling API
prompt = "Your long prompt here..."
token_count = count_tokens(prompt)
print(f"Tokens: {token_count}")

if token_count > 4000:
    print("⚠️ Prompt too long, consider truncating")
```

## Pattern 7: Batch Processing

```python
import asyncio
from openai import AsyncAzureOpenAI

async_client = AsyncAzureOpenAI(
    azure_endpoint=os.getenv("AZURE_OPENAI_ENDPOINT"),
    api_key=os.getenv("AZURE_OPENAI_KEY"),
    api_version="2024-02-01"
)

async def process_item(item):
    response = await async_client.chat.completions.create(
        model="gpt-4",
        messages=[{"role": "user", "content": f"Analyze: {item}"}]
    )
    return response.choices[0].message.content

async def process_batch(items):
    tasks = [process_item(item) for item in items]
    return await asyncio.gather(*tasks)

# Process 100 items in parallel
items = ["item1", "item2", ...]
results = asyncio.run(process_batch(items))
```

## Pattern 8: Cost Tracking

```python
PRICING = {
    "gpt-4": {"input": 0.03, "output": 0.06},  # per 1K tokens
    "gpt-35-turbo": {"input": 0.0015, "output": 0.002}
}

def calculate_cost(model, input_tokens, output_tokens):
    rates = PRICING[model]
    cost = (input_tokens / 1000 * rates["input"]) + \
           (output_tokens / 1000 * rates["output"])
    return round(cost, 4)

# Track usage
response = client.chat.completions.create(...)
usage = response.usage
cost = calculate_cost("gpt-4", usage.prompt_tokens, usage.completion_tokens)
print(f"Cost: ${cost}")
```

## Quick Tips

- Always set `max_tokens` to control costs
- Use `temperature=0` for deterministic outputs
- Enable `stream=True` for better UX
- Cache embeddings to reduce API calls
- Monitor rate limits (check headers)
