---
title: "Quick Start"
source: "https://opensand.ai/en/docs/guide/quick-start"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.128Z"
---
# Quick Start

This guide helps you create an API key, make your first request, and configure common tools.

## Understand Three Concepts First

| Concept | Meaning | Common Field Names |
|---|---|---|
| API Key | Your credential, usually starting with `sk-` | API Key, Token, Secret |
| Base URL | The OpenSand API entry point | Base URL, API Address, Endpoint |
| Model | The model you want to call | Model, Model ID, Deployment |

Most OpenAI-compatible tools only need these three values:

```text
Base URL: https://opensand.ai/v1
API Key: sk-your-api-key
Model: query the console or /v1/models
```

## 1. Create an API Key

1. Open [https://opensand.ai](https://opensand.ai) and sign in.
2. Go to API tokens in the console.
3. Create a new token, copy it, and store it safely.

API keys are usually shown only once. If a key is exposed, delete it and create a new one.

Create separate keys for separate uses:

- One key for desktop chat tools.
- One key for coding tools.
- One key for automation scripts.

This makes logs and cost tracking much easier later.

## 2. Make Your First Chat Request

```bash
curl https://opensand.ai/v1/chat/completions \
  -H "Authorization: Bearer sk-your-api-key" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-4o",
    "messages": [
      {"role": "user", "content": "Introduce OpenSand in one sentence"}
    ]
  }'
```

## 3. Use the Python SDK

```python
from openai import OpenAI

client = OpenAI(
    base_url="https://opensand.ai/v1",
    api_key="sk-your-api-key",
)

response = client.chat.completions.create(
    model="gpt-4o",
    messages=[{"role": "user", "content": "Hello"}],
)

print(response.choices[0].message.content)
```

## 4. List Models

```bash
curl https://opensand.ai/v1/models \
  -H "Authorization: Bearer sk-your-api-key"
```

Use the returned `id` as the model name in requests.

If this step succeeds, your API key, Base URL, and account status are working. If a specific client still fails, the issue is usually in that client's settings.

## 5. Configure Tools

For tools that support OpenAI Compatible, Custom Endpoint, or custom Base URL:

| Field | Value |
|---|---|
| Base URL | `https://opensand.ai/v1` |
| API Key | Your OpenSand API key |
| Model | A model ID returned by the console or `/v1/models` |

Next, see [App Integrations](/en/docs/apps).

## Common Errors

| Error | Likely Cause | Fix |
|---|---|---|
| 401 Unauthorized | Wrong, expired, or missing API key | Copy the key again and check `Authorization: Bearer sk-...` |
| 403 Forbidden | Account, quota, group, or model permission issue | Check balance, token status, and model access |
| model not found | Wrong model name | Call `/v1/models` and copy the returned `id` |
| connection error | Wrong Base URL | Most tools should use `https://opensand.ai/v1` |
| empty response | Model error or client parser issue | Try another model and check request logs |

## Next Steps

- For code integration, see [API Docs](/en/docs/api).
- For client setup, see [App Integrations](/en/docs/apps).
- For usage cost, see [Pricing and Usage](/en/docs/guide/pricing).
