# PowerShell script to fix git state
Set-Location "c:\Users\anwasita\AI-Delivery-Methodology"

# Set environment variable to skip editor
$env:GIT_EDITOR = "true"

# Continue rebase
Write-Host "Continuing rebase..."
$result = & git rebase --continue 2>&1 | Out-String
Write-Output $result
Write-Output $result | Out-File "git-rebase-result.txt"

# Check status
Write-Host "`nChecking status..."
$status = & git status --short 2>&1 | Out-String
Write-Output $status
Write-Output $status | Out-File "git-status-result.txt"

# Show last commits
Write-Host "`nLast 3 commits:"
$log = & git log --oneline -3 2>&1 | Out-String
Write-Output $log
Write-Output $log | Out-File "git-log-result.txt"
