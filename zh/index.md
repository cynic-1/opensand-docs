---
title: "快速开始"
source: "https://opensand.ai/zh/docs"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.069Z"
---
# OpenSand 文档

OpenSand 是一个统一的 AI 模型接入网关。你可以用一个 API Key 和一个 Base URL 接入聊天、Embedding、图片、视频以及常见开发工具。

## 从这里开始

1. [快速入门](/zh/docs/guide/quick-start)：创建 API Key，并完成第一次 API 调用。
2. [价格与用量](/zh/docs/guide/pricing)：理解余额、用量和模型费用。
3. [API 文档](/zh/docs/api)：查看 OpenAI 兼容接口和模型接口。
4. [应用接入](/zh/docs/apps)：配置 Claude Code、Codex CLI、Cherry Studio、OpenClaw 等工具。

## 最常用配置

| 配置项 | 值 |
|---|---|
| API Base URL | `https://opensand.ai/v1` |
| API Key | 在 OpenSand 控制台创建 |
| 模型名称 | 从控制台或 `/v1/models` 查询 |

## 用户最常见的问题

- 不知道填哪个地址：大多数 OpenAI 兼容工具填写 `https://opensand.ai/v1`。
- 不知道模型名：先调用 `GET /v1/models`。
- 调不通：先检查 API Key，再检查模型名和账户额度。
