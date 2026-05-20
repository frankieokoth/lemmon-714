Write-Host "Deploying Lemmon-714 Windows Symlinks..." -ForegroundColor Cyan

$RepoRoot = $PWD.Path

# The Deployment Matrix
$Symlinks = @(
    @{
        Source = "$RepoRoot\shell\windows\settings.json"
        Target = "$env:LOCALAPPDATA\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json"
    },
    @{
        Source = "$RepoRoot\shell\powershell\Microsoft.PowerShell_profile.ps1"
        Target = "$HOME\Documents\PowerShell\Microsoft.PowerShell_profile.ps1"
    }
)

foreach ($link in $Symlinks) {
    $src = $link.Source
    $tgt = $link.Target

    # Ensure target directory exists (PowerShell folder might not exist on fresh install)
    $TargetDir = Split-Path $tgt -Parent
    if (-Not (Test-Path $TargetDir)) { New-Item -ItemType Directory -Path $TargetDir -Force | Out-Null }

    if (-Not (Test-Path $src)) {
        Write-Host "Source missing: $src" -ForegroundColor Yellow
        continue
    }

    if ((Test-Path $tgt) -and (Get-Item $tgt).LinkType -ne "SymbolicLink") {
        Rename-Item -Path $tgt -NewName "$tgt.backup" -Force
    }

    New-Item -ItemType SymbolicLink -Path $tgt -Target $src -Force | Out-Null
    Write-Host "Linked: $tgt -> $src" -ForegroundColor Green
}