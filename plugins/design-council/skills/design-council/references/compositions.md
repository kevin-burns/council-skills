# Design Council — Compositions

Named presets the Director can convene. Each composition is a list of member skills plus a one-line description of when it fits. The Director reads this file in Step 2 of the workflow to either match a user-named preset or pick one based on the request type.

If no preset fits, the Director should compose ad-hoc using the heuristics in `roster.md`.

---

## Product-mode compositions

### `product-discovery`
*When the user is asking whether to build something, or what problem something should solve.*

- product-strategist
- customer-voice
- market-competitive
- data-measurement
- feasibility-engineering
- red-team-product

### `feature-prioritisation`
*When the user has a list of candidate features and needs to decide which to build, in what order.*

- product-strategist
- product-manager
- customer-voice
- data-measurement
- feasibility-engineering
- pragmatist
- red-team-product

### `gtm-decision`
*When the user is deciding how to launch, position, or price something.*

- product-strategist
- market-competitive
- customer-voice
- data-measurement
- red-team-product

### `pricing-change`
*When the user is changing pricing, packaging, or entitlements.*

- product-strategist
- market-competitive
- customer-voice
- data-measurement
- security-auditor *(if entitlements touch access control)*
- red-team-product

### `roadmap-review`
*When the user wants to sanity-check a roadmap.*

- product-strategist
- product-manager
- customer-voice
- data-measurement
- feasibility-engineering
- pragmatist
- red-team-product

---

## Front-end & feature compositions

### `frontend-feature`
*When the user is designing a user-facing feature and the open risk is on the client — whether the design holds up as a buildable, performant, maintainable UI.*

- product-manager
- ux-design
- front-end-engineer
- feasibility-engineering
- data-measurement
- red-team-frontend

### `full-stack-feature`
*When the user is designing a feature that spans client and backend and wants both halves reviewed together.*

- product-manager
- ux-design
- front-end-engineer
- software-architect
- data-engineer
- red-team-engineering

### `design-system-decision`
*When the user is deciding on a component library, design tokens, or a shared UI foundation.*

- front-end-engineer
- ux-design
- software-architect
- pragmatist
- red-team-frontend

---

## Engineering-mode compositions

### `architecture-review`
*When the user has a proposed design or RFC and wants a structured review.*

- software-architect
- data-engineer
- security-auditor
- devops-sre
- red-team-engineering

### `incident-pre-mortem`
*When the user wants to anticipate failure modes before launching something risky.*

- software-architect
- devops-sre
- security-auditor
- red-team-engineering
- pragmatist

### `migration-decision`
*When the user is considering migrating a system, framework, or vendor.*

- software-architect
- data-engineer
- devops-sre
- pragmatist
- red-team-engineering

---

## Hybrid compositions

### `build-vs-buy`
*When the user is deciding whether to build something in-house or buy/adopt an existing solution.*

- product-strategist
- software-architect
- security-auditor
- data-measurement
- pragmatist
- red-team-product

### `data-platform-decision`
*When the user is making a strategic decision about data infrastructure or analytics capability.*

- product-strategist
- data-engineer
- software-architect
- security-auditor
- data-measurement
- red-team-engineering

### `scaling-decision`
*When the user is deciding how to handle growth — multi-tenancy, regions, performance.*

- product-strategist
- software-architect
- devops-sre
- data-engineer
- pragmatist
- red-team-engineering

---

## Picking a composition

The Director's rule of thumb when matching a request to a preset:

If the user named a preset explicitly, use it. If they described a situation that obviously matches a preset, use that preset and tell them which one you picked. If nothing fits cleanly, compose ad-hoc from `roster.md` and explain the picks — name each member and give a 5–7 word reason.

When uncertain between two compositions, pick the smaller one. Council bloat reduces signal: every extra voice is one more reason for synthesis to drift toward consensus mush.
