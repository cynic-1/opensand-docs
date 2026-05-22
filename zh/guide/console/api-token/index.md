---
title: "API 令牌"
source: "https://opensand.ai/zh/docs/guide/console/api-token"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.078Z"
---
# API 令牌

API 令牌用于调用 OpenSand API。每个令牌都可以独立管理，适合按项目、工具或团队成员分开使用。

## 建议做法

- 不同项目使用不同 API Key。
- 不要把 API Key 写进公开仓库。
- Key 泄露后立即删除并重新创建。
- 给自动化任务设置单独 Key，方便追踪用量。

## 创建后怎么用

在请求头中加入：

```http
Authorization: Bearer sk-你的APIKey
```

客户端工具则把它填到 API Key 字段。

## 新手常见问题

| 问题 | 说明 |
|---|---|
| API Key 要不要带引号 | 在客户端里不要额外加引号；在代码字符串里按语言语法加引号 |
| Base URL 是不是 Key 的一部分 | 不是。Base URL 是接口地址，API Key 是凭证 |
| 一个 Key 能不能多个工具共用 | 可以，但不建议。分开创建更方便查日志和控成本 |
| Key 泄露怎么办 | 立刻删除旧 Key，重新创建新 Key |

## 安全建议

- 前端网页不要直接暴露 API Key。
- 公开仓库不要提交 `.env`、配置文件或截图里的 Key。
- 生产环境建议把 Key 放到环境变量或密钥管理系统中。
