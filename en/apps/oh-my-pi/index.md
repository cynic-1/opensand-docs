---
title: "Oh My Pi"
source: "https://opensand.ai/en/docs/apps/oh-my-pi"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.138Z"
---
# Oh My Pi

> This page uses OpenSand API endpoints, setup scripts, and console field names. Third-party client interfaces may change by version, so use your installed version as the source of truth.


**Project Introduction**

**Oh My Pi** is a terminal AI coding agent. Custom model providers are added through a `models.yml` config file, with full support for reasoning effort, tool calling, and context management.

- GitHub: [https://github.com/can1357/oh-my-pi](https://github.com/can1357/oh-my-pi)
- Install guide: [https://github.com/can1357/oh-my-pi#installation](https://github.com/can1357/oh-my-pi#installation)

## 📦 Prerequisites

**What you'll need**

- Oh My Pi installed (the `omp` command is on your PATH)
- An OpenSand endpoint (use `https://opensand.ai/v1` as usual)
- An OpenSand API key (generated in the console)
- A model ID exactly matching one exposed by your OpenSand console (e.g. `claude-sonnet-4-6`, `gemini-2.5-flash`)

## 🔑 Step 1: Set the API key environment variable

```bash
```

## 🔧 Step 2: Create the config file

Create `~/.omp/agent/models.yml` and add OpenSand as a provider:

```yaml
providers:
  opensand:
    baseUrl: https://opensand.ai/v1
    api: openai-completions
    apiKey: OPENSAND_API_KEY
    authHeader: true
    models:
      - id: claude-sonnet-4-6
        name: Claude Sonnet 4.6
        reasoning: true
        thinking:
          minLevel: high
          maxLevel: xhigh
          mode: effort
        input: [text]
        contextWindow: 200000
        maxTokens: 128000
        compat:
          supportsDeveloperRole: false
          supportsReasoningEffort: true
          maxTokensField: max_tokens
          reasoningEffortMap:
            high: high
            xhigh: max
          supportsToolChoice: false
          requiresReasoningContentForToolCalls: true
          requiresAssistantContentForToolCalls: true
        extraBody:
          thinking:
            type: enabled
      - id: gemini-2.5-flash
        name: Gemini 2.5 Flash
        reasoning: false
        input: [text]
        contextWindow: 1000000
        maxTokens: 65536
        compat:
          supportsDeveloperRole: false
          maxTokensField: max_tokens
```

**Key configuration fields**

| Field | Purpose |
|--------|------|
| `baseUrl` | OpenSand endpoint (keep the `/v1` suffix — Oh My Pi handles path joining) |
| `authHeader: true` | Send `Authorization: Bearer $OPENSAND_API_KEY` |
| `supportsDeveloperRole: false` | Send system prompts with the `system` role |
| `maxTokensField: max_tokens` | Use `max_tokens` as the output limit field |
| `supportsToolChoice: false` | `tool_choice` param not accepted in thinking mode |
| `requiresReasoningContentForToolCalls: true` | History messages in tool-call chats must preserve `reasoning_content` |
| `requiresAssistantContentForToolCalls: true` | Ensure the `content` field of tool-call messages is not empty |

**Important**

The `compat` field in `models.yml` is a **full replacement**, not a merge with built-in defaults. You must set every field you care about — anything omitted falls back to implicit defaults.

## ✅ Step 3: Launch & verify

From your project directory:

```bash
cd /path/to/your-project
omp --model opensand/claude-sonnet-4-6
```

For faster, non-reasoning responses:

```bash
omp --model opensand/gemini-2.5-flash
```

Press `Ctrl+L` or type `/model` inside Oh My Pi to switch models at any time.

## ❓ Troubleshooting

| Issue | Fix |
|------|----------|
| "Provider not found" on launch | Confirm `~/.omp/agent/models.yml` exists and the YAML is valid |
| 401 Unauthorized | Make sure `OPENSAND_API_KEY` is exported in the current shell |
| Reasoning-model tool calls failing | Ensure `requiresReasoningContentForToolCalls: true` is set |
| Weird behaviour after switching models | Non-reasoning models: drop `reasoning: true` and the `extraBody.thinking` block |
