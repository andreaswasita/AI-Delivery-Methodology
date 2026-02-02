# Azure Dev Environment - Quick Setup (15 Minutes)

Get a lightweight Azure environment for hackathons - faster than full landing zone deployment.

## 🎯 What You Get

- Azure Machine Learning Workspace
- Compute Instance (for Jupyter notebooks)
- Azure OpenAI Service
- Storage Account (for datasets)
- Basic security (managed identity, private networking optional)

**Cost**: ~$50-100 for 3-day hackathon

---

## Option 1: One-Click Azure Portal Deployment ⚡ (Easiest)

Click this button to deploy:

[![Deploy to Azure](https://aka.ms/deploytoazurebutton)](https://portal.azure.com/#create/Microsoft.Template/uri/https%3A%2F%2Fraw.githubusercontent.com%2Fandreaswasita%2FAI-Delivery-Methodology%2Fmain%2Fhackathons%2Fazure-dev-template.json)

**Parameters to configure:**
- **Workspace Name**: `hackathon-workspace`
- **Location**: `australiaeast` or your preferred region
- **Compute Size**: `Standard_DS3_v2` (sufficient for most hackathons)
- **Enable OpenAI**: `Yes`

**Duration**: ~10-15 minutes

---

## Option 2: Azure CLI Deployment 🖥️ (For Automation)

```bash
# 1. Login and set subscription
az login
az account set --subscription "Your-Subscription-Name"

# 2. Create resource group
az group create \
    --name rg-hackathon \
    --location australiaeast

# 3. Deploy Azure ML Workspace
az ml workspace create \
    --name hackathon-workspace \
    --resource-group rg-hackathon \
    --location australiaeast

# 4. Create compute instance
az ml compute create \
    --name hackathon-compute \
    --size Standard_DS3_v2 \
    --type ComputeInstance \
    --resource-group rg-hackathon \
    --workspace-name hackathon-workspace

# 5. Create storage account
az storage account create \
    --name hackathonstorage123 \
    --resource-group rg-hackathon \
    --location australiaeast \
    --sku Standard_LRS

# 6. Request Azure OpenAI access (if not already approved)
# Fill form: https://aka.ms/oai/access

# 7. Create Azure OpenAI resource
az cognitiveservices account create \
    --name hackathon-openai \
    --resource-group rg-hackathon \
    --kind OpenAI \
    --sku S0 \
    --location australiaeast

# 8. Deploy GPT-4 model
az cognitiveservices account deployment create \
    --name hackathon-openai \
    --resource-group rg-hackathon \
    --deployment-name gpt-4 \
    --model-name gpt-4 \
    --model-version "0613" \
    --model-format OpenAI \
    --sku-capacity 10 \
    --sku-name "Standard"
```

---

## Option 3: PowerShell Script 🔧

Save this as `setup-hackathon-env.ps1`:

```powershell
param(
    [string]$ResourceGroup = "rg-hackathon",
    [string]$Location = "australiaeast",
    [string]$WorkspaceName = "hackathon-workspace"
)

# Login
Write-Host "🔐 Logging in to Azure..." -ForegroundColor Cyan
az login

# Create resource group
Write-Host "📦 Creating resource group..." -ForegroundColor Cyan
az group create --name $ResourceGroup --location $Location

# Create ML workspace
Write-Host "🤖 Creating Azure ML workspace..." -ForegroundColor Cyan
az ml workspace create `
    --name $WorkspaceName `
    --resource-group $ResourceGroup `
    --location $Location

# Create compute
Write-Host "💻 Creating compute instance..." -ForegroundColor Cyan
az ml compute create `
    --name "hackathon-compute" `
    --size Standard_DS3_v2 `
    --type ComputeInstance `
    --resource-group $ResourceGroup `
    --workspace-name $WorkspaceName

# Create storage
Write-Host "💾 Creating storage account..." -ForegroundColor Cyan
$storageAccountName = "hackathon" + (Get-Random -Maximum 9999)
az storage account create `
    --name $storageAccountName `
    --resource-group $ResourceGroup `
    --location $Location `
    --sku Standard_LRS

Write-Host "✅ Setup complete!" -ForegroundColor Green
Write-Host "🌐 Access your workspace at: https://ml.azure.com"
Write-Host "📊 Workspace: $WorkspaceName"
Write-Host "💾 Storage: $storageAccountName"
```

Run with:
```powershell
./setup-hackathon-env.ps1 -ResourceGroup "rg-hackathon" -Location "australiaeast"
```

---

## 📝 Post-Deployment Configuration

### 1. Access Your Workspace

```bash
# Get workspace details
az ml workspace show \
    --name hackathon-workspace \
    --resource-group rg-hackathon

# Or visit Azure ML Studio
open https://ml.azure.com
```

### 2. Upload Sample Notebooks

```bash
# Clone this repository
git clone https://github.com/andreaswasita/AI-Delivery-Methodology.git

# Upload notebooks to Azure ML
az ml job create \
    --file notebooks/01-document-analysis-quickstart.ipynb \
    --workspace-name hackathon-workspace \
    --resource-group rg-hackathon
```

### 3. Configure Environment Variables

Create a `.env` file in your notebook:

```python
# .env file
AZURE_OPENAI_ENDPOINT=https://hackathon-openai.openai.azure.com/
AZURE_OPENAI_KEY=your-key-here
AZURE_STORAGE_CONNECTION_STRING=your-connection-string
```

Get your keys:
```bash
# OpenAI key
az cognitiveservices account keys list \
    --name hackathon-openai \
    --resource-group rg-hackathon

# Storage connection string
az storage account show-connection-string \
    --name hackathonstorage123 \
    --resource-group rg-hackathon
```

---

## 🔐 Share Access with Hackathon Teams

### Option A: Azure Portal (Easiest)

1. Go to Resource Group → Access control (IAM)
2. Add role assignment
3. Select "Contributor" role
4. Add team members by email

### Option B: Azure CLI (Bulk)

```bash
# Create service principal for team
az ad sp create-for-rbac \
    --name "hackathon-team-1" \
    --role Contributor \
    --scopes /subscriptions/{subscription-id}/resourceGroups/rg-hackathon

# Output will contain credentials to share
```

### Option C: Managed Identity (Most Secure)

```bash
# Create user-assigned managed identity
az identity create \
    --name hackathon-identity \
    --resource-group rg-hackathon

# Assign to compute
az ml compute update \
    --name hackathon-compute \
    --resource-group rg-hackathon \
    --workspace-name hackathon-workspace \
    --assign-identity hackathon-identity
```

---

## 📊 Monitor Costs During Hackathon

```bash
# Set up cost alert
az consumption budget create \
    --budget-name hackathon-budget \
    --amount 500 \
    --time-grain Monthly \
    --start-date 2026-02-01 \
    --resource-group rg-hackathon \
    --notifications threshold=80 contactEmails='["admin@company.com"]'

# Check current spending
az consumption usage list \
    --resource-group rg-hackathon \
    --start-date 2026-02-01 \
    --end-date 2026-02-04
```

---

## 🧹 Cleanup After Hackathon

**Important**: Delete resources to stop charges!

```bash
# Option 1: Delete entire resource group
az group delete --name rg-hackathon --yes --no-wait

# Option 2: Keep workspace, delete compute only
az ml compute delete \
    --name hackathon-compute \
    --resource-group rg-hackathon \
    --workspace-name hackathon-workspace
```

---

## 🚀 Next Steps

1. **Access your workspace**: https://ml.azure.com
2. **Start compute instance**: Takes ~3 minutes
3. **Open Jupyter**: Click "Notebooks" → "Launch Jupyter"
4. **Clone sample notebooks**: From our hackathons/notebooks folder
5. **Start building!** 🎉

---

## 🆘 Troubleshooting

### Compute won't start
```bash
# Check compute status
az ml compute show \
    --name hackathon-compute \
    --resource-group rg-hackathon \
    --workspace-name hackathon-workspace

# Restart if needed
az ml compute restart \
    --name hackathon-compute \
    --resource-group rg-hackathon \
    --workspace-name hackathon-workspace
```

### OpenAI quota issues
```bash
# Check available quota
az cognitiveservices account list-skus \
    --name hackathon-openai \
    --resource-group rg-hackathon

# Request quota increase
# Visit: https://portal.azure.com → OpenAI resource → Quotas
```

### Permission denied
```bash
# Verify your role
az role assignment list \
    --assignee your-email@company.com \
    --resource-group rg-hackathon
```

---

## 💡 Pro Tips

1. **Pre-warm compute**: Start instances 30 min before hackathon
2. **Load balance**: Use multiple compute instances for large teams
3. **Cache embeddings**: Store in Azure Redis to reduce API calls
4. **Version control**: Use Git integration in Azure ML
5. **Monitor usage**: Set up Application Insights for debugging

---

**Estimated Costs for 3-Day Hackathon:**

| Resource | Configuration | Cost |
|----------|--------------|------|
| **Compute Instance** | Standard_DS3_v2, 72 hours | ~$15 |
| **Azure OpenAI** | 1M tokens (GPT-4) | ~$30 |
| **Storage** | 100GB data | ~$2 |
| **Azure ML Workspace** | Basic tier | $0 |
| **Networking** | Standard | ~$3 |
| **Total** | | **~$50** |

**Want full production setup?** Use our [AI Landing Zone deployment](../deploy-landing-zone.html) instead.
