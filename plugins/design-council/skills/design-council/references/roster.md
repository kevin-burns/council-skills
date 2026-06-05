# Council Roster Reference

This is the full list of available council members, what each one is for, and when to include or leave them out. The Director uses this to compose a roster when none of the presets in `presets.md` fits cleanly.

## How to read this

For each member: the lens it brings, the typical questions it answers, when to include it, and when to leave it out. Bias toward smaller councils — every voice you add costs synthesis effort and dilutes the signal. The point of the council is **distinct lenses**, not coverage.

## The full roster

### product-strategist
- **Lens**: problem framing, jobs-to-be-done, strategic fit, "is this the right thing to be doing".
- **Include when**: the decision is about *what* to build, not *how*; when product direction or prioritisation is in scope; when you suspect the proposal is solution-first.
- **Leave out when**: the question is purely technical with a fixed product spec; when the product strategy is settled and the question is execution.

### product-manager
- **Lens**: delivery — the MVP cut, acceptance criteria, dependencies and sequencing, prioritisation under constraint, rollout. "Is the plan to build this actually shippable?"
- **Include when**: the direction is settled and the question is execution; when scope is sprawling and needs a v1 line drawn; when sequencing or cross-team dependencies are in play; when "what exactly ships first" is unclear.
- **Leave out when**: the decision is still about whether to build it at all (that's product-strategist); when there's no delivery plan yet to scope. Pairs naturally with product-strategist (why/what → what-first) but you rarely need both unless the council spans strategy *and* execution.

### customer-voice
- **Lens**: would real users actually adopt this, given how they actually behave?
- **Include when**: success depends on user adoption or behaviour change; when the proposal assumes user enthusiasm not yet evidenced; when distribution and onboarding matter.
- **Leave out when**: the decision is internal-facing with no end-user behaviour exposure; when there's already strong user signal documented and the dispute is elsewhere.

### market-competitive
- **Lens**: what's already out there, what category is this, where's the durable wedge?
- **Include when**: build-vs-buy is a real option; when positioning, pricing, or differentiation is part of the question; when the team risks discovering competitors after launch.
- **Leave out when**: the work is internal infrastructure with no market exposure; when the market context is well-known and shared by the room.

### ux-design
- **Lens**: flow, friction, IA, accessibility — does this work for actual humans?
- **Include when**: a user-facing flow is in scope; when "technically possible" and "humanly tolerable" might diverge; when IA or accessibility shapes the decision.
- **Leave out when**: there is no user-facing surface; when the design is genuinely settled and the question is implementation.

### front-end-engineer
- **Lens**: how the client is built and what it costs — component architecture, state/data-fetching, rendering strategy and performance budget, design-system reuse, the client/server contract, accessibility *implementation*.
- **Include when**: the proposal touches a user-facing client (web/app UI, a component or design-system change, a client-performance decision); when "the design is fine but can we build it performantly and maintainably" is the open question.
- **Leave out when**: there's no client surface; when the front end is trivial CRUD over an existing design system. Pair with ux-design (they own the experience, you own the build) — including both is the default for any non-trivial UI feature.

### red-team-frontend
- **Lens**: adversarial review of a *client* proposal — performance cliffs on real devices, bundle bloat, accessibility failures that ship, UI state/consistency bugs, edge-state and browser gaps, component rot.
- **Include when**: the council's centre of gravity is a user-facing client and you want the sharpest critique aimed there.
- **Leave out when**: the dominant risk is backend or product (use red-team-engineering or red-team-product). Run exactly one red team per council.

### data-measurement
- **Lens**: how would we know this worked, and could we detect it?
- **Include when**: the proposal will need to be evaluated post-launch; when success criteria are vague; when instrumentation may be hidden work.
- **Leave out when**: success is self-evident and instant (e.g. unblocking a specific named user with a fix); when measurement isn't on the critical path.

### feasibility-engineering
- **Lens**: how hard is this, what's the main technical risk, what does it preclude — in product-mode.
- **Include when**: the council is product-flavoured and you need a fast, honest engineering read without convening the full Architect role.
- **Leave out when**: the question is deeply technical and warrants the Software Architect instead; when there's no engineering work in scope at all.

### red-team-product
- **Lens**: adversarial review of the *product* proposal — wishful thinking, missing distribution, optimism stacking.
- **Include when**: any product-flavoured council. The red team is rarely optional.
- **Leave out when**: the question is purely technical (use red-team-engineering instead); when the council is informational rather than decisional.

### software-architect
- **Lens**: system shape, boundaries, coupling, alternatives, decision-recording — full architectural depth.
- **Include when**: the council is engineering-flavoured; when the question is about system design or major refactor; when build-vs-buy needs technical depth beyond feasibility.
- **Leave out when**: the question is product-flavoured (use feasibility-engineering instead); when the architecture is genuinely settled and the question is operational.

### data-engineer
- **Lens**: data model, ownership, lineage, schema-as-contract, backfill, retention.
- **Include when**: data flows, schemas, or pipelines are in scope; when consistency or source-of-truth questions arise; when there's analytical work downstream of this build.
- **Leave out when**: the work is stateless and doesn't touch persistent data; when the data model is small, settled, and uncontroversial.

### security-auditor
- **Lens**: trust boundaries, authorisation, blast radius, sensitive data.
- **Include when**: authentication, authorisation, multi-tenancy, third-party integrations, or sensitive data are in scope; when a new cross-boundary trust is being established; when regulated data or PII is involved.
- **Leave out when**: the work is genuinely internal and low-trust-surface; when there's no new boundary being drawn.

### devops-sre
- **Lens**: operability, observability, deployment, on-call burden, cost trajectory.
- **Include when**: a new service, component, or significant operational surface is being introduced; when reliability requirements matter; when the on-call rotation will inherit work.
- **Leave out when**: the change is internal to an already-operated component and doesn't change its operational shape.

### red-team-engineering
- **Lens**: adversarial review of the *technical* proposal — god patterns, hidden coupling, optimism about complexity, second-order decay.
- **Include when**: any engineering-flavoured council. The red team is rarely optional.
- **Leave out when**: the question is purely product (use red-team-product instead); when the council is informational.

### pragmatist
- **Lens**: are we over-engineering, is there a 30% version, is the cost proportional to the value?
- **Include when**: the proposal feels ambitious, the team has a known tendency to over-scope, or no one in the room is naturally arguing for "less". This is most councils.
- **Leave out when**: the proposal is already explicitly scoped down and the risk is under-scoping rather than over.

## Composition heuristics

A few patterns worth knowing:

- **Always include exactly one red team** for the council's flavour. Match it to the centre of gravity: `red-team-product` for product councils, `red-team-engineering` for backend/system councils, `red-team-frontend` for client-heavy councils. Two red teamers is noisy unless the question is genuinely hybrid; zero red teamers is malpractice.
- **Pair UX/Design with Front-End Engineer for any non-trivial UI.** They own complementary halves — UX owns whether the experience is *right*, Front-End owns whether it can be *built* performantly and maintained. One without the other ships un-buildable designs or unusable builds.
- **Product Strategist and Product Manager are different jobs.** Strategist answers "should we build this"; Manager answers "what ships first and in what order". Most councils need one, not both — reach for the Manager once the direction is settled and the risk is execution.
- **Pragmatist is the secret weapon.** Most councils benefit from one. The voice arguing for less is almost always missing in product and engineering conversations and almost always valuable.
- **Cap at 7 members.** Beyond that the synthesis becomes a chore and members start blurring. If you feel you need eight, look for two voices that overlap.
- **Pair Architect with Data Engineer for any non-trivial backend question.** Most architecture is data architecture in disguise.
- **Pair Customer Voice with Data Measurement for any product bet.** "Would they do it" plus "how would we know" together is much stronger than either alone.
- **Security and DevOps overlap on operational concerns but with different lenses.** Include both for any new service handling external traffic; one or neither for internal-only changes.
