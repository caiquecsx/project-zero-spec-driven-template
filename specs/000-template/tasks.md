# Tasks 000 — Add `hello` subcommand to a CLI

> Status: Reference example (read-only) · Depends on: `plan.md` · Created: 2026-06-06

## Tasks

- [ ] T-001 — Create `pyproject.toml` declaring the `mytool` package and `pytest` dev dep  [file: `pyproject.toml`, est: S, deps: none]
  - Acceptance: `python -c "import tomllib; tomllib.load(open('pyproject.toml','rb'))"` exits 0 and the file contains the strings `[project]` and `pytest`.
- [ ] T-002 — Create `src/mytool/__init__.py` as an empty file  [file: `src/mytool/__init__.py`, est: S, deps: none]
  - Acceptance: file exists and is empty (0 bytes).
- [ ] T-003 — Implement `hello(name: str = "World") -> int` in `src/mytool/hello.py`  [file: `src/mytool/hello.py`, est: S, deps: T-001, T-002]
  - Acceptance: `python -c "from mytool.hello import hello; assert hello.__doc__ is not None"` exits 0 and the function returns `0` when called with no args after parsing.
- [ ] T-004 — Implement CLI entry point in `src/mytool/__main__.py` that wires argparse to `hello`  [file: `src/mytool/__main__.py`, est: S, deps: T-003]
  - Acceptance: `python -m mytool hello --name Ada` prints `Hello, Ada` and exits 0.
- [ ] T-005 — Write tests covering AC-1, AC-2, AC-3 in `tests/test_hello.py`  [file: `tests/test_hello.py`, est: M, deps: T-003]
  - Acceptance: `pytest -q` reports 3 passed, 0 failed.
- [ ] T-006 — Verify AC-4 by running the full test suite  [file: `tests/`, est: S, deps: T-005]
  - Acceptance: `pytest -q` exits 0 and includes the test names from T-005.

## Definition of done

- [x] Every task above is ticked.
- [x] No file outside the `plan.md` `File-by-file changes` table was touched.
- [x] `pytest -q` passes locally.
- [x] `history/changelog.md` has one line per ticked task.
