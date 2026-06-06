# AGENTS.md — opencode protocol for project_zero

opencode reads this file automatically. It is the operating manual for
the AI agent. The rules below are **enforced**, not advisory.

---

## 0. Project identity

- **Project:** `project_zero`
- **Methodology:** Spec-Driven Development (SDD)
- **Binding document:** `.specify/memory/constitution.md` (read first, every session)
- **Templates:** `.specify/templates/` (do not edit; copy into new spec folders)
- **Conventions:** `.specify/memory/constitution.md` §3 (code style), §5 (naming)

If any instruction here conflicts with the constitution, **the constitution wins**.
Surface the conflict to the user as a proposed ADR — do not silently override.

---

## 1. The five phases (hard gate)

The agent operates in exactly one phase at a time. Each phase has a
trigger phrase, an input, and an output. The agent **must refuse** to
advance if the previous phase's gate condition is unmet.

| # | Phase | Trigger | Reads | Writes | Gate to advance |
|---|---|---|---|---|---|
| 1 | Specify | `specify: <idea>` | constitution, templates, active spec (if any) | `specs/<active>/spec.md` | No `[NEEDS CLARIFICATION]` markers remain |
| 2 | Clarify | `clarify` | `spec.md` | updates `spec.md` | All open questions resolved or moved to out-of-scope |
| 3 | Plan | `plan` | `spec.md`, constitution | `specs/<active>/plan.md` | File-level changes enumerated, deps listed, contracts specified |
| 4 | Tasks | `tasks` | `plan.md` | `specs/<active>/tasks.md` | Every task has an `Acceptance:` line; no task > L |
| 5 | Implement | `implement` | `tasks.md`, `plan.md` | code in `src/` + `tests/` | Tasks ticked off one at a time; definition-of-done met per task |
| 6 | Verify | `checklist` | all four artifacts + code | `specs/<active>/checklist.md` | All quality-gate boxes pass |

**Active spec = the spec folder the user names, or the only one under
`specs/`, or `specs/000-template/` (which is read-only and used only for
shape reference).** If ambiguous, ask.

### 1a. What "refuse" looks like

When the user asks to advance past an unmet gate, respond with:

1. A one-sentence statement of which gate is unmet.
2. A bulleted list of what is missing.
3. A single concrete next action the user can take.

Do not write code. Do not edit any artifact. Do not invent a workaround.

---

## 2. Phase-by-phase behavior

### Phase 1 — Specify

- Read the constitution and the active spec (if any) before writing.
- Produce a `spec.md` from the user's natural-language intent, filling
  every section of the template. Use `<!-- [NEEDS CLARIFICATION: ...] -->`
  markers **only** for things the user must decide. Do not invent
  decisions silently.
- For every `[NEEDS CLARIFICATION]`, list 2–3 reasonable options to make
  the question cheap to answer.
- The spec must include at least one goal, one non-goal, one user story,
  one functional requirement, and one acceptance criterion.

### Phase 2 — Clarify

- Walk through every `OQ-N` in the spec and every `[NEEDS CLARIFICATION]`
  marker.
- For each, ask the user the question. On their answer, edit the line in
  place: append `<!-- resolved YYYY-MM-DD: <answer> -->` and remove the
  marker.
- If the user defers an item to a future spec, move it to the `Out of
  scope` section.
- Phase is complete when no marker remains and no `OQ-N` is unanswered.

### Phase 3 — Plan

- Choose a tech stack in the plan if and only if no prior plan in the
  project has set one for the same domain. If one exists, reuse it.
- For every technology decision that is non-trivial, file an ADR under
  `history/decisions/ADR-NNN-<slug>.md` and reference it from the plan.
- The `File-by-file changes` table must be exhaustive. If a file is
  modified but not in the table, the plan is incomplete.
- The plan is the **only** place where the agent declares dependencies.
  Don't add them later.

### Phase 4 — Tasks

- Decompose the plan into tasks of size S or M. L tasks are allowed only
  when the agent first explains why splitting is impossible.
- Order tasks so dependencies are respected. The first task should make
  the smallest possible commit and the last task should make the system
  shippable.
- Every task gets an `Acceptance:` line that is a single, testable
  statement. Vague words ("works", "handles", "looks good") are
  forbidden in acceptance lines.

### Phase 5 — Implement

- Work on **one task at a time**. Do not start T-002 until T-001's
  acceptance line is satisfied.
- Tick the box in `tasks.md` only after the acceptance line is met.
- If a task requires touching a file not listed in `plan.md`, **stop**
  and ask the user to amend the plan first.
- After every ticked task, append a one-line note to
  `history/changelog.md`.

### Phase 6 — Verify

- Walk the `checklist.md` top to bottom. Mark each box pass/fail.
- For any failure, name the smallest set of follow-up tasks needed to
  close the gap and offer to add them to `tasks.md` (do not auto-add).

---

## 3. Conventions the agent must follow at all times

- **Paths:** always absolute or repo-relative. Never use bare filenames
  in instructions to the user; show `file:line` style references
  (`specs/001-foo/spec.md:14`).
- **No comments in code** unless the user asks for them.
- **No secrets in code, logs, or examples.**
- **Tests before "done":** if a task affects a public surface, its test
  is part of the task.
- **Append-only changelog:** never rewrite past entries in
  `history/changelog.md`.
- **ADRs are immutable once filed.** A new ADR supersedes an old one
  with explicit reference.

---

## 4. Slash-style triggers cheat sheet

Type these at the start of a message:

```
specify: <describe what you want built>
clarify
plan
tasks
implement
checklist
```

The agent infers the active spec from the most recent context. If the
context is ambiguous, it asks before writing.

---

## 5. Failure modes & how the agent responds

| Situation | Agent response |
|---|---|
| User asks to skip a phase | Refuse; explain the gate; suggest the smallest next step. |
| User asks to override the constitution | Refuse; offer to draft an ADR. |
| Active spec cannot be identified | Ask which spec folder; list existing `specs/NNN-*` folders. |
| Plan needs a file outside its declared scope | Stop the current task; ask to amend the plan. |
| Task is too large (size L, but splittable) | Refuse; propose a split and wait. |
| User says "just do it" or "skip the spec" | Refuse; cite §4 of the constitution. |
| Templates are missing | Stop; report the missing path; do not improvise. |
