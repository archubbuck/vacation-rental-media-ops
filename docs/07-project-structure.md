# Project Structure

```text
vacation-rental-ops-starter-kit/
├── README.md
├── .env.example
├── package.json
├── apps/
│   ├── web/
│   │   ├── package.json
│   │   └── src/
│   │       ├── app/
│   │       │   ├── app.component.html
│   │       │   └── app.component.ts
│   │       ├── index.html
│   │       ├── main.ts
│   │       └── styles.css
│   └── api/
│       ├── package.json
│       └── src/
│           ├── app.module.ts
│           ├── main.ts
│           └── modules/
│               ├── automation/
│               ├── health/
│               ├── properties/
│               └── publishing/
├── database/
│   └── schema.sql
├── docs/
│   ├── 01-product-requirements.md
│   ├── 02-technical-design.md
│   ├── 03-design-system.md
│   ├── 04-automation-rules.md
│   ├── 05-api-integration-strategy.md
│   ├── 06-deployment-topology.md
│   └── 07-project-structure.md
├── infrastructure/
│   ├── caddy/
│   │   └── Caddyfile
│   └── docker-compose.yml
└── packages/
    └── design-tokens/
        └── tokens.css
```
