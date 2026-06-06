# project-zero-spec-driven-template

> A spec-first, multi-agent project template. **Code is a downstream
> consequence of the spec.**

This repository is a blank canvas for **Spec-Driven Development (SDD)**.
Every non-trivial change starts as a specification, is refined into a
plan, decomposed into tasks, and only then implemented — driven by a
multi-agent team inside [opencode](https://opencode.ai).

## Philosophy

The artifacts in `specs/` are the source of truth; the code in `src/`
is a downstream consequence. (Constitution §1.)

We don't write code from vibes. We write specs, plans, and tasks first,
then let the implementation follow. The five hard-gated phases make
"skip the spec" impossible: the AI agent will refuse.

## The pipeline

| # | Phase | Trigger | Output | Gate to advance |
|---|---|---|---|---|
| 1 | **Specify** | `specify: <idea>` | `spec.md` | No `[NEEDS CLARIFICATION]` markers |
| 1.5 | **Clarify** | `clarify` | updates `spec.md` | All open questions resolved |
| 2 | **Plan** | `plan` | `plan.md` (+ ADRs) | File-level changes enumerated |
| 3 | **Tasks** | `tasks` | `tasks.md` | Every task has an `Acceptance:` line |
| 4 | **Implement** | `implement` | code in `src/` + tests | Tasks ticked, definition-of-done met |
| 5 | **Verify** | `checklist` | `checklist.md` | All quality gates pass |

The AI agent **refuses** to advance if any gate condition is unmet.
Constitution §4 makes this a hard contract.

## The team

A 9-agent opencode team drives the pipeline. See [`AGENTS.md`](./AGENTS.md)
for the full table; the short version:

- `manager` (default) — orchestrates the pipeline, enforces gates
- `spec-author`, `architect`, `task-decomposer` — write the spec, plan, tasks
- `backend-dev`, `frontend-dev`, `mobile-dev`, `data-dev` — implement, one task at a time
- `reviewer` — walks the checklist at the end (read-only otherwise)

## Quick start

1. Clone (or use this repo as a GitHub template):
   ```bash
   git clone https://github.com/caiquecsx/project-zero-spec-driven-template.git
   cd project-zero-spec-driven-template
   ```
2. Open it in opencode.
3. Drive the workflow at the manager prompt:
   ```
   specify: <describe the feature>
   clarify
   plan
   tasks
   implement
   checklist
   ```
4. To scaffold a new spec folder by hand:
   ```powershell
   pwsh .specify/scripts/new-spec.ps1 my-feature
   ```

## Directory map

```
project-zero-spec-driven-template/
├── AGENTS.md                      ← opencode reads this every turn
├── README.md                      ← you are here
├── opencode.json                  ← 9-agent team config
├── .specify/
│   ├── memory/constitution.md     ← binding project rules
│   ├── templates/                 ← blank forms (spec, plan, tasks, ADR, checklist)
│   └── scripts/new-spec.ps1       ← scaffold a new spec folder
├── .opencode/
│   ├── agent/                     ← specialist agent definitions
│   └── skill/                     ← role-specific guidance (sdd-*, git-workflow)
├── specs/
│   ├── 000-template/              ← fully filled-out reference example
│   └── NNN-slug/                  ← your specs land here
│       ├── spec.md
│       ├── plan.md
│       ├── tasks.md
│       └── checklist.md
├── history/
│   ├── decisions/                 ← ADRs (immutable once filed)
│   └── changelog.md               ← append-only
├── src/                           ← implementation (backend/ frontend/ mobile/ data/)
└── tests/                         ← tests, mirroring src/
```

## Contributing

1. **Never push to `master` directly** — branch protection is on.
2. For a new feature, follow the pipeline; the spec folder is the unit
   of work.
3. For docs or tooling changes outside a spec, use a branch named
   `docs/<slug>`, `chore/<slug>`, or `refactor/<slug>`.
4. Open a PR. The `reviewer` agent walks the checklist; the human
   squash-merges.
5. After merging a ticked task, append a one-line note to
   `history/changelog.md`. Spec artifacts and code land in separate
   commits.

## See also

- [`AGENTS.md`](./AGENTS.md) — the AI protocol, the team table, and the
  trigger phrases.
- [`.specify/memory/constitution.md`](./.specify/memory/constitution.md) — the
  binding rules.
- [`.opencode/skill/sdd-protocol/SKILL.md`](./.opencode/skill/sdd-protocol/SKILL.md) — the
  5-phase protocol in machine-loadable form.
- [`specs/000-template/`](./specs/000-template/) — a worked example you can
  copy from before deleting.
