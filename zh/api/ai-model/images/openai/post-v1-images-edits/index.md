---
title: "图片编辑"
source: "https://opensand.ai/zh/docs/api/ai-model/images/openai/post-v1-images-edits"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.086Z"
---
# 图片编辑

使用 OpenSand 调用 OpenAI 兼容的图像编辑接口。

## 请求地址

```text
POST /images/edits
```

## 适合什么时候用

- 基于已有图片进行局部修改、风格调整或重绘。
- 需要接入支持 OpenAI 图片接口的客户端或工作流。

## 常用参数

- `model`：图片模型 ID，以控制台实际开放为准。
- `prompt`：图片描述，越具体越容易得到稳定结果。
- `size`：输出尺寸，例如 `1024x1024`，具体可选值取决于模型。
- \`image\`：要编辑的原图文件，通常通过 multipart/form-data 上传。
- \`mask\`：可选，用于指定需要修改的区域。

## 示例

```bash
curl https://opensand.ai/v1/images/edits \
  -H "Authorization: Bearer sk-你的APIKey" \
  -F "model=gpt-image-1" \
  -F "prompt=把背景改成办公室" \
  -F "image=@input.png"
```

## 注意事项

- 图片模型、尺寸和费用以控制台实际开放为准。
- 图像编辑通常需要使用 multipart/form-data 上传文件。
- 如果工具只支持文本模型，不能直接调用图片接口。
- 如果图片生成失败，先降低尺寸、简化提示词，再查看请求日志中的错误信息。
