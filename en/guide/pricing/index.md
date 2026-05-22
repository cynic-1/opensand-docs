---
title: "Pricing and Usage"
source: "https://opensand.ai/en/docs/guide/pricing"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.128Z"
---
# Pricing and Usage

OpenSand usage cost depends on the model, input and output tokens, image or video parameters, and the current site configuration. This page avoids hard-coded prices so users do not read stale numbers.

## Where To Check Pricing

- The console model or pricing page shows currently available models and rates.
- Usage logs show per-request usage and cost.
- If balance or quota is insufficient, reduce the model tier, shorten output, or add credits.

## Text Model Usage

Text models are usually billed by tokens:

- Input tokens: user messages, system prompts, and conversation history.
- Output tokens: model-generated content.
- Long context and multi-turn chat increase input tokens.

You can think of tokens as pieces of text that the model reads or writes. Longer conversations and more history increase input tokens.

### Why the Same Question Can Cost Differently

- Different model: stronger models usually cost more.
- Different output length: long answers use more output tokens.
- Different context: many previous messages increase input tokens.
- Tool calling, reasoning, image, or video features may add cost.

### Beginner Recommendation

Start with a balanced or lower-cost model while building your workflow. Switch to stronger models after prompts and product behavior are stable.

## Image and Video Usage

Image and video models may also depend on size, duration, resolution, and audio settings. Test with small images or short videos before submitting expensive jobs.

Video generation needs extra care. Duration, resolution, and audio generation can all increase cost and waiting time.

## Cost Control Tips

- Draft with a cheaper or faster model first.
- Set a reasonable `max_tokens` or output length.
- Test video prompts with short duration.
- Review usage logs regularly to find abnormal consumption.

## How To Investigate Unexpected Cost

1. Open usage logs and find the abnormal request by time.
2. Check the model to see whether a high-cost model was used.
3. Check input and output tokens to see whether context was too long.
4. Check whether a script or client is retrying in a loop.
5. Use separate API keys for separate projects to identify the source quickly.
