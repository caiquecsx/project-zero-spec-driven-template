# project_zero

Spec-Driven Development (SDD) project driven by opencode.

## How it works

Every feature follows the pipeline below. The AI agent (opencode) reads
[`AGENTS.md`](./AGENTS.md) on every turn and refuses to advance past a
phase whose gate is unmet.

```
specify: <idea>  →  clarify  →  plan  →  tasks  →  implement  →  checklist
   spec.md         spec.md    plan.md   tasks.md    src/ + tests/  checklist.md
```

The binding rules live in [`.specify/memory/constitution.md`](./.specify/memory/constitution.md).
Templates are in [`.specify/templates/`](./.specify/templates/).
A worked example lives in [`specs/000-template/`](./specs/000-template/) (delete after
the first real spec lands).

## Quick start

1. Scaffold a new spec (PowerShell):

   ```powershell
   pwsh .specify/scripts/new-spec.ps1 my-feature
   ```

2. In opencode, drive the workflow:

   ```
   specify: <describe the feature>
   clarify
   plan
   tasks
   implement
   checklist
   ```

## Directory map

```
project_zero/
├── AGENTS.md                      ← opencode reads this every turn
├── README.md                      ← you are here
├── .specify/
│   ├── memory/constitution.md     ← binding project rules
│   ├── templates/                 ← blank forms
│   └── scripts/new-spec.ps1       ← scaffold a new spec folder
├── specs/
│   ├── 000-template/              ← reference example (read-only)
│   └── NNN-slug/
│       ├── spec.md
│       ├── plan.md
│       ├── tasks.md
│       └── checklist.md
├── history/
│   ├── decisions/                 ← ADRs
│   └── changelog.md               ← append-only
├── src/                           ← implementation
└── tests/                         ← tests
```

## See also

- [`AGENTS.md`](./AGENTS.md) — the AI protocol, including the hard-gate rules.
- [`.specify/memory/constitution.md`](./.specify/memory/constitution.md) — project principles and SDD contract.
- [`specs/000-template/`](./specs/000-template/) — a fully filled-out example.
