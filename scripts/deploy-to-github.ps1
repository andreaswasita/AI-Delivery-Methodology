# PowerShell script to fix git and deploy to GitHub Pages
Write-Host "===================================" -ForegroundColor Cyan
Write-Host "Fixing Git and Deploying to GitHub Pages" -ForegroundColor Cyan
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""

Set-Location "c:\Users\anwasita\AI-Delivery-Methodology"

Write-Host "Step 1: Cleaning up rebase state..." -ForegroundColor Yellow
Remove-Item -Path ".git\rebase-merge" -Recurse -Force -ErrorAction SilentlyContinue
Remove-Item -Path ".git\REBASE_HEAD" -Force -ErrorAction SilentlyContinue
Remove-Item -Path ".git\ORIG_HEAD" -Force -ErrorAction SilentlyContinue
Write-Host "Done." -ForegroundColor Green
Write-Host ""

Write-Host "Step 2: Checking current status..." -ForegroundColor Yellow
git status --short
Write-Host ""

Write-Host "Step 3: Adding all files..." -ForegroundColor Yellow
git add .
Write-Host "Done." -ForegroundColor Green
Write-Host ""

Write-Host "Step 4: Committing changes..." -ForegroundColor Yellow
git commit -m "Add program governance framework and fix GitHub Pages deployment"
Write-Host ""

Write-Host "Step 5: Pushing to GitHub..." -ForegroundColor Yellow
git push origin main
Write-Host ""

Write-Host "===================================" -ForegroundColor Cyan
Write-Host "Deployment Complete!" -ForegroundColor Green
Write-Host "===================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Your site should be available at:" -ForegroundColor White
Write-Host "https://andreaswasita.github.io/AI-Delivery-Methodology/" -ForegroundColor Yellow
Write-Host ""
Write-Host "Note: GitHub Pages may take 1-2 minutes to update." -ForegroundColor Gray
Write-Host ""

Read-Host "Press Enter to continue"
