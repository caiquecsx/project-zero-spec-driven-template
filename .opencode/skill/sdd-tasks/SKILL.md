---
name: sdd-tasks
description: Use when invoked as the task-decomposer agent in project_zero, or when the user wants to break a plan into ordered, testable tasks with acceptance lines. Teaches task sizing (S/M/L), dependency ordering, and the definition of done.
---

# sdd-tasks

You are writing `tasks.md` for the active spec. The plan (`plan.md`)
is your input. The implementer agents will tick tasks off one at a
time during the `implement` phase.

## Preconditions

- `plan.md` exists and is complete.
- Every file the implementer will touch appears in the plan's
  `File-by-file changes` table.
- Every interface contract is defined.

If any of these are missing, refuse and report the gap.

## Task format

```
- [ ] T-NNN — <imperative verb> <what>  [file: <path>, est: S|M|L, deps: <T-IDs|none>]
  - Acceptance: <how to verify, observable>
```

### Sizing

- **S** = ≤ 30 min, single file, trivial.
- **M** = ≤ 2 h, 1–3 files, some thinking.
- **L** = ≤ half a day, multiple files, real design.

L tasks are allowed only when you first explain in your reply why
splitting is impossible. The default is to split further.

### Acceptance lines

A single, testable statement. The implementer ticks the box only when
this line is satisfied. Vague words are forbidden:

- ✗ "works"
- ✗ "handles edge cases"
- ✗ "looks good"
- ✓ `pytest -q` reports 3 passed
- ✓ `python -m mytool hello --name Ada` prints `Hello, Ada` and exits 0
- ✓ The endpoint returns 404 when `id` is not a valid UUID

### Dependency order

Tasks are ordered by `deps:` so the implementer can work straight
through. The first task should make the smallest possible commit
(maybe just a manifest). The last task should make the system
shippable.

If task B depends on A, B's `deps:` lists A's id, and B appears after
A in the file.

If two tasks are independent, they may be reordered freely; keep the
list chronologically sensible.

## Definition of done (per task)

A task is "done" only when **all** of the following hold:

- The `Acceptance:` line is satisfied (test or manual check recorded).
- No new warnings/errors from the project's lint or typecheck.
- No file was modified outside the scope declared in `plan.md`.
- If a public surface was added, its test is in `tests/`.
- The task checkbox is ticked in this file.
- A one-line note was added to `history/changelog.md`.

## Task quality floor

Every task must have an `Acceptance:` line. A `tasks.md` with any task
missing `Acceptance:` is incomplete; the implementer will refuse to
start.

## What you do NOT do

- Do not modify `plan.md` or `spec.md`. If the plan is wrong, ask the
  architect to amend it.
- Do not write code, even to "stub" a task. Stubs belong in tasks.
- Do not introduce a new dependency. That decision belongs in
  `plan.md`.
