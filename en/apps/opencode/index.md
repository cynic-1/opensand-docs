---
title: "OpenCode"
source: "https://opensand.ai/en/docs/apps/opencode"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.139Z"
---
# OpenCode

> This page uses OpenSand API endpoints, setup scripts, and console field names. Third-party client interfaces may change by version, so use your installed version as the source of truth.


**Project Introduction**

**OpenCode** is an open-source terminal AI coding agent with both TUI and CLI modes. It's compatible with **75+ AI service providers** and, via its built-in `@ai-sdk/anthropic` and `@ai-sdk/openai-compatible` adapters, can seamlessly connect to both Anthropic-protocol models and OpenAI-compatible models served by OpenSand.

- Website: [https://opencode.ai](https://opencode.ai)
- GitHub: [https://github.com/opencode-ai/opencode](https://github.com/opencode-ai/opencode)

## 📦 Prerequisites

**What you'll need**

- OpenCode installed
- An OpenSand endpoint (must end with `/v1`)
- An OpenSand API key (generated in the console)
- A model ID exactly matching one exposed by your OpenSand console (e.g. `claude-sonnet-4-6`, `claude-haiku-4-5`, `deepseek-v4-pro`, `gpt-5.5`)

## 🚀 Option 1: Interactive menu (recommended for new users)

Add OpenSand directly from the OpenCode TUI:

1. Launch the OpenCode TUI
2. Type `/connect`
3. In the provider list, choose **"Other"** (custom endpoint)
4. Fill in:
   - **Base URL**: `https://opensand.ai/v1`
   - **API Key**: your OpenSand API key
5. After saving, type `/models` and switch to the newly added model

## 🔧 Option 2: Config file (recommended for regular use)

Good for pinning multiple models and reusing across projects.

### 1. Edit OpenCode config

File location:

- **Global**: `~/.config/opencode/opencode.json`
- **Per-project** (takes precedence): `opencode.json` in your project root

```json
{
  "$schema": "https://opencode.ai/config.json",
  "provider": {
    "opensand-anthropic": {
      "npm": "@ai-sdk/anthropic",
      "name": "OpenSand (Anthropic)",
      "options": {
        "baseURL": "https://opensand.ai/v1",
        "apiKey": "sk-123"
      },
      "models": {
        "claude-sonnet-4-6": {
          "name": "Claude Sonnet 4.6",
          "limit": { "context": 200000, "output": 8192 }
        },
        "haiku": {
          "id": "claude-haiku-4-5",
          "name": "Claude Haiku 4.5 (fast)",
          "limit": { "context": 200000, "output": 8192 }
        }
      }
    },
    "opensand": {
      "npm": "@ai-sdk/openai-compatible",
      "name": "OpenSand",
      "options": {
        "baseURL": "https://opensand.ai/v1",
        "apiKey": "sk-123"
      },
      "models": {
        "deepseek-v4-flash": {
          "name": "DeepSeek V4 Flash",
          "limit": { "context": 131072, "output": 16384 }
        },
        "deepseek-v4-pro": {
          "name": "DeepSeek V4 Pro",
          "limit": { "context": 131072, "output": 16384 }
        },
        "gpt-5.5": {
          "name": "GPT-5.5",
          "limit": { "context": 128000, "output": 32768 }
        },
        "gpt-5.4": {
          "name": "GPT-5.4",
          "limit": { "context": 128000, "output": 32768 }
        },
        "gpt-5.4-mini": {
          "name": "GPT-5.4 Mini",
          "limit": { "context": 128000, "output": 16384 }
        }
      }
    }
  },
  "model": "opensand-anthropic/claude-sonnet-4-6",
  "autoshare": false
}
```

**Key fields**

- The example declares two providers:
  - `opensand-anthropic`: `npm` **must** be `@ai-sdk/anthropic` — use this for Claude and other Anthropic-protocol models
  - `opensand`: `npm` **must** be `@ai-sdk/openai-compatible` — use this for DeepSeek, GPT, and other OpenAI-compatible models
- Both providers share the same `baseURL`: `https://opensand.ai/v1`
- `apiKey` is embedded directly in the config file — replace `sk-123` with your real OpenSand API key (the example value is a placeholder)
- Model IDs under `models` must exactly match the model names exposed by your OpenSand console. You can use a custom alias by adding an `id` field pointing to the real model (see `haiku` → `claude-haiku-4-5` in the example)
- The top-level `model` field sets the default model in the form `<provider>/<model>`
- Per-project `opencode.json` takes precedence over the global config

### 2. Configure the API key

The example above already embeds the API key directly in `opencode.json` via `options.apiKey`. Just replace `sk-123` with your real OpenSand key — no extra step required.

**Optional: manage keys via auth.json**

If you'd rather not store the API key in `opencode.json`, remove the `apiKey` field from the config and edit `~/.local/share/opencode/auth.json` instead:

```json
{
  "opensand-anthropic": {
    "type": "api",
    "key": "sk-your-opensand-key"
  },
  "opensand": {
    "type": "api",
    "key": "sk-your-opensand-key"
  }
}
```

Or use the CLI:

```bash
opencode auth login
```

Pick `opensand-anthropic` and/or `opensand` when prompted and paste your API key.

## ✅ Step 3: Verify

Launch OpenCode and type `/models`. You should see entries like `opensand-anthropic/claude-sonnet-4-6` and `opensand/deepseek-v4-pro`. Pick a model and send a test message — a normal response means you're set.

## ❓ Troubleshooting

| Issue | Fix |
|------|----------|
| OpenSand models don't show in `/models` | Check that `provider.opensand-anthropic.models` or `provider.opensand.models` is populated |
| Model not found | Confirm the model ID matches your OpenSand console exactly |
| Invalid API key | Verify `apiKey` in `opencode.json` or your `auth.json`; or re-run `opencode auth login` |
| Claude models return protocol errors | Make sure you're calling the `opensand-anthropic` provider (`@ai-sdk/anthropic`), not `opensand` (`@ai-sdk/openai-compatible`) |
| Config changes not picked up | Restart OpenCode; per-project config wins over global |
