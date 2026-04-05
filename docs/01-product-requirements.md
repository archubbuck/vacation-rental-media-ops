# Product Requirements Document (PRD)

## Product name
Vacation Rental Media Operations Platform

## Product vision
Help hosts and property managers maintain platform-ready, high-performing listing photo sets with as much automation as possible while preserving accuracy, auditability, and channel compliance.

## Problem statement
Vacation-rental teams lose time and booking performance because photo sets degrade over time:
- low-light or poorly composed images stay live too long
- cover photos are weak
- rooms are underrepresented
- new images arrive without optimization
- different channels drift out of sync
- teams lack a centralized workflow to approve, publish, and monitor changes

## Goals
1. Reduce manual effort for media intake, scoring, enhancement, ordering, and publishing.
2. Improve listing readiness and visual consistency across channels.
3. Preserve accurate representation of the property.
4. Support a self-hosted deployment model.
5. Provide a full management system, not a single-purpose editor.

## Non-goals
- Generative staging by default
- Unsupported scraping as a primary integration model
- Full PMS feature parity beyond listing/media operations
- Direct booking engine

## Primary users
- Solo host
- Small vacation-rental operator
- Property manager
- Internal media ops reviewer
- Platform admin

## Core user stories
### Client onboarding
- As an operator, I can create a client account, connect data sources, and define standing automation policies.
- As an admin, I can onboard a new client without engineering involvement.

### Property/listing management
- As an operator, I can view a canonical property record and its connected Airbnb/Vrbo listings.
- As a reviewer, I can see room coverage, cover photo status, and listing health at a glance.

### Media operations
- As an operator, I can ingest new media automatically from connected systems or client uploads.
- As a reviewer, I can inspect before/after versions and approve only policy exceptions.
- As a client, I can let safe edits auto-run without reviewing every job.

### Publishing
- As an operator, I can push approved media updates to connected channels or export a ready-to-upload asset package.
- As a client, I receive a summary when a change is auto-published.

### Monitoring
- As an account manager, I can see which listings are at risk because of weak cover photos, low photo count, or stale media.

## Success metrics
- % of jobs completed with zero human touch
- median turnaround time per photo batch
- % of listings with full room coverage
- publish success rate by channel
- exception rate by policy rule
- active properties per operator
- recurring revenue per client

## Functional requirements
### Required for v1
- Multitenant web app
- Authentication and role-based access control
- Client onboarding
- Property and listing records
- Media ingest
- Photo scoring and room classification
- Safe enhancement pipeline
- Policy-based approval engine
- Publish queue
- Manual export workflow
- Billing and invoicing
- Notifications
- Audit trail
- Reporting dashboards
- Admin support tools

### Required for v1.1
- PMS/channel manager connectors
- Webhook-driven sync
- Auto-publish in connected mode
- Exception replay tools
- Portfolio benchmarking

## Business rules
- Safe edits may auto-run if explicitly allowed by client policy.
- Any blocked or ambiguous change must create an exception case.
- Every publish attempt must be logged with request, response, and acting policy.
- Every photo asset must retain the original file and version history.
- Listing health rules are channel aware.

## Channel-specific policy examples
### Airbnb
- Prefer landscape orientation.
- Require minimum publishable resolution.
- Preserve room accuracy and content compliance.
- Support software-connected workflows and auditability.

### Vrbo
- Optimize the first search-facing image.
- Enforce minimum photo-count safeguards.
- Prefer high-resolution horizontal images.
- Preserve publish-state visibility by listing.

## Commercial plans
### Starter
- 1 workspace
- 1-25 properties
- upload/import mode
- manual export publishing

### Growth
- 1 workspace
- up to 250 properties
- automation policies
- review queue
- recurring monitoring

### Enterprise
- multiple workspaces
- connected integrations
- approval routing
- SLA dashboards
- custom branding
- advanced audit export

## Risks
- partner API approval timing
- webhook/network reliability on home-hosted infrastructure
- weak source media quality
- over-editing that changes guest expectations
- channel rules changing over time

## Release strategy
### Phase 1
Assisted mode with uploads/imports, media scoring, optimization, review, export, and billing.

### Phase 2
Automation center, recurring monitoring, exceptions, audit hardening, and reporting.

### Phase 3
Connected PMS/channel manager integrations and auto-publish inside policy bounds.

### Phase 4
Portfolio intelligence, experimental ranking, and enterprise controls.
