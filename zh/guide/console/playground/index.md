---
title: "Playground"
source: "https://opensand.ai/zh/docs/guide/console/playground"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.080Z"
---
# Playground

Playground 用于在控制台中测试模型，不需要先写代码。

## 适合做什么

- 验证 API Key 和模型是否可用。
- 对比不同模型的回答质量。
- 调试提示词和参数。
- 在接入工具前先确认模型 ID。

测试通过后，再把相同模型名称填到客户端或 API 请求里。

## 测试建议

- 第一次测试只写一句简单问题，避免把提示词问题和接口问题混在一起。
- 先关闭流式、工具调用、联网等高级能力。
- 如果某个模型失败，换一个基础聊天模型测试，判断是模型问题还是账号/接口问题。
- 把 Playground 里可用的模型 ID 原样复制到客户端。
