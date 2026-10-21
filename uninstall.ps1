# ==============================================================================
# Prompted (برومتد) - Uninstaller for Windows
# Removes Prompted from Google Antigravity & Claude Code
# ==============================================================================

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$userHome = $env:USERPROFILE
$geminiConfigDir = Join-Path $userHome ".gemini\config"
$geminiPluginsDir = Join-Path $geminiConfigDir "plugins\prompted"
$geminiSkillsDir = Join-Path $geminiConfigDir "skills\prompted"
$claudeCommandFile = Join-Path $userHome ".claude\commands\prompted.md"

if (Test-Path $geminiPluginsDir) {
    Remove-Item -Path $geminiPluginsDir -Recurse -Force
    Write-Host "✔ Removed Prompted plugin from Antigravity" -ForegroundColor Green
}

if (Test-Path $geminiSkillsDir) {
    Remove-Item -Path $geminiSkillsDir -Recurse -Force
    Write-Host "✔ Removed Prompted skill from Antigravity" -ForegroundColor Green
}

if (Test-Path $claudeCommandFile) {
    Remove-Item -Path $claudeCommandFile -Force
    Write-Host "✔ Removed Prompted command from Claude Code" -ForegroundColor Green
}

Write-Host "`nℹ Note: Your prompts directory ($userHome\.prompted\prompts) was preserved." -ForegroundColor Cyan
Write-Host "✔ Prompted has been uninstalled." -ForegroundColor Green
