---
title: "OpenClaw"
source: "https://opensand.ai/en/docs/apps/openclaw"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.138Z"
---
# OpenClaw

> This page uses OpenSand API endpoints, setup scripts, and console field names. Third-party client interfaces may change by version, so use your installed version as the source of truth.


**Project Introduction**

OpenClaw is an open-source, self-hosted personal AI
assistant platform that connects messaging apps to AI
agents running on your own hardware. Designed for developers and advanced users, it allows you to have an autonomous AI assistant without giving up control of your data.

- Official Homepage: [https://openclaw.ai](https://openclaw.ai)
- Project Documentation: [https://docs.openclaw.ai](https://docs.openclaw.ai)
- GitHub: [https://github.com/openclaw/openclaw](https://github.com/openclaw/openclaw)

OpenClaw is completely open source. You can browse the source code, submit issues, or contribute at [OpenClaw's GitHub repository](https://github.com/openclaw/openclaw). This tutorial covers the complete steps for installation, configuration, and integrating OpenClaw with OpenSand.

## 🌟 Core Features

### Multi-Channel Integration

- **Multi-channel integration**: Supports various messaging channels like Telegram, Discord, WhatsApp, iMessage, and can be extended to more platforms via plugins.
- **Single Gateway**: Unified management of all channels through a single Gateway process.
- **Voice Support**: Supports macOS/iOS/Android voice interaction.
- **Canvas Interface**: Capable of rendering interactive Canvas interfaces.

### Self-Hosting and Data Security

- **Fully Self-Hosted**: Runs on your own machine or server.
- **Open Source & Transparent**: MIT open-source license, fully transparent code.
- **Data Localization**: Context and skills are stored on your local computer, not in the cloud.

### Smart Agent Capabilities

- **Continuous Operation**: Supports persistent background operation with long-term memory.
- **Scheduled Tasks**: Supports cron-based scheduled tasks.
- **Session Isolation**: Isolates sessions by agent/workspace/sender.
- **Multi-Agent Routing**: Supports collaborative work among multiple agents.
- **Tool Calling**: Native support for tool calling and code execution.

## 📦 Pre-integration Preparation

**Preparation Information**

- Node.js 22 or higher
- An available OpenSand address (usually ending with `/v1`)
- An available OpenSand API Key

Before integrating with OpenSand, it's recommended to first get the Gateway and Control UI running according to OpenClaw's currently recommended official process. This makes it easier to distinguish whether OpenClaw itself hasn't started or if the model provider configuration is incorrect when troubleshooting later.

### 1. Install OpenClaw (macOS/Linux)

```bash
curl -fsSL https://openclaw.ai/install.sh | bash
```

For other installation methods, refer to the OpenClaw official documentation: [Getting Started](https://docs.openclaw.ai/start/getting-started).

### 2. Run the Onboarding Wizard

```bash
openclaw onboard --install-daemon
```

This wizard completes basic authentication, Gateway setup, and optional channel initialization. The goal here is to get OpenClaw running first, then switch the default model to OpenSand later.

### 3. Check Gateway and Control UI

```bash
openclaw gateway status
```

```bash
openclaw dashboard
```

If your browser can open the Control UI, it means OpenClaw's basic operation is normal. At this stage, there's no need to configure messaging channels like Telegram, Discord, or Feishu yet.

### 4. Locate the Configuration File

OpenClaw's configuration file is usually located at `~/.openclaw/openclaw.json`. You can continue to modify it based on what the onboarding wizard generates.

**Path-Related Environment Variables**

If you run OpenClaw under a dedicated service account, or wish to customize the configuration/state directory, you can use:

- `OPENCLAW_HOME`
- `OPENCLAW_STATE_DIR`
- `OPENCLAW_CONFIG_PATH`

For detailed explanations, see the official environment variables documentation: [Environment Variables](https://docs.openclaw.ai/help/environment).

## 🚀 Using OpenSand as a Model Provider

OpenClaw supports integrating custom or OpenAI-compatible model gateways via `models.providers`. For OpenSand, the most common approach is to add it as a custom provider to the configuration, then point the default model to `newapi/MODEL_ID`.

### Integration Approach

1. Declare a `opensand` provider under `models.providers`.
2. Point `baseUrl` to your OpenSand address, ensuring it includes `/v1`.
3. Set `api` to `openai-completions`.
4. List the model IDs you want OpenClaw to use in `models`.
5. Switch the default model to `opensand/...` in `agents.defaults.model.primary`.

### Recommended Practice: Store API Keys in Environment Variables

First, provide your OpenSand key in the current shell, service environment, or a `.env` file readable by OpenClaw:

```bash
```

Then, add or modify the following snippet in `openclaw.json`:

```json5
{
  models: {
    mode: "merge",
    providers: {
      opensand: {
        baseUrl: "https://opensand.ai/v1",
        apiKey: "${OPENSAND_API_KEY}",
        api: "openai-completions",
        models: [
          { id: "gemini-2.5-flash", name: "Gemini 2.5 Flash" },
          { id: "kimi-k2.5", name: "Kimi K2.5" },
        ],
      },
    },
  },

  agents: {
    defaults: {
      model: {
        primary: "opensand/gemini-2.5-flash",
        fallbacks: ["opensand/kimi-k2.5"],
      },
      models: {
        "opensand/gemini-2.5-flash": { alias: "flash" },
        "opensand/kimi-k2.5": { alias: "kimi" },
      },
    },
  },
}
```

This is not a complete configuration to be copied verbatim, but rather the most critical part for integrating OpenSand. As long as the `provider`, model ID, and default model references are correctly matched, OpenClaw will be able to call the model resources you expose via OpenSand.

### Key Configuration Explanation

| Configuration Item | Description |
| --- | --- |
| `models.mode` | Recommended to set to `merge` to append `opensand` while retaining OpenClaw's built-in providers. |
| `models.providers.opensand.baseUrl` | Your OpenSand address, usually needs to include `/v1`. |
| `models.providers.opensand.apiKey` | OpenSand key, recommended to inject via `${OPENSAND_API_KEY}`. |
| `models.providers.opensand.api` | For OpenAI-compatible gateways like OpenSand, use `openai-completions`. |
| `models.providers.opensand.models` | The model IDs listed here must match the actual model names exposed by your OpenSand. |
| `agents.defaults.model.primary` | Default primary model, format must be `provider/model-id`. |
| `agents.defaults.model.fallbacks` | Fallback model list, automatically switches if the primary model fails. |
| `agents.defaults.models` | Optional, used to create aliases for models, convenient for referencing in UI or conversations. |

### Verify Successful Integration

After completing the configuration, return to or reopen the Control UI:

```bash
openclaw dashboard
```

If you can initiate conversations normally in OpenClaw and the default model has become `opensand/...`, then the integration is successful. You can also use:

```bash
openclaw models list
```

to confirm that models with the `newapi/` prefix appear in the selectable list.

### Common Issues

- `baseUrl` without `/v1`: This is one of the most common integration errors.
- Incorrect model ID: `primary` and `fallbacks` must correspond to the `id` in `models.providers.opensand.models`.
- Key only effective in the current terminal: If Gateway runs as a background service, ensure the service process can also read `OPENSAND_API_KEY`.
- For foreground troubleshooting: You can use the official foreground running method `openclaw gateway --port 18789` to observe logs and errors.
