# Design Council

A multi-perspective deliberation plugin for Claude — a panel of specialist agents convened by a Director to review high-stakes product or engineering decisions.

Built around two patterns from Anthropic's *Building Effective Agents*:

- **Orchestrator-workers** — the Director decomposes the request, picks the council members, runs them in parallel.
- **Evaluator-optimizer** — after proposers produce a working synthesis, a Red Team attacks it. The Director then produces the final brief.

## How to use

Invoke the Director skill with a decision you want reviewed. Either name a preset ("run a product-discovery council on this PRD") or describe the situation and let the Director pick. Examples:

- "Convene a design council on whether to add team-level usage analytics."
- "Run a build-vs-buy council on the customer messaging requirement."
- "I want a pre-mortem on the migration plan."

The Director will:
1. Frame the request.
2. Pick a composition (5–8 members) and tell you who.
3. Run each proposer in their own lane.
4. Draft a working synthesis.
5. Run the Red Team against the synthesis.
6. Produce a final brief with consensus, disagreements, Red Team findings, open questions, and a qualified recommendation.

## Structure

```
design-council/
├── README.md                         (this file)
├── SKILL.md                          (the orchestrator / Director — skill entry point)
├── references/
│   ├── roster.md                     (who's available, when to use them)
│   └── compositions.md               (named presets — product/engineering/hybrid)
└── members/                          (specialist roles, loaded by the Director)
    ├── product-strategist/           (why/what — is this the right thing)
    ├── product-manager/              (delivery — MVP cut, sequencing, rollout)
    ├── customer-voice/
    ├── market-competitive/
    ├── ux-design/                    (the experience)
    ├── front-end-engineer/           (how the client is built and what it costs)
    ├── data-measurement/
    ├── software-architect/
    ├── data-engineer/
    ├── security-auditor/
    ├── devops-sre/
    ├── feasibility-engineering/      (slimmed architect for product councils)
    ├── pragmatist/                   (anti-over-engineering counterweight)
    ├── red-team-product/             (adversarial pass — product mode)
    ├── red-team-engineering/         (adversarial pass — engineering mode)
    └── red-team-frontend/            (adversarial pass — client mode)
```

Each member's SKILL.md defines: what they contribute, what they don't do (lane boundaries), their output format, and the anti-patterns to avoid.

## Named compositions

**Product-mode:** `product-discovery`, `feature-prioritisation`, `gtm-decision`, `pricing-change`, `roadmap-review`.

**Front-end & feature:** `frontend-feature`, `full-stack-feature`, `design-system-decision`.

**Engineering-mode:** `architecture-review`, `incident-pre-mortem`, `migration-decision`.

**Hybrid:** `build-vs-buy`, `data-platform-decision`, `scaling-decision`.

The full list with member rosters lives in `references/compositions.md`.

## Design principles

A few decisions shape how this works:

**One plugin, composable rosters.** Product and engineering decisions are interleaved in real teams — splitting them into two plugins would force copy-paste between councils. Instead, members are composable and the Director picks the right combination per request.

**Members stay in their lane.** Every member SKILL.md has an explicit "what you do not do" section. The Software Architect doesn't propose strategy; the Product Strategist doesn't redesign databases; the Red Team doesn't propose alternatives. Lane discipline is what makes a council different from a panel of generalists.

**Dissent is the deliverable.** The Director surfaces disagreement rather than averaging. A council that produces consensus mush has wasted everyone's tokens — the value of multiple lenses is the friction.

**Every member opens with a verdict.** Each contribution starts with a three-line triage header — Verdict (proceed/revise/reject), Top concern, and whether it's a blocker. When several reports land at once the Director scans the headers first, then reads the bodies for substance. A terse header is not allowed to let a verbose report drown out the others.

**Red Team is separate and goes last.** The adversarial pass runs after the working synthesis, not in parallel with proposers. Attacking a consolidated proposal produces sharper critique than attacking nine half-formed ones. Red Team members are forbidden from proposing alternatives — they only critique.

**Small compositions over large.** Five sharp members beats eight diffuse ones. The Director defaults to the smaller composition when unsure.

## Adding new members

Drop a new directory under `members/<role-name>/` with a `SKILL.md` following the established shape:

1. YAML frontmatter with `name` and `description`.
2. Role identity (one paragraph).
3. "What you contribute" — three to five concrete contributions.
4. "What you do not do" — explicit lane boundaries with named members who own the overlap.
5. Output format — structured markdown template.
6. Anti-patterns — two to four specific failure modes for this role.

Then add the member to `references/roster.md` and to any compositions where it fits in `references/compositions.md`.
