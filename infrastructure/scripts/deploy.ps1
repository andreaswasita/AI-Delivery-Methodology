#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Deploy standardized AI platform infrastructure to Azure
.DESCRIPTION
    This script deploys the complete AI platform infrastructure including:
    - Networking (VNet, NSGs, Firewall, Bastion)
    - Security (Key Vault, Managed Identity)
    - Monitoring (Log Analytics, Application Insights, Sentinel)
    - Data (Storage, SQL, Cosmos DB, Data Lake, Synapse)
    - AI Services (Azure ML, OpenAI, Cognitive Services)
    - Compute (AKS, VM Scale Sets)
    - Governance (Policies, Budgets, Tags)
.PARAMETER Environment
    Target environment: dev, test, uat, prod
.PARAMETER Location
    Primary Azure region (default: australiaeast)
.PARAMETER ProjectName
    Project name for resource naming (3-10 characters)
.PARAMETER SubscriptionId
    Azure subscription ID
.PARAMETER WhatIf
    Preview deployment without making changes
.EXAMPLE
    .\deploy.ps1 -Environment prod -ProjectName myaiproj -SubscriptionId "your-sub-id"
.EXAMPLE
    .\deploy.ps1 -Environment dev -ProjectName testai -WhatIf
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('dev', 'test', 'uat', 'prod')]
    [string]$Environment,

    [Parameter(Mandatory = $false)]
    [string]$Location = 'australiaeast',

    [Parameter(Mandatory = $true)]
    [ValidateLength(3, 10)]
    [string]$ProjectName,

    [Parameter(Mandatory = $false)]
    [string]$SubscriptionId,

    [Parameter(Mandatory = $false)]
    [switch]$WhatIf
)

# ============================================================================
# CONFIGURATION
# ============================================================================

$ErrorActionPreference = 'Stop'
$WarningPreference = 'Continue'

$ScriptPath = Split-Path -Parent $MyInvocation.MyCommand.Path
$BicepPath = Join-Path $ScriptPath 'main.bicep'
$ParametersPath = Join-Path $ScriptPath "parameters\$Environment.parameters.json"

# ============================================================================
# FUNCTIONS
# ============================================================================

function Write-Header {
    param([string]$Message)
    Write-Host "`n========================================" -ForegroundColor Cyan
    Write-Host $Message -ForegroundColor Cyan
    Write-Host "========================================`n" -ForegroundColor Cyan
}

function Write-Step {
    param([string]$Message)
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')]" -ForegroundColor Gray -NoNewline
    Write-Host " $Message" -ForegroundColor White
}

function Write-Success {
    param([string]$Message)
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')]" -ForegroundColor Gray -NoNewline
    Write-Host " ✓ $Message" -ForegroundColor Green
}

function Write-Error {
    param([string]$Message)
    Write-Host "[$(Get-Date -Format 'HH:mm:ss')]" -ForegroundColor Gray -NoNewline
    Write-Host " ✗ $Message" -ForegroundColor Red
}

function Test-AzureCLI {
    try {
        $azVersion = az version --output json 2>$null | ConvertFrom-Json
        Write-Success "Azure CLI installed (version $($azVersion.'azure-cli'))"
        return $true
    }
    catch {
        Write-Error "Azure CLI not found. Please install: https://aka.ms/azure-cli"
        return $false
    }
}

function Test-BicepCLI {
    try {
        az bicep version 2>$null | Out-Null
        Write-Success "Bicep CLI installed"
        return $true
    }
    catch {
        Write-Step "Installing Bicep CLI..."
        az bicep install
        Write-Success "Bicep CLI installed"
        return $true
    }
}

# ============================================================================
# MAIN SCRIPT
# ============================================================================

Write-Header "AI Platform Infrastructure Deployment"

Write-Host "Configuration:" -ForegroundColor Yellow
Write-Host "  Environment:   $Environment" -ForegroundColor White
Write-Host "  Location:      $Location" -ForegroundColor White
Write-Host "  Project Name:  $ProjectName" -ForegroundColor White
Write-Host "  What-If Mode:  $WhatIf" -ForegroundColor White
Write-Host ""

# Validate prerequisites
Write-Header "Validating Prerequisites"

if (-not (Test-AzureCLI)) {
    exit 1
}

if (-not (Test-BicepCLI)) {
    exit 1
}

# Check if Bicep template exists
if (-not (Test-Path $BicepPath)) {
    Write-Error "Bicep template not found: $BicepPath"
    exit 1
}
Write-Success "Bicep template found"

# Check if parameters file exists
if (-not (Test-Path $ParametersPath)) {
    Write-Error "Parameters file not found: $ParametersPath"
    exit 1
}
Write-Success "Parameters file found"

# Login to Azure
Write-Header "Azure Authentication"

$accountInfo = az account show 2>$null | ConvertFrom-Json
if (-not $accountInfo) {
    Write-Step "Logging in to Azure..."
    az login
    $accountInfo = az account show | ConvertFrom-Json
}

Write-Success "Logged in as: $($accountInfo.user.name)"
Write-Host "  Subscription: $($accountInfo.name)" -ForegroundColor White
Write-Host "  Tenant:       $($accountInfo.tenantId)" -ForegroundColor White

# Set subscription if provided
if ($SubscriptionId) {
    Write-Step "Setting subscription: $SubscriptionId"
    az account set --subscription $SubscriptionId
    Write-Success "Subscription set"
}

# Validate Bicep template
Write-Header "Validating Bicep Template"

Write-Step "Running Bicep validation..."
try {
    az bicep build --file $BicepPath 2>&1 | Out-Null
    Write-Success "Bicep template is valid"
}
catch {
    Write-Error "Bicep validation failed"
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}

# Deploy infrastructure
Write-Header "Deploying Infrastructure"

$deploymentName = "ai-platform-$Environment-$(Get-Date -Format 'yyyyMMdd-HHmmss')"
Write-Step "Deployment name: $deploymentName"

$deployCommand = @(
    'az', 'deployment', 'sub', 'create',
    '--name', $deploymentName,
    '--location', $Location,
    '--template-file', $BicepPath,
    '--parameters', $ParametersPath,
    '--parameters', "projectName=$ProjectName"
)

if ($WhatIf) {
    $deployCommand += '--what-if'
    Write-Host "`nRunning What-If analysis..." -ForegroundColor Yellow
}
else {
    Write-Host "`nStarting deployment (this may take 30-45 minutes)..." -ForegroundColor Yellow
}

try {
    $startTime = Get-Date
    
    & $deployCommand[0] $deployCommand[1..($deployCommand.Length - 1)]
    
    if ($LASTEXITCODE -ne 0) {
        throw "Deployment failed with exit code $LASTEXITCODE"
    }
    
    $duration = (Get-Date) - $startTime
    Write-Success "Deployment completed in $([math]::Round($duration.TotalMinutes, 2)) minutes"
}
catch {
    Write-Error "Deployment failed"
    Write-Host $_.Exception.Message -ForegroundColor Red
    exit 1
}

# Get deployment outputs
if (-not $WhatIf) {
    Write-Header "Deployment Outputs"
    
    $outputs = az deployment sub show --name $deploymentName --query properties.outputs --output json | ConvertFrom-Json
    
    if ($outputs) {
        Write-Host "Resource Group:       " -NoNewline -ForegroundColor Yellow
        Write-Host $outputs.resourceGroupName.value -ForegroundColor White
        
        Write-Host "Key Vault:            " -NoNewline -ForegroundColor Yellow
        Write-Host $outputs.keyVaultName.value -ForegroundColor White
        
        Write-Host "Storage Account:      " -NoNewline -ForegroundColor Yellow
        Write-Host $outputs.storageAccountName.value -ForegroundColor White
        
        Write-Host "Azure ML Workspace:   " -NoNewline -ForegroundColor Yellow
        Write-Host $outputs.azureMLWorkspaceName.value -ForegroundColor White
        
        Write-Host "AKS Cluster:          " -NoNewline -ForegroundColor Yellow
        Write-Host $outputs.aksClusterName.value -ForegroundColor White
        
        Write-Host "Compliance Enabled:   " -NoNewline -ForegroundColor Yellow
        Write-Host $outputs.complianceEnabled.value -ForegroundColor White
        
        Write-Host "Data Residency:       " -NoNewline -ForegroundColor Yellow
        Write-Host $outputs.dataResidency.value -ForegroundColor White
    }
    
    # Save outputs to file
    $outputsFile = Join-Path $ScriptPath "outputs\$Environment-outputs.json"
    $outputsDir = Split-Path -Parent $outputsFile
    if (-not (Test-Path $outputsDir)) {
        New-Item -ItemType Directory -Path $outputsDir -Force | Out-Null
    }
    $outputs | ConvertTo-Json -Depth 10 | Out-File $outputsFile
    Write-Success "Outputs saved to: $outputsFile"
}

Write-Header "Deployment Complete"

Write-Host "`nNext Steps:" -ForegroundColor Yellow
Write-Host "1. Configure RBAC permissions for your team" -ForegroundColor White
Write-Host "2. Set up Azure DevOps or GitHub Actions for CI/CD" -ForegroundColor White
Write-Host "3. Configure monitoring alerts and dashboards" -ForegroundColor White
Write-Host "4. Deploy your AI use cases to the platform" -ForegroundColor White
Write-Host "`nDocumentation: https://github.com/andreaswasita/AI-Delivery-Methodology" -ForegroundColor Cyan
Write-Host ""
