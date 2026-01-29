# PowerShell script to complete git rebase
$ErrorActionPreference = "Stop"
Set-Location "c:\Users\anwasita\AI-Delivery-Methodology"

Write-Host "Attempting to continue git rebase..."

# Try continuing the rebase
& git -c core.editor=true rebase --continue 2>&1 | Out-String

Write-Host "`nChecking status..."
& git status --short

Write-Host "`nComplete!"
