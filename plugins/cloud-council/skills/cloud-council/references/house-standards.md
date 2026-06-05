# House Standards

The organisation's own conventions. Every architect aligns its proposal to this file and calls out deviations; the Red Team treats a silent deviation as a finding. This is the council's differentiation — keep it current. Sections marked **TODO** need filling; the architects will flag when a decision depends on a TODO that isn't yet specified.

`client_name` throughout is a placeholder for the actual client/tenant namespace token, substituted per engagement.

## Infrastructure as code

The house IaC tooling is **Terraform**, orchestrated with **Terragrunt** where multi-environment / multi-account composition warrants it. This is the default across all three clouds — architects express designs in Terraform/Terragrunt, not CDK, Bicep, or ARM, unless this file says otherwise for a specific case.

- Module conventions: **TODO** — module registry/source, versioning policy, root-vs-child module layout.
- Terragrunt usage: **TODO** — when Terragrunt wraps Terraform vs. plain Terraform; remote-state backend and locking; the `_envcommon` / live-layout convention if used.
- State: **TODO** — backend per cloud (S3+DynamoDB / Azure Storage+blob lease / GCS), naming, and isolation boundary (per account/subscription/project).

## Tagging and labelling

The canonical required tag set, in Terraform map form. Keys are namespaced with the `client_name:` prefix except `Heritage` and `source_repo`.

```hcl
tags = {
  "client_name:BusinessUnit"      = "business-unit"
  "client_name:ProjectCode"       = "some-project-code"
  "client_name:WorkloadOwnerPri"  = "xxxx@client_name.com"
  "client_name:WorkloadOwnerSec"  = "None"
  "client_name:TechnicalOwnerPri" = "yyyy@client_name.com"
  "client_name:TechnicalOwnerSec" = "None"
  "client_name:CostCenter"        = "123456"
  "client_name:OpsModel"          = "client operations model"
  "client_name:OperatedBy"        = "operated-by-unit"
  "Heritage"                      = "Terraform"   # or "Terragrunt"
  "source_repo"                   = "<IaC project repo>"
}
```

Rules: every taggable resource carries the full set; `*Sec` (secondary owner) and other optional fields use the literal `"None"` rather than being omitted, so absence is explicit. `CostCenter` must be a real cost-centre code. `source_repo` points at the IaC repo that manages the resource.

### Per-cloud application — this schema does not map identically across clouds

This is the "varies cloud to cloud" reality, made explicit so each architect applies it correctly:

| Cloud | Mechanism | Does the schema work as-is? |
|---|---|---|
| **AWS** | Resource tags, applied via the provider's `default_tags` so every resource inherits the map | **Yes.** AWS tag keys permit `: . @ _ - / +`, mixed case, and spaces. The `client_name:` prefix and email values are valid. Avoid the reserved `aws:` prefix only. |
| **Azure** | Resource tags, applied via a shared `local.tags` map merged into every resource; enforce/inherit with Azure Policy | **Mostly.** Azure tag names permit `:` and disallow `< > % & \ ? /`. Email values are fine. Note some resource types don't support tags, and a few have shorter limits — the architect names those exceptions. |
| **GCP** | **Labels** (the cost/inventory analog), plus resource-manager **Tags** for policy — different things | **No — needs transformation.** GCP labels allow only lowercase `[a-z0-9_-]`, must start with a letter, max 63 chars, and forbid `:`, `@`, `.`, and uppercase. So `client_name:BusinessUnit` → `clientname_businessunit`, and owner-email values cannot be labels at all. |

**GCP transform (house rule):** flatten the namespace to an underscore (`client_name:CostCenter` → `clientname_costcenter`), lowercase everything, and for owner fields that are emails, store only a sanitised local-part (`xxxx`) as the label value and record the full contact in the resource `description` or the CMDB — never as a label. The GCP Architect applies this mapping automatically and notes it in its output.

## Landing zone

**TODO** per cloud — account/subscription/project topology, the org/folder hierarchy, shared-services vs. workload separation, network landing zone (hub-spoke / shared VPC), and the guardrails (SCPs / Azure Policy / Org Policy) that are assumed to already exist.

## Naming convention

**TODO** — the resource naming scheme (e.g. `<client>-<env>-<region>-<workload>-<resource>`), allowed environment and region tokens, and any per-cloud divergence (GCP project IDs and bucket names are globally unique and lowercase; storage-account names are short and alphanumeric; etc.).

## Approved services

**TODO** — the allow-list (or deny-list) of services per cloud. Until specified, architects propose mainstream managed services and flag anything that might be off-list for you to confirm. Capture any services that are explicitly *not* permitted (often for data-residency, support, or procurement reasons) — those are the ones an architect most needs to know.

## Security baseline

**TODO** — the non-negotiables: identity model (no long-lived keys; workload/managed identity; SSO), encryption posture (CMK/CMEK requirement, in-transit), network defaults (private by default, egress control), logging/audit retention, and the compliance regime(s) in scope. Architects measure their design against this rather than against cloud defaults.
