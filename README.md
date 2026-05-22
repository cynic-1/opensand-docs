# OpenSand Docs

Site: https://opensand.ai
API Base URL: `https://opensand.ai/v1`

Directory layout:

- `zh/`: Chinese Markdown documentation for the website
- `en/`: English Markdown documentation for the website
- `scripts/`: OpenSand setup scripts referenced by the app guides
- `pictures/apps/`: local images referenced by app integration guides
- `manifest.json`: root summary; each language also has its own `manifest.json`

Before publishing:

- Replace console screenshots and static assets with OpenSand-owned assets.
- Deploy `opensand-docs/scripts/*` to `https://opensand.ai/scripts/*`.
- Verify third-party app examples with a real OpenSand API key.
- Fill real release notes, acknowledgements, support channels, and license references.
- Private deployment, management API, admin console, payment, business, support, skills, and coding-plan docs remain excluded.
