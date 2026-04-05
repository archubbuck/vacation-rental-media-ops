# Automation Rules

## Principle
Automate everything that is low-risk, deterministic, and already approved by policy. Route only exceptions to people.

## Default allowed operations
- exposure correction
- white balance normalization
- straightening
- mild perspective correction
- crop optimization
- denoise / sharpen within safe thresholds
- duplicate suppression
- derivative resizing and export packaging
- sequence reordering by ranking model

## Default blocked operations
- object insertion or removal
- misleading staging
- fabricated views or amenities
- room relabeling below confidence threshold
- publish when minimum channel requirements are not met

## Policy fields
- `autoOptimize`
- `autoPublish`
- `roomConfidenceThreshold`
- `maxEditDelta`
- `reorderStrategy`
- `notifyOnPublish`
- `requireReviewOnLargeDelta`
- `minResolutionWidth`
- `minResolutionHeight`

## Routing rules
### Auto-complete
All inspections pass and transforms stay within approved thresholds.

### Create exception
- room classifier confidence below threshold
- transform delta too large
- photo count minimum at risk
- conflicting publish state
- integration publish failure
- missing rights/authorization signal

## Event triggers
### Immediate
- new upload
- new media sync
- failed publish retries
- low photo count risk
- integration health checks

### Weekly
- stale media age report
- weak cover photo detection
- duplicate set cleanup suggestions
- missing room coverage report

### Monthly
- portfolio scorecard
- manual touch rate analysis
- rule tuning suggestions

## Workflow templates
### Template: new-photo-webhook
1. fetch source metadata
2. create SyncEvent
3. queue ingest
4. inspect assets
5. run policy
6. create versions
7. publish or route exception

### Template: listing-health-rescan
1. scan listing media
2. compute readiness score
3. compare against prior baseline
4. create recommendations or jobs

### Template: exception-review
1. notify reviewer
2. open compare view
3. capture disposition
4. resume workflow
5. close loop with audit entry
