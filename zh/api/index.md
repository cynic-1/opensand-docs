---
title: "API 文档"
source: "https://opensand.ai/zh/docs/api"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.077Z"
---
# API 文档

OpenSand 对外提供 OpenAI 兼容接口，并保留部分模型原生协议。大多数应用只需要 OpenAI 兼容 API。

## 基础信息

| 项目 | 值 |
|---|---|
| Base URL | `https://opensand.ai/v1` |
| 认证 | `Authorization: Bearer sk-你的APIKey` |
| 请求格式 | JSON，除图片编辑等上传接口外 |

## 最小请求长什么样

每个 OpenAI 兼容请求通常由三部分组成：

1. 请求地址：例如 `https://opensand.ai/v1/chat/completions`。
2. 请求头：包含 API Key 和内容类型。
3. 请求体：包含模型名称和输入内容。

```bash
curl https://opensand.ai/v1/chat/completions \
  -H "Authorization: Bearer sk-你的APIKey" \
  -H "Content-Type: application/json" \
  -d '{"model":"gpt-4o","messages":[{"role":"user","content":"你好"}]}'
```

如果你用 SDK，不需要自己拼 HTTP 请求，只要把 SDK 的 `base_url` 设置成 `https://opensand.ai/v1`。

## 推荐阅读顺序

1. [模型列表](/zh/docs/api/ai-model/models/list/listmodels)
2. [Chat Completions](/zh/docs/api/ai-model/chat/openai/createchatcompletion)
3. [Responses](/zh/docs/api/ai-model/chat/openai/createresponse)
4. [Claude Messages](/zh/docs/api/ai-model/chat/createmessage)
5. [Embeddings](/zh/docs/api/ai-model/embeddings/openai/createembedding)
6. [图片生成](/zh/docs/api/ai-model/images/openai/post-v1-images-generations)

## 选择哪个接口

| 需求 | 接口 |
|---|---|
| 普通聊天、Agent、OpenAI SDK | `/chat/completions` |
| 新版 OpenAI Responses 客户端 | `/responses` |
| Claude 原生协议工具 | `/messages` |
| 语义搜索、知识库 | `/embeddings` |
| 生成图片 | `/images/generations` |
| 生成视频 | `/video/generations` |

## 调试建议

- 第一步永远先调用 `/models`，确认 Key 可用并复制正确模型 ID。
- 第二步用 `/chat/completions` 发送最小请求。
- 第三步再接入 SDK、客户端或复杂参数。
- 不要一开始就同时调试流式输出、工具调用、长上下文和高级模型。
