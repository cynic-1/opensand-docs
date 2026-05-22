---
title: "HappyHorse Video Generation"
source: "https://opensand.ai/en/docs/api/ai-model/videos/happyhorse"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.131Z"
---
# HappyHorse Video Generation

HappyHorse video models use OpenSand's unified asynchronous task API. Video generation usually takes longer than text generation, so the API returns a task ID first and you poll for the result.

## Flow

1. Submit a generation task: `POST /v1/video/generations`.
2. Save the returned `task_id`.
3. Poll the task: `GET /v1/video/generations/{task_id}`.
4. Download the video from the returned `url` when the task succeeds.

## Common Parameters

- `model`: video model ID enabled in the console.
- `prompt`: video description. Include subject, action, scene, camera movement, and style.
- `duration`: video length, depending on model support.
- `size` / `resolution`: higher resolution is usually slower and more expensive.
- `image` / `images`: some models support image-to-video and may require public image URLs or upload support.

## Submit a Task

```bash
curl https://opensand.ai/v1/video/generations \
  -H "Authorization: Bearer sk-your-api-key" \
  -H "Content-Type: application/json" \
  -d '{
    "model": "happyhorse",
    "prompt": "A product showcase video in natural light",
    "duration": 5
  }'
```

## Check a Task

```bash
curl https://opensand.ai/v1/video/generations/task_xxx \
  -H "Authorization: Bearer sk-your-api-key"
```

## Notes

- Available video models, durations, resolutions, and pricing depend on console configuration.
- Check the returned `error` field when a task fails.
- Download URLs are usually temporary. Save completed results promptly.
- Beginners should test prompts with short duration and lower resolution before submitting high-quality jobs.
