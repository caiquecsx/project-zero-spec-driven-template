---
name: git-workflow
description: Use when creating commits, branches, pull requests, or when discussing version-control hygiene in project_zero. Covers branch naming, commit-message format, and PR conventions for an SDD-driven repo.
---

# git-workflow

## Branch naming

For an active spec `NNN-slug`, work on a single feature branch:

```
spec/NNN-slug
```

For infrastructure or tooling changes that aren't a spec:

```
chore/<short-slug>
docs/<short-slug>
refactor/<short-slug>
```

## Commit-message format

```
<type>(<scope>): <imperative summary>

<body explaining why, not what>

Refs: specs/NNN-slug/, ADRs, etc.
```

`<type>` ∈ {feat, fix, refactor, chore, docs, test, perf}.
`<scope>` is the area: `agents`, `skills`, `constitution`, `templates`,
`<domain>` (e.g. `backend`, `frontend`).

### Examples

```
chore(agents): introduce multi-agent team config
docs(agents): refactor AGENTS.md, move details to skills
feat(backend): add /health endpoint
test(backend): cover AC-1, AC-2, AC-3 from spec 003
```

## Commit hygiene

- One logical change per commit.
- Don't bundle spec/plan/tasks code in the same commit as the spec
  artifacts themselves.
- After every ticked task in `tasks.md`, append a one-line note to
  `history/changelog.md`. The commit can (and usually should) be
  separate from that note.
- Never amend an existing commit unless the user explicitly asks.
- Never force-push, never skip hooks, never rewrite history.

## Pull request hygiene

- PR title mirrors the commit summary; body links to the spec folder.
- PR description includes the checklist results.
- Squash-merge by default; preserve the original commit message in the
  squash body for traceability.

## What is NOT in this skill

- The SDD pipeline itself. See `sdd-protocol`.
- The constitution's rules. See `sdd-constitution`.
- The skill/agent system. See `AGENTS.md` and `.opencode/agent/`.
