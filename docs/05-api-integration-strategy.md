# API and Integration Strategy

## Principle
The system should be API-capable, not API-dependent. It must be useful on day one in assisted mode and become more automatic as official integrations are approved.

## Supported integration modes
### 1. Assisted mode
- client uploads originals
- folder watch / object store drop-zone
- CSV or manifest import
- export package generation

### 2. Connected mode
- PMS/channel manager integration
- official Airbnb software-connected workflow
- official Vrbo/Expedia integration path
- webhooks for changes and confirmations

## Adapter model
Every integration implements:
- `validateConnection()`
- `discoverProperties()`
- `syncListing()`
- `listMedia()`
- `downloadMedia()`
- `publishMedia()`
- `reconcilePublishState()`
- `receiveWebhook()`

## Integration priorities
### Priority 1
- folder watch adapter
- CSV import adapter
- client portal upload adapter

### Priority 2
- PMS/channel manager adapter(s)
- generic import normalizer
- webhook framework

### Priority 3
- Airbnb software-connected adapter
- Vrbo/Expedia adapter
- listing-state reconciliation

## OAuth and secret handling
- never store plaintext access tokens in the database
- encrypt credentials at rest
- rotate refresh tokens when possible
- separate tenant secrets from app secrets
- support revocation workflow

## Publish modes
### Connected push
Preferred when officially supported.

### Assisted export
Generate:
- optimized image set
- sequence manifest
- cover-photo recommendation
- operator checklist
- version report

### Review-only
For prospects or low-trust accounts.

## Webhook rules
- public HTTPS endpoint only
- signature verification when available
- replay protection
- idempotent event handling
- correlation IDs for every event
