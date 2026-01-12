# Azure AI Platform - Quick Start Guide

## Overview

This guide will help you deploy the standardized AI platform infrastructure in **15 minutes**. The platform includes:

- **Networking**: VNet with NSGs, Firewall, Bastion
- **Security**: Key Vault, Managed Identity, RBAC
- **Monitoring**: Log Analytics, Application Insights, Sentinel
- **Data**: Storage, SQL Database, Cosmos DB, Data Lake
- **AI Services**: Azure ML, Azure OpenAI, Cognitive Services
- **Compute**: AKS cluster, VM Scale Sets
- **Governance**: Azure Policies, Budgets, Cost Management

All resources are configured with **compliance built-in** for GDPR, SOC 2, ISO 27001, PCI-DSS, APRA CPS 234, and HIPAA.

---

## Prerequisites

### 1. Azure Subscription

- Active Azure subscription with Owner or Contributor permissions
- Sufficient quota for GPU VMs (if using production environment)

### 2. Required Tools

| Tool | Version | Installation |
|------|---------|--------------|
| Azure CLI | 2.50+ | https://aka.ms/azure-cli |
| PowerShell | 7.0+ | https://aka.ms/powershell (Windows has PowerShell 5.1 built-in) |
| Bash | 4.0+ | Built-in on macOS/Linux, WSL on Windows |
| Bicep CLI | Latest | Auto-installed by script |

### 3. Azure Permissions

Required Azure RBAC roles:
- **Owner** (preferred) or **Contributor + User Access Administrator**
- Permissions to create resources at subscription level
- Permissions to assign Azure Policies

---

## Quick Start (15 Minutes)

### Step 1: Clone Repository (2 minutes)

```bash
# Clone the repository
git clone https://github.com/andreaswasita/AI-Delivery-Methodology.git
cd AI-Delivery-Methodology/infrastructure
```

### Step 2: Configure Parameters (3 minutes)

Edit the parameter file for your environment:

```bash
# For Development
code bicep/parameters/dev.parameters.json

# For Production
code bicep/parameters/prod.parameters.json
```

**Required changes:**

```json
{
  "parameters": {
    "projectName": {
      "value": "myaiproj"  // Change this (3-10 chars, lowercase)
    },
    "organizationName": {
      "value": "YourCompany"  // Change this
    },
    "costCenter": {
      "value": "CC-12345"  // Change this
    }
  }
}
```

### Step 3: Deploy Infrastructure (10 minutes)

#### Option A: PowerShell (Windows/macOS/Linux)

```powershell
# Navigate to scripts directory
cd scripts

# Deploy to Development
.\deploy.ps1 -Environment dev -ProjectName myaiproj

# Deploy to Production
.\deploy.ps1 -Environment prod -ProjectName myaiproj -SubscriptionId "your-sub-id"

# Preview changes without deploying (What-If)
.\deploy.ps1 -Environment prod -ProjectName myaiproj -WhatIf
```

#### Option B: Bash (macOS/Linux/WSL)

```bash
# Navigate to scripts directory
cd scripts

# Make script executable
chmod +x deploy.sh

# Deploy to Development
./deploy.sh -e dev -p myaiproj

# Deploy to Production
./deploy.sh -e prod -p myaiproj -s "your-subscription-id"

# Preview changes without deploying (What-If)
./deploy.sh -e prod -p myaiproj -w
```

### Step 4: Verify Deployment (2 minutes)

After deployment completes, you'll see output like:

```
========================================
Deployment Outputs
========================================

Resource Group:       rg-myaiproj-prod
Key Vault:            kv-myaiproj-prod-abc123
Storage Account:      stmyaiprojprodabc123
Azure ML Workspace:   mlw-myaiproj-prod
AKS Cluster:          aks-myaiproj-prod
Compliance Enabled:   true
Data Residency:       Australia

✓ Outputs saved to: outputs/prod-outputs.json
```

**Verify in Azure Portal:**

1. Go to [portal.azure.com](https://portal.azure.com)
2. Navigate to your resource group: `rg-<projectname>-<environment>`
3. Confirm all resources are created and healthy

---

## Environment Configurations

### Development Environment

**Purpose**: Development and testing  
**Cost**: ~$1,500 - $3,000/month  
**Features**:
- Single region (australiaeast)
- No geo-redundancy
- No Sentinel
- No DDoS Protection
- Basic SKUs
- Compliance features: Optional

**Use when**:
- Early prototyping
- Individual developer work
- Cost optimization is critical

### Test/UAT Environment

**Purpose**: Integration testing and user acceptance  
**Cost**: ~$3,000 - $5,000/month  
**Features**:
- Single region
- No geo-redundancy
- Optional Sentinel
- Standard SKUs
- Compliance features: Enabled

**Use when**:
- Integration testing
- Performance testing
- Pre-production validation

### Production Environment

**Purpose**: Live production workloads  
**Cost**: ~$10,000 - $25,000/month  
**Features**:
- Multi-region (australiaeast + australiasoutheast)
- Geo-redundancy enabled
- Sentinel enabled
- DDoS Protection
- Premium SKUs
- Zone-redundant services
- Compliance features: Fully enabled

**Use when**:
- Production AI applications
- Customer-facing services
- Compliance required

---

## Post-Deployment Configuration

### 1. Configure RBAC (5 minutes)

Assign roles to your team:

```bash
# Get resource group ID
RG_ID=$(az group show --name "rg-myaiproj-prod" --query id -o tsv)

# Assign Contributor role to team
az role assignment create \
  --role "Contributor" \
  --assignee "user@company.com" \
  --scope "$RG_ID"

# Assign Azure ML Workspace roles
WORKSPACE_ID=$(az ml workspace show \
  --name "mlw-myaiproj-prod" \
  --resource-group "rg-myaiproj-prod" \
  --query id -o tsv)

az role assignment create \
  --role "AzureML Data Scientist" \
  --assignee "user@company.com" \
  --scope "$WORKSPACE_ID"
```

### 2. Configure AKS Access (5 minutes)

Get AKS credentials:

```bash
# Get AKS credentials
az aks get-credentials \
  --resource-group "rg-myaiproj-prod" \
  --name "aks-myaiproj-prod"

# Verify connection
kubectl get nodes

# Create namespaces
kubectl create namespace dev
kubectl create namespace prod
```

### 3. Set Up Monitoring Alerts (10 minutes)

The platform includes default alerts, but you should configure email notifications:

```bash
# Update Action Group with email
az monitor action-group update \
  --name "ag-myaiproj-prod" \
  --resource-group "rg-myaiproj-prod" \
  --add-action \
    email \
    "team-email" \
    "devops@company.com"
```

### 4. Configure Key Vault Secrets (5 minutes)

Store sensitive configuration:

```bash
# Get Key Vault name
KV_NAME=$(az keyvault list \
  --resource-group "rg-myaiproj-prod" \
  --query "[0].name" -o tsv)

# Add secrets
az keyvault secret set \
  --vault-name "$KV_NAME" \
  --name "OpenAIKey" \
  --value "your-openai-key"

az keyvault secret set \
  --vault-name "$KV_NAME" \
  --name "DatabasePassword" \
  --value "your-secure-password"
```

---

## Deploying Your First AI Use Case

### Example: Deploy a Financial Services Fraud Detection Model

**Time**: 30 minutes

#### 1. Prepare Your Model

```python
# train_model.py
from azureml.core import Workspace, Experiment, Environment
from azureml.core.model import Model

# Connect to Azure ML Workspace
ws = Workspace.from_config()

# Create experiment
experiment = Experiment(workspace=ws, name='fraud-detection')

# Train model (your code here)
# ...

# Register model
model = Model.register(
    workspace=ws,
    model_name='fraud-detection-v1',
    model_path='outputs/model.pkl',
    tags={'use-case': 'fraud-detection', 'version': '1.0'}
)
```

#### 2. Create Deployment Configuration

```python
# deploy_model.py
from azureml.core import Workspace
from azureml.core.model import Model
from azureml.core.webservice import AksWebservice, Webservice

ws = Workspace.from_config()

# Get model
model = Model(ws, 'fraud-detection-v1')

# Configure deployment
aks_config = AksWebservice.deploy_configuration(
    cpu_cores=2,
    memory_gb=4,
    autoscale_enabled=True,
    autoscale_min_replicas=2,
    autoscale_max_replicas=10,
    enable_app_insights=True,
    collect_model_data=True
)

# Deploy to AKS
service = Model.deploy(
    workspace=ws,
    name='fraud-detection-service',
    models=[model],
    deployment_config=aks_config,
    deployment_target='aks-myaiproj-prod'
)

service.wait_for_deployment(show_output=True)
print(f"Scoring URI: {service.scoring_uri}")
```

#### 3. Test the Endpoint

```python
# test_endpoint.py
import requests
import json

# Get scoring URI from deployment
scoring_uri = "https://aks-myaiproj-prod.australiaeast.cloudapp.azure.com/score"

# Test data
data = {
    "data": [
        {
            "transaction_amount": 1500.00,
            "merchant_id": "MERCH12345",
            "location": "Sydney, AU"
        }
    ]
}

# Make prediction
response = requests.post(scoring_uri, json=data)
print(f"Prediction: {response.json()}")
```

---

## Compliance Verification

### Run Compliance Scan

```powershell
# Run compliance scan
.\scripts\compliance-scan.ps1 -Environment prod -ProjectName myaiproj
```

### Expected Results

```
Compliance Framework: GDPR
✓ Data encryption at rest: Enabled
✓ Data encryption in transit: TLS 1.3
✓ Audit logging: Enabled (365 days retention)
✓ Private endpoints: Configured
✓ Data residency: Australia

Compliance Framework: SOC 2
✓ Access controls: Azure AD + RBAC
✓ Logging and monitoring: Enabled
✓ Incident response: Sentinel configured
✓ Change management: Version controlled IaC

Compliance Framework: ISO 27001
✓ Information security policy: Enforced via Azure Policy
✓ Asset management: Tagged and inventoried
✓ Access control: Multi-factor authentication required
✓ Cryptography: AES-256 encryption

Overall Compliance Score: 98%
```

---

## Cost Management

### View Current Costs

```bash
# Get current month costs
az consumption usage list \
  --start-date "2025-01-01" \
  --end-date "2025-01-31" \
  --query "[?contains(instanceName, 'myaiproj')].{Name:instanceName, Cost:pretaxCost}" \
  --output table
```

### Cost Optimization Tips

1. **Scale down when not in use**:
   ```bash
   # Scale AKS node pool to 0
   az aks nodepool scale \
     --cluster-name "aks-myaiproj-dev" \
     --name userpool \
     --node-count 0 \
     --resource-group "rg-myaiproj-dev"
   ```

2. **Use spot instances for non-critical workloads**:
   - GPU node pools configured with low-priority VMs
   - Save up to 80% on compute costs

3. **Enable autoscaling**:
   - AKS clusters autoscale from min to max nodes
   - Azure ML compute clusters scale to 0 when idle

4. **Use reserved instances** (production only):
   - 1-year commitment: 40% savings
   - 3-year commitment: 60% savings

---

## Troubleshooting

### Issue: Deployment Fails with Quota Error

**Error**: `QuotaExceeded: Operation could not be completed as it results in exceeding approved quota`

**Solution**:
```bash
# Check current quota
az vm list-usage --location australiaeast --output table

# Request quota increase
az support tickets create \
  --ticket-name "GPU Quota Increase" \
  --severity "minimal" \
  --issue-type "quota"
```

### Issue: Unable to Access Key Vault

**Error**: `Access denied: caller does not have permission`

**Solution**:
```bash
# Add yourself as Key Vault Administrator
az role assignment create \
  --role "Key Vault Administrator" \
  --assignee "your-email@company.com" \
  --scope "/subscriptions/<sub-id>/resourceGroups/rg-myaiproj-prod/providers/Microsoft.KeyVault/vaults/kv-myaiproj-prod-abc123"
```

### Issue: AKS Pods Cannot Pull Images

**Error**: `ImagePullBackOff: failed to pull image`

**Solution**:
```bash
# Attach ACR to AKS
az aks update \
  --name "aks-myaiproj-prod" \
  --resource-group "rg-myaiproj-prod" \
  --attach-acr "crmyaiprojprodabc123"
```

### Issue: Azure ML Workspace Not Accessible

**Error**: `Workspace not found or access denied`

**Solution**:
```bash
# Update workspace to allow public access temporarily
az ml workspace update \
  --name "mlw-myaiproj-prod" \
  --resource-group "rg-myaiproj-prod" \
  --public-network-access Enabled

# Or configure private endpoint on your machine
# Follow: https://docs.microsoft.com/azure/machine-learning/how-to-configure-private-link
```

---

## Next Steps

### 1. Explore Use Case Templates

Browse industry-specific use cases:
- **Financial Services** (24 use cases): [financial-services-use-cases.md](../guides/industry-use-cases/financial-services-use-cases.md)
- **Energy & Mining** (25 use cases): [energy-mining-use-cases.md](../guides/industry-use-cases/energy-mining-use-cases.md)
- **Retail** (20 use cases): [retail-use-cases.md](../guides/industry-use-cases/retail-use-cases.md)
- **Defense** (16 use cases): [defense-use-cases.md](../guides/industry-use-cases/defense-use-cases.md)
- **Public Sector** (22 use cases): [public-sector-use-cases.md](../guides/industry-use-cases/public-sector-use-cases.md)

### 2. Set Up CI/CD Pipeline

Configure automated deployments:
- [MLOps/DevOps Complete Guide](../guides/mlops-devops-complete-guide.md)
- Azure DevOps YAML templates
- GitHub Actions workflows

### 3. Implement Governance

Establish organizational controls:
- [AI Center of Excellence Framework](../guides/ai-center-of-excellence-framework.md)
- [AI Scaling Patterns Guide](../guides/ai-scaling-patterns-guide.md)

### 4. Enable Model Monitoring

Monitor model performance and drift:
- [AI Model Risk Management Guide](../guides/ai-model-risk-management-guide.md)
- Implement drift detection
- Set up adversarial defenses

---

## Support

### Documentation
- **Main README**: [README.md](../README.md)
- **Full Infrastructure Guide**: [infrastructure/README.md](README.md)
- **3-Month Fast Track**: [3-month-fast-track-guide.md](../guides/3-month-fast-track-guide.md)

### Community
- **GitHub Issues**: [Report bugs or request features](https://github.com/andreaswasita/AI-Delivery-Methodology/issues)
- **Discussions**: [Ask questions and share ideas](https://github.com/andreaswasita/AI-Delivery-Methodology/discussions)

### Microsoft Resources
- **Azure Documentation**: https://docs.microsoft.com/azure
- **Azure ML Documentation**: https://docs.microsoft.com/azure/machine-learning
- **Azure OpenAI Service**: https://docs.microsoft.com/azure/cognitive-services/openai

---

## Estimated Costs by Environment

| Environment | Monthly Cost | Use Case |
|-------------|--------------|----------|
| **Development** | $1,500 - $3,000 | Prototyping, individual development |
| **Test** | $3,000 - $5,000 | Integration testing, team collaboration |
| **UAT** | $4,000 - $7,000 | Pre-production validation |
| **Production** | $10,000 - $25,000 | Live customer-facing services |

**Cost breakdown** (Production):
- Compute (AKS, VMs): 40-50%
- AI Services (Azure ML, OpenAI): 25-35%
- Data (Storage, SQL, Cosmos DB): 10-15%
- Networking (Firewall, DDoS): 5-10%
- Monitoring (Sentinel, Log Analytics): 5-10%

---

## License

This infrastructure is part of the AI Delivery Methodology, available under the MIT License.

Copyright (c) 2025 Microsoft Consulting Services
