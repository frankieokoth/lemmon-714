# 1. Clear the Microsoft Copyright Noise
Clear-Host

# 2. Host Execution Aliases
Set-Alias ll Get-ChildItem
Set-Alias g git

# 3. Lemmon-714 Minimalist Prompt
function prompt {
    $path = (Get-Location).Path -replace [regex]::Escape($HOME), '~'
    
    Write-Host "Lemmon-714 " -NoNewline -ForegroundColor Cyan
    Write-Host "[$path] " -NoNewline -ForegroundColor DarkGray
    Write-Host "⚡ " -NoNewline -ForegroundColor Yellow
    
    return " "
}