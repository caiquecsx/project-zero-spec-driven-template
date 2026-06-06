# Spec 000 — Add `hello` subcommand to a CLI

> Status: Reference example (read-only) · Owner: — · Created: 2026-06-06

This is a **reference example** that fills the template with a complete,
small feature. Pattern-match real specs against it. Delete this folder
after the first real spec lands (i.e. when `specs/001-...` exists).

## Context

The project ships a command-line tool with no commands yet. We want a
first, trivial command to exercise the SDD pipeline end-to-end and to
give the team a worked example to copy from.

## Goals

- [ ] G-1 — Ship a `hello` subcommand that prints a greeting to stdout.
- [ ] G-2 — Demonstrate the full SDD pipeline (spec → plan → tasks → impl → checklist) on a feature small enough to review in one sitting.

## Non-goals

- NG-1 — Localization of the greeting string.
- NG-2 — Interactive prompts or arguments other than `--name`.
- NG-3 — Packaging / distribution of the CLI.

## User stories

- US-1 — As a CLI user, I want to run `mytool hello --name Ada` and see `Hello, Ada`, so that I can confirm the tool is installed and reachable.

## Functional requirements

- FR-1 — The tool shall expose a `hello` subcommand.
- FR-2 — The subcommand shall accept exactly one optional flag, `--name`, defaulting to `World`.
- FR-3 — The subcommand shall write a single line `Hello, <name>` to stdout and exit with code 0.
- FR-4 — On unknown flags, the subcommand shall exit with a non-zero code and print a usage line to stderr.

## Acceptance criteria

- AC-1 — Given the tool is installed, when the user runs `mytool hello --name Ada`, then stdout contains exactly `Hello, Ada` and the exit code is 0.
- AC-2 — Given the tool is installed, when the user runs `mytool hello`, then stdout contains exactly `Hello, World`.
- AC-3 — Given the tool is installed, when the user runs `mytool hello --unknown`, then the exit code is non-zero and stderr contains the substring `usage`.
- AC-4 — The automated test suite covers AC-1, AC-2, and AC-3 and all three pass.

## Open questions

(none — kept here to show the section's shape; delete or leave empty in real specs.)

## Out of scope

- OS-1 — Persisting the user's name between invocations.
- OS-2 — Colored or styled output.

## Change log

- 2026-06-06 — Initial draft (reference example).
