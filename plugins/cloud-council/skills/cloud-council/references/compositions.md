# Cloud Council — Compositions

The Director reads this in Step 2 to map the classified mode to a roster. Default hard toward single-cloud; the other two modes are deliberate exceptions.

## Single-cloud (default)

The customer is on one cloud and staying there. The work is either a **design** (greenfield or a new workload) or an **audit** (review an existing architecture).

**Roster:** the one relevant architect → then the red team.
- `members/aws-architect/SKILL.md`
- `members/azure-architect/SKILL.md`
- `members/gcp-architect/SKILL.md`
- then `members/red-team-cloud/SKILL.md`

The breadth here comes from the architect reasoning across all five Well-Architected pillars and surfacing the tensions between them — not from convening multiple clouds. Do not add the other two architects "for completeness"; that's noise.

This is the right composition for the large majority of requests.

## Selection

The workload is **not yet placed** and the real question is which cloud fits. Only use this when the user is explicitly choosing — not when they mention more than one cloud in passing.

**Roster:** all three architects, run independently and one at a time to avoid anchoring → then the red team on the leading pick.
- `members/aws-architect/SKILL.md`
- `members/azure-architect/SKILL.md`
- `members/gcp-architect/SKILL.md`
- then `members/red-team-cloud/SKILL.md`

Each architect argues its own cloud's fit honestly, including where its cloud is the wrong choice. The Director makes the cross-cloud verdict in synthesis; the architects do not.

Bias the recommendation toward the cloud the customer already operates unless the workload's requirements clearly override that — an unplanned second cloud carries a real operational and skills tax that rarely shows up in a feature-by-feature comparison.

## Hybrid (rare)

One customer genuinely spans clouds **for this workload** — e.g. data gravity on one cloud, a managed capability only another provides. Before using this mode, confirm it's truly one cross-cloud problem and not two single-cloud problems that should each get their own council.

**Roster:** the relevant subset (usually two architects) → then the red team, with explicit attention to the seams.
- the two relevant architect SKILL.md files
- then `members/red-team-cloud/SKILL.md`

The red team must focus on the integration seams — egress cost, latency across clouds, identity federation, and the operational burden of two control planes. Hybrid designs fail at the joins, not in either half.

## Selection heuristic

If you're unsure between single-cloud and selection, default to single-cloud and say so to the user — they can ask you to widen to a comparison. Adding architects is cheap; a comparison the user didn't want is wasted tokens and a flattened, lukewarm recommendation.
