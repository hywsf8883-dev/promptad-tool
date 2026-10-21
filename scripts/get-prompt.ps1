param (
    [Parameter(Position=0, Mandatory=$true)]
    [string]$Target
)

[Console]::OutputEncoding = [System.Text.Encoding]::UTF8

$promptDirs = @(
    (Join-Path (Get-Location) "prompts"),
    (Join-Path $env:USERPROFILE ".prompted\prompts"),
    (Join-Path $PSScriptRoot "..\prompts")
)

$foundFiles = [System.Collections.Generic.Dictionary[string, string]]::new()

foreach ($dir in $promptDirs) {
    if (Test-Path $dir) {
        Get-ChildItem -Path $dir -Filter "*.md" -File | ForEach-Object {
            if (-not $foundFiles.ContainsKey($_.Name) -and $_.Name -ne "README.md") {
                $foundFiles[$_.Name] = $_.FullName
            }
        }
    }
}

# Check if target is a number
$sortedKeys = $foundFiles.Keys | Sort-Object
if ($Target -match "^\d+$") {
    $idx = [int]$Target - 1
    if ($idx -ge 0 -and $idx -lt $sortedKeys.Count) {
        $selectedKey = $sortedKeys[$idx]
        Get-Content -Path $foundFiles[$selectedKey] -Encoding UTF8 -Raw
        exit 0
    }
}

# Check if target matches filename directly or partially
foreach ($key in $sortedKeys) {
    if ($key -like "*$Target*" -or ($key -replace "\.md$", "") -like "*$Target*") {
        Get-Content -Path $foundFiles[$key] -Encoding UTF8 -Raw
        exit 0
    }
}

Write-Error "Prompt matching '$Target' was not found."
exit 1
