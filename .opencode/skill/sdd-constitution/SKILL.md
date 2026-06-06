---
name: sdd-constitution
description: Use when the user asks about "constitution", "amendment", "ADR procedure", "binding rules", "tech-stack policy", or when an agent is about to deviate from .specify/memory/constitution.md. Universal skill that mirrors the constitution's rules into a model-loadable form.
---

# sdd-constitution

A model-loadable mirror of `.specify/memory/constitution.md`. The
constitution is the binding source of truth; this skill is a
summarization. If the two disagree, the constitution file wins.

## §1 — Purpose

This project follows Spec-Driven Development. Every non-trivial change
begins as a specification, is refined into a plan, decomposed into
tasks, and only then implemented. The artifacts in `specs/` are the
source of truth; the code in `src/` is downstream.

## §2 — Tech-stack policy

- **Tech-agnostic by default.** No language, framework, or runtime is
  pre-selected. Each plan may pick the stack that best fits the
  requirements.
- **Stack reuse:** once chosen for a feature, subsequent features in
  the same domain must reuse the same stack unless an ADR justifies
  divergence.
- **Banned without ADR:** network calls to non-public endpoints,
  plaintext secrets, undisclosed telemetry.

## §3 — Code-style rules (universal)

- Prefer small, single-purpose functions.
- No dead code, no commented-out code, no TODOs without a linked spec.
- All public functions/modules must have at least one test.
- Dependencies must be declared and pinned.
- Never commit secrets, keys, tokens, or `.env` files.
- Match existing conventions before introducing new ones.

## §4 — SDD workflow contract (hard gate)

Six phases: Specify → Clarify → Plan → Tasks → Implement → Verify.
Each phase has a gate. The agent must refuse to advance if the gate
condition is unmet. Full table: see the `sdd-protocol` skill.

## §5 — Naming conventions

- `specs/NNN-kebab-case-slug/`, NNN zero-padded, monotonically increasing.
- `history/decisions/ADR-NNN-kebab-slug.md`, numbered independently.
- `history/changelog.md` is append-only.

## §6 — Amendment procedure

The constitution can only be amended by:

1. Filing an ADR titled `ADR-NNN-amend-constitution-section-X`.
2. The ADR documents current text, proposed text, and rationale.
3. The change is applied to the constitution file only after the ADR
   is committed.

Agents MUST surface a proposed amendment as an ADR rather than editing
the constitution file unilaterally.

## When to load

- Before writing any artifact, to confirm the rules above are in force.
- When the user asks to "change the rules", "amend", "override", or
  "skip" anything — refuse, and offer to draft an ADR.
