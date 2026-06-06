# AGENTS.md — project_zero

This project uses **Spec-Driven Development (SDD)** with a multi-agent
team. opencode reads this file on every turn; the team's specialists
are configured in `.opencode/agent/`, the role-specific guidance
lives in `.opencode/skill/`.

## Read first (in order)

1. **`.specify/memory/constitution.md`** — binding project rules.
2. The skill named in the active agent's file (e.g. `sdd-spec` for
   the spec-author).
3. **`.opencode/skill/sdd-protocol/SKILL.md`** — the 5 phases, hard
   gates, naming, paths. Universal.

If anything in this file conflicts with the constitution, **the
constitution wins**. Surface the conflict as a proposed ADR.

## The team

| Agent | Mode | Owns |
|---|---|---|
| `manager` | primary (default) | Orchestrates the pipeline, enforces gates |
| `spec-author` | subagent | `spec.md` |
| `architect` | subagent | `plan.md` + ADRs |
| `task-decomposer` | subagent | `tasks.md` |
| `backend-dev` | subagent | `src/backend/**`, `tests/backend/**` |
| `frontend-dev` | subagent | `src/frontend/**`, `tests/frontend/**` |
| `mobile-dev` | subagent | `src/mobile/**`, `tests/mobile/**` |
| `data-dev` | subagent | `src/data/**`, `tests/data/**` |
| `reviewer` | subagent | `checklist.md` (read-only otherwise) |

Built-in `build` and `plan` are **disabled**; they would conflict
with `manager` and `architect`. `explore` and `general` are kept.

## Triggers (type at the start of a message to the manager)

```
specify: <idea>
clarify
plan
tasks
implement
checklist
```

## Conventions

- File references to the user: always `file:line` style
  (`specs/001-foo/spec.md:14`). Never bare filenames.
- No comments in code; no secrets anywhere; tests required for
  public surfaces.
- Append-only changelog at `history/changelog.md`.
- ADRs in `history/decisions/` are immutable once filed.

## Commit attribution

AI-made commits must be visibly distinct from human commits on
GitHub. The AI always commits through a wrapper that overrides the
author and committer identity for the duration of the call:

- **Wrapper:** `pwsh .specify/scripts/ai-commit.ps1 -Message "<msg>"`
- **Identity:** `opencode <opencode@ai.local>` (override per-call via
  `AI_COMMIT_NAME` / `AI_COMMIT_EMAIL` env vars)

The wrapper sets `GIT_AUTHOR_*` and `GIT_COMMITTER_*` env vars only
for that invocation. The local `user.name` / `user.email` are not
modified, so plain `git commit` calls (human commits) keep the
project owner's identity.

Never invoke `git commit` directly from an AI session — always go
through the wrapper. This is a binding rule; violating it muddies
the commit history on GitHub.

## How to start work

1. Have an idea? Type `specify: <describe it>` to the manager.
2. The manager picks the active spec (creating a new folder via
   `.specify/scripts/new-spec.ps1 <slug>` if needed) and delegates
   to `spec-author`.
3. Walk the pipeline: `clarify` → `plan` → `tasks` → `implement` →
   `checklist`.

Don't try to skip steps. The gates are there for a reason.
