# ==============================================================================
# Prompted (برومتد) - Installer for Windows
# Configures Prompted for Google Antigravity & Claude Code
# ==============================================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host "🚀 Installing Prompted for Antigravity & Claude Code..." -ForegroundColor Cyan
Write-Host "==============================================================" -ForegroundColor Cyan

$scriptRoot = $PSScriptRoot
if (-not $scriptRoot) { $scriptRoot = Get-Location }

$userHome = $env:USERPROFILE

# 1. Setup Global Prompts Directory
$globalPromptsDir = Join-Path $userHome ".prompted\prompts"
if (-not (Test-Path $globalPromptsDir)) {
    New-Item -ItemType Directory -Path $globalPromptsDir -Force | Out-Null
    Write-Host "[+] Created global prompts library at: $globalPromptsDir" -ForegroundColor Green
} else {
    Write-Host "[*] Found existing global prompts library at: $globalPromptsDir" -ForegroundColor DarkGray
}

# Copy starter prompt templates if not existing
$sourcePromptsDir = Join-Path $scriptRoot "prompts"
if (Test-Path $sourcePromptsDir) {
    Get-ChildItem -Path $sourcePromptsDir -Filter "*.md" | ForEach-Object {
        $destFile = Join-Path $globalPromptsDir $_.Name
        if (-not (Test-Path $destFile)) {
            Copy-Item -Path $_.FullName -Destination $destFile -Force
        }
    }
    Write-Host "[+] Starter prompt templates synced to global library." -ForegroundColor Green
}

# 2. Setup Antigravity Integration
$geminiConfigDir = Join-Path $userHome ".gemini\config"
$geminiPluginsDir = Join-Path $geminiConfigDir "plugins\prompted"
$geminiSkillsDir = Join-Path $geminiConfigDir "skills\prompted"

try {
    # Install as Plugin
    if (-not (Test-Path $geminiPluginsDir)) {
        New-Item -ItemType Directory -Path $geminiPluginsDir -Force | Out-Null
    }
    Copy-Item -Path (Join-Path $scriptRoot "plugins\prompted\*") -Destination $geminiPluginsDir -Recurse -Force
    
    # Also install as standalone Skill for instant discovery
    if (-not (Test-Path $geminiSkillsDir)) {
        New-Item -ItemType Directory -Path $geminiSkillsDir -Force | Out-Null
    }
    Copy-Item -Path (Join-Path $scriptRoot ".agents\skills\prompted\*") -Destination $geminiSkillsDir -Recurse -Force
    
    Write-Host "[+] Installed Prompted into Google Antigravity ($geminiSkillsDir)" -ForegroundColor Green
} catch {
    Write-Host "[!] Warning while installing to Antigravity: $_" -ForegroundColor Yellow
}

# 3. Setup Claude Code Integration
$claudeCommandsDir = Join-Path $userHome ".claude\commands"
try {
    if (-not (Test-Path $claudeCommandsDir)) {
        New-Item -ItemType Directory -Path $claudeCommandsDir -Force | Out-Null
    }
    $claudeSource = Join-Path $scriptRoot ".claude\commands\prompted.md"
    if (Test-Path $claudeSource) {
        Copy-Item -Path $claudeSource -Destination (Join-Path $claudeCommandsDir "prompted.md") -Force
        Write-Host "[+] Installed Prompted into Claude Code ($claudeCommandsDir\prompted.md)" -ForegroundColor Green
    }
} catch {
    Write-Host "[!] Warning while installing to Claude Code: $_" -ForegroundColor Yellow
}

Write-Host ""
Write-Host "[SUCCESS] Installation Complete!" -ForegroundColor Green
Write-Host "==============================================================" -ForegroundColor DarkGray
Write-Host "How to use Prompted:" -ForegroundColor Cyan
Write-Host "1. In Google Antigravity / Claude Code, simply type:" -ForegroundColor White
Write-Host "   /prompted" -ForegroundColor Yellow
Write-Host "2. Or execute a specific prompt directly:" -ForegroundColor White
Write-Host "   /prompted 01-feature-builder" -ForegroundColor Yellow
Write-Host "3. Add your custom prompt templates anytime in:" -ForegroundColor White
Write-Host "   $globalPromptsDir" -ForegroundColor DarkCyan
Write-Host "   (or create a ./prompts folder inside your project)" -ForegroundColor DarkCyan
Write-Host "==============================================================" -ForegroundColor DarkGray
