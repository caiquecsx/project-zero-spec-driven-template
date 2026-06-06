#requires -Version 5.1
<#
.SYNOPSIS
    Scaffold a new spec folder for the SDD workflow.

.DESCRIPTION
    Creates specs/NNN-<slug>/ with spec.md, plan.md, tasks.md, and
    checklist.md pre-populated from .specify/templates/. NNN is the
    next zero-padded index after the highest existing one.

.PARAMETER Slug
    Kebab-case short name for the feature, e.g. "user-login".

.EXAMPLE
    pwsh .specify/scripts/new-spec.ps1 user-login
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true, Position = 0)]
    [ValidatePattern('^[a-z0-9]+(-[a-z0-9]+)*$')]
    [string]$Slug
)

$ErrorActionPreference = 'Stop'

$root   = Resolve-Path (Join-Path $PSScriptRoot '..\..')
$specs  = Join-Path $root 'specs'
$tplDir = Join-Path $root '.specify\templates'

if (-not (Test-Path -LiteralPath $specs)) {
    New-Item -ItemType Directory -Force -Path $specs | Out-Null
}

$existing = Get-ChildItem -LiteralPath $specs -Directory -ErrorAction SilentlyContinue |
    Where-Object { $_.Name -match '^(\d{3})-'} |
    ForEach-Object { [int]$_.Name.Substring(0, 3) }

$next = if ($existing) { ([int[]]$existing | Measure-Object -Maximum).Maximum + 1 } else { 1 }
if ($existing -and ($existing -contains 0)) { $next = 1 }
$index = '{0:D3}' -f $next

$folderName = "$index-$Slug"
$folderPath = Join-Path $specs $folderName

if (Test-Path -LiteralPath $folderPath) {
    throw "Folder already exists: $folderPath"
}

New-Item -ItemType Directory -Force -Path $folderPath | Out-Null

$files = @{
    'spec-template.md'      = 'spec.md'
    'plan-template.md'      = 'plan.md'
    'tasks-template.md'     = 'tasks.md'
    'checklist-template.md' = 'checklist.md'
}

foreach ($kvp in $files.GetEnumerator()) {
    $src = Join-Path $tplDir $kvp.Key
    $dst = Join-Path $folderPath $kvp.Value
    if (-not (Test-Path -LiteralPath $src)) {
        throw "Missing template: $src"
    }
    Copy-Item -LiteralPath $src -Destination $dst
}

$today = Get-Date -Format 'yyyy-MM-dd'

Write-Host ""
Write-Host "Created: $folderPath" -ForegroundColor Green
Write-Host ""
Write-Host "Next steps in opencode:" -ForegroundColor Cyan
Write-Host "  1. Open the new spec and fill in the Context / Goals sections."
Write-Host "  2. In opencode, type:  specify: <describe the feature in your own words>"
Write-Host "     (the AI will write/overwrite spec.md based on your intent)"
Write-Host "  3. Then run:           clarify"
Write-Host "  4. Then run:           plan"
Write-Host "  5. Then run:           tasks"
Write-Host "  6. Then run:           implement"
Write-Host "  7. Finally run:        checklist"
Write-Host ""
Write-Host "Date: $today" -ForegroundColor DarkGray
