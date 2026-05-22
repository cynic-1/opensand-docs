---
title: "Wanx 2.7 视频生成"
source: "https://opensand.ai/zh/docs/api/ai-model/videos/wanx27"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.087Z"
---
# Wanx 2.7 视频生成

Wanx 2.7 视频模型通过 OpenSand 的统一异步任务接口调用。视频生成通常耗时较长，因此接口会先返回任务 ID，再通过轮询查询结果。

## 调用流程

1. 提交视频生成任务：`POST /v1/video/generations`。
2. 保存返回的 `task_id`。
3. 轮询查询任务：`GET /v1/video/generations/{task_id}`。
4. 任务成功后，从返回的 `url` 下载视频。

## 常用参数

- `model`：视频模型 ID，以控制台实际开放为准。
- `prompt`：视频描述。建议写清主体、动作、场景、镜头和风格。
- `duration`：视频时长，支持范围取决于模型。
- `size` / `resolution`：分辨率或尺寸，越高通常越慢、越贵。
- `image` / `images`：部分模型支持图生视频，需要公网可访问图片或上传方式。

## 提交任务示例

```bash
curl https://opensand.ai/v1/video/generations \
  -H "Authorization: Bearer sk-你的APIKey" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "wanx-2.7",
    "prompt": "一段自然光下的产品展示视频",
    "duration": 5
  }'
```

## 查询任务示例

```bash
curl https://opensand.ai/v1/video/generations/task_xxx \
  -H "Authorization: Bearer sk-你的APIKey"
```

## 注意事项

- 视频模型、时长、分辨率和价格以控制台实际开放为准。
- 生成失败时，请查看返回的 `error` 字段。
- 下载链接通常有有效期，建议任务完成后及时保存结果。
- 新手建议先用短时长和低分辨率测试提示词，再提交高质量任务。
