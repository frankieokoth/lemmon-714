Write-Host "Deploying Lemmon-714 Windows Symlinks..." -ForegroundColor Cyan

# 1. Define Paths (Assuming script is run from the repository root)
$RepoRoot = $PWD.Path
$TerminalSource = "$RepoRoot\shell\windows\settings.json"
$TerminalTarget = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"

# 2. The Deployment Engine
function Deploy-Symlink {
    param ([string]$Source, [string]$Target)
    
    if (-Not (Test-Path $Source)) {
        Write-Host "Source missing: $Source" -ForegroundColor Yellow
        return
    }

    # Backup existing config if it's not already a symlink
    if ((Test-Path $Target) -and (Get-Item $Target).LinkType -ne "SymbolicLink") {
        Write-Host "Backing up existing config..." -ForegroundColor DarkGray
        Rename-Item -Path $Target -NewName "$Target.backup" -Force
    }

    # Force the symbolic link
    New-Item -ItemType SymbolicLink -Path $Target -Target $Source -Force | Out-Null
    Write-Host "Linked: $Target -> $Source" -ForegroundColor Green
}

# 3. Execute
Deploy-Symlink -Source $TerminalSource -Target $TerminalTarget

Write-Host "Windows host synchronization complete." -ForegroundColor Cyan