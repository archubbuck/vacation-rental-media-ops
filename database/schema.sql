-- PostgreSQL schema for Vacation Rental Media Operations Platform

create extension if not exists pgcrypto;

create table organizations (
  id uuid primary key default gen_random_uuid(),
  name text not null,
  slug text not null unique,
  created_at timestamptz not null default now()
);

create table workspaces (
  id uuid primary key default gen_random_uuid(),
  organization_id uuid not null references organizations(id) on delete cascade,
  name text not null,
  created_at timestamptz not null default now()
);

create table users (
  id uuid primary key default gen_random_uuid(),
  email text not null unique,
  display_name text not null,
  password_hash text,
  created_at timestamptz not null default now()
);

create table role_assignments (
  id uuid primary key default gen_random_uuid(),
  user_id uuid not null references users(id) on delete cascade,
  workspace_id uuid not null references workspaces(id) on delete cascade,
  role_name text not null,
  unique (user_id, workspace_id, role_name)
);

create table client_accounts (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references workspaces(id) on delete cascade,
  name text not null,
  legal_name text,
  timezone text,
  billing_email text,
  status text not null default 'active',
  created_at timestamptz not null default now()
);

create table billing_plans (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references workspaces(id) on delete cascade,
  name text not null,
  billing_model text not null,
  monthly_price_cents integer,
  per_property_price_cents integer,
  per_publish_event_price_cents integer,
  per_photo_price_cents integer,
  created_at timestamptz not null default now()
);

create table contracts (
  id uuid primary key default gen_random_uuid(),
  client_account_id uuid not null references client_accounts(id) on delete cascade,
  billing_plan_id uuid references billing_plans(id),
  standing_authorization boolean not null default false,
  signed_at timestamptz,
  starts_at timestamptz,
  ends_at timestamptz,
  status text not null default 'draft'
);

create table integration_connections (
  id uuid primary key default gen_random_uuid(),
  client_account_id uuid not null references client_accounts(id) on delete cascade,
  provider text not null,
  mode text not null,
  status text not null default 'pending',
  external_account_id text,
  encrypted_credentials jsonb,
  settings jsonb not null default '{}'::jsonb,
  last_sync_at timestamptz,
  created_at timestamptz not null default now()
);

create table properties (
  id uuid primary key default gen_random_uuid(),
  client_account_id uuid not null references client_accounts(id) on delete cascade,
  external_property_key text,
  name text not null,
  address_line_1 text,
  address_line_2 text,
  city text,
  region text,
  postal_code text,
  country_code text,
  timezone text,
  status text not null default 'active',
  readiness_score numeric(5,2),
  last_scan_at timestamptz,
  created_at timestamptz not null default now()
);

create table channel_listings (
  id uuid primary key default gen_random_uuid(),
  property_id uuid not null references properties(id) on delete cascade,
  channel text not null,
  external_listing_id text,
  sync_mode text not null default 'assisted',
  publish_state text not null default 'draft',
  cover_photo_asset_id uuid,
  published_photo_count integer not null default 0,
  last_sync_at timestamptz,
  unique (property_id, channel)
);

create table rooms (
  id uuid primary key default gen_random_uuid(),
  property_id uuid not null references properties(id) on delete cascade,
  room_type text not null,
  label text not null,
  sort_order integer not null default 0,
  is_required boolean not null default false
);

create table photo_assets (
  id uuid primary key default gen_random_uuid(),
  property_id uuid not null references properties(id) on delete cascade,
  channel_listing_id uuid references channel_listings(id) on delete set null,
  source_type text not null,
  source_url text,
  storage_key text not null,
  width integer,
  height integer,
  mime_type text,
  sha256 text not null,
  room_id uuid references rooms(id) on delete set null,
  capture_type text,
  original_uploaded_at timestamptz,
  created_at timestamptz not null default now()
);

alter table channel_listings
  add constraint fk_cover_photo_asset
  foreign key (cover_photo_asset_id) references photo_assets(id) on delete set null;

create table photo_inspections (
  id uuid primary key default gen_random_uuid(),
  photo_asset_id uuid not null references photo_assets(id) on delete cascade,
  brightness_score numeric(5,2),
  blur_score numeric(5,2),
  tilt_score numeric(5,2),
  white_balance_score numeric(5,2),
  duplicate_group text,
  room_classifier_label text,
  room_classifier_confidence numeric(5,4),
  publishability_score numeric(5,2),
  issues_json jsonb not null default '[]'::jsonb,
  created_at timestamptz not null default now()
);

create table photo_versions (
  id uuid primary key default gen_random_uuid(),
  photo_asset_id uuid not null references photo_assets(id) on delete cascade,
  parent_version_id uuid references photo_versions(id) on delete set null,
  version_type text not null,
  storage_key text not null,
  transform_recipe_json jsonb not null default '{}'::jsonb,
  approved_by_policy boolean not null default false,
  created_at timestamptz not null default now()
);

create table optimization_presets (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references workspaces(id) on delete cascade,
  name text not null,
  preset_type text not null,
  settings_json jsonb not null default '{}'::jsonb,
  is_default boolean not null default false,
  created_at timestamptz not null default now()
);

create table automation_policies (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references workspaces(id) on delete cascade,
  scope_type text not null,
  scope_id uuid not null,
  auto_optimize boolean not null default true,
  auto_publish boolean not null default false,
  require_review_on_large_delta boolean not null default true,
  min_resolution_width integer,
  min_resolution_height integer,
  room_confidence_threshold numeric(5,4),
  max_edit_delta numeric(5,4),
  reorder_strategy text,
  notify_on_publish boolean not null default true,
  created_at timestamptz not null default now()
);

create table optimization_jobs (
  id uuid primary key default gen_random_uuid(),
  property_id uuid not null references properties(id) on delete cascade,
  trigger_type text not null,
  status text not null default 'queued',
  preset_id uuid references optimization_presets(id),
  started_at timestamptz,
  completed_at timestamptz,
  created_at timestamptz not null default now()
);

create table publish_jobs (
  id uuid primary key default gen_random_uuid(),
  channel_listing_id uuid not null references channel_listings(id) on delete cascade,
  source_version_set_json jsonb not null default '[]'::jsonb,
  publish_mode text not null,
  status text not null default 'queued',
  request_payload_json jsonb not null default '{}'::jsonb,
  response_payload_json jsonb,
  started_at timestamptz,
  completed_at timestamptz,
  created_at timestamptz not null default now()
);

create table sync_events (
  id uuid primary key default gen_random_uuid(),
  integration_connection_id uuid references integration_connections(id) on delete set null,
  external_event_id text,
  event_type text not null,
  payload_json jsonb not null default '{}'::jsonb,
  status text not null default 'received',
  created_at timestamptz not null default now()
);

create table exception_cases (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references workspaces(id) on delete cascade,
  property_id uuid references properties(id) on delete set null,
  channel_listing_id uuid references channel_listings(id) on delete set null,
  job_type text not null,
  reason_code text not null,
  severity text not null default 'medium',
  state text not null default 'open',
  context_json jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now(),
  resolved_at timestamptz
);

create table invoices (
  id uuid primary key default gen_random_uuid(),
  client_account_id uuid not null references client_accounts(id) on delete cascade,
  period_start date,
  period_end date,
  subtotal_cents integer not null default 0,
  tax_cents integer not null default 0,
  total_cents integer not null default 0,
  status text not null default 'draft',
  issued_at timestamptz,
  paid_at timestamptz,
  created_at timestamptz not null default now()
);

create table notifications (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references workspaces(id) on delete cascade,
  user_id uuid references users(id) on delete set null,
  channel text not null,
  subject text not null,
  body text not null,
  status text not null default 'queued',
  created_at timestamptz not null default now(),
  sent_at timestamptz
);

create table audit_events (
  id uuid primary key default gen_random_uuid(),
  workspace_id uuid not null references workspaces(id) on delete cascade,
  actor_user_id uuid references users(id) on delete set null,
  event_type text not null,
  entity_type text not null,
  entity_id uuid,
  metadata_json jsonb not null default '{}'::jsonb,
  created_at timestamptz not null default now()
);

create index idx_properties_client on properties(client_account_id);
create index idx_listings_property on channel_listings(property_id);
create index idx_photo_assets_property on photo_assets(property_id);
create index idx_photo_versions_asset on photo_versions(photo_asset_id);
create index idx_publish_jobs_listing on publish_jobs(channel_listing_id);
create index idx_exception_cases_workspace_state on exception_cases(workspace_id, state);
create index idx_audit_events_workspace_created on audit_events(workspace_id, created_at desc);
