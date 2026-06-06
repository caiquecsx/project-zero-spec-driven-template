# Checklist 000 — Add `hello` subcommand to a CLI

> Status: Reference example (read-only) · Run after `implement` phase, before declaring the feature complete.

## Spec quality

- [x] No `[NEEDS CLARIFICATION]` markers in `spec.md`.
- [x] Every functional requirement is covered by at least one acceptance criterion (FR-1→AC-1, FR-2→AC-1+AC-2, FR-3→AC-1+AC-2, FR-4→AC-3).
- [x] Every acceptance criterion is observable.
- [x] Non-goals and out-of-scope sections are non-empty.
- [x] User story US-1 has acceptance criteria AC-1, AC-2, AC-3.

## Plan quality

- [x] Architecture overview explains the post-change shape.
- [x] All five files in `File-by-file changes` exist (or are removed, if `DEL`).
- [x] New dependency `pytest` is declared in `pyproject.toml` and pinned.
- [x] Interface contract matches the actual signature in `src/mytool/hello.py`.
- [x] Test strategy matches the tests that were written.

## Task quality

- [x] Every task in `tasks.md` is ticked.
- [x] Every `Acceptance:` line is satisfied (evidence: command transcripts in the PR description).
- [x] No task was implemented outside its declared file scope.
- [x] Definition of done satisfied for every task.

## Code quality

- [x] No commented-out code, no dead code.
- [x] No secrets, keys, or `.env` content in version control.
- [x] No linter configured for this stack (acceptable per template: "or no linter is configured").
- [x] No type checker configured for this stack (acceptable per template).
- [x] No file exceeds 500 lines.

## Test quality

- [x] All tests pass (`pytest -q` → 3 passed).
- [x] At least one test exists per public function (`hello` is covered by 3 tests).
- [x] Failure messages are clear (`assert stdout == "Hello, Ada"` is self-explanatory).

## Process quality

- [x] `history/changelog.md` updated with one line per ticked task.
- [x] No deviation from the constitution was made.
- [x] Tech stack choice is captured in an ADR (`history/decisions/ADR-001-choose-python-cli.md`).
- [x] The spec, plan, and tasks reflect the code as it actually shipped.
