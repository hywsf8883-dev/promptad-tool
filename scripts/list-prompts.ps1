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
    (Join-Path $scriptDir '..\prompts'),
    (Join-Path $env:USERPROFILE '.gemini\antigravity\scratch\prompted\prompts'),
    (Join-Path $env:USERPROFILE '.prompted\prompts')
)

$knownTitles = @{
    'components-v2-full-guide.md' = 'Discord.js Components V2 - Complete Migration Guide'
    'discord-bot-expert-prompt.md' = 'Discord & Telegram Bot Expert (Node.js & discord.js v14+)'
    'discord-dashboard-complete-guide2.md' = 'Discord Bot Web Dashboard - Complete Guide'
    'discord-dashboard-prompt.md' = 'Discord Bot Web Dashboard & OAuth2 Specialist'
    'discord-image-drawing-prompt.md' = 'Discord Image & Canvas Drawing Expert'
    'discord-image-expert-v2.md' = 'Discord Image & Graphics Generator (V2 Advanced)'
    'discord-image-ultimate.md' = 'Discord Image & Graphics Suite - Ultimate Edition'
    'discord-mega-expert-prompt.md' = 'Discord Mega Expert (Unified Bot & Systems)'
    'discord-mega-expert-ultimate-prompt.md' = 'Discord & Telegram Mega Expert - Ultimate Master Suite (510 KB)'
    'minecraft-modding-expert-prompt.md' = 'Minecraft Modding Master (Fabric, NeoForge, Forge, Java 21)'
    'prompt.md' = 'Universal Code Diagnostician (Direct Code & Root-Cause Mode)'
}

$knownDescs = @{
    'components-v2-full-guide.md' = 'Transform Embeds into modern interactive Components V2 layouts.'
    'discord-bot-expert-prompt.md' = 'Production bot architecture, handlers, slash commands, and databases.'
    'discord-dashboard-complete-guide2.md' = 'Responsive HTML/CSS/JS dashboard, live stats, and OAuth2.'
    'discord-dashboard-prompt.md' = 'OAuth2 authentication, guild management, permissions, and backend.'
    'discord-image-drawing-prompt.md' = 'Graphic rendering with @napi-rs/canvas, Skia-Canvas, and Sharp.'
    'discord-image-expert-v2.md' = 'Welcome cards, member ranks, level banners, and canvas systems.'
    'discord-image-ultimate.md' = 'Comprehensive visual engine for cards, leaderboards, and graphics.'
    'discord-mega-expert-prompt.md' = 'All-in-one guide: moderation, economy, leveling, games, and voice.'
    'discord-mega-expert-ultimate-prompt.md' = '14,000+ line reference covering every event, system, and library.'
    'minecraft-modding-expert-prompt.md' = 'Full modding guide for blocks, entities, items, and Blockbench.'
    'prompt.md' = 'Direct root-cause diagnosis and immediate working code in any language.'
}

$foundFiles = [System.Collections.Generic.Dictionary[string, string]]::new()

foreach ($dir in $promptDirs) {
    if (Test-Path -LiteralPath $dir -ErrorAction SilentlyContinue) {
        Get-ChildItem -LiteralPath $dir -Filter '*.md' -File -ErrorAction SilentlyContinue | ForEach-Object {
            if (-not $foundFiles.ContainsKey($_.Name) -and $_.Name -ne 'README.md' -and $_.Name -notmatch '^0\d-') {
                $foundFiles[$_.Name] = $_.FullName
            }
        }
    }
}

if ($foundFiles.Count -eq 0) {
    Write-Host 'No prompt files found.' -ForegroundColor Yellow
    exit 0
}

Write-Host ''
Write-Host '==============================================================' -ForegroundColor Cyan
Write-Host '  Prompted Library - Available Master Prompts:' -ForegroundColor Cyan
Write-Host '==============================================================' -ForegroundColor Cyan

$index = 1
foreach ($key in ($foundFiles.Keys | Sort-Object)) {
    $fullPath = $foundFiles[$key]
    
    $title = $knownTitles[$key]
    if (-not $title) { $title = $key }
    
    $desc = $knownDescs[$key]
    if (-not $desc) { $desc = 'Comprehensive master prompt template.' }

    $sizeKb = [math]::Round(((Get-Item -LiteralPath $fullPath).Length / 1KB), 1)

    Write-Host "[$index] $key ($sizeKb KB)" -ForegroundColor Green
    Write-Host "    Title: $title" -ForegroundColor White
    Write-Host "    Desc:  $desc" -ForegroundColor Gray
    Write-Host ''
    $index++
}

Write-Host 'Usage: In Antigravity or Claude Code chat, type: /prompted [name-or-number]' -ForegroundColor DarkCyan
Write-Host ''
