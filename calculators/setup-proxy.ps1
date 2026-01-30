# Quick Setup Script for Local CORS Proxy
# Run this in PowerShell

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "   LOCAL PROXY SERVER - SETUP GUIDE" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan

# Check if proxy is running
$proxyRunning = $false
try {
    $response = Invoke-WebRequest -Uri "http://localhost:3000/api/messages" -Method OPTIONS -ErrorAction SilentlyContinue
    $proxyRunning = $true
} catch {}

if ($proxyRunning) {
    Write-Host "✅ Proxy server is RUNNING on http://localhost:3000" -ForegroundColor Green
} else {
    Write-Host "⚠️  Proxy server is NOT running" -ForegroundColor Yellow
    Write-Host "`nTo start it, run in a separate terminal:" -ForegroundColor Yellow
    Write-Host "   cd calculators" -ForegroundColor White
    Write-Host "   python proxy_server.py`n" -ForegroundColor White
}

Write-Host "`n📝 STEP 1: Set Your Anthropic API Key" -ForegroundColor Yellow
Write-Host "=========================================`n" -ForegroundColor Yellow

if ($env:ANTHROPIC_API_KEY) {
    $keyPreview = $env:ANTHROPIC_API_KEY.Substring(0, [Math]::Min(10, $env:ANTHROPIC_API_KEY.Length)) + "..." + $env:ANTHROPIC_API_KEY.Substring([Math]::Max(0, $env:ANTHROPIC_API_KEY.Length - 4))
    Write-Host "✅ API Key is set: $keyPreview" -ForegroundColor Green
} else {
    Write-Host "❌ No API key found in environment" -ForegroundColor Red
    Write-Host "`nRun this command (replace with your actual key):" -ForegroundColor Yellow
    Write-Host '   $env:ANTHROPIC_API_KEY = "sk-ant-your-actual-api-key-here"' -ForegroundColor White
    Write-Host "`nGet your API key from: https://console.anthropic.com/" -ForegroundColor Cyan
    Write-Host "`n⚠️  After setting the key, RESTART the proxy server`n" -ForegroundColor Yellow
}

Write-Host "`n🔧 STEP 2: Update the Chatbot Code" -ForegroundColor Yellow
Write-Host "=========================================`n" -ForegroundColor Yellow

Write-Host "Edit file: " -NoNewline -ForegroundColor White
Write-Host "calculators/js/value-analysis-chatbot.js" -ForegroundColor Cyan

Write-Host "`nFind line ~1333 in the " -NoNewline -ForegroundColor White
Write-Host "callAnthropicAPI" -NoNewline -ForegroundColor Cyan
Write-Host " function and change:" -ForegroundColor White

Write-Host "`n   FROM:" -ForegroundColor Red
Write-Host "   const response = await fetch('https://api.anthropic.com/v1/messages', {" -ForegroundColor Gray

Write-Host "`n   TO:" -ForegroundColor Green
Write-Host "   const response = await fetch('http://localhost:3000/api/messages', {" -ForegroundColor White

Write-Host "`n   ALSO REMOVE this line (~1336):" -ForegroundColor Red
Write-Host "   'x-api-key': this.state.anthropicApiKey," -ForegroundColor Gray

Write-Host "`n💡 The proxy handles the API key for you!`n" -ForegroundColor Cyan

Write-Host "`n🚀 STEP 3: Test the Chatbot" -ForegroundColor Yellow
Write-Host "=========================================`n" -ForegroundColor Yellow

Write-Host "1. Make sure proxy is running (see above)" -ForegroundColor White
Write-Host "2. Open chatbot in browser (if using local server):" -ForegroundColor White
Write-Host "   http://localhost:8000/calculators/value-analysis-chatbot.html" -ForegroundColor Cyan
Write-Host "3. Type a message and it should work!" -ForegroundColor White

Write-Host "`n🎯 QUICK TEST" -ForegroundColor Yellow
Write-Host "=========================================`n" -ForegroundColor Yellow

Write-Host "Want me to apply the code changes automatically? (Y/N): " -NoNewline -ForegroundColor Cyan
$response = Read-Host

if ($response -eq 'Y' -or $response -eq 'y') {
    Write-Host "`n🔧 Applying changes to chatbot code..." -ForegroundColor Green
    
    $filePath = "js\value-analysis-chatbot.js"
    if (Test-Path $filePath) {
        $content = Get-Content $filePath -Raw
        
        # Replace the API URL
        $content = $content -replace 'https://api\.anthropic\.com/v1/messages', 'http://localhost:3000/api/messages'
        
        # Comment out the API key line
        $content = $content -replace "(\s+)'x-api-key':\s*this\.state\.anthropicApiKey,", "`$1// 'x-api-key': this.state.anthropicApiKey, // Handled by proxy"
        
        Set-Content $filePath $content
        
        Write-Host "✅ Code updated successfully!" -ForegroundColor Green
        Write-Host "`n📝 Changes made:" -ForegroundColor Cyan
        Write-Host "   - API URL changed to http://localhost:3000/api/messages" -ForegroundColor White
        Write-Host "   - API key header commented out (proxy handles it)" -ForegroundColor White
        Write-Host "`n🎉 You're all set! Open the chatbot and test it." -ForegroundColor Green
    } else {
        Write-Host "❌ Could not find: $filePath" -ForegroundColor Red
        Write-Host "Make sure you're in the calculators directory" -ForegroundColor Yellow
    }
} else {
    Write-Host "`n💡 No changes made. Follow the manual steps above." -ForegroundColor Yellow
}

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "   Setup complete! Good luck! 🚀" -ForegroundColor Cyan
Write-Host "========================================`n" -ForegroundColor Cyan
