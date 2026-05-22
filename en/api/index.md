---
title: "API Docs"
source: "https://opensand.ai/en/docs/api"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.128Z"
---
# API Docs

OpenSand exposes OpenAI-compatible APIs and selected native model protocols. Most applications only need the OpenAI-compatible APIs.

## Basics

| Item | Value |
|---|---|
| Base URL | `https://opensand.ai/v1` |
| Authentication | `Authorization: Bearer sk-your-api-key` |
| Request format | JSON, except upload endpoints such as image edits |

## What a Minimal Request Looks Like

Most OpenAI-compatible requests have three parts:

1. Request URL, such as `https://opensand.ai/v1/chat/completions`.
2. Headers, including API key and content type.
3. Body, including model name and input.

```bash
curl https://opensand.ai/v1/chat/completions \
  -H "Authorization: Bearer sk-your-api-key" \
  -H "Content-Type: application/json" \
  -d '{"model":"gpt-4o","messages":[{"role":"user","content":"Hello"}]}'
```

When using an SDK, you usually only need to set `base_url` to `https://opensand.ai/v1`.

## Recommended Reading Order

1. [Model List](/en/docs/api/ai-model/models/list/listmodels)
2. [Chat Completions](/en/docs/api/ai-model/chat/openai/createchatcompletion)
3. [Responses](/en/docs/api/ai-model/chat/openai/createresponse)
4. [Claude Messages](/en/docs/api/ai-model/chat/createmessage)
5. [Embeddings](/en/docs/api/ai-model/embeddings/openai/createembedding)
6. [Image Generation](/en/docs/api/ai-model/images/openai/post-v1-images-generations)

## Which Endpoint Should I Use?

| Need | Endpoint |
|---|---|
| Chat, agents, OpenAI SDK | `/chat/completions` |
| Newer OpenAI Responses clients | `/responses` |
| Native Claude protocol tools | `/messages` |
| Semantic search and RAG | `/embeddings` |
| Image generation | `/images/generations` |
| Video generation | `/video/generations` |

## Debugging Tips

- Always call `/models` first to confirm the key works and copy the correct model ID.
- Then send a minimal `/chat/completions` request.
- Add SDKs, clients, streaming, tools, or complex parameters after the minimal request works.
- Avoid debugging streaming, tool calling, long context, and advanced models all at once.
