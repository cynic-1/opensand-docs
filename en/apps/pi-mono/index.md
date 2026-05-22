---
title: "Pi"
source: "https://opensand.ai/en/docs/apps/pi-mono"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.139Z"
---
# Pi

> This page uses OpenSand API endpoints, setup scripts, and console field names. Third-party client interfaces may change by version, so use your installed version as the source of truth.


**Project Introduction**

**Pi** (pi-mono) is a minimal, highly extensible terminal coding framework. It ships with TypeScript extensions, skills, prompt templates, themes, a tree-structured session model, and **15+ built-in providers**. Adding OpenSand as a custom OpenAI-compatible provider is a single config edit away.

- GitHub: [https://github.com/can1357/pi-mono](https://github.com/can1357/pi-mono)

## 📦 Prerequisites

**What you'll need**

- Pi (pi-mono) installed
- An OpenSand endpoint (use `https://opensand.ai/v1` as usual)
- An OpenSand API key (generated in the console)
- A model ID exactly matching one exposed by your OpenSand console (e.g. `claude-sonnet-4-6`, `gemini-2.5-flash`)

## 🔑 Step 1: Set the API key env var

```bash
```

## 🔧 Step 2: Edit the Pi config file

Add OpenSand as a provider in Pi's config file:

```json
{
  "providers": {
    "opensand": {
      "baseUrl": "https://opensand.ai/v1",
      "api": "openai-completions",
      "apiKey": "$OPENSAND_API_KEY",
      "models": [
        {
          "id": "claude-sonnet-4-6",
          "name": "Claude Sonnet 4.6",
          "contextWindow": 200000,
          "maxTokens": 128000,
          "input": ["text"],
          "reasoning": true,
          "compat": {
            "requiresReasoningContentOnAssistantMessages": true,
            "thinkingFormat": "anthropic",
            "reasoningEffortMap": {
              "minimal": "low",
              "low": "low",
              "medium": "medium",
              "high": "high",
              "xhigh": "max"
            }
          }
        },
        {
          "id": "gemini-2.5-flash",
          "name": "Gemini 2.5 Flash",
          "contextWindow": 1000000,
          "maxTokens": 65536,
          "input": ["text"],
          "reasoning": false
        }
      ]
    }
  }
}
```

**Field notes**

- `baseUrl` uses the standard OpenSand endpoint `https://opensand.ai/v1`
- `api` is always `openai-completions`
- `apiKey` uses the `$OPENSAND_API_KEY` variable reference
- `compat.requiresReasoningContentOnAssistantMessages: true` keeps reasoning content on historical messages when thinking mode is active
- `reasoningEffortMap` maps Pi's effort levels to the target model's supported levels; you can omit this block for non-reasoning models

## ✅ Step 3: Launch & verify

Launch Pi, pick **opensand** in the provider selector, then pick a model. Send a test message — a normal response means you're set.

## ❓ Troubleshooting

| Issue | Fix |
|------|----------|
| opensand not in the provider list | Check the config file path and JSON format |
| 401 Unauthorized | Make sure `OPENSAND_API_KEY` is exported in the current shell |
| Reasoning model acts weird | Verify `requiresReasoningContentOnAssistantMessages` and `thinkingFormat` match the model |
| Model not found | Confirm `models[].id` matches your OpenSand console |
