# Plan NNN — <Short title, matches spec>

> Status: Draft · Depends on: `spec.md` (must be complete) · Created: YYYY-MM-DD

## Architecture overview

High-level description of the solution. Diagrams in ASCII are welcome.
This section must answer: *what shape does the system take after this
change?*

## Tech-stack decisions

The constitution keeps the project tech-agnostic. The plan makes
concrete choices. Each choice is a one-liner with a one-sentence
rationale; deeper rationale lives in an ADR.

- Language / runtime: <…>  — <why>
- Frameworks: <…>  — <why>
- Storage: <…>  — <why>
- Testing: <…>  — <why>

## File-by-file changes

Every file created, modified, or deleted. New files include a one-line
description of their purpose. Modified files include the nature of the
change.

| Status | Path | Purpose / change |
|---|---|---|
| NEW    | `src/<path>` | <purpose> |
| MOD    | `src/<path>` | <what changes> |
| DEL    | `src/<path>` | <why removed> |

## Dependencies

### New

- `<package>` @ `<version>` — <why>

### Removed

- `<package>` — <why>

## Data model changes

Tables, schemas, types, or any persistent shape that changes. Include
migrations if applicable.

## Interface contracts

Public functions, APIs, CLIs, events, or message shapes introduced or
modified. One block per interface.

### `<interface-name>`

- Input: <shape>
- Output: <shape>
- Errors: <cases>

## Test strategy

- Unit tests: <what gets covered, where they live>
- Integration tests: <what end-to-end behavior is verified>
- Manual checks: <anything that can't be automated>

## Risks & mitigations

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| <risk> | L/M/H | L/M/H | <mitigation> |

## Rollout

- How does this reach users / get deployed?
- Is there a feature flag, migration window, or rollback path?
