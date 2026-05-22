---
title: "CodeBuddy"
source: "https://opensand.ai/en/docs/apps/codebuddy"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.134Z"
---
# CodeBuddy

> This page uses OpenSand API endpoints, setup scripts, and console field names. Third-party client interfaces may change by version, so use your installed version as the source of truth.


**Project Introduction**

**WorkBuddy / CodeBuddy** is an AI agent and coding assistant that manages available models via a local **JSON config file**. It talks to models through the standard OpenAI-compatible Chat Completions API, making it easy to point at OpenSand.

## 📦 Prerequisites

**What you'll need**

- WorkBuddy / CodeBuddy installed
- An OpenSand endpoint (must end with `/v1`)
- An OpenSand API key (generated in the console)
- A model ID exactly matching one exposed by your OpenSand console (e.g. `claude-sonnet-4-6`, `gemini-2.5-flash`)

## 🚀 Step 1: Edit the model config file

Find the local JSON model config (usually under your user directory). Add the OpenSand models:

```json
{
  "models": [
    {
      "id": "claude-sonnet-4-6",
      "name": "Claude Sonnet 4.6 (OpenSand)",
      "vendor": "OpenSand",
      "url": "https://opensand.ai/v1/chat/completions",
      "apiKey": "${OPENSAND_API_KEY}",
      "maxInputTokens": 200000,
      "maxOutputTokens": 8192,
      "supportsToolCall": true,
      "supportsImages": true
    },
    {
      "id": "gemini-2.5-flash",
      "name": "Gemini 2.5 Flash (OpenSand)",
      "vendor": "OpenSand",
      "url": "https://opensand.ai/v1/chat/completions",
      "apiKey": "${OPENSAND_API_KEY}",
      "maxInputTokens": 1000000,
      "maxOutputTokens": 8192,
      "supportsToolCall": true,
      "supportsImages": false
    }
  ],
  "availableModels": [
    "claude-sonnet-4-6",
    "gemini-2.5-flash"
  ]
}
```

**Field notes**

- `url` must be the **full Chat Completions endpoint** (including `/v1/chat/completions`)
- `id` must match the model ID exposed by your OpenSand console
- Adjust `maxInputTokens` / `maxOutputTokens` to the real capability of each model
- `availableModels` controls which models appear in the UI

## 🔑 Step 2: Set the API key environment variable

### Linux / macOS

```bash
```

### Windows (PowerShell)

```powershell
$env:OPENSAND_API_KEY="your-opensand-api-key"
```

Persist it in your shell profile (`~/.bashrc` / `~/.zshrc` / PowerShell Profile) so you don't have to re-export every session.

## ✅ Step 3: Verify

Launch WorkBuddy / CodeBuddy, pick an OpenSand model (e.g. `claude-sonnet-4-6`) from the model switcher, and send a test message:

```
Write a quicksort implementation in TypeScript.
```

A normal response means you're set.

## ❓ Troubleshooting

| Issue | Fix |
|------|----------|
| New model doesn't show in the picker | Check `availableModels` contains the ID and restart the app |
| 401 / Invalid API key | Confirm the env var is set and the process picked up the new value |
| `url must end with /chat/completions` | Use the full endpoint, **not** just `/v1` |
| Model not found | Make sure `id` exactly matches your OpenSand console |
| Output truncated | Raise `maxOutputTokens` |
