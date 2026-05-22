---
title: "Gemini 多模态对话"
source: "https://opensand.ai/zh/docs/api/ai-model/chat/gemini/geminirelayv1beta-391536411"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.087Z"
---
# Gemini 多模态对话

OpenSand 可为需要 Gemini 协议的客户端提供兼容入口。只有当你的工具明确要求 Gemini API 格式时，才需要使用本页。

## 常见用途

- 使用 Gemini 系列模型进行文本或多模态对话。
- 接入只支持 Gemini API 路径的第三方工具。

## 配置要点

- API Key：使用 OpenSand 控制台创建的 Key。
- 模型名称：以 OpenSand 控制台或模型列表返回为准。
- Base URL：根据工具要求填写 OpenSand 站点地址；如果工具要求 OpenAI 兼容接口，优先使用 `https://opensand.ai/v1`。

## 新手建议

Gemini 协议在不同客户端里的字段名称差异较大。如果你只是想聊天、写代码或接入普通 Agent，优先选择 OpenAI 兼容模式；只有工具明确写着“Gemini API Key / Gemini Endpoint”时，再使用 Gemini 兼容配置。

排查时先确认三件事：

1. 这个工具到底要求 Gemini 协议还是 OpenAI 协议。
2. 模型 ID 是否来自 OpenSand 控制台。
3. Base URL 是否符合工具要求。

## 建议

如果工具支持 OpenAI 兼容协议，优先使用 [Chat Completions](/zh/docs/api/ai-model/chat/openai/createchatcompletion)，配置更简单，也更容易排查问题。
