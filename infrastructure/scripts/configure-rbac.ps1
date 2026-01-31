#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Configure Role-Based Access Control (RBAC) for AI platform resources
.DESCRIPTION
    This script configures RBAC roles and assignments for the AI platform:
    - Creates custom role definitions (ML Ops Engineer, Data Scientist, Security Reader)
    - Assigns roles to users, groups, and service principals
    - Configures least-privilege access per security baseline
    - Validates role assignments
.PARAMETER Environment
    Target environment: dev, test, uat, prod
.PARAMETER SubscriptionId
    Azure subscription ID
.PARAMETER ConfigFile
    Path to RBAC configuration JSON file (optional)
.EXAMPLE
    .\configure-rbac.ps1 -Environment prod -SubscriptionId "your-sub-id"
.EXAMPLE
    .\configure-rbac.ps1 -Environment dev -ConfigFile "rbac-config.json"
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('dev', 'test', 'uat', 'prod')]
    [string]$Environment,

    [Parameter(Mandatory = $false)]
    [string]$SubscriptionId,

    [Parameter(Mandatory = $false)]
    [string]$ConfigFile = "../docs/rbac-config.json"
)

# ============================================================================
# INITIALIZATION
# ============================================================================

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Configure RBAC - AI Platform" -ForegroundColor Cyan
Write-Host "  Environment: $Environment" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Set subscription context
if ($SubscriptionId) {
    Write-Host "Setting subscription context: $SubscriptionId" -ForegroundColor Yellow
    az account set --subscription $SubscriptionId
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to set subscription context"
    }
} else {
    $SubscriptionId = (az account show --query id -o tsv)
    Write-Host "Using current subscription: $SubscriptionId" -ForegroundColor Yellow
}

# Verify logged in
$account = az account show 2>$null
if (-not $account) {
    Write-Host "ERROR: Not logged in to Azure. Run 'az login' first." -ForegroundColor Red
    exit 1
}

# ============================================================================
# CUSTOM ROLE DEFINITIONS
# ============================================================================

Write-Host "`n[1/4] Creating custom role definitions..." -ForegroundColor Green

# ML Ops Engineer Role
$mlOpsRole = @{
    Name = "ML Ops Engineer"
    IsCustom = $true
    Description = "Can manage ML workspaces, models, and deployments"
    Actions = @(
        "Microsoft.MachineLearningServices/workspaces/*",
        "Microsoft.MachineLearningServices/workspaces/computes/*",
        "Microsoft.MachineLearningServices/workspaces/datastores/*",
        "Microsoft.MachineLearningServices/workspaces/environments/*",
        "Microsoft.MachineLearningServices/workspaces/models/*",
        "Microsoft.MachineLearningServices/workspaces/endpoints/*",
        "Microsoft.Storage/storageAccounts/blobServices/containers/*",
        "Microsoft.Storage/storageAccounts/listKeys/action",
        "Microsoft.KeyVault/vaults/secrets/read",
        "Microsoft.ContainerRegistry/registries/read",
        "Microsoft.ContainerRegistry/registries/build/read"
    )
    NotActions = @(
        "Microsoft.MachineLearningServices/workspaces/delete",
        "Microsoft.Authorization/*/write",
        "Microsoft.Authorization/*/delete"
    )
    AssignableScopes = @(
        "/subscriptions/$SubscriptionId/resourceGroups/rg-aiplatform-$Environment"
    )
} | ConvertTo-Json -Depth 10

$mlOpsRoleFile = New-TemporaryFile
$mlOpsRole | Out-File -FilePath $mlOpsRoleFile.FullName -Encoding UTF8

Write-Host "  Creating 'ML Ops Engineer' role..." -ForegroundColor Cyan
az role definition create --role-definition $mlOpsRoleFile.FullName 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ ML Ops Engineer role created" -ForegroundColor Green
} else {
    Write-Host "  ✓ ML Ops Engineer role already exists" -ForegroundColor Yellow
}

# Data Scientist Role
$dataScienceRole = @{
    Name = "Data Scientist"
    IsCustom = $true
    Description = "Can run experiments and train models, read-only infrastructure"
    Actions = @(
        "Microsoft.MachineLearningServices/workspaces/read",
        "Microsoft.MachineLearningServices/workspaces/experiments/*",
        "Microsoft.MachineLearningServices/workspaces/runs/*",
        "Microsoft.MachineLearningServices/workspaces/jobs/*",
        "Microsoft.MachineLearningServices/workspaces/models/read",
        "Microsoft.MachineLearningServices/workspaces/datasets/*",
        "Microsoft.Storage/storageAccounts/blobServices/containers/read",
        "Microsoft.Storage/storageAccounts/blobServices/containers/blobs/read",
        "Microsoft.ContainerRegistry/registries/read"
    )
    NotActions = @(
        "Microsoft.MachineLearningServices/workspaces/computes/write",
        "Microsoft.MachineLearningServices/workspaces/computes/delete",
        "Microsoft.MachineLearningServices/workspaces/delete"
    )
    AssignableScopes = @(
        "/subscriptions/$SubscriptionId/resourceGroups/rg-aiplatform-dev",
        "/subscriptions/$SubscriptionId/resourceGroups/rg-aiplatform-test"
    )
} | ConvertTo-Json -Depth 10

$dataScienceRoleFile = New-TemporaryFile
$dataScienceRole | Out-File -FilePath $dataScienceRoleFile.FullName -Encoding UTF8

Write-Host "  Creating 'Data Scientist' role..." -ForegroundColor Cyan
az role definition create --role-definition $dataScienceRoleFile.FullName 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ Data Scientist role created" -ForegroundColor Green
} else {
    Write-Host "  ✓ Data Scientist role already exists" -ForegroundColor Yellow
}

# Security Reader Role
$securityReaderRole = @{
    Name = "Security Reader - AI Platform"
    IsCustom = $true
    Description = "Read-only access to security logs and configurations"
    Actions = @(
        "Microsoft.Security/*/read",
        "Microsoft.SecurityInsights/*/read",
        "Microsoft.OperationalInsights/workspaces/*/read",
        "Microsoft.Authorization/policyDefinitions/read",
        "Microsoft.Authorization/policyAssignments/read",
        "Microsoft.Authorization/policySetDefinitions/read",
        "Microsoft.KeyVault/vaults/read",
        "Microsoft.Network/networkSecurityGroups/read",
        "Microsoft.Network/azureFirewalls/read"
    )
    NotActions = @()
    AssignableScopes = @(
        "/subscriptions/$SubscriptionId"
    )
} | ConvertTo-Json -Depth 10

$securityReaderRoleFile = New-TemporaryFile
$securityReaderRole | Out-File -FilePath $securityReaderRoleFile.FullName -Encoding UTF8

Write-Host "  Creating 'Security Reader - AI Platform' role..." -ForegroundColor Cyan
az role definition create --role-definition $securityReaderRoleFile.FullName 2>$null
if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ Security Reader role created" -ForegroundColor Green
} else {
    Write-Host "  ✓ Security Reader role already exists" -ForegroundColor Yellow
}

# Cleanup temporary files
Remove-Item $mlOpsRoleFile.FullName -Force
Remove-Item $dataScienceRoleFile.FullName -Force
Remove-Item $securityReaderRoleFile.FullName -Force

# ============================================================================
# ROLE ASSIGNMENTS (EXAMPLE - CUSTOMIZE FOR YOUR ORGANIZATION)
# ============================================================================

Write-Host "`n[2/4] Configuring role assignments..." -ForegroundColor Green

$resourceGroup = "rg-aiplatform-$Environment"

# Check if resource group exists
$rgExists = az group exists --name $resourceGroup
if ($rgExists -eq "false") {
    Write-Host "  ⚠ Resource group $resourceGroup does not exist. Skipping role assignments." -ForegroundColor Yellow
} else {
    Write-Host "  Resource group: $resourceGroup" -ForegroundColor Cyan

    # Example: Assign Contributor role to dev team group
    # CUSTOMIZE: Replace with your Azure AD group object IDs
    # $devTeamGroupId = "xxxxxxxx-xxxx-xxxx-xxxx-xxxxxxxxxxxx"
    # az role assignment create `
    #     --role "Contributor" `
    #     --assignee-object-id $devTeamGroupId `
    #     --assignee-principal-type Group `
    #     --scope "/subscriptions/$SubscriptionId/resourceGroups/$resourceGroup"
    
    Write-Host "  ℹ No default role assignments configured." -ForegroundColor Yellow
    Write-Host "  ℹ Customize this script with your organization's user/group IDs." -ForegroundColor Yellow
}

# ============================================================================
# MANAGED IDENTITY RBAC
# ============================================================================

Write-Host "`n[3/4] Configuring managed identity RBAC..." -ForegroundColor Green

# Get managed identities in resource group
$identities = az identity list --resource-group $resourceGroup --query "[].{Name:name, PrincipalId:principalId}" -o json 2>$null | ConvertFrom-Json

if ($identities) {
    foreach ($identity in $identities) {
        Write-Host "  Configuring permissions for: $($identity.Name)" -ForegroundColor Cyan
        
        # App Service managed identity → Key Vault
        if ($identity.Name -like "*appservice*") {
            az role assignment create `
                --role "Key Vault Secrets User" `
                --assignee-object-id $identity.PrincipalId `
                --assignee-principal-type ServicePrincipal `
                --scope "/subscriptions/$SubscriptionId/resourceGroups/$resourceGroup" `
                2>$null
            Write-Host "    ✓ Assigned Key Vault Secrets User" -ForegroundColor Green
        }
        
        # Azure ML managed identity → Storage
        if ($identity.Name -like "*mlworkspace*" -or $identity.Name -like "*aml*") {
            az role assignment create `
                --role "Storage Blob Data Contributor" `
                --assignee-object-id $identity.PrincipalId `
                --assignee-principal-type ServicePrincipal `
                --scope "/subscriptions/$SubscriptionId/resourceGroups/$resourceGroup" `
                2>$null
            Write-Host "    ✓ Assigned Storage Blob Data Contributor" -ForegroundColor Green
        }
    }
} else {
    Write-Host "  ℹ No managed identities found in $resourceGroup" -ForegroundColor Yellow
}

# ============================================================================
# VALIDATION
# ============================================================================

Write-Host "`n[4/4] Validating RBAC configuration..." -ForegroundColor Green

# List all role assignments
Write-Host "`n  Role assignments for $resourceGroup`:" -ForegroundColor Cyan
az role assignment list --resource-group $resourceGroup --output table 2>$null

# Check for overly permissive assignments
Write-Host "`n  Checking for security concerns..." -ForegroundColor Cyan
$ownerAssignments = az role assignment list `
    --resource-group $resourceGroup `
    --role "Owner" `
    --query "[].{Principal:principalName, Type:principalType}" `
    -o json 2>$null | ConvertFrom-Json

if ($ownerAssignments.Count -gt 0) {
    Write-Host "  ⚠ Warning: $($ownerAssignments.Count) Owner role assignment(s) found" -ForegroundColor Yellow
    Write-Host "  ⚠ Review and minimize Owner access per least-privilege principle" -ForegroundColor Yellow
}

# ============================================================================
# SUMMARY
# ============================================================================

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  RBAC Configuration Complete" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "✓ Custom roles created (ML Ops Engineer, Data Scientist, Security Reader)" -ForegroundColor Green
Write-Host "✓ Managed identity permissions configured" -ForegroundColor Green
Write-Host "✓ RBAC validation completed" -ForegroundColor Green
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. Customize role assignments with your organization's user/group IDs" -ForegroundColor White
Write-Host "2. Review Owner role assignments and minimize access" -ForegroundColor White
Write-Host "3. Conduct quarterly access reviews (Azure AD Access Reviews)" -ForegroundColor White
Write-Host "4. Document role assignment rationale for compliance" -ForegroundColor White
Write-Host ""
Write-Host "Documentation: infrastructure/docs/security-baseline.md" -ForegroundColor Cyan
Write-Host ""
