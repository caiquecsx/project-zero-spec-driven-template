# Constitution

> Immutable project principles for **project_zero**. The AI agent (opencode)
> is bound by this document. Any deviation requires an Architecture Decision
> Record (ADR) filed under `history/decisions/`.

---

## §1 — Purpose

This project follows **Spec-Driven Development (SDD)**. Every non-trivial
change begins as a specification, is refined into a plan, decomposed into
tasks, and only then implemented. The artifacts in `specs/` are the source
of truth; the code in `src/` is a downstream consequence.

## §2 — Tech-stack policy

- **Tech-agnostic by default.** No language, framework, or runtime is
  pre-selected. Each `specs/NNN-*/plan.md` is free to pick the stack that
  best fits the requirements.
- Once a stack is chosen for a feature, **subsequent features in the same
  domain must use the same stack** unless an ADR justifies a divergence.
- Banned categories (require an ADR to introduce):
  - Network calls to non-public endpoints without explicit spec.
  - Storage of secrets, credentials, or PII in plaintext.
  - Telemetry that leaves the host without explicit user consent.

## §3 — Code-style rules (universal)

- Prefer small, single-purpose functions.
- No dead code, no commented-out code, no TODOs without a linked spec.
- All public functions/modules must have at least one test.
- Dependencies must be declared (manifest file) and pinned.
- Never commit secrets, API keys, tokens, or `.env` files.
- Match existing conventions in the codebase before introducing new ones.

## §4 — SDD workflow contract (hard gate)

The AI agent MUST follow this pipeline. Skipping a phase is a protocol
violation; the agent must refuse and explain.

| Phase | Trigger phrase | Output file | Gate condition to advance |
|---|---|---|---|
| 1. Specify | `specify: <idea>` | `specs/NNN-slug/spec.md` | No `[NEEDS CLARIFICATION]` markers remain |
| 1.5. Clarify | `clarify` | updates `spec.md` | All open questions resolved with concrete answers |
| 2. Plan | `plan` | `specs/NNN-slug/plan.md` | File-level changes enumerated, dependencies listed |
| 3. Tasks | `tasks` | `specs/NNN-slug/tasks.md` | Every task has an `Acceptance:` line |
| 4. Implement | `implement` | code in `src/` + tests | Tasks ticked off one at a time, definition-of-done met |
| 5. Verify | `checklist` | `specs/NNN-slug/checklist.md` | All quality gates pass |

The agent MUST refuse to advance if any gate condition is unmet.

## §5 — Naming conventions

- Spec folders: `specs/NNN-kebab-case-slug/` where `NNN` is zero-padded and
  monotonically increasing (`001-`, `002-`, ...).
- ADRs: `history/decisions/ADR-NNN-kebab-slug.md`, numbered independently
  from specs.
- Changelog entries are appended (never rewritten) to `history/changelog.md`.

## §6 — Amendment procedure

The constitution can only be amended by:

1. Filing an ADR titled `ADR-NNN-amend-constitution-section-X`.
2. The ADR documents the current text, the proposed text, and the rationale.
3. The change is applied to this file only after the ADR is committed.

The agent MUST surface a proposed amendment as an ADR rather than editing
this file unilaterally.
