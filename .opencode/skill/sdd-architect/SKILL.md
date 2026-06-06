---
name: sdd-architect
description: Use when invoked as the architect agent in project_zero, or when the user wants to write a "plan.md", choose a tech stack, draft ADRs, or enumerate file-by-file changes. Teaches the plan template, tech-stack reuse policy, and ADR procedure.
---

# sdd-architect

You are writing `plan.md` (and possibly one or more ADRs) for the
active spec. The plan is the **how** — it picks the tech stack, lays
out the files, lists dependencies, and defines interface contracts.

The plan is the **only place** that declares dependencies. Don't add
them later.

## Preconditions

Before writing the plan, verify the spec gate is met:

- `spec.md` exists for the active spec.
- No `[NEEDS CLARIFICATION]` markers remain.
- At least one functional requirement and one acceptance criterion.

If the gate is unmet, refuse and report the gap.

## Template sections (in order)

The template is `.specify/templates/plan-template.md`. Sections:

1. **Architecture overview** — the post-change shape of the system.
2. **Tech-stack decisions** — language, frameworks, storage, testing,
   one line each with a one-sentence rationale.
3. **File-by-file changes** — exhaustive table. NEW / MOD / DEL.
4. **Dependencies** — new and removed, with version + rationale.
5. **Data model changes** — schemas, migrations, types.
6. **Interface contracts** — one block per public interface.
7. **Test strategy** — unit, integration, manual.
8. **Risks & mitigations** — table.
9. **Rollout** — feature flags, migration windows, rollback path.

## Tech-stack decision rule

If a prior plan in this project has set a stack for the same domain
(e.g., "backend"), reuse it. Only pick a new stack if no prior plan
exists for that domain, OR an ADR explicitly supersedes the prior
choice.

Each non-trivial tech decision gets an ADR. "Non-trivial" means:

- A language or framework is chosen for the first time.
- A new external service is introduced.
- A banned-category item (see `sdd-constitution` §2) is requested.
- A previously made decision is reversed.

ADRs are immutable once filed. A new ADR supersedes an old one with
explicit reference.

## File-by-file changes — the discipline

Every file the implementation will touch must appear in this table.
The agent that implements the plan will refuse to edit a file not in
this table. Be exhaustive; the implementer cannot widen scope later.

| Status | Path | Purpose / change |
|---|---|---|
| NEW    | `src/<path>` | <purpose> |
| MOD    | `src/<path>` | <what changes> |
| DEL    | `src/<path>` | <why removed> |

The implementer agents have strict file-scope permissions:

- `backend-dev` → `src/backend/**`, `tests/backend/**`
- `frontend-dev` → `src/frontend/**`, `tests/frontend/**`
- `mobile-dev` → `src/mobile/**`, `tests/mobile/**`
- `data-dev` → `src/data/**`, `tests/data/**`

If a plan needs a file outside the conventional domain paths, either
(a) change the path to fit the convention, or (b) plan for a
multi-implementer split and update the relevant agents' permissions.

## Interface contracts — the discipline

Every public function, API endpoint, CLI flag, event, or message shape
introduced or modified by the plan gets an interface contract:

```
### `<name>`

- Input: <shape>
- Output: <shape>
- Errors: <cases>
- Side effects: <if any>
```

The implementer must match these contracts exactly. If a task needs
to deviate, the plan must be amended first.

## What you do NOT do

- Do not write `spec.md` (already written, you read it).
- Do not write `tasks.md` (next phase, owned by `task-decomposer`).
- Do not write code. Do not run `implement`.
- Do not silently change a previously chosen tech stack. File an ADR.
