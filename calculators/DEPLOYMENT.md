# Deploying AI Calculators to Azure

This guide explains how to deploy the AI calculators website to Azure Static Web Apps.

## 🚀 Quick Deploy (Recommended)

### Option 1: PowerShell Script (Fastest)

```powershell
# Navigate to the infrastructure scripts folder
cd infrastructure/scripts

# Run the deployment script
.\deploy-calculators.ps1

# Or with custom parameters
.\deploy-calculators.ps1 `
    -ResourceGroupName "rg-my-calculators" `
    -StaticWebAppName "swa-my-calculators" `
    -Location "eastus2" `
    -Sku "Free"
```

**That's it!** The script will:
- ✅ Check prerequisites (Azure CLI, SWA CLI)
- ✅ Create resource group if needed
- ✅ Deploy Static Web App using Bicep
- ✅ Upload calculator files
- ✅ Provide your live URL

---

## 📋 Prerequisites

Before deploying, ensure you have:

1. **Azure Subscription** - Active Azure subscription
2. **Azure CLI** - Install from https://aka.ms/installazurecli
3. **Node.js** (for SWA CLI) - Install from https://nodejs.org
4. **SWA CLI** - Will be installed automatically by script

---

## 🛠️ Manual Deployment

### Step 1: Install Prerequisites

```powershell
# Install Azure CLI (if not installed)
winget install Microsoft.AzureCLI

# Install SWA CLI
npm install -g @azure/static-web-apps-cli

# Login to Azure
az login
```

### Step 2: Create Static Web App

```powershell
# Set variables
$resourceGroup = "rg-ai-calculators"
$staticWebApp = "swa-ai-calculators"
$location = "eastus2"

# Create resource group
az group create --name $resourceGroup --location $location

# Deploy using Bicep
az deployment group create `
    --resource-group $resourceGroup `
    --template-file infrastructure/bicep/modules/static-web-app.bicep `
    --parameters `
        staticWebAppName=$staticWebApp `
        location=$location `
        sku="Free"

# Get deployment token
$token = az staticwebapp secrets list `
    --name $staticWebApp `
    --resource-group $resourceGroup `
    --query "properties.apiKey" `
    --output tsv
```

### Step 3: Deploy Content

```powershell
# Navigate to calculators folder
cd calculators

# Deploy to Azure
swa deploy . --deployment-token $token --env production
```

---

## 🔄 Automated Deployment (GitHub Actions)

For continuous deployment from GitHub:

### Step 1: Get Deployment Token

```powershell
az staticwebapp secrets list `
    --name swa-ai-calculators `
    --resource-group rg-ai-calculators `
    --query "properties.apiKey" `
    --output tsv
```

### Step 2: Add GitHub Secret

1. Go to your GitHub repository
2. Settings → Secrets and variables → Actions
3. Click "New repository secret"
4. Name: `AZURE_STATIC_WEB_APPS_API_TOKEN`
5. Value: [paste the token from Step 1]
6. Click "Add secret"

### Step 3: Push to Main Branch

The GitHub Action (`.github/workflows/deploy-calculators.yml`) will automatically deploy on every push to the `main` branch that changes files in the `calculators/` folder.

---

## 💰 Pricing

### Free Tier (Default)
- ✅ **Cost**: $0/month
- ✅ **Bandwidth**: 100 GB/month
- ✅ **Custom domains**: 2
- ✅ **SSL**: Automatic & free
- ✅ Perfect for calculators website

### Standard Tier (Optional)
- 💵 **Cost**: ~$9/month
- ✅ **Bandwidth**: 100 GB/month (more available)
- ✅ **Custom domains**: Unlimited
- ✅ **Authentication**: Advanced options
- ✅ **SLA**: 99.95%

---

## 🌐 Custom Domain (Optional)

### Add Custom Domain

```powershell
# Add custom domain
az staticwebapp hostname set `
    --name swa-ai-calculators `
    --resource-group rg-ai-calculators `
    --hostname "calculators.yourdomain.com"

# Validate domain
az staticwebapp hostname show `
    --name swa-ai-calculators `
    --resource-group rg-ai-calculators `
    --hostname "calculators.yourdomain.com"
```

### DNS Configuration

Add CNAME record to your DNS:
```
Type: CNAME
Name: calculators (or www)
Value: [your-static-web-app].azurestaticapps.net
TTL: 3600
```

SSL is automatic and free!

---

## 🧪 Testing

### Local Testing

```powershell
# Test locally before deploying
cd calculators
swa start . --port 8000

# Open browser
start http://localhost:8000
```

### Production Testing

After deployment, test your live site:
- Homepage: `https://[your-app].azurestaticapps.net`
- ROI Calculator: `https://[your-app].azurestaticapps.net/roi-calculator.html`

---

## 📊 Monitoring

### View Deployment Logs

```powershell
# List deployments
az staticwebapp show `
    --name swa-ai-calculators `
    --resource-group rg-ai-calculators

# View in Azure Portal
az staticwebapp browse `
    --name swa-ai-calculators `
    --resource-group rg-ai-calculators
```

### Usage Analytics

Enable Application Insights for detailed analytics:

```powershell
az monitor app-insights component create `
    --app swa-ai-calculators-insights `
    --location eastus2 `
    --resource-group rg-ai-calculators

# Link to Static Web App
az staticwebapp appsettings set `
    --name swa-ai-calculators `
    --resource-group rg-ai-calculators `
    --setting-names APPINSIGHTS_INSTRUMENTATIONKEY=[key]
```

---

## 🗑️ Cleanup

To delete all resources:

```powershell
# Delete resource group (removes everything)
az group delete --name rg-ai-calculators --yes --no-wait
```

---

## 🔧 Troubleshooting

### Issue: "az command not found"
**Solution**: Install Azure CLI:
```powershell
winget install Microsoft.AzureCLI
```

### Issue: "swa command not found"
**Solution**: Install SWA CLI:
```powershell
npm install -g @azure/static-web-apps-cli
```

### Issue: Deployment fails with 404
**Solution**: Check `staticwebapp.config.json` is in the calculators folder

### Issue: CSS/JS not loading
**Solution**: Verify paths in `staticwebapp.config.json` and ensure files exist

---

## 📚 Additional Resources

- [Azure Static Web Apps Documentation](https://learn.microsoft.com/azure/static-web-apps/)
- [SWA CLI Documentation](https://azure.github.io/static-web-apps-cli/)
- [Custom Domain Setup](https://learn.microsoft.com/azure/static-web-apps/custom-domain)
- [Authentication Setup](https://learn.microsoft.com/azure/static-web-apps/authentication-authorization)

---

## 🆘 Support

For issues or questions:
1. Check this documentation
2. Review Azure Static Web Apps docs
3. Check GitHub Actions logs (if using CI/CD)
4. Open an issue in this repository

---

**Last Updated**: January 13, 2026
