# Technical Design

## Architecture summary
A self-hosted modular monolith backed by event-driven workflows.

- Frontend: Angular 21
- Backend: NestJS
- Database: PostgreSQL
- Cache / queue coordination: Redis
- Object storage: MinIO
- Reverse proxy: Caddy
- Workflow orchestration: Temporal recommended, BullMQ acceptable for a lighter initial build

## Why modular monolith first
The system has a shared domain model, strong transactional boundaries, and many cross-cutting concerns. A modular monolith delivers:
- simpler local development
- easier home-network deployment
- fewer distributed failure modes
- room to extract services later

## Bounded contexts
- Identity & tenancy
- CRM & onboarding
- Integrations
- Properties & listings
- Media
- Inspections
- Optimization
- Automation
- Publishing
- Billing
- Notifications
- Audit & reporting

## Frontend design
### Angular 21 principles
- standalone components only
- signals-first local state
- feature route isolation
- typed API clients
- no NgModules for new code
- SSR optional and isolated to public-marketing surfaces only

### Angular app structure
- `core/`
- `shared/`
- `features/dashboard/`
- `features/clients/`
- `features/properties/`
- `features/listings/`
- `features/media-ops/`
- `features/automation/`
- `features/publishing/`
- `features/billing/`
- `features/admin/`

## Backend design
### NestJS modules
- AuthModule
- TenancyModule
- ClientsModule
- IntegrationsModule
- PropertiesModule
- ListingsModule
- RoomsModule
- MediaModule
- InspectionsModule
- OptimizationModule
- AutomationModule
- PublishingModule
- BillingModule
- NotificationsModule
- AuditModule
- AdminModule

### Cross-cutting services
- EventBusService
- PolicyEngineService
- StorageService
- WorkflowService
- MetricsService
- SignedUrlService

## Primary flows
### New media sync
1. Receive webhook or import event
2. Resolve tenant, client, property, listing
3. Download/store originals
4. Run dedupe
5. Run CV inspections
6. Apply policy
7. Generate derivatives
8. Rank cover-photo candidates
9. Publish or create exception
10. Notify and log

### Exception review
1. Create ExceptionCase
2. Generate diff preview
3. Route to queue
4. Reviewer accepts/rejects/modifies
5. Resume workflow
6. Log outcome

### Recurring monitoring
- scheduled scans for stale media, missing room coverage, weak cover photo, low photo count, or sync drift

## Workflow orchestration
### Use Temporal when you want:
- durable stateful workflows
- step retries across long-running integrations
- replay/debug capabilities
- strong workflow visibility

### Use BullMQ when you want:
- simpler initial deployment
- lower operational overhead
- queue-based processing only

## Storage model
### Originals
Never mutate original files.

### Derivatives
Store every generated derivative with:
- transform recipe
- processing version
- creator
- policy decision
- timestamps

### Preview assets
- thumbnails
- before/after composites
- room coverage maps

## Security design
- admin access through VPN/Tailscale
- public access limited to webhook/callback endpoints
- signed media URLs
- encrypted secrets
- per-tenant row security or application-level tenancy guards
- audit event on every sensitive action

## Failure handling
- retriable workflows for transient integration failures
- dead-letter queue for repeated failures
- operator dashboard for stuck jobs
- replay support for publish and sync failures

## Performance targets
- ingest-to-score < 60s for standard photo batches
- optimize < 10s per image on baseline hardware
- publish queue latency < 2m when connected
- dashboard p95 API < 400ms for list views

## Observability
- OpenTelemetry traces
- structured JSON logs
- correlation IDs on every job
- tenant-aware metrics
- workflow state dashboard

## Trade-offs
- home-hosted infrastructure reduces hosting costs but increases network-hardening needs
- partner API variability means the app must work in assisted mode first
- full auto-publish requires a conservative rules engine
