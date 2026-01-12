# Deploy AI Calculators to Azure Static Web Apps
# Version: 1.0
# Last Updated: January 13, 2026

param(
    [Parameter(Mandatory=$false)]
    [string]$ResourceGroupName = "rg-ai-calculators",
    
    [Parameter(Mandatory=$false)]
    [string]$StaticWebAppName = "swa-ai-calculators",
    
    [Parameter(Mandatory=$false)]
    [string]$Location = "eastus2",
    
    [Parameter(Mandatory=$false)]
    [ValidateSet("Free", "Standard")]
    [string]$Sku = "Free",
    
    [Parameter(Mandatory=$false)]
    [string]$SubscriptionId = "",
    
    [Parameter(Mandatory=$false)]
    [switch]$WhatIf
)

# ============================================================================
# CONFIGURATION
# ============================================================================

$ErrorActionPreference = "Stop"
$scriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$infraPath = Split-Path -Parent $scriptPath
$calculatorsPath = Join-Path (Split-Path -Parent $infraPath) "calculators"

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "Azure Static Web App Deployment" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# ============================================================================
# PREREQUISITES CHECK
# ============================================================================

Write-Host "Checking prerequisites..." -ForegroundColor Yellow

# Check if Azure CLI is installed
if (-not (Get-Command az -ErrorAction SilentlyContinue)) {
    Write-Host "❌ Azure CLI is not installed. Please install it from https://aka.ms/installazurecli" -ForegroundColor Red
    exit 1
}

# Check if SWA CLI is installed
if (-not (Get-Command swa -ErrorAction SilentlyContinue)) {
    Write-Host "⚠️  Azure Static Web Apps CLI is not installed. Installing now..." -ForegroundColor Yellow
    npm install -g @azure/static-web-apps-cli
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to install SWA CLI. Please install Node.js first." -ForegroundColor Red
        exit 1
    }
}

Write-Host "✅ Prerequisites check passed" -ForegroundColor Green
Write-Host ""

# ============================================================================
# AZURE LOGIN & SUBSCRIPTION
# ============================================================================

Write-Host "Checking Azure login status..." -ForegroundColor Yellow

$account = az account show 2>$null | ConvertFrom-Json
if (-not $account) {
    Write-Host "Not logged in to Azure. Logging in..." -ForegroundColor Yellow
    az login
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Azure login failed" -ForegroundColor Red
        exit 1
    }
    $account = az account show | ConvertFrom-Json
}

if ($SubscriptionId) {
    Write-Host "Setting subscription to: $SubscriptionId" -ForegroundColor Yellow
    az account set --subscription $SubscriptionId
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to set subscription" -ForegroundColor Red
        exit 1
    }
}

$currentSub = az account show | ConvertFrom-Json
Write-Host "✅ Logged in as: $($currentSub.user.name)" -ForegroundColor Green
Write-Host "   Subscription: $($currentSub.name) ($($currentSub.id))" -ForegroundColor Gray
Write-Host ""

# ============================================================================
# RESOURCE GROUP
# ============================================================================

Write-Host "Checking resource group: $ResourceGroupName" -ForegroundColor Yellow

$rg = az group show --name $ResourceGroupName 2>$null | ConvertFrom-Json
if (-not $rg) {
    Write-Host "Creating resource group: $ResourceGroupName in $Location" -ForegroundColor Yellow
    if (-not $WhatIf) {
        az group create --name $ResourceGroupName --location $Location
        if ($LASTEXITCODE -ne 0) {
            Write-Host "❌ Failed to create resource group" -ForegroundColor Red
            exit 1
        }
    } else {
        Write-Host "[WhatIf] Would create resource group: $ResourceGroupName" -ForegroundColor Cyan
    }
}

Write-Host "✅ Resource group ready: $ResourceGroupName" -ForegroundColor Green
Write-Host ""

# ============================================================================
# DEPLOY STATIC WEB APP
# ============================================================================

Write-Host "Deploying Static Web App: $StaticWebAppName" -ForegroundColor Yellow

$bicepFile = Join-Path $infraPath "bicep\modules\static-web-app.bicep"

if (-not $WhatIf) {
    $deployment = az deployment group create `
        --resource-group $ResourceGroupName `
        --template-file $bicepFile `
        --parameters `
            staticWebAppName=$StaticWebAppName `
            location=$Location `
            sku=$Sku `
        --query 'properties.outputs' `
        --output json | ConvertFrom-Json
    
    if ($LASTEXITCODE -ne 0) {
        Write-Host "❌ Failed to deploy Static Web App" -ForegroundColor Red
        exit 1
    }
    
    $hostname = $deployment.defaultHostname.value
    $deploymentToken = $deployment.deploymentToken.value
    
    Write-Host "✅ Static Web App deployed successfully!" -ForegroundColor Green
    Write-Host "   Default URL: https://$hostname" -ForegroundColor Gray
    Write-Host ""
    
    # ============================================================================
    # DEPLOY CONTENT
    # ============================================================================
    
    Write-Host "Deploying calculator files..." -ForegroundColor Yellow
    
    $env:SWA_CLI_DEPLOYMENT_TOKEN = $deploymentToken
    
    Push-Location $calculatorsPath
    try {
        swa deploy . --deployment-token $deploymentToken --env production
        if ($LASTEXITCODE -ne 0) {
            Write-Host "❌ Failed to deploy content" -ForegroundColor Red
            exit 1
        }
    } finally {
        Pop-Location
    }
    
    Write-Host ""
    Write-Host "========================================" -ForegroundColor Green
    Write-Host "✅ DEPLOYMENT SUCCESSFUL!" -ForegroundColor Green
    Write-Host "========================================" -ForegroundColor Green
    Write-Host ""
    Write-Host "Your calculator website is now live at:" -ForegroundColor Cyan
    Write-Host "https://$hostname" -ForegroundColor Yellow -NoNewline
    Write-Host ""
    Write-Host ""
    Write-Host "Resource Details:" -ForegroundColor Cyan
    Write-Host "  Resource Group: $ResourceGroupName" -ForegroundColor Gray
    Write-Host "  Static Web App: $StaticWebAppName" -ForegroundColor Gray
    Write-Host "  SKU: $Sku" -ForegroundColor Gray
    Write-Host "  Location: $Location" -ForegroundColor Gray
    Write-Host ""
    Write-Host "Next Steps:" -ForegroundColor Cyan
    Write-Host "  1. Test your website: https://$hostname" -ForegroundColor Gray
    Write-Host "  2. Set up custom domain (optional)" -ForegroundColor Gray
    Write-Host "  3. Configure GitHub Actions for CI/CD" -ForegroundColor Gray
    Write-Host ""
    
} else {
    Write-Host "[WhatIf] Would deploy Static Web App with Bicep template" -ForegroundColor Cyan
    Write-Host "[WhatIf] Would deploy calculator files to Azure" -ForegroundColor Cyan
}
