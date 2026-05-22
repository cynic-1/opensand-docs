---
title: "Image Editing"
source: "https://opensand.ai/en/docs/api/ai-model/images/openai/post-v1-images-edits"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.130Z"
---
# Image Editing

Use OpenSand with the OpenAI-compatible image editing endpoint.

## Endpoint

```text
POST /images/edits
```

## When To Use It

- Modify, restyle, or repaint an existing image.
- Integrate clients or workflows that support OpenAI image APIs.

## Common Parameters

- `model`: image model ID enabled in the console.
- `prompt`: image description. More specific prompts are usually more stable.
- `size`: output size, such as `1024x1024`, depending on model support.
- \`image\`: source image file, usually uploaded as multipart/form-data.
- \`mask\`: optional area mask for targeted edits.

## Example

```bash
curl https://opensand.ai/v1/images/edits \
  -H "Authorization: Bearer sk-your-api-key" \
  -F "model=gpt-image-1" \
  -F "prompt=Change the background to an office" \
  -F "image=@input.png"
```

## Notes

- Available image models, sizes, and pricing depend on the console configuration.
- Image editing usually requires multipart/form-data file upload.
- Text-only clients cannot call image endpoints directly.
- If generation fails, try a smaller size, simplify the prompt, and check request logs for the error.
