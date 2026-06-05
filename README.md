# Council Skills

> Claude Code plugin marketplace providing two multi-perspective deliberation councils. A Director agent convenes specialist roles, runs each in its own lane, has a red team attack the synthesis, and preserves disagreement instead of averaging it. Pattern source: Anthropic, *Building Effective Agents* (orchestrator-workers + evaluator-optimizer).

- **Marketplace name:** `council-skills`
- **Owner:** `kevin-burns`
- **Repo:** `https://github.com/kevin-burns/council-skills`
- **Plugins provided:** `cloud-council`, `design-council`
- **Install model:** Claude Code marketplace (one repo, two independently installable plugins)
- **License:** MIT

## Quick install

Run these in a Claude Code session. Add the marketplace once, then install either or both plugins.

```text
/plugin marketplace add kevin-burns/council-skills
/plugin install cloud-council@council-skills
/plugin install design-council@council-skills
```

Non-interactive CLI equivalent:

```bash
claude plugin marketplace add kevin-burns/council-skills
claude plugin install cloud-council@council-skills
claude plugin install design-council@council-skills
```

The plugins are independent — installing one does not require the other.

## Plugins

| Plugin | Skill name (trigger) | Domain | Use for |
|--------|----------------------|--------|---------|
| `cloud-council` | `cloud-council-director` | Public-cloud architecture (AWS / Azure / GCP) | Designing, auditing, or choosing a cloud for a workload |
| `design-council` | `design-council-director` | Product + engineering decisions | Build-vs-buy, RFC/architecture review, roadmap/PRD review, pre-mortems |

### cloud-council

**Purpose:** Produce a multi-pillar public-cloud architecture decision from a specialist cloud architect, stress-tested by a red team. Pillar tensions (cost vs. reliability, security vs. simplicity) are named, not averaged.

**Modes:**
1. `single-cloud` (default) — design or audit a workload on one named cloud.
2. `cloud-selection` — compare AWS/Azure/GCP for a workload not yet placed.
3. `hybrid` — only when a workload genuinely spans clouds.

**Invoke with phrases like:**
- "Convene a cloud council to design a multi-region event pipeline on AWS."
- "Run a cloud-selection council: AWS vs Azure for our data platform."
- "Audit this Terraform architecture for the Well-Architected reliability pillar."
- "Pre-mortem this landing-zone design."

**Runtime dependency (first use):** The architects ground reasoning in upstream AWS/Azure/GCP skills that are fetched on first use, not committed. The skill runs `scripts/fetch-skills.sh` to sparse-checkout the upstream `skills/` subtrees into a git-ignored `vendor-skills/` cache. Live-documentation MCP servers (AWS Knowledge, MS Learn) are opt-in: the council asks before making metered calls. Grounding order is defined in the plugin's `AGENTS.md`.

### design-council

**Purpose:** Review a high-stakes product or engineering decision with a panel of specialist roles (product strategy, PM/delivery, software architecture, front-end, UX, security, data, go-to-market). Each contributes in its own lane; a red team runs a pre-mortem; the Director synthesises with disagreements surfaced.

**Invoke with phrases like:**
- "Run a design council on whether to build or buy customer messaging."
- "Convene a design council on adding team-level usage analytics."
- "I want a pre-mortem on this migration plan."
- "Review this PRD from product, security, and market angles."

## How a council runs

Both councils follow the same Director-orchestrated sequence:

1. **Frame** — restate the decision as an unambiguous brief.
2. **Compose** — select the specialist members (stated to the user before running).
3. **Propose** — run each member independently, in its own lane, one at a time.
4. **Synthesise (working)** — combine proposals; record alignment, disagreement, and open questions without flattening.
5. **Red team** — one adversarial pass (pre-mortem, unstated assumptions, failure scenarios) against the working synthesis.
6. **Final brief** — consensus, disagreements, red-team findings, open questions, a qualified recommendation, considered alternatives, and next steps.

## Repository layout

```text
council-skills/
├── .claude-plugin/
│   └── marketplace.json                         # marketplace manifest; lists both plugins via relative source paths
├── plugins/
│   ├── cloud-council/
│   │   ├── .claude-plugin/plugin.json           # plugin manifest
│   │   └── skills/cloud-council/
│   │       ├── SKILL.md                          # Director skill (entry point; frontmatter name: cloud-council-director)
│   │       ├── AGENTS.md                          # grounding rules (skills-before-memory, MCP opt-in)
│   │       ├── members/                           # aws-architect, azure-architect, gcp-architect, red-team-cloud
│   │       ├── references/                        # compositions.md, roster.md, house-standards.md
│   │       ├── scripts/fetch-skills.sh            # lazy-fetch upstream cloud skills into vendor-skills/
│   │       └── vendor-skills/                     # runtime cache (git-ignored, not committed)
│   └── design-council/
│       ├── .claude-plugin/plugin.json
│       └── skills/design-council/
│           ├── SKILL.md                          # Director skill (entry point; frontmatter name: design-council-director)
│           ├── members/                           # 16 specialist + red-team roles
│           └── references/                        # compositions.md, roster.md
├── LICENSE
└── README.md
```

## When NOT to use these

- For a one-off factual lookup ("max SQS message size?"), answer directly — do not convene a council.
- For line-level code/PR bug review, use a code-review tool, not a council.
- For open-ended idea generation, use brainstorming, not a council.

A council is for **deliberation over a real decision**, where a single perspective is insufficient and dissent is the signal.

## License

MIT © Kevin Burns. See [LICENSE](LICENSE).
