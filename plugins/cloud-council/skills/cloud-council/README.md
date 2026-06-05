# Cloud Architecture Council

A multi-agent skill bundle that convenes specialist cloud architects (AWS, Azure, GCP) plus a red team to design, audit, or choose a cloud for a workload — grounded in the official vendor skill repos, with disagreement preserved rather than averaged. Built to mirror the Design Council pattern.

## What's in here

```
cloud-council/
├── SKILL.md                      # the Director — orchestrator; entry point
├── README.md                     # this file
├── AGENTS.md                     # repo rules: skills-before-memory, MCP ask-first
├── members/
│   ├── aws-architect/SKILL.md    # AWS lens (Well-Architected pillars)
│   ├── azure-architect/SKILL.md  # Azure lens (WAF pillars; Learn-MCP escalation ladder)
│   ├── gcp-architect/SKILL.md    # GCP lens (Architecture Framework pillars)
│   └── red-team-cloud/SKILL.md   # adversarial pre-mortem; runs last; never proposes
├── references/
│   ├── compositions.md           # the 3 modes → which member(s) to convene
│   ├── roster.md                 # member index
│   └── house-standards.md        # YOUR conventions: tagging, IaC, landing zone, security
├── scripts/
│   └── fetch-skills.sh           # sparse-checkout install/refresh of the vendor skill repos
└── vendor-skills/                # populated by fetch-skills.sh; gitignored (not committed)
```

## Install

Drop `cloud-council/` into your agent's skills directory (e.g. `.claude/skills/` for Claude Code, or upload as a skill in Claude.ai). Put `AGENTS.md` where your agent reads project rules (repo root or alongside the skill).

The vendor skills install lazily — the Director fetches them on first use — or you can prime them now:

```bash
cd cloud-council
chmod +x scripts/fetch-skills.sh  # once, after extracting (or run via `bash scripts/fetch-skills.sh`)
./scripts/fetch-skills.sh          # installs AWS, Azure, GCP skill subtrees into vendor-skills/
./scripts/fetch-skills.sh --list   # show what's installed and when last pulled
./scripts/fetch-skills.sh --refresh# re-pull latest from upstream
```

Requires `git` and network access to github.com. In a locked-down network, point each provider at an internal mirror in the `REPOS` list at the top of the script.

## Use

Invoke in natural language — the Director's description triggers it:

- *"Convene the cloud council to audit this AWS design."* → single-cloud audit
- *"Design a serverless API on Azure."* → single-cloud design
- *"Which cloud should this data pipeline run on?"* → selection mode (all three)
- *"Refresh the cloud skills first."* → runs `fetch-skills.sh --refresh` before convening

The Director classifies the mode, states the composition for your sign-off, runs the architect(s), drafts a synthesis, runs the red team, and returns a structured brief with tensions and rejected alternatives preserved.

## Before you rely on it

Fill the four **TODO** sections in `references/house-standards.md` (landing zone, naming, approved services, security baseline). The tagging schema and Terraform/Terragrunt defaults are already filled in. Until the rest are specified, architects propose mainstream defaults and flag any decision that depends on an unset standard.

## Notes

- Grounding is local-first: the AWS and Azure vendor skills carry real depth offline; the breadth MCPs (AWS knowledge, MS Learn) are an ask-first escalation for the long tail.
- To swap Azure for the larger Learn-grounded catalogue (`MicrosoftDocs/Agent-Skills`, ~193 services, network-dependent), toggle the commented line in `scripts/fetch-skills.sh`.
