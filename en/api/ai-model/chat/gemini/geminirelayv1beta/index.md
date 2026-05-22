---
title: "Gemini Text Chat"
source: "https://opensand.ai/en/docs/api/ai-model/chat/gemini/geminirelayv1beta"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.131Z"
---
# Gemini Text Chat

OpenSand can provide a Gemini-compatible entry point for clients that require the Gemini protocol. Use this page only when your tool explicitly expects Gemini API formatting.

## Common Uses

- Use Gemini-family models for text or multimodal chat.
- Connect third-party tools that only support Gemini API paths.

## Configuration Notes

- API key: use a key created in the OpenSand console.
- Model name: use the OpenSand console or model list as the source of truth.
- Base URL: follow the client requirement; if it supports OpenAI-compatible APIs, prefer `https://opensand.ai/v1`.

## Beginner Advice

Gemini protocol settings vary across clients. If you only need chat, coding, or a normal agent integration, prefer OpenAI-compatible mode. Use Gemini-compatible settings only when the tool explicitly asks for a Gemini API key or Gemini endpoint.

When troubleshooting, confirm:

1. Whether the tool expects Gemini or OpenAI protocol.
2. Whether the model ID comes from the OpenSand console.
3. Whether the Base URL matches the tool's expectation.

## Recommendation

If your tool supports OpenAI-compatible APIs, prefer [Chat Completions](/en/docs/api/ai-model/chat/openai/createchatcompletion). It is simpler to configure and easier to troubleshoot.
