---
title: "Gemini Model List"
source: "https://opensand.ai/en/docs/api/ai-model/models/list/listmodelsgemini"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.130Z"
---
# Gemini Model List

Review Gemini-compatible models available through OpenSand. Most users can use the general `/models` endpoint.

## Start Here

If you are new to APIs, think of a request as a structured message sent to OpenSand:

- **Endpoint** decides which capability you are using, such as chat, embeddings, images, or video.
- **API key** proves the request belongs to your account and must be sent in the `Authorization` header.
- **model** selects the actual model and must exactly match a model ID from the console or `/models`.
- **Request body** contains the task you want the model to perform.

## Endpoint

```text
GET /models
```

Full request URL:

```text
https://opensand.ai/v1/models
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

Use it when configuring Gemini-protocol clients or checking whether Gemini-family models are enabled.

## Common Request Body

GET requests do not require a request body.

## Request Body

This is a GET endpoint and does not require a request body. Send the correct `Authorization` header.


## Example

```bash
curl https://opensand.ai/v1/models \
  -H "Authorization: Bearer sk-your-api-key"
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

- Some Gemini-protocol tools may ask for the site URL without `/v1`; follow the tool-specific guide.
- Model IDs still come from the OpenSand console and `/models`.
