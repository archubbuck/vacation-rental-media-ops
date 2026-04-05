# Design System

## Design intent
Build an operator-grade control center that feels modern, clean, and trustworthy. The UI should look optimized for long working sessions, dense data, and frequent status scanning.

## Theme direction
- Dark default theme for operator console
- Optional light theme later
- Cool slate neutrals with electric blue primary actions and cyan highlights
- High information density without visual clutter

## Color system

### Core neutrals
- `--color-bg-page`: `#0B1220`
- `--color-bg-canvas`: `#111827`
- `--color-bg-surface-1`: `#172033`
- `--color-bg-surface-2`: `#1F2A3D`
- `--color-bg-surface-3`: `#253247`
- `--color-border-subtle`: `#334155`
- `--color-border-strong`: `#475569`
- `--color-text-primary`: `#F8FAFC`
- `--color-text-secondary`: `#CBD5E1`
- `--color-text-muted`: `#94A3B8`

### Brand / interactive
- `--color-primary-500`: `#3B82F6`
- `--color-primary-600`: `#2563EB`
- `--color-primary-700`: `#1D4ED8`
- `--color-accent-500`: `#06B6D4`
- `--color-accent-600`: `#0891B2`
- `--color-focus-ring`: `#60A5FA`

### Status
- `--color-success-500`: `#22C55E`
- `--color-warning-500`: `#F59E0B`
- `--color-danger-500`: `#EF4444`
- `--color-info-500`: `#38BDF8`

### Data visualization
- quality score: blue gradient
- publish success: green
- exceptions: amber
- failures: red
- manual touch: violet
- stale media: orange

## Spacing scale
4px base grid.

- `--space-0`: 0
- `--space-1`: 4px
- `--space-2`: 8px
- `--space-3`: 12px
- `--space-4`: 16px
- `--space-5`: 20px
- `--space-6`: 24px
- `--space-8`: 32px
- `--space-10`: 40px
- `--space-12`: 48px
- `--space-16`: 64px

Usage:
- control padding: 10-14px vertical, 14-16px horizontal
- card padding: 20px
- section spacing: 24px
- page gutters: 24px desktop / 16px tablet
- modal body padding: 24px

## Radius scale
- `--radius-sm`: 8px
- `--radius-md`: 12px
- `--radius-lg`: 16px
- `--radius-xl`: 20px
- `--radius-pill`: 999px

## Typography
Use Inter or system UI fallback.

### Type scale
- `--font-size-12`: 12px
- `--font-size-13`: 13px
- `--font-size-14`: 14px
- `--font-size-16`: 16px
- `--font-size-18`: 18px
- `--font-size-20`: 20px
- `--font-size-24`: 24px
- `--font-size-32`: 32px

### Weights
- regular: 400
- medium: 500
- semibold: 600
- bold: 700

### Rules
- list/table content defaults to 14px
- secondary metadata at 12-13px
- page titles 24px
- module titles 18-20px
- uppercase labels only for very small UI accents, not for general navigation

## Elevation / surfaces
- cards use subtle internal border + soft shadow
- navigation uses a stronger contrast band than content panels
- modals sit above a 60% black scrim

Shadows:
- `--shadow-sm`: `0 1px 2px rgba(0,0,0,.18)`
- `--shadow-md`: `0 8px 24px rgba(0,0,0,.22)`
- `--shadow-lg`: `0 16px 40px rgba(0,0,0,.28)`

## Layout
### Shell
- left nav: 280px desktop, collapsible to 88px
- top app bar: 64px
- content max width: fluid, optimized for operational dashboards
- right utility panel optional for review queues and quick stats

### Grid
- 12-column content grid
- standard card spans:
  - KPI card: 3 cols
  - detail chart: 6 cols
  - full table: 12 cols

## Component specifics
### Buttons
- primary: blue filled
- secondary: slate surface with border
- tertiary: text-only
- danger: red filled or outlined depending on prominence

States:
- hover: +4% brightness or slightly darker border
- active: inset shadow
- disabled: 50% opacity, no strong shadow

### Inputs
- default height: 40px
- bg surface 1
- 1px subtle border
- focus: 2px ring using focus token
- invalid: danger border + helper text

### Tables
- row height: 44px compact / 52px standard
- sticky header
- zebra striping optional and subtle
- status chips aligned with score cells
- right-align numeric columns

### Cards
- padding: 20px
- header section with title + action group
- footer optional, separated by 1px top border
- KPI cards use large numeric value + small trend delta

### Navigation
- icon + label rows
- active item uses surface 3 + blue accent line
- group headings muted and small

### Status chips
- rounded pill
- 24-28px height
- icon optional
- use tinted fills rather than fully saturated blocks

## Motion
- 120-180ms for hover/focus
- 180-240ms for drawers and modals
- avoid overly springy motion in ops contexts
- skeleton loaders preferred over spinners for data tables

## Accessibility
- WCAG AA contrast minimum
- full keyboard navigation
- visible focus ring always on keyboard focus
- do not encode status by color alone
- charts need labels and tooltips
- every workflow status visible in text

## Page-specific direction
### Dashboard
- KPI strip at top
- operational alerts left
- trend charts center
- queue and publish activity right

### Property detail
- hero header with property summary
- room coverage and listing health cards
- tabbed sub-sections: photos, listings, automation, history

### Media review
- split layout:
  - left: queue/table
  - center: before/after compare
  - right: issue list + actions

## Brand voice in UI
- direct
- calm
- operational
- never cute or playful
- precise labels over marketing language
