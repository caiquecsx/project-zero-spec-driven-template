---
name: sdd-spec
description: Use when invoked as the spec-author agent in project_zero, or when the user wants to write a "spec.md", draft requirements, define user stories, or surface open questions. Teaches the spec template, clarifying-question discipline, and testable acceptance criteria.
---

# sdd-spec

You are writing `spec.md` for the active spec folder. The spec is the
**what**, never the how. Tech choices, file paths, and architecture
appear in `plan.md` (a different phase, owned by a different agent).

## Template sections (in order)

1. **Context** — what problem exists, why this spec is being written.
2. **Goals** — bulleted, concrete, testable.
3. **Non-goals** — explicit out-of-scope items.
4. **User stories** — *As a <role>, I want <capability>, so that <benefit>.*
5. **Functional requirements** — numbered, imperative, unambiguous.
6. **Acceptance criteria** — one observable outcome per bullet.
7. **Open questions** — `OQ-N` items, each with a `[NEEDS CLARIFICATION]`
   marker, followed by 2–3 reasonable options.
8. **Out of scope** — items deferred to a future spec.
9. **Change log** — append-only.

The template file is `.specify/templates/spec-template.md`. Copy it
into `specs/NNN-slug/spec.md` (or use the scaffold script) and fill it.

## Clarifying questions — the discipline

For every ambiguity, ask the user a single concrete question with
2–3 reasonable options. Use the marker format:

```
- OQ-3 — Should the greeting default to "World" or be required?
  <!-- [NEEDS CLARIFICATION: default to "World" / require a name / prompt for it] -->
```

Rules:

- **Never invent decisions silently.** If the user didn't say it, mark
  it as an open question.
- **Options must be reasonable.** Don't offer a strawman and a "right"
  answer; offer 2–3 legitimate choices.
- **Bundle related questions** so the user can answer them in one
  round.
- **When the user answers:** edit the line in place: append
  `<!-- resolved YYYY-MM-DD: <answer> -->` and remove the marker.

## Acceptance criteria — the test

Every acceptance criterion is a single bullet of the form:

```
- AC-1 — Given <precondition>, when <action>, then <observable result>.
```

Pass/fail must be determinable by reading the criterion alone, without
re-reading the code. Vague words ("works", "handles", "looks good",
"is fast") are forbidden.

## Spec quality floor

A spec is not "ready" until it has at least one of each:

- Goal
- Non-goal
- User story
- Functional requirement
- Acceptance criterion

If the user's intent is so vague that the floor can't be met, push
back: ask for more before writing the spec.

## When to defer

If a question is interesting but doesn't block the spec, mark it
`OQ-N` and leave it for `clarify`. If the user says "later", move the
item to the `Out of scope` section.

## What you do NOT do

- Do not write `plan.md`, `tasks.md`, or code. Those are different
  phases owned by different agents.
- Do not pick a tech stack. That belongs in `plan.md`.
- Do not run `implement` even if the user asks. Refuse, citing the
  gate.
