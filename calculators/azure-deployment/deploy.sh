#!/bin/bash

# Azure Deployment Script for AI Delivery Chatbot
# This script deploys the chatbot to Azure Static Web Apps with secure API backend

set -e  # Exit on error

echo "=========================================="
echo "  Azure AI Delivery Chatbot Deployment"
echo "=========================================="
echo ""

# Configuration
RESOURCE_GROUP="rg-ai-delivery-chatbot"
LOCATION="eastus"
STATIC_WEB_APP_NAME="swa-ai-delivery-chatbot-$RANDOM"
KEY_VAULT_NAME="kv-ai-chatbot-$RANDOM"

# Colors
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m' # No Color

# Check if Azure CLI is installed
if ! command -v az &> /dev/null; then
    echo -e "${RED}❌ Azure CLI is not installed${NC}"
    echo "Install from: https://learn.microsoft.com/en-us/cli/azure/install-azure-cli"
    exit 1
fi

echo -e "${GREEN}✅ Azure CLI found${NC}"

# Check if logged in
echo -e "\n${YELLOW}Checking Azure login status...${NC}"
if ! az account show &> /dev/null; then
    echo -e "${YELLOW}Please login to Azure:${NC}"
    az login
fi

SUBSCRIPTION=$(az account show --query name -o tsv)
echo -e "${GREEN}✅ Logged in to subscription: $SUBSCRIPTION${NC}"

# Prompt for API key
echo -e "\n${YELLOW}📝 Enter your Anthropic API key:${NC}"
read -s ANTHROPIC_API_KEY
echo ""

if [[ ! $ANTHROPIC_API_KEY =~ ^sk-ant- ]]; then
    echo -e "${RED}❌ Invalid API key format. Should start with 'sk-ant-'${NC}"
    exit 1
fi

# Create resource group
echo -e "\n${YELLOW}📦 Creating resource group: $RESOURCE_GROUP${NC}"
az group create \
  --name $RESOURCE_GROUP \
  --location $LOCATION \
  --output none

echo -e "${GREEN}✅ Resource group created${NC}"

# Create Static Web App
echo -e "\n${YELLOW}🌐 Creating Static Web App: $STATIC_WEB_APP_NAME${NC}"
echo "This may take a few minutes..."

az staticwebapp create \
  --name $STATIC_WEB_APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --location $LOCATION \
  --output none

echo -e "${GREEN}✅ Static Web App created${NC}"

# Get Static Web App URL
SWA_URL=$(az staticwebapp show \
  --name $STATIC_WEB_APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --query defaultHostname -o tsv)

echo -e "${GREEN}🌐 Your chatbot URL: https://$SWA_URL${NC}"

# Configure API key as application setting
echo -e "\n${YELLOW}🔐 Configuring API key...${NC}"
az staticwebapp appsettings set \
  --name $STATIC_WEB_APP_NAME \
  --resource-group $RESOURCE_GROUP \
  --setting-names ANTHROPIC_API_KEY="$ANTHROPIC_API_KEY" \
  --output none

echo -e "${GREEN}✅ API key configured${NC}"

# Optional: Create Key Vault for enhanced security
read -p "$(echo -e ${YELLOW}🔒 Do you want to create an Azure Key Vault for enhanced security? \(y/n\) ${NC})" -n 1 -r
echo
if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "\n${YELLOW}🔐 Creating Key Vault: $KEY_VAULT_NAME${NC}"
    
    az keyvault create \
      --name $KEY_VAULT_NAME \
      --resource-group $RESOURCE_GROUP \
      --location $LOCATION \
      --output none
    
    echo -e "${GREEN}✅ Key Vault created${NC}"
    
    echo -e "\n${YELLOW}Storing API key in Key Vault...${NC}"
    az keyvault secret set \
      --vault-name $KEY_VAULT_NAME \
      --name anthropic-api-key \
      --value "$ANTHROPIC_API_KEY" \
      --output none
    
    echo -e "${GREEN}✅ API key stored in Key Vault${NC}"
    echo -e "${YELLOW}💡 Update your Function to use Key Vault instead of app settings${NC}"
fi

# Summary
echo ""
echo "=========================================="
echo -e "  ${GREEN}✅ Deployment Complete!${NC}"
echo "=========================================="
echo ""
echo -e "${GREEN}🌐 Chatbot URL:${NC} https://$SWA_URL"
echo -e "${GREEN}📦 Resource Group:${NC} $RESOURCE_GROUP"
echo -e "${GREEN}🔧 Static Web App:${NC} $STATIC_WEB_APP_NAME"

if [[ $REPLY =~ ^[Yy]$ ]]; then
    echo -e "${GREEN}🔐 Key Vault:${NC} $KEY_VAULT_NAME"
fi

echo ""
echo -e "${YELLOW}📋 Next Steps:${NC}"
echo "1. Deploy your code using GitHub Actions or Azure CLI"
echo "2. Visit https://$SWA_URL to test your chatbot"
echo "3. Configure custom domain (optional)"
echo "4. Set up monitoring and alerts"
echo ""
echo -e "${YELLOW}📚 Documentation:${NC}"
echo "See calculators/azure-deployment/README.md for detailed guides"
echo ""
