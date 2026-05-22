---
title: "Technical Architecture"
source: "https://opensand.ai/en/docs/guide/wiki/basic-concepts/technical-architecture"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.129Z"
---
# Technical Architecture

OpenSand accepts client requests through a unified API entry point, then routes them to the appropriate upstream model provider according to model, provider, and policy configuration.

## Request Flow

1. A client sends a request with an API key.
2. OpenSand checks authentication, quota, model, and policy.
3. The request is routed to an available provider.
4. Usage and logs are recorded.
5. The client receives a unified response.

## What This Means for Users

- Clients only need one Base URL.
- Switching models usually means changing the `model` field.
- Troubleshooting should start from request logs.
