# Microsoft Fabric Landing Zone - Terraform Deployment

Infrastructure as Code for Microsoft Fabric using Terraform.

## Overview

This Terraform configuration deploys a production-ready Microsoft Fabric Landing Zone with:
- Fabric capacity provisioning
- Log Analytics workspace for monitoring
- Azure Key Vault for customer-managed keys (optional)
- Virtual Network for Private Link (optional)
- Budget alerts and cost management
- Compliance-ready configuration

## Prerequisites

- **Terraform** >= 1.5.0
- **Azure CLI** >= 2.50.0
- **Azure subscription** with appropriate permissions
- **Fabric Admin** or **Capacity Admin** role

## Quick Start

### 1. Install Terraform

```bash
# macOS
brew install terraform

# Windows (Chocolatey)
choco install terraform

# Linux (Ubuntu/Debian)
wget -O- https://apt.releases.hashicorp.com/gpg | sudo gpg --dearmor -o /usr/share/keyrings/hashicorp-archive-keyring.gpg
echo "deb [signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt install terraform
```

### 2. Authenticate to Azure

```bash
az login
az account set --subscription "Your-Subscription-Name"
```

### 3. Configure Deployment

```bash
# Copy example variables file
cp terraform.tfvars.example terraform.tfvars

# Edit with your values
nano terraform.tfvars
```

### 4. Deploy Infrastructure

```bash
# Initialize Terraform
terraform init

# Preview changes
terraform plan

# Apply changes
terraform apply
```

## Configuration

### Required Variables

Edit `terraform.tfvars`:

```hcl
capacity_name  = "fabric-ai-prod"
capacity_sku   = "F64"
region         = "australiaeast"
workspace_prefix = "ai-platform"

capacity_admin_emails = ["admin@company.com"]
alert_email_address   = "alerts@company.com"
```

### Compliance Profiles

Set `compliance_profile` to one of:
- `GDPR` - General Data Protection Regulation
- `SOC2` - SOC 2 Type II
- `HIPAA` - Healthcare compliance
- `PCIDSS` - Payment Card Industry
- `FinancialServices` - APRA CPS 234, Basel III
- `Healthcare` - HIPAA + HITECH + FDA
- `Retail` - PCI-DSS + GDPR
- `PublicSector` - FedRAMP/IRAP

### Capacity SKUs

| SKU | Monthly Cost | Users | Data Volume |
|-----|-------------|-------|-------------|
| F2 | $262 | 1-5 | <1TB |
| F8 | $1,048 | 5-20 | 1-10TB |
| F16 | $2,096 | 10-30 | 5-20TB |
| F32 | $4,192 | 20-50 | 10-50TB |
| F64 | $8,384 | 50-100 | 20-100TB |
| F128 | $16,768 | 100-200 | 50-200TB |
| F256 | $33,536 | 200-500 | 100-500TB |

## Examples

### Development Environment

```hcl
# terraform.tfvars
capacity_name    = "fabric-ai-dev"
capacity_sku     = "F8"
region           = "eastus"
workspace_prefix = "dev-ai"
environment      = "dev"
environments     = ["dev"]

enable_private_link          = false
enable_customer_managed_keys = false
log_retention_days           = 90
monthly_budget               = 1000
```

### Production Financial Services

```hcl
# terraform.tfvars
capacity_name    = "fabric-ai-prod"
capacity_sku     = "F64"
region           = "australiaeast"
workspace_prefix = "ai-platform"
environment      = "prod"
compliance_profile = "FinancialServices"

enable_private_link          = true
enable_customer_managed_keys = true
require_mfa                  = true
enable_purview               = true
enable_dlp                   = true
log_retention_days           = 2555  # 7 years
monthly_budget               = 10000
```

### Healthcare/HIPAA

```hcl
# terraform.tfvars
capacity_name    = "fabric-health-prod"
capacity_sku     = "F128"
region           = "eastus"
workspace_prefix = "healthcare-ai"
compliance_profile = "Healthcare"

enable_private_link          = true
enable_customer_managed_keys = true  # Required for HIPAA
require_mfa                  = true
log_retention_days           = 2190  # 6 years
monthly_budget               = 20000
```

## Outputs

After deployment, Terraform provides:

```bash
# View all outputs
terraform output

# Specific outputs
terraform output capacity_name
terraform output capacity_id
terraform output estimated_monthly_cost_usd
terraform output fabric_portal_url
terraform output deployment_summary
```

## State Management

### Local State (Default)

State stored locally in `terraform.tfstate`. **Not recommended for production**.

### Remote State (Recommended)

Configure Azure Storage backend:

```hcl
# main.tf
terraform {
  backend "azurerm" {
    resource_group_name  = "rg-terraform-state"
    storage_account_name = "tfstatestorageaccount"
    container_name       = "tfstate"
    key                  = "fabric-landing-zone.tfstate"
  }
}
```

Create backend storage:

```bash
# Create resource group
az group create --name rg-terraform-state --location australiaeast

# Create storage account
az storage account create \
  --name tfstatestorageaccount \
  --resource-group rg-terraform-state \
  --location australiaeast \
  --sku Standard_LRS \
  --encryption-services blob

# Create container
az storage container create \
  --name tfstate \
  --account-name tfstatestorageaccount
```

## Workspace Creation

Terraform creates the infrastructure but not Power BI/Fabric workspaces (requires Power BI REST API).

Create workspaces manually:

1. Navigate to: https://app.fabric.microsoft.com
2. Click **Workspaces** → **New workspace**
3. Name: `{workspace_prefix}-dev`, `{workspace_prefix}-test`, `{workspace_prefix}-prod`
4. Assign to capacity: `{capacity_name}`

Or use PowerShell:

```powershell
Connect-PowerBIServiceAccount

terraform output -json workspace_names | ConvertFrom-Json | ForEach-Object {
    New-PowerBIWorkspace -Name $_
}
```

## Validation

Validate compliance:

```bash
# Run compliance validation script
cd ../scripts
./Validate-FabricCompliance.ps1 \
  -CapacityName "fabric-ai-prod" \
  -ComplianceProfile "FinancialServices" \
  -GenerateReport
```

## Cleanup

```bash
# Destroy all resources
terraform destroy

# Destroy specific resources
terraform destroy -target=azapi_resource.fabric_capacity
```

## Troubleshooting

### "Provider not registered"

```bash
az provider register --namespace Microsoft.Fabric
# Wait 2-5 minutes
az provider show -n Microsoft.Fabric --query registrationState
```

### "Insufficient permissions"

Ensure you have:
- Azure subscription Contributor/Owner role
- Fabric Admin or Capacity Admin role

### "Capacity name already exists"

Capacity names are globally unique. Choose a different name or add random suffix:

```hcl
capacity_name = "fabric-ai-prod-${random_integer.suffix.result}"

resource "random_integer" "suffix" {
  min = 1000
  max = 9999
}
```

### "Invalid region"

Check supported regions:

```bash
az provider show --namespace Microsoft.Fabric \
  --query "resourceTypes[?resourceType=='capacities'].locations" -o table
```

## Cost Optimization

1. **Right-size capacity**: Start with F8-F16 for development
2. **Pause unused capacity**: Pause dev/test during off-hours
3. **Monitor utilization**: Set up alerts at 80% capacity
4. **Use incremental refresh**: Reduce data processing costs
5. **Archive cold data**: Move old data to Cool/Archive tiers

## Security Best Practices

✅ **Enable Private Link** for production
✅ **Enable Customer-Managed Keys** for sensitive data
✅ **Require MFA** via Azure AD Conditional Access
✅ **Enable Purview** for data governance
✅ **Set log retention** to meet compliance (365+ days)
✅ **Configure budget alerts** to avoid cost overruns
✅ **Use separate workspaces** for dev/test/prod
✅ **Implement RBAC** with Azure AD groups

## Additional Resources

- **Terraform Azure Provider**: https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs
- **Terraform AzAPI Provider**: https://registry.terraform.io/providers/Azure/azapi/latest/docs
- **Fabric Docs**: https://learn.microsoft.com/fabric
- **Fabric Landing Zone Guide**: ../FABRIC-LANDING-ZONE.md

## Support

- **Issues**: https://github.com/andreaswasita/AI-Delivery-Methodology/issues
- **Documentation**: See [FABRIC-LANDING-ZONE.md](../FABRIC-LANDING-ZONE.md)

## License

MIT License
