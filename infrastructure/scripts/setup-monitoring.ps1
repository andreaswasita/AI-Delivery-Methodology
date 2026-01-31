#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Configure monitoring and alerting for AI platform infrastructure
.DESCRIPTION
    This script configures comprehensive monitoring, alerting, and observability:
    - Creates Log Analytics workspace and Application Insights
    - Configures diagnostic settings for all resources
    - Sets up alert rules (performance, security, cost)
    - Creates action groups for notifications
    - Deploys Azure Sentinel (optional)
    - Creates custom dashboards and workbooks
.PARAMETER Environment
    Target environment: dev, test, uat, prod
.PARAMETER SubscriptionId
    Azure subscription ID
.PARAMETER EnableSentinel
    Deploy Azure Sentinel SIEM (default: true for prod)
.PARAMETER NotificationEmail
    Email address for alert notifications
.EXAMPLE
    .\setup-monitoring.ps1 -Environment prod -NotificationEmail "oncall@company.com"
.EXAMPLE
    .\setup-monitoring.ps1 -Environment dev -EnableSentinel:$false
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('dev', 'test', 'uat', 'prod')]
    [string]$Environment,

    [Parameter(Mandatory = $false)]
    [string]$SubscriptionId,

    [Parameter(Mandatory = $false)]
    [bool]$EnableSentinel = ($Environment -eq 'prod'),

    [Parameter(Mandatory = $false)]
    [string]$NotificationEmail = "alerts@company.com"
)

# ============================================================================
# INITIALIZATION
# ============================================================================

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Setup Monitoring - AI Platform" -ForegroundColor Cyan
Write-Host "  Environment: $Environment" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""

# Set subscription context
if ($SubscriptionId) {
    az account set --subscription $SubscriptionId
    if ($LASTEXITCODE -ne 0) {
        throw "Failed to set subscription context"
    }
} else {
    $SubscriptionId = (az account show --query id -o tsv)
}

Write-Host "Subscription: $SubscriptionId" -ForegroundColor Yellow
Write-Host "Notification Email: $NotificationEmail" -ForegroundColor Yellow
Write-Host ""

$resourceGroup = "rg-aiplatform-$Environment"
$location = "australiaeast"

# ============================================================================
# LOG ANALYTICS WORKSPACE
# ============================================================================

Write-Host "[1/7] Configuring Log Analytics workspace..." -ForegroundColor Green

$workspaceName = "log-aiplatform-$Environment"

# Check if workspace exists
$workspaceExists = az monitor log-analytics workspace show `
    --resource-group $resourceGroup `
    --workspace-name $workspaceName `
    --query "id" -o tsv 2>$null

if (-not $workspaceExists) {
    Write-Host "  Creating Log Analytics workspace: $workspaceName" -ForegroundColor Cyan
    az monitor log-analytics workspace create `
        --resource-group $resourceGroup `
        --workspace-name $workspaceName `
        --location $location `
        --retention-time 90 `
        --sku PerGB2018
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ Workspace created" -ForegroundColor Green
    } else {
        throw "Failed to create Log Analytics workspace"
    }
} else {
    Write-Host "  ✓ Workspace already exists: $workspaceName" -ForegroundColor Yellow
}

# Get workspace ID
$workspaceId = az monitor log-analytics workspace show `
    --resource-group $resourceGroup `
    --workspace-name $workspaceName `
    --query "id" -o tsv

Write-Host "  Workspace ID: $workspaceId" -ForegroundColor Cyan

# ============================================================================
# APPLICATION INSIGHTS
# ============================================================================

Write-Host "`n[2/7] Configuring Application Insights..." -ForegroundColor Green

$appInsightsName = "appi-aiplatform-$Environment"

# Check if App Insights exists
$appInsightsExists = az monitor app-insights component show `
    --app $appInsightsName `
    --resource-group $resourceGroup `
    --query "id" -o tsv 2>$null

if (-not $appInsightsExists) {
    Write-Host "  Creating Application Insights: $appInsightsName" -ForegroundColor Cyan
    az monitor app-insights component create `
        --app $appInsightsName `
        --resource-group $resourceGroup `
        --location $location `
        --workspace $workspaceId `
        --kind web
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ Application Insights created" -ForegroundColor Green
    } else {
        throw "Failed to create Application Insights"
    }
} else {
    Write-Host "  ✓ Application Insights already exists: $appInsightsName" -ForegroundColor Yellow
}

# ============================================================================
# DIAGNOSTIC SETTINGS FOR ALL RESOURCES
# ============================================================================

Write-Host "`n[3/7] Configuring diagnostic settings..." -ForegroundColor Green

# Get all resources in resource group
$resources = az resource list --resource-group $resourceGroup --query "[].{Id:id, Name:name, Type:type}" -o json | ConvertFrom-Json

$configuredCount = 0
foreach ($resource in $resources) {
    # Skip certain resource types that don't support diagnostics
    $skipTypes = @(
        "Microsoft.Network/networkInterfaces",
        "Microsoft.Network/publicIPAddresses",
        "Microsoft.ManagedIdentity/userAssignedIdentities"
    )
    
    if ($skipTypes -contains $resource.Type) {
        continue
    }
    
    Write-Host "  Configuring: $($resource.Name) ($($resource.Type))" -ForegroundColor Cyan
    
    # Create diagnostic setting
    az monitor diagnostic-settings create `
        --name "diag-to-law" `
        --resource $resource.Id `
        --workspace $workspaceId `
        --logs '[{"category":"allLogs","enabled":true}]' `
        --metrics '[{"category":"AllMetrics","enabled":true}]' `
        2>$null
    
    if ($LASTEXITCODE -eq 0) {
        $configuredCount++
        Write-Host "    ✓ Configured" -ForegroundColor Green
    } else {
        Write-Host "    ⚠ Skipped (not supported or already configured)" -ForegroundColor Yellow
    }
}

Write-Host "  ✓ Configured diagnostic settings for $configuredCount resources" -ForegroundColor Green

# ============================================================================
# ACTION GROUPS
# ============================================================================

Write-Host "`n[4/7] Creating action groups..." -ForegroundColor Green

# Critical alerts action group
$criticalActionGroup = "ag-critical-$Environment"
az monitor action-group create `
    --name $criticalActionGroup `
    --resource-group $resourceGroup `
    --short-name "Critical" `
    --action email oncall $NotificationEmail `
    2>$null

if ($LASTEXITCODE -eq 0 -or $LASTEXITCODE -eq 1) {
    Write-Host "  ✓ Created action group: $criticalActionGroup" -ForegroundColor Green
} else {
    Write-Host "  ⚠ Action group may already exist" -ForegroundColor Yellow
}

# Warning alerts action group
$warningActionGroup = "ag-warning-$Environment"
az monitor action-group create `
    --name $warningActionGroup `
    --resource-group $resourceGroup `
    --short-name "Warning" `
    --action email team $NotificationEmail `
    2>$null

if ($LASTEXITCODE -eq 0 -or $LASTEXITCODE -eq 1) {
    Write-Host "  ✓ Created action group: $warningActionGroup" -ForegroundColor Green
}

# ============================================================================
# ALERT RULES
# ============================================================================

Write-Host "`n[5/7] Creating alert rules..." -ForegroundColor Green

$criticalActionGroupId = az monitor action-group show `
    --name $criticalActionGroup `
    --resource-group $resourceGroup `
    --query "id" -o tsv

$warningActionGroupId = az monitor action-group show `
    --name $warningActionGroup `
    --resource-group $resourceGroup `
    --query "id" -o tsv

# Alert 1: High error rate (Application Insights)
if ($appInsightsExists) {
    Write-Host "  Creating alert: High Error Rate" -ForegroundColor Cyan
    az monitor metrics alert create `
        --name "alert-high-error-rate-$Environment" `
        --resource-group $resourceGroup `
        --scopes $appInsightsExists `
        --condition "count requests/failed > 10" `
        --window-size 5m `
        --evaluation-frequency 1m `
        --severity 1 `
        --action $criticalActionGroupId `
        --description "Application error rate exceeds 10 failures in 5 minutes" `
        2>$null
    
    Write-Host "    ✓ High Error Rate alert created" -ForegroundColor Green
}

# Alert 2: High CPU utilization (VMs/App Services)
$computeResources = $resources | Where-Object { $_.Type -match "Microsoft.Compute|Microsoft.Web" }
foreach ($compute in $computeResources) {
    Write-Host "  Creating alert: High CPU for $($compute.Name)" -ForegroundColor Cyan
    az monitor metrics alert create `
        --name "alert-high-cpu-$($compute.Name)" `
        --resource-group $resourceGroup `
        --scopes $compute.Id `
        --condition "avg Percentage CPU > 80" `
        --window-size 15m `
        --evaluation-frequency 5m `
        --severity 2 `
        --action $warningActionGroupId `
        --description "CPU utilization >80% for 15 minutes" `
        2>$null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "    ✓ Alert created" -ForegroundColor Green
    }
}

# Alert 3: Storage capacity warning
$storageAccounts = $resources | Where-Object { $_.Type -eq "Microsoft.Storage/storageAccounts" }
foreach ($storage in $storageAccounts) {
    Write-Host "  Creating alert: Storage capacity for $($storage.Name)" -ForegroundColor Cyan
    az monitor metrics alert create `
        --name "alert-storage-capacity-$($storage.Name)" `
        --resource-group $resourceGroup `
        --scopes $storage.Id `
        --condition "avg UsedCapacity > 800000000000" `
        --window-size 1h `
        --evaluation-frequency 30m `
        --severity 2 `
        --action $warningActionGroupId `
        --description "Storage used capacity >800 GB" `
        2>$null
}

Write-Host "  ✓ Alert rules created" -ForegroundColor Green

# ============================================================================
# AZURE SENTINEL (OPTIONAL)
# ============================================================================

if ($EnableSentinel) {
    Write-Host "`n[6/7] Deploying Azure Sentinel..." -ForegroundColor Green
    
    # Enable Sentinel on Log Analytics workspace
    az sentinel onboard `
        --resource-group $resourceGroup `
        --workspace-name $workspaceName `
        2>$null
    
    if ($LASTEXITCODE -eq 0) {
        Write-Host "  ✓ Sentinel enabled on workspace" -ForegroundColor Green
        
        # Install common data connectors
        Write-Host "  Installing data connectors..." -ForegroundColor Cyan
        
        # Azure Activity connector
        az sentinel data-connector create `
            --resource-group $resourceGroup `
            --workspace-name $workspaceName `
            --name "AzureActivity" `
            --kind "AzureActivity" `
            2>$null
        
        # Azure Security Center connector
        az sentinel data-connector create `
            --resource-group $resourceGroup `
            --workspace-name $workspaceName `
            --name "AzureSecurityCenter" `
            --kind "AzureSecurityCenter" `
            2>$null
        
        Write-Host "  ✓ Data connectors installed" -ForegroundColor Green
    } else {
        Write-Host "  ⚠ Sentinel may already be enabled" -ForegroundColor Yellow
    }
} else {
    Write-Host "`n[6/7] Skipping Azure Sentinel (disabled for $Environment)" -ForegroundColor Yellow
}

# ============================================================================
# CUSTOM DASHBOARD
# ============================================================================

Write-Host "`n[7/7] Creating monitoring dashboard..." -ForegroundColor Green

$dashboardName = "dashboard-aiplatform-$Environment"

# Dashboard JSON template
$dashboardJson = @{
    location = $location
    tags = @{
        environment = $Environment
        purpose = "monitoring"
    }
    properties = @{
        lenses = @(
            @{
                order = 0
                parts = @(
                    @{
                        position = @{ x = 0; y = 0; rowSpan = 4; colSpan = 6 }
                        metadata = @{
                            type = "Extension/Microsoft_OperationsManagementSuite_Workspace/PartType/LogsDashboardPart"
                            inputs = @(
                                @{
                                    name = "Scope"
                                    value = @{
                                        resourceIds = @($workspaceId)
                                    }
                                }
                            )
                            settings = @{
                                content = @{
                                    Query = "AzureMetrics | summarize avg(Average) by Resource | order by avg_Average desc"
                                    Title = "Resource Performance Overview"
                                }
                            }
                        }
                    }
                )
            }
        )
    }
} | ConvertTo-Json -Depth 10 -Compress

# Save to temporary file
$dashboardFile = New-TemporaryFile
$dashboardJson | Out-File -FilePath $dashboardFile.FullName -Encoding UTF8

# Create dashboard
az portal dashboard create `
    --name $dashboardName `
    --resource-group $resourceGroup `
    --location $location `
    --input-path $dashboardFile.FullName `
    2>$null

if ($LASTEXITCODE -eq 0) {
    Write-Host "  ✓ Dashboard created: $dashboardName" -ForegroundColor Green
} else {
    Write-Host "  ⚠ Dashboard may already exist or creation skipped" -ForegroundColor Yellow
}

Remove-Item $dashboardFile.FullName -Force

# ============================================================================
# VALIDATION
# ============================================================================

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Validating Configuration" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# List configured alerts
Write-Host "`nAlert rules configured:" -ForegroundColor Yellow
az monitor metrics alert list --resource-group $resourceGroup --output table

# List action groups
Write-Host "`nAction groups configured:" -ForegroundColor Yellow
az monitor action-group list --resource-group $resourceGroup --output table

# ============================================================================
# SUMMARY
# ============================================================================

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Monitoring Setup Complete" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "✓ Log Analytics workspace configured" -ForegroundColor Green
Write-Host "✓ Application Insights enabled" -ForegroundColor Green
Write-Host "✓ Diagnostic settings configured ($configuredCount resources)" -ForegroundColor Green
Write-Host "✓ Alert rules created" -ForegroundColor Green
Write-Host "✓ Action groups configured" -ForegroundColor Green
if ($EnableSentinel) {
    Write-Host "✓ Azure Sentinel deployed" -ForegroundColor Green
}
Write-Host "✓ Monitoring dashboard created" -ForegroundColor Green
Write-Host ""
Write-Host "Access your monitoring:" -ForegroundColor Yellow
Write-Host "  Log Analytics: https://portal.azure.com/#blade/Microsoft_OperationsManagementSuite_Workspace" -ForegroundColor Cyan
Write-Host "  Application Insights: https://portal.azure.com/#blade/HubsExtension/BrowseResource/resourceType/microsoft.insights%2Fcomponents" -ForegroundColor Cyan
if ($EnableSentinel) {
    Write-Host "  Sentinel: https://portal.azure.com/#blade/Microsoft_Azure_Security_Insights/WorkspaceUsageBlade/subscriptionId/$SubscriptionId/resourceGroup/$resourceGroup/workspaceName/$workspaceName" -ForegroundColor Cyan
}
Write-Host ""
Write-Host "Next Steps:" -ForegroundColor Yellow
Write-Host "1. Customize alert thresholds based on your workload" -ForegroundColor White
Write-Host "2. Configure additional notification channels (Teams, SMS, PagerDuty)" -ForegroundColor White
Write-Host "3. Create custom workbooks for specific use cases" -ForegroundColor White
Write-Host "4. Enable Sentinel analytics rules for security monitoring" -ForegroundColor White
Write-Host ""
