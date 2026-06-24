#Requires -RunAsAdministrator
$ErrorActionPreference = "Stop"

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Syncing Lemmon-714 Windows Host Environment" -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan

# 1. Enforce App Ecosystem via Winget
$WingetFile = Join-Path $PSScriptRoot "..\os\windows\winget-export.json"
if (Test-Path $WingetFile) {
    Write-Host "=> Importing Windows developer application matrix..." -ForegroundColor Green
    winget import --import-file $WingetFile --accept-package-agreements --accept-source-agreements
}

# 2. Inject Registry Performance Tweaks
$RegFile = Join-Path $PSScriptRoot "..\os\windows\registry-tweaks.reg"
if (Test-Path $RegFile) {
    Write-Host "=> Injecting curated Windows Registry modifications..." -ForegroundColor Green
    reg import $RegFile
}

# 3. Symlink PowerShell Profile
$ProfileRepoPath = Join-Path $PSScriptRoot "..\shell\powershell\Microsoft.PowerShell_profile.ps1"
$ProfileDestDir  = "$HOME\Documents\WindowsPowerShell"
if (-not (Test-Path $ProfileDestDir)) { New-Item -ItemType Directory -Path $ProfileDestDir -Force | Out-Null }
$ProfileDestFile = Join-Path $ProfileDestDir "Microsoft.PowerShell_profile.ps1"

Write-Host "=> Linking PowerShell host nervous system..." -ForegroundColor Green
if (Test-Path $ProfileDestFile) { Remove-Item $ProfileDestFile -Force }
New-Item -ItemType SymbolicLink -Path $ProfileDestFile -Target $ProfileRepoPath -Force | Out-Null

Write-Host "==========================================" -ForegroundColor Cyan
Write-Host "Windows Sync Complete! Host is now configured." -ForegroundColor Cyan
Write-Host "==========================================" -ForegroundColor Cyan