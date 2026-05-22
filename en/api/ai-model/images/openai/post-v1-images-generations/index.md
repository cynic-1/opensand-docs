---
title: "Image Generation"
source: "https://opensand.ai/en/docs/api/ai-model/images/openai/post-v1-images-generations"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.130Z"
---
# Image Generation

Use OpenSand with the OpenAI-compatible image generation endpoint.

## Endpoint

```text
POST /images/generations
```

## When To Use It

- Generate images from text prompts.
- Integrate clients or workflows that support OpenAI image APIs.

## Common Parameters

- `model`: image model ID enabled in the console.
- `prompt`: image description. More specific prompts are usually more stable.
- `size`: output size, such as `1024x1024`, depending on model support.
- \`n\`: number of images, depending on model limits.

## Example

```bash
curl https://opensand.ai/v1/images/generations \
  -H "Authorization: Bearer sk-your-api-key" \
  -H "Content-Type: application/json" \
  -d '{"model":"gpt-image-1","prompt":"A clean product poster","size":"1024x1024"}'
```

## Notes

- Available image models, sizes, and pricing depend on the console configuration.
- Image editing usually requires multipart/form-data file upload.
- Text-only clients cannot call image endpoints directly.
- If generation fails, try a smaller size, simplify the prompt, and check request logs for the error.
