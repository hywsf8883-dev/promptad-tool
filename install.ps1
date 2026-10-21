$Host.UI.RawUI.WindowTitle = "Prompted Installer"

Write-Host ""
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host "      Prompted Installer | Antigravity & Claude Code          " -ForegroundColor Cyan
Write-Host "    Repository: https://github.com/hywsf8883-dev/promptad-tool" -ForegroundColor DarkCyan
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Select the platform you want to install Prompted for:" -ForegroundColor Yellow
Write-Host ""
Write-Host "  [1] Google Antigravity only" -ForegroundColor White
Write-Host "  [2] Claude Code only" -ForegroundColor White
Write-Host "  [3] Both (Antigravity & Claude Code) [Recommended]" -ForegroundColor Green
Write-Host "  [4] Cancel" -ForegroundColor Gray
Write-Host ""

$inputChoice = Read-Host "Enter your choice [1-4] (Default: 3)"
if ([string]::IsNullOrWhiteSpace($inputChoice)) { $inputChoice = "3" }

switch ($inputChoice.Trim()) {
    "1" { $targetPlatform = "antigravity" }
    "2" { $targetPlatform = "claude" }
    "3" { $targetPlatform = "both" }
    "4" {
        Write-Host "[-] Installation cancelled." -ForegroundColor Yellow
        return
    }
    default { $targetPlatform = "both" }
}

Write-Host ""
Write-Host "[*] Setting up Prompted for: $targetPlatform..." -ForegroundColor Cyan

$userHome = $env:USERPROFILE
$tempDownloadDir = $null
$tempZip = $null
$sourceDir = $null

# Check if local files exist
$localCandidates = @($PSScriptRoot, (Get-Location).Path)
foreach ($cand in $localCandidates) {
    if ($cand -and (Test-Path (Join-Path $cand "prompts"))) {
        $sourceDir = $cand
        break
    }
}

if (-not $sourceDir) {
    Write-Host "[*] Downloading latest files from GitHub..." -ForegroundColor Cyan
    $zipUrl = "https://github.com/hywsf8883-dev/promptad-tool/archive/refs/heads/main.zip"
    $tempZip = Join-Path $env:TEMP "promptad-tool-main.zip"
    $tempDownloadDir = Join-Path $env:TEMP "promptad-tool-extract"

    if (Test-Path $tempDownloadDir) { Remove-Item -Path $tempDownloadDir -Recurse -Force -ErrorAction SilentlyContinue }
    if (Test-Path $tempZip) { Remove-Item -Path $tempZip -Force -ErrorAction SilentlyContinue }

    Invoke-WebRequest -Uri $zipUrl -OutFile $tempZip -UseBasicParsing
    Expand-Archive -Path $tempZip -DestinationPath $tempDownloadDir -Force

    $sourceDir = Join-Path $tempDownloadDir "promptad-tool-main"
    if (-not (Test-Path $sourceDir)) {
        $sub = Get-ChildItem -Path $tempDownloadDir -Directory | Select-Object -First 1
        if ($sub) { $sourceDir = $sub.FullName }
    }
}

# 1. Setup Global Prompts Library (~/.prompted/prompts)
$globalPromptsDir = Join-Path $userHome ".prompted\prompts"
if (-not (Test-Path $globalPromptsDir)) {
    New-Item -ItemType Directory -Path $globalPromptsDir -Force | Out-Null
}
$sourcePromptsDir = Join-Path $sourceDir "prompts"
if (Test-Path $sourcePromptsDir) {
    Get-ChildItem -Path $sourcePromptsDir -Filter "*.md" | ForEach-Object {
        $destFile = Join-Path $globalPromptsDir $_.Name
        if (-not (Test-Path $destFile)) {
            Copy-Item -Path $_.FullName -Destination $destFile -Force
        }
    }
    Write-Host "[+] Global prompts library configured at: $globalPromptsDir" -ForegroundColor Green
}

# 2. Setup Global CLI Command (prompted)
try {
    $npmDir = Join-Path $env:APPDATA "npm"
    if (Test-Path $npmDir) {
        $cmdContent = "@ECHO off`nIF EXIST `"%USERPROFILE%\.gemini\antigravity\scratch\prompted\bin\prompted.js`" (`n  node `"%USERPROFILE%\.gemini\antigravity\scratch\prompted\bin\prompted.js`" %*`n) ELSE IF EXIST `"$sourceDir\bin\prompted.js`" (`n  node `"$sourceDir\bin\prompted.js`" %*`n) ELSE (`n  node bin\prompted.js %*`n)"
        Set-Content -Path (Join-Path $npmDir "prompted.cmd") -Value $cmdContent -Force
        Write-Host "[+] Global CLI command 'prompted' registered in PATH!" -ForegroundColor Green
    }
} catch {}

# 3. Install for Google Antigravity
if ($targetPlatform -eq "antigravity" -or $targetPlatform -eq "both") {
    $geminiConfigDir = Join-Path $userHome ".gemini\config"
    $geminiPluginsDir = Join-Path $geminiConfigDir "plugins\prompted"
    $geminiSkillsDir = Join-Path $geminiConfigDir "skills\prompted"

    try {
        if (-not (Test-Path $geminiPluginsDir)) {
            New-Item -ItemType Directory -Path $geminiPluginsDir -Force | Out-Null
        }
        Copy-Item -Path (Join-Path $sourceDir "plugins\prompted\*") -Destination $geminiPluginsDir -Recurse -Force

        if (-not (Test-Path $geminiSkillsDir)) {
            New-Item -ItemType Directory -Path $geminiSkillsDir -Force | Out-Null
        }
        Copy-Item -Path (Join-Path $sourceDir ".agents\skills\prompted\*") -Destination $geminiSkillsDir -Recurse -Force

        $extraSkills = @("discord-bot-expert", "discord-dashboard", "minecraft-modding", "code-diagnostician")
        foreach ($sk in $extraSkills) {
            $dest = Join-Path $geminiConfigDir "skills\$sk"
            $src = Join-Path $sourceDir ".agents\skills\$sk"
            if (Test-Path $src) {
                if (-not (Test-Path $dest)) { New-Item -ItemType Directory -Path $dest -Force | Out-Null }
                Copy-Item -Path (Join-Path $src "*") -Destination $dest -Recurse -Force
            }
        }

        Write-Host "[+] Google Antigravity: Prompted plugin & skills installed successfully!" -ForegroundColor Green
    } catch {
        Write-Host "[!] Warning while installing to Antigravity: $_" -ForegroundColor Yellow
    }
}

# 4. Install for Claude Code
if ($targetPlatform -eq "claude" -or $targetPlatform -eq "both") {
    $claudeCommandsDir = Join-Path $userHome ".claude\commands"
    try {
        if (-not (Test-Path $claudeCommandsDir)) {
            New-Item -ItemType Directory -Path $claudeCommandsDir -Force | Out-Null
        }
        $claudeCommandsSource = Join-Path $sourceDir ".claude\commands"
        if (Test-Path $claudeCommandsSource) {
            Get-ChildItem -Path $claudeCommandsSource -Filter "*.md" | ForEach-Object {
                Copy-Item -Path $_.FullName -Destination (Join-Path $claudeCommandsDir $_.Name) -Force
            }
            Write-Host "[+] Claude Code: Prompted slash commands installed successfully!" -ForegroundColor Green
        }
    } catch {
        Write-Host "[!] Warning while installing to Claude Code: $_" -ForegroundColor Yellow
    }
}

# Cleanup temporary files
if ($tempDownloadDir -and (Test-Path $tempDownloadDir)) {
    Remove-Item -Path $tempDownloadDir -Recurse -Force -ErrorAction SilentlyContinue
}
if ($tempZip -and (Test-Path $tempZip)) {
    Remove-Item -Path $tempZip -Force -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "==============================================================" -ForegroundColor DarkGray
Write-Host "[SUCCESS] Installation Complete!" -ForegroundColor Green
Write-Host "==============================================================" -ForegroundColor DarkGray
Write-Host "How to use Prompted:" -ForegroundColor Cyan
Write-Host "  * From Any Terminal:  prompted list" -ForegroundColor Yellow
Write-Host "  * In Antigravity:     type /prompted (in the chat)" -ForegroundColor White
Write-Host "  * In Claude Code:     type /prompted (in the chat)" -ForegroundColor White
Write-Host "==============================================================" -ForegroundColor DarkGray
Write-Host ""
