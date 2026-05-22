---
title: "Chat Completions"
source: "https://opensand.ai/zh/docs/api/ai-model/chat/openai/createchatcompletion"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.081Z"
---
# Chat Completions

使用 OpenAI Chat Completions 格式创建对话回复。这是大多数聊天、Agent 和兼容 OpenAI SDK 的工具最常用的接口。

## 新手先看

如果你第一次接触 API，可以把一次请求理解成“向 OpenSand 发一封格式固定的消息”：

- **请求地址**决定你要使用哪类能力，例如聊天、向量、图片或视频。
- **API Key**证明这是你的账号在调用，必须放在 `Authorization` 请求头里。
- **model** 决定真正使用哪个模型，必须和控制台或 `/models` 返回的模型 ID 完全一致。
- **请求体**是你交给模型的任务，例如用户问题、提示词、图片参数或视频参数。

## 请求地址

```text
POST /chat/completions
```

完整请求地址：

```text
https://opensand.ai/v1/chat/completions
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

用于多轮对话、流式输出、函数/工具调用、结构化输出和多数 OpenAI 兼容客户端。

## 常用请求体

- `model`：模型 ID，可从 `/models` 查询。
- `messages`：对话消息数组，常见角色为 `system`、`user`、`assistant`。
- `stream`：设为 `true` 时返回 SSE 流式结果。
- `temperature`、`top_p`：控制生成随机性。
- `max_tokens` 或 `max_completion_tokens`：限制输出长度。

## 请求体怎么填

最小可用请求一般只需要必填字段。先跑通最小请求，再逐步增加 `temperature`、`stream`、工具调用、图片尺寸等高级参数。

填写参数时注意：

- 字段名大小写必须完全一致，例如 `max_tokens` 不能写成 `maxTokens`。
- JSON 字符串必须使用英文双引号。
- 如果你从网页复制 API Key，确认前后没有空格或换行。


## 示例

```bash
curl https://opensand.ai/v1/chat/completions \
  -H "Authorization: Bearer sk-你的APIKey" \
  -H "Content-Type: application/json" \
  -d '{"model":"gpt-4o","messages":[{"role":"user","content":"用一句话介绍 OpenSand"}]}'
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

- 如果客户端要求填写 Base URL，请填写 `https://opensand.ai/v1`。
- 模型名称必须和控制台或 `/models` 返回的 `id` 完全一致。
- 出现 401 时优先检查 API Key；出现 404 或模型不可用时检查模型 ID。
