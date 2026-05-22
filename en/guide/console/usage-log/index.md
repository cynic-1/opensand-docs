---
title: "Usage Logs"
source: "https://opensand.ai/en/docs/guide/console/usage-log"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.129Z"
---
# Usage Logs

Usage logs help troubleshoot requests and analyze cost.

## What To Check

- Request time: locate when an issue happened.
- Model: confirm the expected model was used.
- Status code: identify success, auth failure, rate limit, or model errors.
- Tokens and cost: understand where spending comes from.

## Common Troubleshooting

| Symptom | Check |
|---|---|
| 401 | API key correctness |
| 429 | Rate limit or quota |
| Model not found | Model ID spelling |
| Unexpected cost | Long context or expensive model settings |

## How To Read a Log Entry

A log entry usually answers four questions:

1. Who called it: API key or user information.
2. What was called: model and endpoint path.
3. Did it work: status code and error message.
4. How much it cost: tokens, image/video parameters, and usage cost.

When a user says a tool does not work, ask them to send one request from the tool, then refresh logs. If no log appears, the client likely did not reach OpenSand.
