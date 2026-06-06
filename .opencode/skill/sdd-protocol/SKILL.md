---
name: sdd-protocol
description: Use when working in a project_zero SDD session and the user mentions "specify", "clarify", "plan", "tasks", "implement", "checklist", "phase", "gate", "active spec", "spec folder", or any phase of the Spec-Driven Development pipeline. Universal SDD rules covering the 5 phases, hard gates between them, file paths, and naming conventions.
---

# sdd-protocol

The binding workflow for project_zero. Every agent on the team loads
this skill. The constitution (`.specify/memory/constitution.md`)
supersedes anything in this skill on conflict.

## The five phases (hard gate)

| # | Phase | Trigger | Writes | Gate to advance |
|---|---|---|---|---|
| 1 | Specify | `specify: <idea>` | `specs/<active>/spec.md` | No `[NEEDS CLARIFICATION]` markers remain |
| 1.5 | Clarify | `clarify` | updates `spec.md` | All `OQ-N` resolved or moved to out-of-scope |
| 2 | Plan | `plan` | `specs/<active>/plan.md` | File-level changes enumerated, deps listed, contracts specified |
| 3 | Tasks | `tasks` | `specs/<active>/tasks.md` | Every task has an `Acceptance:` line; no task > L |
| 4 | Implement | `implement` | code in `src/` + `tests/` | Tasks ticked off one at a time; definition-of-done met per task |
| 5 | Verify | `checklist` | `specs/<active>/checklist.md` | All quality-gate boxes pass |

You operate in exactly one phase at a time. **Refuse** to advance if the
previous phase's gate is unmet.

## What "refuse" looks like

When asked to advance past an unmet gate, respond with:

1. One sentence stating which gate is unmet.
2. A bulleted list of what is missing.
3. A single concrete next action.

Do not write code. Do not edit any artifact. Do not invent a workaround.

## Active spec resolution

The **active spec** is, in order of precedence:

1. The spec folder the user names explicitly.
2. The only non-template folder under `specs/`.
3. `specs/000-template/` (read-only, for shape reference only).

If none of these resolves, ask the user before writing.

## File paths and naming

- Spec folders: `specs/NNN-kebab-slug/`, where `NNN` is zero-padded and
  monotonically increasing (`001-`, `002-`, ...).
- Use `.specify/scripts/new-spec.ps1 <slug>` to scaffold a new folder.
- All file references to the user must be absolute or repo-relative, in
  the form `specs/001-foo/spec.md:14`. Never use bare filenames.
- ADRs: `history/decisions/ADR-NNN-slug.md` (numbered independently
  from specs).

## Conventions (apply at all times)

- **No comments in code** unless the user asks for them.
- **No secrets** in code, logs, examples, or commits.
- **Tests before "done":** if a task touches a public surface, the test
  is part of the task.
- **Append-only changelog:** never rewrite past entries in
  `history/changelog.md`.
- **ADRs are immutable.** A new ADR supersedes an old one with explicit
  reference.

## Slash-style triggers

The user types these at the start of a message to invoke a phase:

```
specify: <idea>
clarify
plan
tasks
implement
checklist
```

## Failure-mode reference

| Situation | Response |
|---|---|
| User asks to skip a phase | Refuse; explain the gate; suggest the smallest next step. |
| User asks to override the constitution | Refuse; offer to draft an ADR. |
| Active spec cannot be identified | Ask which spec folder; list existing `specs/NNN-*` folders. |
| Plan needs a file outside its declared scope | Stop; ask to amend the plan. |
| Task is too large (size L, but splittable) | Refuse; propose a split and wait. |
| User says "just do it" or "skip the spec" | Refuse; cite §4 of the constitution. |
| Templates are missing | Stop; report the missing path; do not improvise. |
