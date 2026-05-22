---
title: "Crush"
source: "https://opensand.ai/en/docs/apps/crush"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.135Z"
---
# Crush

> This page uses OpenSand API endpoints, setup scripts, and console field names. Third-party client interfaces may change by version, so use your installed version as the source of truth.


**Project Introduction**

**Crush** is an open-source AI coding agent by [Charm](https://charm.sh), running inside your terminal. It supports multi-model switching, LSP integration, MCP servers and agentic coding workflows — and ships with a polished, responsive TUI.

- GitHub: [https://github.com/charmbracelet/crush](https://github.com/charmbracelet/crush)

## 📦 Prerequisites

**What you'll need**

- [Node.js](https://nodejs.org/en/download/) installed
- An OpenSand endpoint (must end with `/v1`)
- An OpenSand API key (generated in the console)
- A model ID exactly matching one exposed by your OpenSand console (e.g. `claude-sonnet-4-6`, `gemini-2.5-flash`)

## 🚀 Step 1: Install Crush

```bash
npm install -g @charmland/crush
```

macOS users can also install via Homebrew:

```bash
brew install charmbracelet/tap/crush
```

Verify:

```bash
crush --version
```

## 🔧 Step 2: Edit the config file

Config file location:

- **Linux / macOS**: `~/.config/crush/crush.json`
- **Windows**: `%USERPROFILE%\.config\crush\crush.json`

Create it if it doesn't exist, and paste in:

```json
{
  "$schema": "https://charm.land/crush.json",
  "providers": {
    "opensand": {
      "type": "openai-compat",
      "base_url": "https://opensand.ai/v1",
      "api_key": "$OPENSAND_API_KEY",
      "models": [
        {
          "id": "claude-sonnet-4-6",
          "name": "Claude Sonnet 4.6",
          "context_window": 200000,
          "default_max_tokens": 32768,
          "can_reason": true
        },
        {
          "id": "gemini-2.5-flash",
          "name": "Gemini 2.5 Flash",
          "context_window": 1000000,
          "default_max_tokens": 32768,
          "can_reason": false
        }
      ]
    }
  }
}
```

**Field notes**

- `type` must be `openai-compat`
- `base_url` must end with `/v1`
- `api_key` uses the `$OPENSAND_API_KEY` variable reference so you don't commit the key
- `models[].id` must exactly match your OpenSand console

## 🔑 Step 3: Set the API key env var

### Linux / macOS

```bash
```

### Windows (PowerShell)

```powershell
$env:OPENSAND_API_KEY="your-opensand-api-key"
```

Persist it in your shell profile for convenience.

## ✅ Step 4: Launch & pick a model

```bash
cd /path/to/my-project
crush
```

Press `Ctrl+L` (or type `/model`) to open the model switcher. Choose the **opensand** provider, then pick your target model. Send a test message to verify.

## ❓ Troubleshooting

| Issue | Fix |
|------|----------|
| opensand doesn't appear in the model switcher | Check the path and JSON format of `crush.json` |
| 401 Unauthorized | Make sure `OPENSAND_API_KEY` is exported in the current shell |
| Model not found | Confirm `models[].id` matches your OpenSand console |
| Config changes don't apply | Restart Crush |
