---
title: "Copilot CLI"
source: "https://opensand.ai/en/docs/apps/copilot-cli"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.135Z"
---
# Copilot CLI

> This page uses OpenSand API endpoints, setup scripts, and console field names. Third-party client interfaces may change by version, so use your installed version as the source of truth.


**Project Introduction**

**GitHub Copilot CLI** is GitHub's official terminal AI coding assistant. It supports **BYOK (Bring Your Own Key)** mode for custom model endpoints, letting you point it at OpenSand via a few environment variables. Agent mode, tool calling, and MCP are all supported.

- Official docs: [https://docs.github.com/copilot/how-tos/copilot-cli/cli-getting-started](https://docs.github.com/en/copilot/how-tos/copilot-cli/cli-getting-started)
- Package: [https://www.npmjs.com/package/@github/copilot](https://www.npmjs.com/package/@github/copilot)

This tutorial shows how to point Copilot CLI at OpenSand using BYOK mode.

## 📦 Prerequisites

**What you'll need**

- **Node.js 22 or later**
- An OpenSand endpoint (must end with `/v1`)
- An OpenSand API key (generated in the console)
- A model ID exactly matching one exposed by your OpenSand console (e.g. `claude-sonnet-4-6`, `gemini-2.5-flash`)

## 🚀 Step 1: Install Copilot CLI

```bash
npm install -g @github/copilot
```

Verify the install:

```bash
copilot --version
```

Full setup steps are in GitHub's [getting started guide](https://docs.github.com/en/copilot/how-tos/copilot-cli/cli-getting-started).

## 🔧 Step 2: Point it at OpenSand

Copilot CLI reads provider config from environment variables. **Use `anthropic` as the provider type** for the best compatibility.

### Linux / macOS

```bash
```

### Windows (PowerShell)

```powershell
$env:COPILOT_PROVIDER_TYPE="anthropic"
$env:COPILOT_PROVIDER_BASE_URL="https://opensand.ai/v1"
$env:COPILOT_PROVIDER_API_KEY="your-opensand-api-key"
$env:COPILOT_MODEL="claude-sonnet-4-6"
```

**Why anthropic type is recommended**

Some models (especially reasoning models) require `reasoning_content` to be echoed back verbatim in the next turn. Copilot CLI's OpenAI integration doesn't support that mechanism, which can trigger `400` errors. Using the **Anthropic Messages API** compatible endpoint avoids this.

If you only use non-reasoning models (e.g. `gemini-2.5-flash`), you may set `COPILOT_PROVIDER_TYPE=openai` instead.

### Optional: context / output token limits

```bash
```

## ✅ Step 3: Launch & verify

```bash
copilot
```

Ask any coding question (e.g. "Write a Python function that reads a JSON file"). A normal response means you're set.

```bash
copilot help providers
```

lists every provider-related environment variable.

## 🔄 Switching models

Change `COPILOT_MODEL` and restart:

```bash
copilot
```

The model name **must exactly match** the model ID exposed by your OpenSand console.

## ❓ Troubleshooting

| Issue | Fix |
|------|----------|
| `400 Bad Request` | Switch `COPILOT_PROVIDER_TYPE` to `anthropic` |
| Model not found | Confirm `COPILOT_MODEL` exactly matches the OpenSand model ID |
| Invalid API key | Regenerate a key in the OpenSand console and update the env var |
| Variables don't take effect | New shell needed, or persist them in `~/.bashrc` / `~/.zshrc` / PowerShell profile |
| Output truncated | Raise `COPILOT_PROVIDER_MAX_OUTPUT_TOKENS` |
