# ~\os\windows\bootstrap.ps1

Write-Host "⚡ Bootstrapping Lemmon-714 Windows Host..." -ForegroundColor Cyan

# The Definitive Winget Matrix
$packages = @(
    # --- Architectural Core ---
    "Microsoft.PowerToys",
    "Microsoft.WindowsTerminal",
    "JetBrains.JetBrainsMono",
    "Warp.Warp",

    # --- Development & Infrastructure ---
    "Anysphere.Cursor",
    "Microsoft.VisualStudioCode",
    "Docker.DockerDesktop",

    # --- Database & API GUIs ---
    "Postman.Postman",
    "MongoDB.Compass.Full",
    "Oracle.MySQLWorkbench",

    # --- Web, Cloud & Utilities ---
    "Google.Chrome",
    "Google.GoogleDrive",
    "Surfshark.Surfshark",
    "AnyDesk.AnyDesk",

    # --- Communications ---
    "Discord.Discord",
    "WhatsApp.WhatsApp",

    # --- High-Resolution Media & Audio ---
    "Daum.PotPlayer",
    "Apple.AppleMusic",
    "Spotify.Spotify",
    "50072StevenMayall.MusicBee",
    "XP9CSRSZ9PS7X0" # Qobuz
)

# Execution Engine
foreach ($pkg in $packages) {
    Write-Host "Installing $pkg..." -ForegroundColor Yellow
    winget install --id $pkg -e --accept-package-agreements --accept-source-agreements --silent
}

Write-Host "✅ Host Bootstrap Complete. Reboot required for font rendering." -ForegroundColor Green