#!/usr/bin/env pwsh
<#
.SYNOPSIS
    Run compliance scan and validation for AI platform infrastructure
.DESCRIPTION
    This script performs comprehensive compliance validation:
    - Azure Policy compliance assessment
    - Security baseline validation
    - Encryption verification (at rest and in transit)
    - Network isolation checks
    - RBAC configuration review
    - Data residency verification
    - Generates compliance report (JSON/HTML)
.PARAMETER Environment
    Target environment: dev, test, uat, prod
.PARAMETER SubscriptionId
    Azure subscription ID
.PARAMETER Framework
    Compliance frameworks to check: GDPR, SOC2, ISO27001, PCI, APRA (comma-separated)
.PARAMETER OutputPath
    Path to save compliance report
.EXAMPLE
    .\compliance-scan.ps1 -Environment prod -Framework "GDPR,SOC2"
.EXAMPLE
    .\compliance-scan.ps1 -Environment prod -OutputPath "C:\compliance-reports\"
#>

[CmdletBinding()]
param(
    [Parameter(Mandatory = $true)]
    [ValidateSet('dev', 'test', 'uat', 'prod')]
    [string]$Environment,

    [Parameter(Mandatory = $false)]
    [string]$SubscriptionId,

    [Parameter(Mandatory = $false)]
    [string]$Framework = "GDPR,SOC2,ISO27001",

    [Parameter(Mandatory = $false)]
    [string]$OutputPath = "./compliance-reports/"
)

# ============================================================================
# INITIALIZATION
# ============================================================================

$ErrorActionPreference = "Stop"
Set-StrictMode -Version Latest

Write-Host "========================================" -ForegroundColor Cyan
Write-Host "  Compliance Scan - AI Platform" -ForegroundColor Cyan
Write-Host "  Environment: $Environment" -ForegroundColor Cyan
Write-Host "  Frameworks: $Framework" -ForegroundColor Cyan
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

$resourceGroup = "rg-aiplatform-$Environment"
$timestamp = Get-Date -Format "yyyy-MM-dd-HHmmss"

# Create output directory
if (-not (Test-Path $OutputPath)) {
    New-Item -ItemType Directory -Path $OutputPath -Force | Out-Null
}

# Compliance results object
$complianceResults = @{
    Timestamp = $timestamp
    Environment = $Environment
    SubscriptionId = $SubscriptionId
    ResourceGroup = $resourceGroup
    Framework = $Framework -split ','
    Checks = @()
    Summary = @{
        TotalChecks = 0
        PassedChecks = 0
        FailedChecks = 0
        WarningChecks = 0
        ComplianceScore = 0
    }
}

# Helper function to add check result
function Add-ComplianceCheck {
    param(
        [string]$Name,
        [string]$Category,
        [ValidateSet('Pass', 'Fail', 'Warning')]
        [string]$Status,
        [string]$Details,
        [string]$Framework
    )
    
    $complianceResults.Checks += @{
        Name = $Name
        Category = $Category
        Status = $Status
        Details = $Details
        Framework = $Framework
        Timestamp = (Get-Date -Format "yyyy-MM-dd HH:mm:ss")
    }
    
    $complianceResults.Summary.TotalChecks++
    
    switch ($Status) {
        'Pass' { $complianceResults.Summary.PassedChecks++ }
        'Fail' { $complianceResults.Summary.FailedChecks++ }
        'Warning' { $complianceResults.Summary.WarningChecks++ }
    }
}

# ============================================================================
# [1] AZURE POLICY COMPLIANCE
# ============================================================================

Write-Host "[1/8] Checking Azure Policy compliance..." -ForegroundColor Green

$policyStates = az policy state list `
    --resource-group $resourceGroup `
    --query "[].{Policy:policyDefinitionName, Resource:resourceId, State:complianceState}" `
    -o json | ConvertFrom-Json

$nonCompliantPolicies = $policyStates | Where-Object { $_.State -eq 'NonCompliant' }

if ($nonCompliantPolicies.Count -eq 0) {
    Write-Host "  ✓ All policies compliant" -ForegroundColor Green
    Add-ComplianceCheck -Name "Azure Policy Compliance" -Category "Governance" -Status "Pass" `
        -Details "All Azure Policy assignments are compliant" -Framework "SOC2,ISO27001"
} else {
    Write-Host "  ✗ $($nonCompliantPolicies.Count) non-compliant policies found" -ForegroundColor Red
    foreach ($policy in $nonCompliantPolicies | Select-Object -First 5) {
        Write-Host "    - $($policy.Policy): $($policy.Resource)" -ForegroundColor Yellow
    }
    Add-ComplianceCheck -Name "Azure Policy Compliance" -Category "Governance" -Status "Fail" `
        -Details "$($nonCompliantPolicies.Count) non-compliant policy assignments" -Framework "SOC2,ISO27001"
}

# ============================================================================
# [2] ENCRYPTION AT REST
# ============================================================================

Write-Host "`n[2/8] Checking encryption at rest..." -ForegroundColor Green

# Check storage accounts
$storageAccounts = az storage account list --resource-group $resourceGroup --query "[].{Name:name, Id:id}" -o json | ConvertFrom-Json
$unencryptedStorage = @()

foreach ($storage in $storageAccounts) {
    $encryption = az storage account show --name $storage.Name --resource-group $resourceGroup --query "encryption.services.blob.enabled" -o tsv
    if ($encryption -ne "true") {
        $unencryptedStorage += $storage.Name
    }
}

if ($unencryptedStorage.Count -eq 0) {
    Write-Host "  ✓ All storage accounts encrypted" -ForegroundColor Green
    Add-ComplianceCheck -Name "Storage Encryption" -Category "Data Protection" -Status "Pass" `
        -Details "All storage accounts have encryption enabled" -Framework "GDPR,SOC2,ISO27001,PCI"
} else {
    Write-Host "  ✗ Unencrypted storage accounts: $($unencryptedStorage -join ', ')" -ForegroundColor Red
    Add-ComplianceCheck -Name "Storage Encryption" -Category "Data Protection" -Status "Fail" `
        -Details "Storage accounts without encryption: $($unencryptedStorage -join ', ')" -Framework "GDPR,SOC2,ISO27001,PCI"
}

# Check SQL databases
$sqlServers = az sql server list --resource-group $resourceGroup --query "[].name" -o json | ConvertFrom-Json
$unencryptedDatabases = @()

foreach ($server in $sqlServers) {
    $databases = az sql db list --resource-group $resourceGroup --server $server --query "[?name!='master'].name" -o json | ConvertFrom-Json
    foreach ($db in $databases) {
        $tde = az sql db tde show --resource-group $resourceGroup --server $server --database $db --query "state" -o tsv 2>$null
        if ($tde -ne "Enabled") {
            $unencryptedDatabases += "$server/$db"
        }
    }
}

if ($unencryptedDatabases.Count -eq 0) {
    Write-Host "  ✓ All SQL databases have TDE enabled" -ForegroundColor Green
    Add-ComplianceCheck -Name "SQL Database Encryption (TDE)" -Category "Data Protection" -Status "Pass" `
        -Details "Transparent Data Encryption enabled on all databases" -Framework "GDPR,SOC2,PCI"
} else {
    Write-Host "  ✗ Databases without TDE: $($unencryptedDatabases -join ', ')" -ForegroundColor Red
    Add-ComplianceCheck -Name "SQL Database Encryption (TDE)" -Category "Data Protection" -Status "Fail" `
        -Details "TDE not enabled: $($unencryptedDatabases -join ', ')" -Framework "GDPR,SOC2,PCI"
}

# ============================================================================
# [3] PRIVATE ENDPOINTS
# ============================================================================

Write-Host "`n[3/8] Checking private endpoint configuration..." -ForegroundColor Green

$privateEndpoints = az network private-endpoint list --resource-group $resourceGroup --query "[].{Name:name, State:privateLinkServiceConnections[0].privateLinkServiceConnectionState.status}" -o json | ConvertFrom-Json

$requiredServices = @("storage", "sql", "vault", "ml", "openai", "cognitiveservices")
$configuredServices = $privateEndpoints | ForEach-Object { $_.Name } | Where-Object { $_ -match ($requiredServices -join '|') }

if ($privateEndpoints.Count -ge $requiredServices.Count) {
    Write-Host "  ✓ Private endpoints configured ($($privateEndpoints.Count) found)" -ForegroundColor Green
    Add-ComplianceCheck -Name "Private Endpoint Configuration" -Category "Network Security" -Status "Pass" `
        -Details "$($privateEndpoints.Count) private endpoints configured" -Framework "SOC2,ISO27001,APRA"
} else {
    Write-Host "  ⚠ Only $($privateEndpoints.Count)/$($requiredServices.Count) private endpoints configured" -ForegroundColor Yellow
    Add-ComplianceCheck -Name "Private Endpoint Configuration" -Category "Network Security" -Status "Warning" `
        -Details "Expected $($requiredServices.Count) private endpoints, found $($privateEndpoints.Count)" -Framework "SOC2,ISO27001,APRA"
}

# ============================================================================
# [4] NETWORK SECURITY GROUPS
# ============================================================================

Write-Host "`n[4/8] Checking Network Security Groups..." -ForegroundColor Green

$nsgs = az network nsg list --resource-group $resourceGroup --query "[].{Name:name, Id:id}" -o json | ConvertFrom-Json
$weakRules = @()

foreach ($nsg in $nsgs) {
    $rules = az network nsg rule list --nsg-name $nsg.Name --resource-group $resourceGroup --query "[].{Name:name, Access:access, Direction:direction, SourceAddress:sourceAddressPrefix, DestPort:destinationPortRange}" -o json | ConvertFrom-Json
    
    # Check for overly permissive inbound rules
    $badRules = $rules | Where-Object { 
        $_.Direction -eq "Inbound" -and 
        $_.Access -eq "Allow" -and 
        ($_.SourceAddress -eq "*" -or $_.SourceAddress -eq "Internet") -and
        $_.DestPort -ne "443"
    }
    
    if ($badRules) {
        $weakRules += "$($nsg.Name): $($badRules.Count) overly permissive rules"
    }
}

if ($weakRules.Count -eq 0) {
    Write-Host "  ✓ NSG rules follow least-privilege principle" -ForegroundColor Green
    Add-ComplianceCheck -Name "Network Security Group Rules" -Category "Network Security" -Status "Pass" `
        -Details "No overly permissive NSG rules detected" -Framework "SOC2,ISO27001,PCI"
} else {
    Write-Host "  ⚠ Potentially weak NSG rules:" -ForegroundColor Yellow
    foreach ($weak in $weakRules) {
        Write-Host "    - $weak" -ForegroundColor Yellow
    }
    Add-ComplianceCheck -Name "Network Security Group Rules" -Category "Network Security" -Status "Warning" `
        -Details "Review NSG rules: $($weakRules -join '; ')" -Framework "SOC2,ISO27001,PCI"
}

# ============================================================================
# [5] DATA RESIDENCY
# ============================================================================

Write-Host "`n[5/8] Checking data residency compliance..." -ForegroundColor Green

$allowedRegions = @("australiaeast", "australiasoutheast", "australia")
$resources = az resource list --resource-group $resourceGroup --query "[].{Name:name, Location:location}" -o json | ConvertFrom-Json
$nonCompliantResources = $resources | Where-Object { $allowedRegions -notcontains $_.Location.ToLower() }

if ($nonCompliantResources.Count -eq 0) {
    Write-Host "  ✓ All resources in Australia regions" -ForegroundColor Green
    Add-ComplianceCheck -Name "Data Residency" -Category "Data Governance" -Status "Pass" `
        -Details "All resources located in approved Australian regions" -Framework "GDPR,APRA"
} else {
    Write-Host "  ✗ Resources outside Australia:" -ForegroundColor Red
    foreach ($resource in $nonCompliantResources) {
        Write-Host "    - $($resource.Name): $($resource.Location)" -ForegroundColor Red
    }
    Add-ComplianceCheck -Name "Data Residency" -Category "Data Governance" -Status "Fail" `
        -Details "$($nonCompliantResources.Count) resources outside approved regions" -Framework "GDPR,APRA"
}

# ============================================================================
# [6] RBAC CONFIGURATION
# ============================================================================

Write-Host "`n[6/8] Checking RBAC configuration..." -ForegroundColor Green

# Check for overly permissive Owner assignments
$ownerAssignments = az role assignment list --resource-group $resourceGroup --role "Owner" --query "[].{Principal:principalName, Type:principalType}" -o json | ConvertFrom-Json

if ($ownerAssignments.Count -le 2) {
    Write-Host "  ✓ Owner role assignments minimized ($($ownerAssignments.Count) assignments)" -ForegroundColor Green
    Add-ComplianceCheck -Name "RBAC - Owner Role" -Category "Access Control" -Status "Pass" `
        -Details "Owner role appropriately restricted ($($ownerAssignments.Count) assignments)" -Framework "SOC2,ISO27001"
} else {
    Write-Host "  ⚠ $($ownerAssignments.Count) Owner role assignments (review for least-privilege)" -ForegroundColor Yellow
    Add-ComplianceCheck -Name "RBAC - Owner Role" -Category "Access Control" -Status "Warning" `
        -Details "$($ownerAssignments.Count) Owner assignments - review for least-privilege" -Framework "SOC2,ISO27001"
}

# ============================================================================
# [7] AUDIT LOGGING
# ============================================================================

Write-Host "`n[7/8] Checking audit logging configuration..." -ForegroundColor Green

# Check diagnostic settings
$diagnosticSettings = az monitor diagnostic-settings subscription list --query "value[].{Name:name, WorkspaceId:workspaceId}" -o json 2>$null | ConvertFrom-Json

if ($diagnosticSettings -and $diagnosticSettings.Count -gt 0) {
    Write-Host "  ✓ Subscription-level diagnostic settings configured" -ForegroundColor Green
    Add-ComplianceCheck -Name "Audit Logging - Subscription" -Category "Monitoring" -Status "Pass" `
        -Details "Diagnostic settings enabled at subscription level" -Framework "SOC2,ISO27001,GDPR,APRA"
} else {
    Write-Host "  ⚠ Subscription-level diagnostic settings not found" -ForegroundColor Yellow
    Add-ComplianceCheck -Name "Audit Logging - Subscription" -Category "Monitoring" -Status "Warning" `
        -Details "Configure diagnostic settings for subscription-level events" -Framework "SOC2,ISO27001,GDPR,APRA"
}

# ============================================================================
# [8] MICROSOFT DEFENDER FOR CLOUD
# ============================================================================

Write-Host "`n[8/8] Checking Microsoft Defender for Cloud..." -ForegroundColor Green

$defenderStatus = az security pricing list --query "value[].{Name:name, Tier:pricingTier}" -o json 2>$null | ConvertFrom-Json

$enabledPlans = ($defenderStatus | Where-Object { $_.Tier -eq "Standard" }).Count
$totalPlans = $defenderStatus.Count

if ($enabledPlans -ge 5) {
    Write-Host "  ✓ Microsoft Defender plans enabled ($enabledPlans/$totalPlans)" -ForegroundColor Green
    Add-ComplianceCheck -Name "Microsoft Defender for Cloud" -Category "Security" -Status "Pass" `
        -Details "$enabledPlans of $totalPlans Defender plans enabled" -Framework "SOC2,ISO27001"
} else {
    Write-Host "  ⚠ Only $enabledPlans/$totalPlans Defender plans enabled" -ForegroundColor Yellow
    Add-ComplianceCheck -Name "Microsoft Defender for Cloud" -Category "Security" -Status "Warning" `
        -Details "Enable more Defender plans for comprehensive protection" -Framework "SOC2,ISO27001"
}

# ============================================================================
# CALCULATE COMPLIANCE SCORE
# ============================================================================

$complianceResults.Summary.ComplianceScore = [math]::Round(
    ($complianceResults.Summary.PassedChecks / $complianceResults.Summary.TotalChecks) * 100, 2
)

# ============================================================================
# GENERATE REPORT
# ============================================================================

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Generating Compliance Report" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan

# Save JSON report
$jsonReportPath = Join-Path $OutputPath "compliance-report-$Environment-$timestamp.json"
$complianceResults | ConvertTo-Json -Depth 10 | Out-File -FilePath $jsonReportPath -Encoding UTF8
Write-Host "  ✓ JSON report saved: $jsonReportPath" -ForegroundColor Green

# Generate HTML report
$htmlReport = @"
<!DOCTYPE html>
<html>
<head>
    <title>Compliance Report - $Environment - $timestamp</title>
    <style>
        body { font-family: Arial, sans-serif; margin: 20px; background: #f5f5f5; }
        .header { background: #0078d4; color: white; padding: 20px; border-radius: 8px; }
        .summary { background: white; padding: 20px; margin: 20px 0; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .score { font-size: 48px; font-weight: bold; color: $(if ($complianceResults.Summary.ComplianceScore -ge 90) { '#107c10' } elseif ($complianceResults.Summary.ComplianceScore -ge 70) { '#ff8c00' } else { '#d13438' }); }
        .checks { background: white; padding: 20px; border-radius: 8px; box-shadow: 0 2px 4px rgba(0,0,0,0.1); }
        .check { padding: 15px; margin: 10px 0; border-left: 4px solid #ccc; background: #fafafa; }
        .check.pass { border-left-color: #107c10; }
        .check.fail { border-left-color: #d13438; }
        .check.warning { border-left-color: #ff8c00; }
        table { width: 100%; border-collapse: collapse; }
        th, td { padding: 12px; text-align: left; border-bottom: 1px solid #ddd; }
        th { background-color: #0078d4; color: white; }
    </style>
</head>
<body>
    <div class="header">
        <h1>Compliance Scan Report</h1>
        <p><strong>Environment:</strong> $Environment | <strong>Date:</strong> $timestamp</p>
        <p><strong>Subscription:</strong> $SubscriptionId</p>
        <p><strong>Frameworks:</strong> $($complianceResults.Framework -join ', ')</p>
    </div>
    
    <div class="summary">
        <h2>Compliance Summary</h2>
        <div class="score">$($complianceResults.Summary.ComplianceScore)%</div>
        <table>
            <tr>
                <th>Metric</th>
                <th>Value</th>
            </tr>
            <tr>
                <td>Total Checks</td>
                <td>$($complianceResults.Summary.TotalChecks)</td>
            </tr>
            <tr>
                <td>✓ Passed</td>
                <td style="color: #107c10;">$($complianceResults.Summary.PassedChecks)</td>
            </tr>
            <tr>
                <td>⚠ Warnings</td>
                <td style="color: #ff8c00;">$($complianceResults.Summary.WarningChecks)</td>
            </tr>
            <tr>
                <td>✗ Failed</td>
                <td style="color: #d13438;">$($complianceResults.Summary.FailedChecks)</td>
            </tr>
        </table>
    </div>
    
    <div class="checks">
        <h2>Detailed Results</h2>
        $(foreach ($check in $complianceResults.Checks) {
            "<div class='check $($check.Status.ToLower())'>
                <h3>$($check.Name) <span style='float:right; color: $(if ($check.Status -eq 'Pass') { '#107c10' } elseif ($check.Status -eq 'Fail') { '#d13438' } else { '#ff8c00' })'>[$($check.Status)]</span></h3>
                <p><strong>Category:</strong> $($check.Category) | <strong>Framework:</strong> $($check.Framework)</p>
                <p>$($check.Details)</p>
            </div>"
        })
    </div>
</body>
</html>
"@

$htmlReportPath = Join-Path $OutputPath "compliance-report-$Environment-$timestamp.html"
$htmlReport | Out-File -FilePath $htmlReportPath -Encoding UTF8
Write-Host "  ✓ HTML report saved: $htmlReportPath" -ForegroundColor Green

# ============================================================================
# SUMMARY
# ============================================================================

Write-Host "`n========================================" -ForegroundColor Cyan
Write-Host "  Compliance Scan Complete" -ForegroundColor Cyan
Write-Host "========================================" -ForegroundColor Cyan
Write-Host ""
Write-Host "Compliance Score: $($complianceResults.Summary.ComplianceScore)% " -NoNewline
if ($complianceResults.Summary.ComplianceScore -ge 90) {
    Write-Host "✓ EXCELLENT" -ForegroundColor Green
} elseif ($complianceResults.Summary.ComplianceScore -ge 70) {
    Write-Host "⚠ NEEDS IMPROVEMENT" -ForegroundColor Yellow
} else {
    Write-Host "✗ CRITICAL" -ForegroundColor Red
}
Write-Host ""
Write-Host "Results Summary:" -ForegroundColor Yellow
Write-Host "  Total Checks: $($complianceResults.Summary.TotalChecks)" -ForegroundColor White
Write-Host "  ✓ Passed: $($complianceResults.Summary.PassedChecks)" -ForegroundColor Green
Write-Host "  ⚠ Warnings: $($complianceResults.Summary.WarningChecks)" -ForegroundColor Yellow
Write-Host "  ✗ Failed: $($complianceResults.Summary.FailedChecks)" -ForegroundColor Red
Write-Host ""
Write-Host "Reports saved to: $OutputPath" -ForegroundColor Cyan
Write-Host "  - JSON: compliance-report-$Environment-$timestamp.json" -ForegroundColor White
Write-Host "  - HTML: compliance-report-$Environment-$timestamp.html" -ForegroundColor White
Write-Host ""

# Return exit code based on failures
if ($complianceResults.Summary.FailedChecks -gt 0) {
    Write-Host "⚠ Action required: $($complianceResults.Summary.FailedChecks) failed checks" -ForegroundColor Red
    exit 1
} else {
    Write-Host "✓ Compliance validated successfully" -ForegroundColor Green
    exit 0
}
