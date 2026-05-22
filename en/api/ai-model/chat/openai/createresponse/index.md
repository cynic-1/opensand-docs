---
title: "Responses"
source: "https://opensand.ai/en/docs/api/ai-model/chat/openai/createresponse"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.130Z"
---
# Responses

Create responses using the OpenAI Responses API format. Use it when your client expects the newer unified input format or reasoning-related options.

## Start Here

If you are new to APIs, think of a request as a structured message sent to OpenSand:

- **Endpoint** decides which capability you are using, such as chat, embeddings, images, or video.
- **API key** proves the request belongs to your account and must be sent in the `Authorization` header.
- **model** selects the actual model and must exactly match a model ID from the console or `/models`.
- **Request body** contains the task you want the model to perform.

## Endpoint

```text
POST /responses
```

Full request URL:

```text
https://opensand.ai/v1/responses
```

If a client only asks for Base URL, use:

```text
https://opensand.ai/v1
```

## Authentication

Use your OpenSand API key on every request:

```http
Authorization: Bearer sk-your-api-key
Content-Type: application/json
```

## When To Use It

Use it for newer OpenAI SDK integrations, applications that expect the `input` field, and projects standardizing on the Responses API.

## Common Request Body

- `model`: model ID.
- `input`: string or structured input.
- `stream`: return streaming output when enabled.
- `reasoning`: configure reasoning effort for supported models.
- `tools`: tool definitions, depending on model support.

## How To Fill the Body

Start with the smallest valid request, confirm it works, then add advanced parameters such as `temperature`, `stream`, tools, image size, or video options.

When editing JSON:

- Field names are case-sensitive, so `max_tokens` is not the same as `maxTokens`.
- JSON strings must use double quotes.
- If you copy an API key from the console, make sure there are no leading or trailing spaces.


## Example

```bash
curl https://opensand.ai/v1/responses \
  -H "Authorization: Bearer sk-your-api-key" \
  -H "Content-Type: application/json" \
  -d '{"model":"gpt-4o","input":"Write a three-bullet product summary"}'
```

## How To Know It Worked

- HTTP 200 usually means the request succeeded.
- A response containing `id`, `choices`, `data`, or task status fields means OpenSand accepted and processed the request.
- For streaming endpoints, the client receives multiple chunks until the stream ends.

## Common Errors

| Error | Meaning | Fix |
|---|---|---|
| 401 Unauthorized | Missing or invalid API key | Check `Authorization: Bearer sk-...` |
| 403 Forbidden | Account, group, or model permission issue | Check account status, model access, and quota |
| 404 Not Found | Wrong path or model | Check Base URL, endpoint path, and model ID |
| 429 Too Many Requests | Rate limit or quota limit | Reduce concurrency, retry later, or check quota |
| 500/502/503 | Temporary platform or upstream issue | Retry later and check request logs |

## Notes

- If your tool only supports Chat Completions, use `/chat/completions` instead.
- Responses and Chat Completions return different shapes. Do not reuse response parsers blindly.
