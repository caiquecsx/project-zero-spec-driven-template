# Plan 000 — Add `hello` subcommand to a CLI

> Status: Reference example (read-only) · Depends on: `spec.md` · Created: 2026-06-06

## Architecture overview

A single-file Python CLI script. Python's `argparse` handles parsing
and error reporting for free, satisfying FR-1, FR-2, and FR-4 without
extra dependencies. A trivial test file exercises the three acceptance
criteria. No new modules, no packages, no I/O beyond stdout/stderr.

This is intentionally the smallest possible plan that still touches
every section of the template — pattern-match, do not copy literally.

## Tech-stack decisions

- Language / runtime: **Python 3.11+** — available everywhere, stdlib covers the requirement, no extra deps needed.
- Frameworks: **argparse** (stdlib) — built-in, no install step.
- Storage: none.
- Testing: **pytest** — de-facto standard, simplest assertion syntax.

ADR: see `history/decisions/ADR-001-choose-python-cli.md` (filed
alongside this example in a real project).

## File-by-file changes

| Status | Path | Purpose / change |
|---|---|---|
| NEW    | `src/mytool/__init__.py`     | Empty package marker. |
| NEW    | `src/mytool/__main__.py`     | Entry point; registers subcommands, invokes `hello`. |
| NEW    | `src/mytool/hello.py`        | Implements the `hello` subcommand (argparse + print). |
| NEW    | `tests/test_hello.py`        | Covers AC-1, AC-2, AC-3. |
| NEW    | `pyproject.toml`             | Declares the package, the `mytool` console script, and pytest as a dev dep. |

## Dependencies

### New

- `pytest` @ `^8.0` — test runner.

### Removed

(none)

## Data model changes

(none — no persistence.)

## Interface contracts

### `hello(argv: list[str] | None = None) -> int`

- Input: `argv` (defaults to `sys.argv[1:]` when `None`).
- Output: integer exit code. `0` on success, `2` on argparse error (Python's default for usage errors).
- Errors: argparse handles unknown flags; nothing custom.
- Side effect: writes one line to stdout on success.

## Test strategy

- Unit tests in `tests/test_hello.py`, invoking `hello()` directly with explicit `argv` so we don't depend on process invocation.
- Each of AC-1, AC-2, AC-3 maps to one test function.
- No integration / e2e tests for this size.

## Risks & mitigations

| Risk | Likelihood | Impact | Mitigation |
|---|---|---|---|
| Python 3.11 not installed on a developer's machine | L | M | README mentions minimum version; CI pins 3.11. |
| `pytest` install fails on a locked-down system | L | L | Document fallback: `python -m unittest` works with one extra import. |

## Rollout

- Landed behind a single PR.
- No feature flag, no migration window (no existing data).
- Rollback = revert the PR.
