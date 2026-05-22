---
title: "Hermes Agent"
source: "https://opensand.ai/en/docs/apps/hermes-agent"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.136Z"
---
# Hermes Agent

> This page uses OpenSand API endpoints, setup scripts, and console field names. Third-party client interfaces may change by version, so use your installed version as the source of truth.


**Project Introduction**

Hermes Agent is an open-source terminal AI agent developed by Nous Research. It provides powerful tool calling, file read/write, and code execution capabilities right in your terminal. With built-in Custom Endpoint support, Hermes can seamlessly connect to any OpenAI-compatible API — including OpenSand — **without writing any code or plugins**.

- Official Homepage: [https://hermes-agent.nousresearch.com](https://hermes-agent.nousresearch.com)
- Quickstart: [https://hermes-agent.nousresearch.com/docs/getting-started/quickstart](https://hermes-agent.nousresearch.com/docs/getting-started/quickstart)
- GitHub: [https://github.com/NousResearch/hermes-agent](https://github.com/NousResearch/hermes-agent)

Hermes Agent is fully open source. You can browse the source code, submit issues, or contribute at the [Hermes Agent GitHub repository](https://github.com/NousResearch/hermes-agent). This tutorial covers the complete steps for installation, configuration, and integrating Hermes Agent with OpenSand.

## 🌟 Core Features

### Smart Agent Capabilities

- **Tool Calling**: Native support for tool calling, file read/write, and code execution
- **Persistent Memory**: Supports persistent background operation with long-term memory
- **Skill System**: Search and install skill packages via the `hermes skills` command
- **Multi-Interface Support**: Supports both CLI and TUI (terminal UI) modes

### Multi-Channel Integration

- **Message Gateway**: Unified management of all channels via `hermes gateway`
- **Multi-Platform Support**: Connects to Telegram, Discord, Slack, WhatsApp, and more
- **Always Online**: Runs persistently as a background service

### Open Model Ecosystem

- **Custom Provider**: Built-in Custom Endpoint support — connects to any OpenAI-compatible API
- **Interactive Configuration**: Configure everything through an interactive menu with `hermes model` — no need to edit config files
- **Flexible Switching**: Switch models on the fly during a conversation via the `/model` command

## 📦 Pre-integration Preparation

**Preparation Information**

- Hermes Agent installed (see installation steps below)
- An available OpenSand address (must end with `/v1`)
- An available OpenSand API Key (generated in the console)
- The model name you want to use (e.g., `claude-sonnet-4-6`, `gemini-2.5-flash`), which must match the model ID in the OpenSand console exactly

**Model Context Requirement**

Hermes Agent requires the model to support a context window of at least **64K tokens**. Make sure your chosen model meets this requirement, otherwise you may run into context-length errors.

## 🚀 Step 1: Install Hermes Agent

### Linux / macOS / WSL2

Run the official one-line install script in your terminal:

```bash
curl -fsSL https://raw.githubusercontent.com/NousResearch/hermes-agent/main/scripts/install.sh | bash
```

After installation, reload your terminal environment:

```bash
source ~/.bashrc
```

If you use zsh (default on macOS), run this instead:

```bash
source ~/.zshrc
```

### Windows

**Note for Windows Users**

Hermes Agent does not natively support Windows. You need to install **WSL2** (Windows Subsystem for Linux 2) first, then run the Linux/macOS install command above inside a WSL2 terminal.

WSL2 installation guide: [https://learn.microsoft.com/windows/wsl/install](https://learn.microsoft.com/windows/wsl/install)

### Verify Installation

Run the following command to verify Hermes was installed successfully:

```bash
hermes --version
```

If a version number is displayed, the installation was successful 🎉.

## 🔧 Step 2: Configure OpenSand (The Key Step)

This is the most important step of the entire integration process. Hermes Agent provides an **interactive menu** so you don't need to write any code or manually edit config files — just follow the prompts and fill in your OpenSand URL, Key, and model name.

Run the following command in your terminal:

```bash
hermes model
```

This opens an interactive menu. Use the arrow keys to navigate and press Enter to confirm.

### Configuration Flow

**Configuration Steps**

**1. Select Provider**

Use the arrow keys to scroll to **Custom Endpoint** (or a similarly named "custom endpoint" option) and press Enter.

**2. Enter Base URL**

Enter your OpenSand address, for example:

```
https://opensand.ai/v1
```

> ⚠️ The address **must end with `/v1`**. This is the most common configuration mistake.

**3. Enter API Key**

Enter the API Key you generated in the OpenSand console, for example:

```
sk-xxxxxxxxxxxxxxxx
```

**4. Enter Model Name**

Enter the model you want to use, for example:

```
claude-sonnet-4-6
```

> The model name must match the model ID in the OpenSand console **exactly**, otherwise you will get a "model not found" error.

**5. Confirm and Save**

Follow the prompts to confirm. Configuration complete.

### Key Configuration Explanation

| Configuration Item | Description | Example |
| --- | --- | --- |
| Base URL | OpenSand address, **must end with `/v1`** | `https://opensand.ai/v1` |
| API Key | Token generated in the OpenSand console | `sk-xxxxxxxxxxxxxxxx` |
| Model | Model name, must match the model ID actually exposed by OpenSand | `claude-sonnet-4-6` |

## ✅ Step 3: Verify Successful Integration

Once configuration is complete, start Hermes directly:

```bash
hermes
```

Or use the modern TUI mode (terminal graphical interface):

```bash
hermes --tui
```

Send any test message, for example:

```
Hello, tell me what day of the week it is today
```

If the model responds normally, the integration is successful 🎉.

### View and Switch Models

Inside the conversation, type the following command to view and quickly switch the current model:

```
/model
```

You can also run `hermes model` again at any time to **overwrite the previous configuration** and enter a new URL, Key, or model name.

## ❓ Common Issues

| Issue | Solution |
| --- | --- |
| Empty response or error | Check that the Base URL ends with `/v1` |
| "Model not found" error | Confirm the model name matches the model ID in the OpenSand console **exactly** |
| "Invalid API Key" error | Regenerate a Key in the OpenSand console, then run `hermes model` again |
| Don't know how to open the config menu | Run `hermes model` in your terminal |
| Want to switch models | Run `hermes model` again, or type `/model` in the conversation |
| "Context not enough" error | Hermes requires models with at least 64K tokens of context; switch to a model with a larger context window |
| Want to modify previous configuration | Run `hermes model` again to overwrite previous settings |
| Can't install on Windows | Hermes does not natively support Windows. Install WSL2 first and run the install command inside WSL2 |

## 🎯 Next Steps (Optional)

After successfully integrating OpenSand, you can explore more capabilities of Hermes Agent:

### Launch the Message Gateway

Connect Hermes to messaging apps like Telegram, Discord, or Slack:

```bash
hermes gateway setup
```

### Search and Install Skills

Hermes has a built-in skill marketplace for extending capabilities with a single command:

```bash
hermes skills search <keyword>
```

### View All Available Commands

```bash
hermes --help
```

**Tip**

Once OpenSand is integrated, all subsequent Hermes Agent capabilities (message gateway, skill execution, background persistence, etc.) will route through OpenSand to call your chosen model. There's no need to configure the model provider separately for each feature.
