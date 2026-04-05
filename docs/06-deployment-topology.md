# Deployment Topology

## Goal
Run the platform on a home network while keeping operational surfaces private and only exposing the minimum public ingress required for callbacks and webhooks.

## Topology
### Public edge host
- Caddy reverse proxy
- TLS
- routes:
  - `/api/*`
  - `/webhooks/*`
  - `/oauth/callback/*`
- rate limiting
- access logs

### Private application tier
- Angular app container
- NestJS API container
- worker container
- Temporal or queue worker container

### Data tier
- PostgreSQL
- Redis
- MinIO
- local backup target / NAS

## Security posture
- admin traffic over Tailscale or VPN
- database and Redis not publicly routable
- MinIO private by default
- only signed URLs for temporary media access
- separate secrets per environment

## Suggested host layout
### Host A: edge / ingress
- Caddy
- Fail2ban or equivalent
- optional Cloudflare Tunnel if you do not want direct inbound port forwarding

### Host B: app
- web
- api
- worker

### Host C: data
- postgres
- redis
- minio
- backup service

A single stronger host can collapse these roles for initial development, but keep the logical separation.

## Backup strategy
- nightly PostgreSQL dump
- object storage replication or snapshot
- weekly configuration backup
- monthly restore drill

## Monitoring
- uptime check for public endpoints
- disk capacity alerts
- queue depth alerts
- failed workflow alerts
- webhook rejection alerts
