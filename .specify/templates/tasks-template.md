# Tasks NNN — <Short title, matches spec & plan>

> Status: Draft · Depends on: `plan.md` (must be complete) · Created: YYYY-MM-DD

## Task format

Each task is one bullet. The agent ticks tasks off one at a time during
the `implement` phase. A task is "done" only when its `Acceptance:`
line is satisfied.

```
- [ ] T-NNN — <imperative verb> <what>  [file: <path>, est: S|M|L, deps: <T-IDs|none>]
  - Acceptance: <how to verify, observable>
```

`S` ≤ 30 min, `M` ≤ 2 h, `L` ≤ half a day. Anything larger must be
split before implementation begins.

## Tasks

- [ ] T-001 — <…>  [file: `src/...`, est: S, deps: none]
  - Acceptance: <…>
- [ ] T-002 — <…>  [file: `src/...`, est: M, deps: T-001]
  - Acceptance: <…>
- [ ] T-003 — <…>  [file: `tests/...`, est: S, deps: T-001, T-002]
  - Acceptance: <…>

## Definition of done

A task is "done" only when **all** of the following hold:

- [ ] The `Acceptance:` line is satisfied (test or manual check recorded).
- [ ] No new warnings/errors from the project's lint or typecheck.
- [ ] No file was modified outside the scope declared in `plan.md`.
- [ ] If a public surface was added, its test is in `tests/`.
- [ ] The task checkbox is ticked in this file.
- [ ] A one-line note was added to `history/changelog.md`.

The whole feature is "done" when every task is ticked **and**
`checklist.md` reports all quality gates passing.
