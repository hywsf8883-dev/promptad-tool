# ==============================================================================
# Prompted (برومتد) - Universal Installer for Windows
# GitHub: https://github.com/hywsf8883-dev/promptad-tool.git
# ==============================================================================

param (
    [Parameter(Position=0)]
    [string]$TargetPlatform = ""
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8
$OutputEncoding = [System.Text.Encoding]::UTF8

Write-Host ""
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host "      🚀 Prompted Installer | مثبت أداة برومتد                " -ForegroundColor Cyan
Write-Host "    Repository: https://github.com/hywsf8883-dev/promptad-tool" -ForegroundColor DarkCyan
Write-Host "==============================================================" -ForegroundColor Cyan
Write-Host ""

# Determine target platform if not passed as parameter
if (-not $TargetPlatform) {
    Write-Host "اختر المنصة التي تريد تثبيت الأداة عليها:" -ForegroundColor Yellow
    Write-Host "Select the platform you want to install Prompted for:" -ForegroundColor Gray
    Write-Host ""
    Write-Host "  [1] Google Antigravity فقط" -ForegroundColor White
    Write-Host "  [2] Claude Code فقط" -ForegroundColor White
    Write-Host "  [3] كلاهما معاً (Both Antigravity and Claude Code) - [موصى به]" -ForegroundColor Green
    Write-Host "  [4] إلغاء (Cancel)" -ForegroundColor Gray
    Write-Host ""
    
    $inputChoice = Read-Host "أدخل رقم اختيارك (Enter choice) [1-4] (Default: 3)"
    if (-not $inputChoice) { $inputChoice = "3" }
    
    switch ($inputChoice.Trim()) {
        "1" { $TargetPlatform = "antigravity" }
        "2" { $TargetPlatform = "claude" }
        "3" { $TargetPlatform = "both" }
        "4" {
            Write-Host "❌ تم إلغاء التثبيت. (Installation cancelled)" -ForegroundColor Red
            exit 0
        }
        default { $TargetPlatform = "both" }
    }
}

Write-Host ""
Write-Host "[*] جاري تجهيز الملفات وتثبيت الأداة لـ: $TargetPlatform..." -ForegroundColor Cyan

$userHome = $env:USERPROFILE
$tempDownloadDir = $null
$sourceDir = $null

$localCandidates = @($PSScriptRoot, (Get-Location).Path)
foreach ($cand in $localCandidates) {
    if ($cand -and (Test-Path (Join-Path $cand "prompts"))) {
        $sourceDir = $cand
        break
    }
}

if (-not $sourceDir) {
    Write-Host "[*] جاري تحميل ملفات الأداة من GitHub..." -ForegroundColor Cyan
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
    Write-Host "[✔] تم تجهيز مكتبة البرومات في: $globalPromptsDir" -ForegroundColor Green
}

# 2. Install for Google Antigravity
if ($TargetPlatform -eq "antigravity" -or $TargetPlatform -eq "both") {
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
        
        Write-Host "[✔] تم تثبيت Prompted في Google Antigravity بنجاح!" -ForegroundColor Green
    } catch {
        Write-Host "[!] تحذير أثناء تثبيت Antigravity: $_" -ForegroundColor Yellow
    }
}

# 3. Install for Claude Code
if ($TargetPlatform -eq "claude" -or $TargetPlatform -eq "both") {
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
            Write-Host "[✔] تم تثبيت أوامر Prompted في Claude Code بنجاح!" -ForegroundColor Green
        }
    } catch {
        Write-Host "[!] تحذير أثناء تثبيت Claude Code: $_" -ForegroundColor Yellow
    }
}

# Cleanup
if ($tempDownloadDir -and (Test-Path $tempDownloadDir)) {
    Remove-Item -Path $tempDownloadDir -Recurse -Force -ErrorAction SilentlyContinue
}
if ($tempZip -and (Test-Path $tempZip)) {
    Remove-Item -Path $tempZip -Force -ErrorAction SilentlyContinue
}

Write-Host ""
Write-Host "==============================================================" -ForegroundColor DarkGray
Write-Host "🎉 تم التثبيت بنجاح! (Installation Completed Successfully)" -ForegroundColor Green
Write-Host "==============================================================" -ForegroundColor DarkGray
Write-Host "💡 للتشغيل الآن:" -ForegroundColor Cyan
if ($TargetPlatform -eq "antigravity" -or $TargetPlatform -eq "both") {
    Write-Host "  - في Google Antigravity: اكتب أمر /prompted" -ForegroundColor White
}
if ($TargetPlatform -eq "claude" -or $TargetPlatform -eq "both") {
    Write-Host "  - في Claude Code: اكتب أمر /prompted" -ForegroundColor White
}
Write-Host "  - من التيرمينال: node bin/prompted.js list" -ForegroundColor DarkCyan
Write-Host "==============================================================" -ForegroundColor DarkGray
Write-Host ""
