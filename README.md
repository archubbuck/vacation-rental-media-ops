# Vacation Rental Media Operations Platform — Starter Kit

This starter kit provides a concrete foundation for a self-hosted, automation-first web app focused on vacation-rental listing media operations.

## Stack
- Angular 21 web app
- NestJS API
- PostgreSQL + Redis
- MinIO object storage
- Docker Compose home-network deployment
- Event-driven workflows with Temporal or BullMQ

## What is included
- `docs/01-product-requirements.md`
- `docs/02-technical-design.md`
- `docs/03-design-system.md`
- `docs/04-automation-rules.md`
- `docs/05-api-integration-strategy.md`
- `docs/06-deployment-topology.md`
- `database/schema.sql`
- `apps/web/*` Angular 21 scaffold
- `apps/api/*` NestJS scaffold
- `infrastructure/*` Docker and reverse proxy configuration

## Product summary
The platform ingests listing media from authorized sources, evaluates quality and room coverage, applies safe enhancement presets, enforces channel-specific rules, and auto-publishes when the changes are within preapproved client policy bounds.

## Design summary
The UI uses a dark modern operator-console style with cool slate neutrals, electric blue primary actions, cyan highlights, a 4px spacing grid, density-aware data tables, and accessible color contrast.

## Verified external constraints
- Angular 21 is the latest major release and Angular 21 supports Node `^20.19.0 || ^22.12.0 || ^24.0.0` and TypeScript `>=5.9.0 <6.0.0`.
- Airbnb software-connected listings can be created and managed through integrated PMS/channel-manager software.
- Airbnb requires software-created listings to comply with listing policies.
- Expedia Group's notification service uses HTTPS webhooks to the integrator's endpoint.

See the docs for details and the final response for citations.
