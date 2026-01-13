# Microsoft Fabric Deployment Scripts

This directory contains PowerShell automation scripts for deploying and managing Microsoft Fabric Landing Zones.

## Scripts

### Deploy-FabricLandingZone.ps1

Main deployment script that creates a complete Fabric environment with compliance controls.

**Features:**
- Fabric capacity provisioning (F2-F2048 SKUs)
- Workspace hierarchy creation (Dev/Test/Prod)
- Security configuration (Azure AD, Private Link, MFA)
- Governance setup (Microsoft Purview, DLP, audit logs)
- Monitoring configuration (Azure Monitor, cost alerts)
- Compliance validation

**Usage:**
```powershell
# Production Financial Services deployment
.\Deploy-FabricLandingZone.ps1 `
    -CapacityName "fabric-ai-prod" `
    -CapacitySKU "F64" `
    -Region "australiaeast" `
    -WorkspacePrefix "ai-platform" `
    -ComplianceProfile "FinancialServices" `
    -EnablePrivateLink `
    -EnableCustomerManagedKeys `
    -RequireMFA `
    -LogRetentionDays 2555 `
    -MonthlyBudget 10000

# Development environment
.\Deploy-FabricLandingZone.ps1 `
    -CapacityName "fabric-ai-dev" `
    -CapacitySKU "F8" `
    -Region "eastus" `
    -WorkspacePrefix "dev-ai" `
    -Environments @("dev") `
    -ComplianceProfile "GDPR"

# Preview deployment
.\Deploy-FabricLandingZone.ps1 `
    -CapacityName "fabric-test" `
    -CapacitySKU "F32" `
    -Region "westeurope" `
    -WorkspacePrefix "test" `
    -WhatIf
```

**Parameters:**
- `CapacityName`: Unique name for Fabric capacity
- `CapacitySKU`: Capacity size (F2, F4, F8, F16, F32, F64, F128, F256, F512, F1024, F2048)
- `Region`: Azure region (e.g., australiaeast, eastus, westeurope)
- `WorkspacePrefix`: Prefix for workspace names
- `Environments`: Array of environments (default: dev, test, prod)
- `ComplianceProfile`: GDPR, SOC2, HIPAA, PCIDSS, FinancialServices, Healthcare, Retail, PublicSector
- `EnablePrivateLink`: Enable Private Link connectivity
- `EnableCustomerManagedKeys`: Enable CMK via Azure Key Vault
- `RequireMFA`: Require MFA for all access
- `EnablePurview`: Enable Microsoft Purview integration
- `EnableDLP`: Enable Data Loss Prevention
- `LogRetentionDays`: Audit log retention (90-2555 days)
- `MonthlyBudget`: Budget for cost alerts (USD)
- `WhatIf`: Preview without making changes

**Deployment Time:** 15-20 minutes

**Prerequisites:**
- PowerShell 7+
- Azure CLI
- Az PowerShell modules (Az.Accounts, Az.Resources, Az.Monitor, Az.KeyVault, Az.Network)
- MicrosoftPowerBIMgmt module
- Fabric Admin or Capacity Admin permissions

---

### Validate-FabricCompliance.ps1

Validates deployed Fabric environment against compliance requirements.

**Usage:**
```powershell
.\Validate-FabricCompliance.ps1 `
    -CapacityName "fabric-ai-prod" `
    -ComplianceProfile "FinancialServices" `
    -GenerateReport
```

**Checks:**
- Data residency verification
- Encryption status (at rest and in transit)
- Access control configuration
- Audit log retention
- Monitoring and alerting
- Compliance-specific requirements

---

## Quick Start

### 1. Install Prerequisites

```powershell
# Install PowerShell 7+
winget install Microsoft.PowerShell

# Install Azure CLI
winget install Microsoft.AzureCLI

# Install required PowerShell modules
Install-Module -Name Az.Accounts, Az.Resources, Az.Monitor, Az.KeyVault, Az.Network -Scope CurrentUser -Force
Install-Module -Name MicrosoftPowerBIMgmt -Scope CurrentUser -Force
```

### 2. Authenticate

```powershell
# Azure authentication
Connect-AzAccount
Set-AzContext -Subscription "Your-Subscription-Name"

# Power BI / Fabric authentication
Connect-PowerBIServiceAccount
```

### 3. Deploy Fabric Landing Zone

```powershell
# Clone repository
git clone https://github.com/andreaswasita/AI-Delivery-Methodology.git
cd AI-Delivery-Methodology/infrastructure/fabric/scripts

# Run deployment
.\Deploy-FabricLandingZone.ps1 `
    -CapacityName "fabric-ai-prod" `
    -CapacitySKU "F64" `
    -Region "australiaeast" `
    -WorkspacePrefix "ai-platform" `
    -ComplianceProfile "FinancialServices" `
    -EnablePrivateLink `
    -RequireMFA `
    -LogRetentionDays 365 `
    -MonthlyBudget 10000
```

### 4. Validate Deployment

```powershell
.\Validate-FabricCompliance.ps1 `
    -CapacityName "fabric-ai-prod" `
    -ComplianceProfile "FinancialServices" `
    -GenerateReport
```

---

## Compliance Profiles

### GDPR
- Data residency enforcement
- 365-day audit log retention
- Encryption at rest and in transit
- PII detection and masking
- Data subject rights workflow

### SOC 2
- MFA enforcement
- 365-day audit log retention
- Continuous monitoring
- Incident response procedures
- Access control reviews

### HIPAA
- Customer-managed keys (CMK) required
- PHI encryption and masking
- 6-year retention (2190 days)
- Access logging for all PHI
- Business Associate Agreement (BAA)

### PCI-DSS
- Private Link required
- Network isolation
- 365-day audit retention
- Quarterly vulnerability scans
- Encrypted cardholder data

### Financial Services (APRA CPS 234)
- 7-year retention (2555 days)
- Private Link required
- Disaster recovery (15-min RTO)
- Third-party risk management
- Model risk management

### Healthcare
- HIPAA + HITECH compliance
- PHI protection with sensitivity labels
- 6-year retention
- Patient consent tracking
- FDA 21 CFR Part 11 (optional)

### Retail
- PCI-DSS for payment data
- GDPR/CCPA for customer data
- Customer consent management
- 365-day retention

### Public Sector
- FedRAMP / IRAP compliance
- Data sovereignty
- NIST 800-53 controls
- 7-year retention
- Supply chain security

---

## Cost Estimates

| SKU | Monthly Cost (USD) | Users Supported | Data Volume |
|-----|-------------------|-----------------|-------------|
| F2 | $262 | 1-5 | <1TB |
| F8 | $1,048 | 5-20 | 1-10TB |
| F16 | $2,096 | 10-30 | 5-20TB |
| F32 | $4,192 | 20-50 | 10-50TB |
| F64 | $8,384 | 50-100 | 20-100TB |
| F128 | $16,768 | 100-200 | 50-200TB |
| F256 | $33,536 | 200-500 | 100-500TB |
| F512 | $67,072 | 500-1000 | 200TB-1PB |

*Capacity costs only. OneLake storage: ~$0.018/GB/month additional*

---

## Troubleshooting

### "Microsoft.Fabric provider not registered"
```powershell
Register-AzResourceProvider -ProviderNamespace Microsoft.Fabric
# Wait 2-5 minutes for registration
```

### "Insufficient permissions"
- Ensure you have Fabric Admin or Capacity Admin role
- Verify Azure subscription Contributor/Owner role

### "Capacity creation failed"
- Capacity names must be globally unique (3-63 characters, lowercase, numbers, hyphens)
- Some regions may not support all SKUs
- Check subscription quotas in Azure Portal

### "Workspace already exists"
- Workspaces are tenant-wide; ensure unique names
- Consider adding random suffix: `$WorkspacePrefix-$((Get-Random -Maximum 9999).ToString('0000'))`

---

## Support

- **Documentation**: See [FABRIC-LANDING-ZONE.md](../FABRIC-LANDING-ZONE.md)
- **Issues**: https://github.com/andreaswasita/AI-Delivery-Methodology/issues
- **Microsoft Fabric Docs**: https://learn.microsoft.com/fabric
- **Compliance**: https://aka.ms/FabricCompliance

---

## License

MIT License - See repository root for details
