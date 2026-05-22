---
title: "Pi"
source: "https://opensand.ai/zh/docs/apps/pi-mono"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.106Z"
---
# Pi

> 本页以 OpenSand 的 API 地址、脚本地址和控制台字段为准；第三方客户端界面可能随版本变化，请以你当前安装版本为准。


**项目介绍**

**Pi**（pi-mono）是一个极简且高度可扩展的终端编码框架，支持 TypeScript 扩展、技能、提示模板和主题，拥有树状会话结构和 **15+ 内置供应商**。通过配置文件即可添加 OpenSand 作为自定义 OpenAI 兼容供应商。

- GitHub：[https://github.com/can1357/pi-mono](https://github.com/can1357/pi-mono)

## 📦 接入前准备

**准备信息**

- 已安装 Pi（pi-mono）
- 一个可用的 OpenSand 地址（必须以 `/v1` 结尾）
- 一个可用的 OpenSand API Key（在控制台生成）
- 想使用的模型名称（如 `claude-sonnet-4-6`、`gemini-2.5-flash` 等，需与 OpenSand 控制台中的模型 ID 完全一致）

## 🔑 第一步：设置环境变量

```bash
```

## 🔧 第二步：编辑配置文件

在 Pi 的配置文件中添加 OpenSand 供应商：

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

**字段要点**

- `baseUrl` 使用 OpenSand 标准地址 `https://opensand.ai/v1`
- `api` 固定为 `openai-completions`
- `apiKey` 使用 `$OPENSAND_API_KEY` 变量引用
- `compat.requiresReasoningContentOnAssistantMessages: true` 确保思考模式下历史消息保留推理内容
- `reasoningEffortMap` 将 Pi 的推理等级映射到目标模型支持的等级；非推理模型可直接省略此块

## ✅ 第三步：启动并验证

启动 Pi，在供应商选择器中选择 **opensand**，然后选择目标模型。发送一条测试消息，收到正常响应即配置成功。

## ❓ 常见问题

| 问题 | 解决方案 |
|------|----------|
| 供应商列表没有 opensand | 检查配置文件路径与 JSON 格式是否正确 |
| 401 Unauthorized | 确认 `OPENSAND_API_KEY` 已导出到当前 shell |
| 推理模型行为异常 | 核对 `requiresReasoningContentOnAssistantMessages` 和 `thinkingFormat` 是否与模型匹配 |
| 模型不存在 | 核对 `models[].id` 与 OpenSand 控制台完全一致 |
