# Cloud Council — Roster

The Director reads this when picking a composition. Member SKILL.md files under `members/<name>/` are the authoritative role definitions; load one only when about to run it.

| Member | File | Cloud lane | Role |
|---|---|---|---|
| AWS Architect | `members/aws-architect/SKILL.md` | AWS only | Design/audit on AWS across the Well-Architected pillars |
| Azure Architect | `members/azure-architect/SKILL.md` | Azure only | Design/audit on Azure across the WAF pillars |
| GCP Architect | `members/gcp-architect/SKILL.md` | GCP only | Design/audit on GCP across the Architecture Framework pillars |
| Cloud Red Team | `members/red-team-cloud/SKILL.md` | cloud-agnostic | Adversarial pre-mortem on the synthesised proposal; runs last; never proposes |

Each architect grounds itself in its provider's cache under `vendor-skills/<provider>/skills/` and in `references/house-standards.md`. The Director never convenes more than one architect in single-cloud mode; selection mode convenes all three; hybrid convenes the relevant subset. The Red Team runs in every mode, exactly once, at the end.
