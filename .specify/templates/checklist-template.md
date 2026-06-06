# Checklist NNN — <Short title, matches spec/plan/tasks>

> Status: Draft · Run after `implement` phase, before declaring the feature complete.
> Every box must be checkable. Unchecked boxes block merge/deploy.

## Spec quality

- [ ] All `[NEEDS CLARIFICATION]` markers removed from `spec.md`.
- [ ] Every functional requirement is covered by at least one acceptance criterion.
- [ ] Every acceptance criterion is **observable** (pass/fail can be determined).
- [ ] Non-goals and out-of-scope sections are non-empty.
- [ ] User stories have at least one acceptance criterion each.

## Plan quality

- [ ] Architecture overview explains the post-change shape.
- [ ] Every file listed in `File-by-file changes` exists in the working tree (or is removed, if `DEL`).
- [ ] All new dependencies are declared in the relevant manifest file and pinned.
- [ ] Interface contracts match the actual signatures in the code.
- [ ] Test strategy matches the tests that were written.

## Task quality

- [ ] Every task in `tasks.md` is ticked.
- [ ] Every task's `Acceptance:` line is satisfied (evidence recorded).
- [ ] No task was implemented outside its declared file scope.
- [ ] Definition of done satisfied for every task.

## Code quality

- [ ] No commented-out code, no dead code.
- [ ] No secrets, keys, or `.env` content in version control.
- [ ] Linter passes (or no linter is configured for this stack).
- [ ] Type checker passes (or no type checker is configured for this stack).
- [ ] No file exceeds 500 lines without a documented reason.

## Test quality

- [ ] All tests in `tests/` pass.
- [ ] At least one test exists for each public function/interface listed in the plan.
- [ ] Failure messages are clear enough to diagnose without re-reading the source.

## Process quality

- [ ] `history/changelog.md` updated with a one-line entry.
- [ ] Any deviation from the constitution is justified by an ADR in `history/decisions/`.
- [ ] If tech stack was chosen, an ADR captures the choice and rationale.
- [ ] The spec, plan, and tasks reflect the code as it actually shipped (no drift).
