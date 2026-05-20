$ErrorActionPreference = "Stop"

Write-Host "==========================================" -ForegroundColor Yellow
Write-Host "Backing Up Windows Host Configuration State" -ForegroundColor Yellow
Write-Host "==========================================" -ForegroundColor Yellow

$WindowsOsDir = Join-Path $PSScriptRoot "..\os\windows"
if (-not (Test-Path $WindowsOsDir)) { New-Item -ItemType Directory -Path $WindowsOsDir -Force | Out-Null }

# 1. Export Winget App Schema
$WingetDest = Join-Path $WindowsOsDir "winget-export.json"
Write-Host "=> Snapshotting installed WinGet application matrix..." -ForegroundColor Green
winget export --output $WingetDest --include-versions | Out-Null

# 2. Export Windows Terminal Configurations (Optional but Recommended)
$WtLocalPath = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
$WtDestPath  = Join-Path $WindowsOsDir "terminal-settings.json"
if (Test-Path $WtLocalPath) {
    Write-Host "=> Backing up high-fidelity Windows Terminal settings..." -ForegroundColor Green
    Copy-Item $WtLocalPath -Destination $WtDestPath -Force
}

Write-Host "==========================================" -ForegroundColor Yellow
Write-Host "State captured successfully inside os/windows/" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Yellow