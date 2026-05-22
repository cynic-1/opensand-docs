---
title: "技术架构"
source: "https://opensand.ai/zh/docs/guide/wiki/basic-concepts/technical-architecture"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.081Z"
---
# 技术架构

OpenSand 的核心思路是把客户端请求统一接入，再根据模型、渠道和策略转发到对应上游。

## 请求链路

1. 客户端携带 API Key 请求 OpenSand。
2. OpenSand 完成鉴权、额度、模型和策略检查。
3. 请求被路由到可用模型渠道。
4. 返回结果写入日志和用量统计。
5. 客户端收到统一格式的响应。

## 对用户意味着什么

- 客户端只需要配置一个 Base URL。
- 切换模型通常只需要修改 `model` 字段。
- 问题排查可以从请求日志开始。
