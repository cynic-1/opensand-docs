---
title: "API Tokens"
source: "https://opensand.ai/en/docs/guide/console/api-token"
adapted_for: "OpenSand"
adapted_at: "2026-05-22T02:54:35.129Z"
---
# API Tokens

API tokens are used to call OpenSand APIs. Use separate tokens for different projects, tools, or team members.

## Recommendations

- Use a different API key for each project.
- Do not commit API keys to public repositories.
- Delete and recreate a key immediately if it is exposed.
- Use a separate key for automation so usage is easy to track.

## How To Use a Token

Add this request header:

```http
Authorization: Bearer sk-your-api-key
```

Client tools should use the same value in their API Key field.

## Common Beginner Questions

| Question | Answer |
|---|---|
| Should I include quotes around the key? | Not in client fields. In code, quote it according to the programming language. |
| Is Base URL part of the key? | No. Base URL is the endpoint; API key is the credential. |
| Can one key be shared by multiple tools? | Yes, but separate keys make logs and cost easier to track. |
| What if a key is exposed? | Delete it immediately and create a new one. |

## Security Tips

- Do not expose API keys in frontend code.
- Do not commit `.env`, config files, or screenshots containing keys.
- In production, use environment variables or secret management.
