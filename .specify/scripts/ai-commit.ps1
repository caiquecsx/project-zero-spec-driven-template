#!/usr/bin/env pwsh
# .specify/scripts/ai-commit.ps1
#
# AI commit wrapper. Sets the author and committer identity to the
# opencode AI identity for the duration of `git commit`, so commits
# made by the AI are visibly distinct from human commits on GitHub.
#
# Usage:
#   pwsh .specify/scripts/ai-commit.ps1 -Message "type(scope): summary"
#   pwsh .specify/scripts/ai-commit.ps1 -Message "fix(backend): ..." -- --amend
#
# The wrapper only sets GIT_AUTHOR_* and GIT_COMMITTER_* for this
# single invocation. The local user.name / user.email are NOT modified,
# so plain `git commit` calls keep the project owner's identity.
#
# Identity is read from the environment with these defaults:
#   AI_COMMIT_NAME  = opencode
#   AI_COMMIT_EMAIL = opencode@ai.local

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [string]$Message,
    [Parameter(ValueFromRemainingArguments)]
    [string[]]$GitArgs
)

$ErrorActionPreference = 'Stop'

$env:GIT_AUTHOR_NAME    = if ($env:AI_COMMIT_NAME)  { $env:AI_COMMIT_NAME }  else { 'opencode' }
$env:GIT_AUTHOR_EMAIL   = if ($env:AI_COMMIT_EMAIL) { $env:AI_COMMIT_EMAIL } else { 'opencode@ai.local' }
$env:GIT_COMMITTER_NAME  = $env:GIT_AUTHOR_NAME
$env:GIT_COMMITTER_EMAIL = $env:GIT_AUTHOR_EMAIL

Write-Host "Author:    $($env:GIT_AUTHOR_NAME) <$($env:GIT_AUTHOR_EMAIL)>"
Write-Host "Committer: $($env:GIT_COMMITTER_NAME) <$($env:GIT_COMMITTER_EMAIL)>"

git commit -m $Message @GitArgs
