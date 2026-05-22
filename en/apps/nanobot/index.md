---
title: "nanobot"
source: "https://opensand.ai/en/docs/apps/nanobot"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.138Z"
---
# nanobot

> This page uses OpenSand API endpoints, setup scripts, and console field names. Third-party client interfaces may change by version, so use your installed version as the source of truth.


**Project Introduction**

**nanobot** is a lightweight AI agent that plugs into common chat tools. Configuration lives in a single `config.json`, so pointing it at OpenSand is a two-line change. It relies on [uv](https://github.com/astral-sh/uv) for Python environment management, keeping install and launch simple.

## 📦 Prerequisites

**What you'll need**

- [uv](https://github.com/astral-sh/uv) installed
- An OpenSand endpoint (must end with `/v1`)
- An OpenSand API key (generated in the console)
- A model ID exactly matching one exposed by your OpenSand console (e.g. `claude-sonnet-4-6`, `gemini-2.5-flash`)

## 🚀 Step 1: Install nanobot

```bash
uv tool install nanobot-ai
```

### Extra step for Windows

Add `.local/bin` to your PATH so the `nanobot` command is directly callable:

```powershell
$env:PATH = "$env:USERPROFILE\.local\bin;$env:PATH"
```

Consider persisting it in your PowerShell Profile.

### Verify

```bash
nanobot --version
```

## 🔧 Step 2: Initialise & edit config

### 1. Generate the default config

```bash
nanobot onboard
```

The config file is created at:

- **Windows**: `%USERPROFILE%\.nanobot\config.json`
- **Linux / macOS**: `~/.nanobot/config.json`

### 2. Edit `config.json`

Set `providers` and `agents.defaults` to point at OpenSand:

```json
{
  "agents": {
    "defaults": {
      "model": "claude-sonnet-4-6",
      "provider": "opensand"
    }
  },
  "providers": {
    "opensand": {
      "apiKey": "your-opensand-api-key",
      "apiBase": "https://opensand.ai/v1"
    }
  }
}
```

**Field notes**

- `apiBase` must end with `/v1`
- `model` must be a real model ID exposed by your OpenSand console
- You can declare multiple providers; `agents.defaults.provider` chooses which one is active

## ✅ Step 3: Launch & verify

```bash
nanobot agent
```

Send any test message (e.g. "Hello, what day is today?"). A normal response means you're set.

## 🔄 Switching models

Edit `agents.defaults.model` in `config.json` and restart `nanobot agent`.

## ❓ Troubleshooting

| Issue | Fix |
|------|----------|
| `nanobot` command not found | Windows: add `.local/bin` to PATH |
| 401 Unauthorized | Confirm `apiKey` is correctly set in `config.json` |
| Model not found | Make sure `model` matches your OpenSand console exactly |
| Config changes don't apply | Restart `nanobot agent` to reload |
