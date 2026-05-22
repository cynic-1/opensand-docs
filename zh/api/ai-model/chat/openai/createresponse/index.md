---
title: "Responses"
source: "https://opensand.ai/zh/docs/api/ai-model/chat/openai/createresponse"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.082Z"
---
# Responses

使用 OpenAI Responses API 格式创建回复。它适合需要更统一输入结构、推理参数或新式 OpenAI SDK 能力的场景。

## 新手先看

如果你第一次接触 API，可以把一次请求理解成“向 OpenSand 发一封格式固定的消息”：

- **请求地址**决定你要使用哪类能力，例如聊天、向量、图片或视频。
- **API Key**证明这是你的账号在调用，必须放在 `Authorization` 请求头里。
- **model** 决定真正使用哪个模型，必须和控制台或 `/models` 返回的模型 ID 完全一致。
- **请求体**是你交给模型的任务，例如用户问题、提示词、图片参数或视频参数。

## 请求地址

```text
POST /responses
```

完整请求地址：

```text
https://opensand.ai/v1/responses
```

如果某个客户端只让你填写 Base URL，请填写：

```text
https://opensand.ai/v1
```

## 认证

所有请求都使用 OpenSand API Key：

```http
Authorization: Bearer sk-你的APIKey
Content-Type: application/json
```

## 适合什么时候用

用于新版 OpenAI SDK、需要 `input` 字段的应用，以及希望后续更平滑迁移到 Responses API 的项目。

## 常用请求体

- `model`：模型 ID。
- `input`：字符串或结构化输入。
- `stream`：是否流式返回。
- `reasoning`：支持推理模型时可设置推理强度。
- `tools`：工具定义，具体可用性取决于模型。

## 请求体怎么填

最小可用请求一般只需要必填字段。先跑通最小请求，再逐步增加 `temperature`、`stream`、工具调用、图片尺寸等高级参数。

填写参数时注意：

- 字段名大小写必须完全一致，例如 `max_tokens` 不能写成 `maxTokens`。
- JSON 字符串必须使用英文双引号。
- 如果你从网页复制 API Key，确认前后没有空格或换行。


## 示例

```bash
curl https://opensand.ai/v1/responses \
  -H "Authorization: Bearer sk-你的APIKey" \
  -H "Content-Type: application/json" \
  -d '{"model":"gpt-4o","input":"写一个三点式产品摘要"}'
```

## 如何判断调用成功

- HTTP 状态码是 200，通常说明请求成功。
- 如果返回中包含 `id`、`choices`、`data` 或任务状态字段，说明 OpenSand 已经收到并处理请求。
- 如果是流式接口，客户端会持续收到多段数据，直到结束标记。

## 常见错误

| 错误 | 含义 | 处理方式 |
|---|---|---|
| 401 Unauthorized | API Key 无效或没有传入 | 检查 `Authorization: Bearer sk-...` 格式 |
| 403 Forbidden | 账号、分组或模型权限不足 | 检查账户状态、模型权限和额度 |
| 404 Not Found | 路径或模型不存在 | 确认 Base URL、接口路径和模型 ID |
| 429 Too Many Requests | 请求过快或额度限制 | 降低并发，稍后重试，或检查额度 |
| 500/502/503 | 上游或平台临时错误 | 稍后重试，并查看请求日志 |

## 注意事项

- 如果你的工具只支持 Chat Completions，优先使用 `/chat/completions`。
- Responses 返回结构与 Chat Completions 不同，解析代码不要混用。
