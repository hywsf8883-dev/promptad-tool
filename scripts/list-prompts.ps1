<#
.SYNOPSIS
    Lists all available prompt files for Prompted.
#>

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

$currentDir = Get-Location
$scriptDir = $PSScriptRoot

$promptDirs = @(
    (Join-Path $currentDir 'prompts'),
    (Join-Path $scriptDir '..\prompts')
)

$foundFiles = [System.Collections.Generic.Dictionary[string, string]]::new()

foreach ($dir in $promptDirs) {
    if (Test-Path -LiteralPath $dir -ErrorAction SilentlyContinue) {
        Get-ChildItem -LiteralPath $dir -Filter '*.md' -File -ErrorAction SilentlyContinue | ForEach-Object {
            if (-not $foundFiles.ContainsKey($_.Name) -and $_.Name -ne 'README.md') {
                $foundFiles[$_.Name] = $_.FullName
            }
        }
    }
}

if ($foundFiles.Count -eq 0) {
    Write-Host 'No prompt files found in ./prompts' -ForegroundColor Yellow
    exit 0
}

Write-Host ''
Write-Host '==============================================================' -ForegroundColor Cyan
Write-Host 'Prompted Library - Available Master Prompts:' -ForegroundColor Cyan
Write-Host '==============================================================' -ForegroundColor Cyan

$index = 1
foreach ($key in ($foundFiles.Keys | Sort-Object)) {
    $fullPath = $foundFiles[$key]
    $lines = Get-Content -LiteralPath $fullPath -Encoding UTF8 -TotalCount 15 -ErrorAction SilentlyContinue
    
    $title = ($lines | Where-Object { $_ -match '^#\s+(.+)' } | Select-Object -First 1) -replace '^#\s+', ''
    if (-not $title) {
        if ($key -eq 'prompt.md') {
            $title = 'Universal Code Diagnostician (Direct Code & Root-Cause Mode)'
        } else {
            $title = $key
        }
    }
    
    $desc = ($lines | Where-Object { $_ -match '^(وصف|description):\s*(.+)' } | Select-Object -First 1) -replace '^(وصف|description):\s*', ''
    if (-not $desc) {
        $subHeader = ($lines | Where-Object { $_ -match '^##\s+([^#\s].+)' } | Select-Object -First 1) -replace '^##\s+', ''
        if ($subHeader) {
            $desc = $subHeader
        } elseif ($key -eq 'prompt.md') {
            $desc = 'Direct diagnosis and immediate production-ready complete code across all languages.'
        } else {
            $desc = 'Comprehensive master prompt template.'
        }
    }

    $sizeKb = [math]::Round(((Get-Item -LiteralPath $fullPath).Length / 1KB), 1)

    Write-Host "[$index] $key ($sizeKb KB)" -ForegroundColor Green
    Write-Host "    Title: $title" -ForegroundColor White
    Write-Host "    Desc:  $desc" -ForegroundColor Gray
    Write-Host ''
    $index++
}

Write-Host 'Usage: In Antigravity or Claude Code, run: /prompted [name-or-number]' -ForegroundColor DarkCyan
Write-Host ''
