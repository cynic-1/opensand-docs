---
title: "快速入门"
source: "https://opensand.ai/zh/docs/guide/quick-start"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.077Z"
---
# 快速入门

这篇文档带你完成三件事：创建 API Key、调用第一个接口、把 OpenSand 配到常用工具里。

## 开始前先理解三个概念

| 概念 | 是什么 | 常见填写位置 |
|---|---|---|
| API Key | 你的调用凭证，通常以 `sk-` 开头 | 客户端的 API Key、Token 或 Secret 字段 |
| Base URL | OpenSand 的接口入口 | 客户端的 Base URL、API Address 或 Endpoint 字段 |
| Model | 要调用的模型名称 | 客户端的 Model、模型 ID 或 Deployment 字段 |

大多数 OpenAI 兼容工具只需要填写这三项：

```text
Base URL: https://opensand.ai/v1
API Key: sk-你的APIKey
Model: 从控制台或 /v1/models 查询
```

## 1. 创建 API Key

1. 打开 [https://opensand.ai](https://opensand.ai) 并登录。
2. 进入控制台的 API 令牌页面。
3. 创建一个新令牌，复制并妥善保存。

API Key 通常只完整显示一次。泄露后请立即删除并重新创建。

建议你为不同用途创建不同 Key，例如：

- 桌面聊天工具一个 Key。
- 代码工具一个 Key。
- 自动化脚本一个 Key。

这样后续查日志和控制成本会简单很多。

## 2. 调用第一个聊天接口

```bash
curl https://opensand.ai/v1/chat/completions \
  -H "Authorization: Bearer sk-你的APIKey" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "gpt-4o",
    "messages": [
      {"role": "user", "content": "用一句话介绍 OpenSand"}
    ]
  }'
```

## 3. 使用 Python SDK

```python
from openai import OpenAI

client = OpenAI(
    base_url="https://opensand.ai/v1",
    api_key="sk-你的APIKey",
)

response = client.chat.completions.create(
    model="gpt-4o",
    messages=[{"role": "user", "content": "你好"}],
)

print(response.choices[0].message.content)
```

## 4. 查询模型列表

```bash
curl https://opensand.ai/v1/models \
  -H "Authorization: Bearer sk-你的APIKey"
```

返回结果里的 `id` 就是请求中要填写的模型名称。

如果这一步成功，说明 API Key、Base URL 和账户状态都是正常的。接下来如果某个客户端不可用，通常是客户端配置问题，而不是 OpenSand API 本身不可用。

## 5. 接入工具

如果工具支持 OpenAI Compatible、Custom Endpoint 或自定义 Base URL，通常按下面填写：

| 字段 | 填写 |
|---|---|
| Base URL | `https://opensand.ai/v1` |
| API Key | OpenSand API Key |
| Model | 控制台或 `/v1/models` 返回的模型 ID |

下一步可以查看 [应用接入](/zh/docs/apps)。

## 常见报错

| 报错 | 可能原因 | 处理方式 |
|---|---|---|
| 401 Unauthorized | API Key 错误、过期或没有传入 | 重新复制 Key，确认请求头是 `Authorization: Bearer sk-...` |
| 403 Forbidden | 账号、额度、分组或模型权限问题 | 检查控制台余额、令牌状态和模型权限 |
| model not found | 模型名称填错 | 调用 `/v1/models`，复制返回的 `id` |
| connection error | Base URL 填错 | 大多数工具填写 `https://opensand.ai/v1` |
| empty response | 模型返回异常或客户端解析失败 | 换一个模型测试，并查看请求日志 |

## 下一步

- 想写代码接入：看 [API 文档](/zh/docs/api)。
- 想接入客户端：看 [应用接入](/zh/docs/apps)。
- 想看费用：看 [价格与用量](/zh/docs/guide/pricing)。
