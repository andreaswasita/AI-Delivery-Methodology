#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Quick deployment script for Terraform-based Fabric Landing Zone
.DESCRIPTION
    Provides a streamlined deployment experience for Fabric Landing Zone using Terraform
.EXAMPLE
    .\deploy.ps1
#>

[CmdletBinding()]
param()

$ErrorActionPreference = 'Stop'

Write-Host "╔══════════════════════════════════════════════════════════════════════╗" -ForegroundColor Cyan
Write-Host "║     Terraform Fabric Landing Zone - Quick Deploy                    ║" -ForegroundColor Cyan
Write-Host "╚══════════════════════════════════════════════════════════════════════╝" -ForegroundColor Cyan
Write-Host ""

# Check prerequisites
Write-Host "🔍 Checking prerequisites..." -ForegroundColor Yellow

# Check Terraform
try {
    $TfVersion = (terraform version -json | ConvertFrom-Json).terraform_version
    Write-Host "  ✅ Terraform installed: $TfVersion" -ForegroundColor Green
} catch {
    Write-Host "  ❌ Terraform not found. Please install Terraform 1.5+" -ForegroundColor Red
    exit 1
}

# Check Azure CLI
try {
    az version | Out-Null
    Write-Host "  ✅ Azure CLI installed" -ForegroundColor Green
} catch {
    Write-Host "  ❌ Azure CLI not found. Please install Azure CLI" -ForegroundColor Red
    exit 1
}

# Select environment
Write-Host ""
Write-Host "Select deployment environment:" -ForegroundColor Cyan
Write-Host "  1) Development (F8, minimal security)"
Write-Host "  2) Production (F64, full security)"
Write-Host "  3) Healthcare/HIPAA (F128, HIPAA compliance)"
Write-Host "  4) Financial Services (F256, APRA CPS 234)"
Write-Host "  5) Retail/PCI-DSS (F64, PCI-DSS compliance)"
Write-Host "  6) Custom (use your own tfvars file)"
Write-Host ""

$EnvChoice = Read-Host "Enter choice [1-6]"

switch ($EnvChoice) {
    "1" {
        $TfvarsFile = "environments/dev.tfvars"
        $EnvName = "Development"
    }
    "2" {
        $TfvarsFile = "environments/prod.tfvars"
        $EnvName = "Production"
    }
    "3" {
        $TfvarsFile = "environments/healthcare-hipaa.tfvars"
        $EnvName = "Healthcare/HIPAA"
    }
    "4" {
        $TfvarsFile = "environments/financial-services.tfvars"
        $EnvName = "Financial Services"
    }
    "5" {
        $TfvarsFile = "environments/retail-pci.tfvars"
        $EnvName = "Retail/PCI-DSS"
    }
    "6" {
        $TfvarsFile = Read-Host "Enter path to your tfvars file"
        $EnvName = "Custom"
    }
    default {
        Write-Host "Invalid choice" -ForegroundColor Red
        exit 1
    }
}

if (-not (Test-Path $TfvarsFile)) {
    Write-Host "❌ File not found: $TfvarsFile" -ForegroundColor Red
    exit 1
}

Write-Host "✅ Using configuration: $EnvName ($TfvarsFile)" -ForegroundColor Green

# Authenticate to Azure
Write-Host ""
Write-Host "🔐 Checking Azure authentication..." -ForegroundColor Yellow
try {
    $Account = az account show --query user.name -o tsv 2>$null
    if (-not $Account) {
        Write-Host "Not authenticated. Logging in..." -ForegroundColor Yellow
        az login
    }
    $Subscription = az account show --query name -o tsv
    Write-Host "✅ Authenticated to: $Subscription" -ForegroundColor Green
} catch {
    Write-Host "❌ Azure authentication failed" -ForegroundColor Red
    exit 1
}

# Initialize Terraform
Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "Step 1: Terraform Init" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
terraform init -upgrade

# Validate configuration
Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "Step 2: Terraform Validate" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
terraform validate

# Plan deployment
Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "Step 3: Terraform Plan" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
terraform plan -var-file=$TfvarsFile -out=tfplan

# Review and confirm
Write-Host ""
Write-Host "📋 Review the plan above carefully." -ForegroundColor Yellow
$Confirm = Read-Host "Proceed with deployment? (yes/no)"

if ($Confirm -ne "yes") {
    Write-Host "❌ Deployment cancelled" -ForegroundColor Red
    Remove-Item -Path tfplan -Force -ErrorAction SilentlyContinue
    exit 0
}

# Apply deployment
Write-Host ""
Write-Host "═══════════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
Write-Host "Step 4: Terraform Apply" -ForegroundColor Cyan
Write-Host "═══════════════════════════════════════════════════════════════════════" -ForegroundColor Cyan
terraform apply tfplan

# Clean up plan file
Remove-Item -Path tfplan -Force -ErrorAction SilentlyContinue

# Display outputs
Write-Host ""
Write-Host "╔══════════════════════════════════════════════════════════════════════╗" -ForegroundColor Green
Write-Host "║                    DEPLOYMENT COMPLETED                              ║" -ForegroundColor Green
Write-Host "╚══════════════════════════════════════════════════════════════════════╝" -ForegroundColor Green
Write-Host ""

Write-Host "📊 Deployment Summary:" -ForegroundColor Cyan
$Summary = terraform output -json deployment_summary | ConvertFrom-Json
$Summary.PSObject.Properties | ForEach-Object {
    Write-Host "   $($_.Name): $($_.Value)"
}

Write-Host ""
Write-Host "🎯 Next Steps:" -ForegroundColor Yellow
$NextSteps = terraform output -raw next_steps
$NextSteps -split "`n" | ForEach-Object { Write-Host "   $_" }

Write-Host ""
Write-Host "💰 Cost Estimate:" -ForegroundColor Yellow
$Cost = terraform output -raw estimated_monthly_cost_usd
Write-Host "   Estimated Monthly Cost: $Cost USD"

Write-Host ""
Write-Host "✅ Deployment completed successfully!" -ForegroundColor Green
Write-Host ""
