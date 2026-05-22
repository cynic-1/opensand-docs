---
title: "LangBot"
source: "https://opensand.ai/zh/docs/apps/langbot"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.101Z"
---
# LangBot - 即时通信机器人开发平台

> 本页以 OpenSand 的 API 地址、脚本地址和控制台字段为准；第三方客户端界面可能随版本变化，请以你当前安装版本为准。


LangBot
是一个开源的即时通信机器人开发平台，支持多种即时通信平台，如飞书、钉钉、微信、QQ、Telegram、Discord、Slack
等。接入全球主流的 AI 模型，支持知识库、Agent、MCP等多种 AI
应用能力，并完美适配 OpenSand。

- 官网地址：[https://langbot.app](https://langbot.app/)
- 下载地址：[https://github.com/langbot-app/LangBot/releases](https://github.com/langbot-app/LangBot/releases)
- 官方文档：[https://docs.langbot.app](https://docs.langbot.app/)
- 开源地址：[https://github.com/langbot-app/LangBot](https://github.com/langbot-app/LangBot)

## 接入 OpenSand

LangBot 支持通过 OpenAI 兼容接口接入 OpenSand。

### 使用方式

1.  从 OpenSand 中获取 API key
    ![获取 API key](../../../pictures/apps/langbot/get_api_key.png)

        使用 OpenSand 时请填写 `https://opensand.ai/v1`，地址需要包含 `/v1`。

2.  在 LangBot 中添加模型，选择使用 OpenSand 供应商，填写对应的 API key 和 API 地址
    ![添加 OpenSand 模型](../../../pictures/apps/langbot/add_newapi_model.png)

3.  在流水线中选择使用模型

    ![选择模型](../../../pictures/apps/langbot/select_model.png)

4.  在对话调试中对话或与绑定至流水线的机器人对话即可使用

    ![对话](../../../pictures/apps/langbot/debug_chat.png)

    ![微信对话](../../../pictures/apps/langbot/wechat.png)

    部署配置机器人请参考[部署机器人](https://docs.langbot.app/zh/deploy/platforms/readme.html)。

### 使用 LangBot 知识库

LangBot 支持使用 OpenSand 的嵌入模型，并将其作为知识库的向量模型。

1. 在 LangBot 中添加嵌入模型，选择使用 OpenSand 供应商
   ![添加嵌入模型](../../../pictures/apps/langbot/add_embedding_model.png)

2. 在新建知识库时选用嵌入模型
   ![使用嵌入模型](../../../pictures/apps/langbot/use_embedding_model.png)

更多使用方式请查看 LangBot 官方文档：[https://docs.langbot.app](https://docs.langbot.app/)
