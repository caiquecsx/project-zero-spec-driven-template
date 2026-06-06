# ADR-001 — Choose Python for the CLI tool

> Status: Accepted · Date: 2026-06-06 · Supersedes: —

## Context

We need a tiny command-line tool. Stack is undecided; the constitution
keeps the project tech-agnostic and lets each plan pick a stack.

## Decision

Use **Python 3.11+** with stdlib `argparse` for the CLI and **pytest**
for tests.

## Consequences

- No runtime install needed beyond Python 3.11.
- One dev dependency (`pytest`).
- Easy for any contributor to read; no language lock-in beyond Python.

## Alternatives considered

- **Node.js + commander** — heavier, requires `npm install` for one file.
- **Go** — compiles to a single binary, but requires Go toolchain on every contributor's machine.
- **Bash** — no portable way to express the test cases on Windows.
