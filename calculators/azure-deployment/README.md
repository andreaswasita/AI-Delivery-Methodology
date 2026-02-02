# Azure Deployment Guide - Secure Chatbot Architecture

## 🎯 Overview

This guide shows how to deploy the Value Analysis Chatbot to Azure with proper security:
- ✅ API keys stored server-side (Azure Key Vault)
- ✅ Server-side API calls (no CORS issues)
- ✅ No exposed credentials in browser
- ✅ Optional authentication via Azure AD
- ✅ Scalable and production-ready

## 🏗️ Architecture Options

### Option 1: Azure Static Web Apps + Functions (Recommended)

**Best for:** Serverless, cost-effective, easy deployment

```
Static HTML/CSS/JS → Azure Functions → Anthropic API
                      (stores API key)
```

**Cost:** ~$0-9/month (free tier available)

### Option 2: Azure App Service

**Best for:** Traditional server apps, more control

```
Node.js/Python App → Server-side routes → Anthropic API
                     (stores API key)
```

**Cost:** ~$13-55/month (Basic tier)

### Option 3: Iframe Hybrid Approach

**Best for:** Keep GitHub Pages, only dynamic chatbot in Azure

```
GitHub Pages (static) → <iframe> → Azure App (dynamic chatbot)
                                    (handles API securely)
```

**Cost:** Same as Option 1 or 2

#### Detailed Architecture Diagram

```
┌─────────────────────────────────────────────────────────────┐
│  GitHub Pages (Static Content)                              │
│  - HTML, CSS, JS                                            │
│  - Public landing pages                                     │
│                                                             │
│  ┌───────────────────────────────────────────┐            │
│  │  <iframe> to Azure Dynamic Content        │            │
│  └───────────────────────────────────────────┘            │
└─────────────────────────────────────────────────────────────┘
                         │
                         │ HTTPS
                         ▼
┌─────────────────────────────────────────────────────────────┐
│  Azure Static Web Apps (or App Service)                     │
│  - Server-side API calls                                    │
│  - API key stored in Azure Key Vault                       │
│  - Authentication via Azure AD (optional)                   │
│                                                             │
│  ┌────────────────┐                                        │
│  │ Azure Function │ ──────────────┐                       │
│  │ (Node.js/C#)   │               │                       │
│  └────────────────┘               │                       │
│                                    ▼                       │
│                            ┌──────────────┐               │
│                            │ Azure Key    │               │
│                            │ Vault        │               │
│                            │ (API Keys)   │               │
│                            └──────────────┘               │
└─────────────────────────────────────────────────────────────┘
                         │
                         │ Server-to-Server (Secure)
                         ▼
                  ┌──────────────────┐
                  │ Anthropic API    │
                  └──────────────────┘
```

**Key Benefits:**
- ✅ API keys never exposed to client browser
- ✅ Server-to-server communication is secure
- ✅ GitHub Pages handles static content (free)
- ✅ Azure handles dynamic/secure operations
- ✅ Optional Azure AD authentication for enterprise

---

## 📦 Option 1: Azure Static Web Apps + Functions (RECOMMENDED)

### Step 1: Prepare the Project

```bash
cd calculators/azure-deployment
```

### Step 2: Deploy to Azure

```bash
# Install Azure CLI
# https://learn.microsoft.com/en-us/cli/azure/install-azure-cli

# Login
az login

# Create resource group
az group create --name rg-ai-delivery-chatbot --location eastus

# Deploy Static Web App (this will set up CI/CD from GitHub)
az staticwebapp create \
  --name swa-ai-delivery-chatbot \
  --resource-group rg-ai-delivery-chatbot \
  --source https://github.com/andreaswasita/AI-Delivery-Methodology \
  --location eastus2 \
  --branch main \
  --app-location "/calculators/azure-deployment/app" \
  --api-location "/calculators/azure-deployment/api" \
  --output-location ""
```

### Step 3: Configure API Key in Azure

```bash
# Create Key Vault
az keyvault create \
  --name kv-ai-chatbot-$(date +%s) \
  --resource-group rg-ai-delivery-chatbot \
  --location eastus

# Store Anthropic API key
az keyvault secret set \
  --vault-name kv-ai-chatbot-XXXXX \
  --name anthropic-api-key \
  --value "sk-ant-your-key-here"

# Grant Static Web App access to Key Vault
az keyvault set-policy \
  --name kv-ai-chatbot-XXXXX \
  --object-id <your-swa-principal-id> \
  --secret-permissions get
```

### Step 4: Configure Application Settings

In Azure Portal:
1. Go to your Static Web App
2. Settings → Configuration
3. Add Application Setting:
   - `KEY_VAULT_URL`: Your Key Vault URL
   - Or directly: `ANTHROPIC_API_KEY`: Your API key (less secure)

### Step 5: Test the Deployment

Your chatbot will be available at:
```
https://<your-swa-name>.azurestaticapps.net
```

---

## 📦 Option 2: Azure App Service (Node.js)

### Step 1: Create App Service

```bash
# Create App Service Plan
az appservice plan create \
  --name plan-ai-chatbot \
  --resource-group rg-ai-delivery-chatbot \
  --sku B1 \
  --is-linux

# Create Web App
az webapp create \
  --name app-ai-delivery-chatbot \
  --resource-group rg-ai-delivery-chatbot \
  --plan plan-ai-chatbot \
  --runtime "NODE:18-lts"
```

### Step 2: Configure App Settings

```bash
# Add API key as environment variable
az webapp config appsettings set \
  --name app-ai-delivery-chatbot \
  --resource-group rg-ai-delivery-chatbot \
  --settings ANTHROPIC_API_KEY="sk-ant-your-key"
```

### Step 3: Deploy Code

```bash
cd calculators/azure-deployment/app-service
zip -r deploy.zip .
az webapp deployment source config-zip \
  --name app-ai-delivery-chatbot \
  --resource-group rg-ai-delivery-chatbot \
  --src deploy.zip
```

---

## 📦 Option 3: Iframe Hybrid (Keep GitHub Pages)

### Architecture

```html
<!-- On GitHub Pages: index.html -->
<iframe 
  src="https://your-chatbot.azurewebsites.net" 
  width="100%" 
  height="800px"
  frameborder="0"
  sandbox="allow-scripts allow-same-origin allow-forms">
</iframe>
```

### Steps

1. Deploy chatbot to Azure using Option 1 or 2
2. Update your GitHub Pages HTML to embed the Azure URL
3. Configure CORS on Azure to allow your GitHub Pages domain

```bash
# Configure CORS
az webapp cors add \
  --name app-ai-delivery-chatbot \
  --resource-group rg-ai-delivery-chatbot \
  --allowed-origins "https://andreaswasita.github.io"
```

---

## 🔒 Security Best Practices

### 1. Use Azure Key Vault (Production)

```javascript
// In Azure Function
const { SecretClient } = require("@azure/keyvault-secrets");
const { DefaultAzureCredential } = require("@azure/identity");

const credential = new DefaultAzureCredential();
const vaultUrl = process.env.KEY_VAULT_URL;
const client = new SecretClient(vaultUrl, credential);

const secret = await client.getSecret("anthropic-api-key");
const apiKey = secret.value;
```

### 2. Add Authentication (Optional)

```bash
# Enable Azure AD authentication
az staticwebapp config authentication show \
  --name swa-ai-delivery-chatbot
```

### 3. Rate Limiting

```javascript
// In Azure Function
const rateLimit = require('express-rate-limit');

const limiter = rateLimit({
  windowMs: 15 * 60 * 1000, // 15 minutes
  max: 100 // limit each IP to 100 requests per windowMs
});
```

### 4. API Management (Enterprise)

For enterprise deployments, add Azure API Management:

```bash
az apim create \
  --name apim-ai-chatbot \
  --resource-group rg-ai-delivery-chatbot \
  --publisher-email admin@yourdomain.com \
  --publisher-name "Your Company"
```

---

## 💰 Cost Estimates

| Service | Tier | Monthly Cost |
|---------|------|--------------|
| Static Web Apps | Free | $0 |
| Static Web Apps | Standard | $9 |
| App Service | B1 (Basic) | $13 |
| App Service | P1v2 (Premium) | $73 |
| Key Vault | Standard | $0.03/10K operations |
| APIM | Developer | $50 |
| APIM | Standard | $675 |

**Recommended for MVP:** Static Web Apps Free Tier = **$0/month**

---

## 🚀 Quick Start (5 minutes)

```bash
# 1. Clone and navigate
cd calculators/azure-deployment

# 2. Login to Azure
az login

# 3. Run deployment script
./deploy.sh

# 4. Follow prompts to enter your API key
```

---

## 📋 Next Steps

1. Choose your deployment option (Option 1 recommended)
2. Follow the step-by-step guide above
3. Configure your API key securely
4. Test the deployed chatbot
5. Update your GitHub Pages to link/embed the Azure-hosted chatbot

---

## 🆘 Troubleshooting

**Error: Function not executing**
- Check Application Settings in Azure Portal
- Verify API key is set correctly
- Review Function logs in Azure Portal

**Error: CORS issues**
- Configure CORS in Azure Portal
- Add your domain to allowed origins

**Error: 500 Internal Server Error**
- Check Azure Function logs
- Verify API key format (starts with sk-ant-)
- Ensure sufficient API credits at Anthropic

---

## 📚 Additional Resources

- [Azure Static Web Apps Docs](https://learn.microsoft.com/en-us/azure/static-web-apps/)
- [Azure Functions Docs](https://learn.microsoft.com/en-us/azure/azure-functions/)
- [Azure Key Vault Docs](https://learn.microsoft.com/en-us/azure/key-vault/)
- [Anthropic API Docs](https://docs.anthropic.com/)
