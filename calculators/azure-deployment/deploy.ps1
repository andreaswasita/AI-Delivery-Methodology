# Azure Deployment Script for AI Delivery Chatbot (PowerShell)
# This script deploys the chatbot to Azure Static Web Apps with secure API backend

$ErrorActionPreference = "Stop"

Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host "  Azure AI Delivery Chatbot Deployment" -ForegroundColor Cyan
Write-Host "==========================================`n" -ForegroundColor Cyan

# Configuration
$RESOURCE_GROUP = "rg-ai-delivery-chatbot"
$LOCATION = "eastus"
$STATIC_WEB_APP_NAME = "swa-ai-delivery-chatbot-$(Get-Random)"
$KEY_VAULT_NAME = "kv-ai-chatbot-$(Get-Random)"

# Check if Azure CLI is installed
try {
    az --version | Out-Null
    Write-Host "✅ Azure CLI found" -ForegroundColor Green
} catch {
    Write-Host "❌ Azure CLI is not installed" -ForegroundColor Red
    Write-Host "Install from: https://learn.microsoft.com/en-us/cli/azure/install-azure-cli"
    exit 1
}

# Check if logged in
Write-Host "`nChecking Azure login status..." -ForegroundColor Yellow
try {
    $subscription = az account show --query name -o tsv
    Write-Host "✅ Logged in to subscription: $subscription" -ForegroundColor Green
} catch {
    Write-Host "Please login to Azure:" -ForegroundColor Yellow
    az login
}

# Prompt for API key
Write-Host "`n📝 Enter your Anthropic API key:" -ForegroundColor Yellow
$ANTHROPIC_API_KEY = Read-Host -AsSecureString
$BSTR = [System.Runtime.InteropServices.Marshal]::SecureStringToBSTR($ANTHROPIC_API_KEY)
$ANTHROPIC_API_KEY = [System.Runtime.InteropServices.Marshal]::PtrToStringAuto($BSTR)

if (-not $ANTHROPIC_API_KEY.StartsWith("sk-ant-")) {
    Write-Host "❌ Invalid API key format. Should start with 'sk-ant-'" -ForegroundColor Red
    exit 1
}

# Create resource group
Write-Host "`n📦 Creating resource group: $RESOURCE_GROUP" -ForegroundColor Yellow
az group create `
  --name $RESOURCE_GROUP `
  --location $LOCATION `
  --output none

Write-Host "✅ Resource group created" -ForegroundColor Green

# Create Static Web App
Write-Host "`n🌐 Creating Static Web App: $STATIC_WEB_APP_NAME" -ForegroundColor Yellow
Write-Host "This may take a few minutes..." -ForegroundColor Yellow

az staticwebapp create `
  --name $STATIC_WEB_APP_NAME `
  --resource-group $RESOURCE_GROUP `
  --location $LOCATION `
  --output none

Write-Host "✅ Static Web App created" -ForegroundColor Green

# Get Static Web App URL
$SWA_URL = az staticwebapp show `
  --name $STATIC_WEB_APP_NAME `
  --resource-group $RESOURCE_GROUP `
  --query defaultHostname -o tsv

Write-Host "🌐 Your chatbot URL: https://$SWA_URL" -ForegroundColor Green

# Configure API key as application setting
Write-Host "`n🔐 Configuring API key..." -ForegroundColor Yellow
az staticwebapp appsettings set `
  --name $STATIC_WEB_APP_NAME `
  --resource-group $RESOURCE_GROUP `
  --setting-names ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" `
  --output none

Write-Host "✅ API key configured" -ForegroundColor Green

# Optional: Create Key Vault
$createKV = Read-Host "`n🔒 Do you want to create an Azure Key Vault for enhanced security? (y/n)"
if ($createKV -eq 'y' -or $createKV -eq 'Y') {
    Write-Host "`n🔐 Creating Key Vault: $KEY_VAULT_NAME" -ForegroundColor Yellow
    
    az keyvault create `
      --name $KEY_VAULT_NAME `
      --resource-group $RESOURCE_GROUP `
      --location $LOCATION `
      --output none
    
    Write-Host "✅ Key Vault created" -ForegroundColor Green
    
    Write-Host "`nStoring API key in Key Vault..." -ForegroundColor Yellow
    az keyvault secret set `
      --vault-name $KEY_VAULT_NAME `
      --name anthropic-api-key `
      --value "$ANTHROPIC_API_KEY" `
      --output none
    
    Write-Host "✅ API key stored in Key Vault" -ForegroundColor Green
    Write-Host "💡 Update your Function to use Key Vault instead of app settings" -ForegroundColor Yellow
}

# Summary
Write-Host "`n==========================================" -ForegroundColor Cyan
Write-Host "  ✅ Deployment Complete!" -ForegroundColor Green
Write-Host "==========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "🌐 Chatbot URL: " -NoNewline -ForegroundColor Green
Write-Host "https://$SWA_URL" -ForegroundColor White
Write-Host "📦 Resource Group: " -NoNewline -ForegroundColor Green
Write-Host $RESOURCE_GROUP -ForegroundColor White
Write-Host "🔧 Static Web App: " -NoNewline -ForegroundColor Green
Write-Host $STATIC_WEB_APP_NAME -ForegroundColor White

if ($createKV -eq 'y' -or $createKV -eq 'Y') {
    Write-Host "🔐 Key Vault: " -NoNewline -ForegroundColor Green
    Write-Host $KEY_VAULT_NAME -ForegroundColor White
}

Write-Host "`n📋 Next Steps:" -ForegroundColor Yellow
Write-Host "1. Deploy your code using GitHub Actions or Azure CLI" -ForegroundColor White
Write-Host "2. Visit https://$SWA_URL to test your chatbot" -ForegroundColor White
Write-Host "3. Configure custom domain (optional)" -ForegroundColor White
Write-Host "4. Set up monitoring and alerts" -ForegroundColor White
Write-Host "`n📚 Documentation:" -ForegroundColor Yellow
Write-Host "See calculators/azure-deployment/README.md for detailed guides`n" -ForegroundColor White
