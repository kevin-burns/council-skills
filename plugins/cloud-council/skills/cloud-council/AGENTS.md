# Cloud work — agent rules

These rules govern how the agent handles any public-cloud architecture task in this repo. They exist because an agent with skills and MCP installed will, by default, still answer from training-data recall and ignore both — and because live documentation MCP calls are accurate but expensive.

## Grounding order (highest to lowest)

1. **Installed cloud skills and their bundled reference files**, cached under `cloud-council/vendor-skills/<provider>/skills/` (populated by `cloud-council/scripts/fetch-skills.sh`). For AWS, Azure, or GCP questions, consult the relevant installed skill before answering. This is free — reference files are local reads, and progressive disclosure means only what's needed loads into context. If the cache is empty, run the fetch script once.
2. **The house standards** in `cloud-council/references/house-standards.md` — landing zone, naming/tagging, approved services, IaC tool, security baseline. House standards override generic best practice.
3. **Your own knowledge** — only for stable fundamentals, never for service limits, pricing, region availability, or "newest" features, which go stale.
4. **Live documentation MCP** (AWS knowledge, MS Learn) — **opt-in only.** Do not call these to answer routine questions. Use them only when a decision genuinely hinges on a current detail you can't confirm from the installed skills, and only after asking the user — these calls pull documentation into context and consume tokens quickly in a metered environment. Deferring to the provider's breadth MCP (Learn for Azure, AWS knowledge for AWS) on a genuine gap the local skills don't cover is *expected and correct* — the failure mode is answering from memory instead of escalating. It stays ask-first.

## When to invoke the Cloud Council

For a one-off factual question ("what's the max message size on SQS"), answer directly from the AWS skill — do not convene the council. Convene the council (the `cloud-council` skill) when the task is a real architecture decision: designing a workload, auditing an existing design, or choosing a cloud. The council is for deliberation, not lookups.

## MCP discipline

Before any MCP documentation call, state in one line what you couldn't confirm from the installed skills and why a live check is warranted, then wait for the user's go-ahead. Never chain MCP calls to "be thorough."
