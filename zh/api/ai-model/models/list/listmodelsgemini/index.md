---
title: "Gemini 模型列表"
source: "https://opensand.ai/zh/docs/api/ai-model/models/list/listmodelsgemini"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.082Z"
---
# Gemini 模型列表

查看可通过 OpenSand 访问的 Gemini 兼容模型。多数用户直接使用通用 `/models` 即可。

## 新手先看

如果你第一次接触 API，可以把一次请求理解成“向 OpenSand 发一封格式固定的消息”：

- **请求地址**决定你要使用哪类能力，例如聊天、向量、图片或视频。
- **API Key**证明这是你的账号在调用，必须放在 `Authorization` 请求头里。
- **model** 决定真正使用哪个模型，必须和控制台或 `/models` 返回的模型 ID 完全一致。
- **请求体**是你交给模型的任务，例如用户问题、提示词、图片参数或视频参数。

## 请求地址

```text
GET /models
```

完整请求地址：

```text
https://opensand.ai/v1/models
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

用于配置 Gemini 协议客户端或检查 Gemini 系列模型是否已开放。

## 常用请求体

GET 请求不需要请求体。

## 请求体怎么填

这是一个 GET 接口，不需要请求体。只要带上正确的 `Authorization` 请求头即可。


## 示例

```bash
curl https://opensand.ai/v1/models \
  -H "Authorization: Bearer sk-你的APIKey"
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

- Gemini 协议工具可能要求填写不带 `/v1` 的站点地址，请以具体工具说明为准。
- 模型 ID 仍以 OpenSand 控制台和 `/models` 返回为准。
