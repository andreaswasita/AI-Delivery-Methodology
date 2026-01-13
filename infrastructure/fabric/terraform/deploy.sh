#!/bin/bash
#
# Quick deployment script for Terraform-based Fabric Landing Zone
# This script provides a streamlined deployment experience
#

set -e

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m'

echo -e "${CYAN}╔══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║     Terraform Fabric Landing Zone - Quick Deploy                    ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Check prerequisites
echo -e "${YELLOW}🔍 Checking prerequisites...${NC}"

if ! command -v terraform &> /dev/null; then
    echo -e "${RED}❌ Terraform not found. Please install Terraform 1.5+${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Terraform installed: $(terraform version -json | jq -r '.terraform_version')${NC}"

if ! command -v az &> /dev/null; then
    echo -e "${RED}❌ Azure CLI not found. Please install Azure CLI${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Azure CLI installed${NC}"

# Select environment
echo ""
echo -e "${CYAN}Select deployment environment:${NC}"
echo "  1) Development (F8, minimal security)"
echo "  2) Production (F64, full security)"
echo "  3) Healthcare/HIPAA (F128, HIPAA compliance)"
echo "  4) Financial Services (F256, APRA CPS 234)"
echo "  5) Retail/PCI-DSS (F64, PCI-DSS compliance)"
echo "  6) Custom (use your own tfvars file)"
echo ""
read -p "Enter choice [1-6]: " ENV_CHOICE

case $ENV_CHOICE in
    1)
        TFVARS_FILE="environments/dev.tfvars"
        ENV_NAME="Development"
        ;;
    2)
        TFVARS_FILE="environments/prod.tfvars"
        ENV_NAME="Production"
        ;;
    3)
        TFVARS_FILE="environments/healthcare-hipaa.tfvars"
        ENV_NAME="Healthcare/HIPAA"
        ;;
    4)
        TFVARS_FILE="environments/financial-services.tfvars"
        ENV_NAME="Financial Services"
        ;;
    5)
        TFVARS_FILE="environments/retail-pci.tfvars"
        ENV_NAME="Retail/PCI-DSS"
        ;;
    6)
        read -p "Enter path to your tfvars file: " TFVARS_FILE
        ENV_NAME="Custom"
        ;;
    *)
        echo -e "${RED}Invalid choice${NC}"
        exit 1
        ;;
esac

if [ ! -f "$TFVARS_FILE" ]; then
    echo -e "${RED}❌ File not found: $TFVARS_FILE${NC}"
    exit 1
fi

echo -e "${GREEN}✅ Using configuration: $ENV_NAME ($TFVARS_FILE)${NC}"

# Authenticate to Azure
echo ""
echo -e "${YELLOW}🔐 Checking Azure authentication...${NC}"
ACCOUNT_NAME=$(az account show --query user.name -o tsv 2>/dev/null || echo "")
if [ -z "$ACCOUNT_NAME" ]; then
    echo -e "${YELLOW}Not authenticated. Logging in...${NC}"
    az login
fi
SUBSCRIPTION_NAME=$(az account show --query name -o tsv)
echo -e "${GREEN}✅ Authenticated to: $SUBSCRIPTION_NAME${NC}"

# Initialize Terraform
echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}Step 1: Terraform Init${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
terraform init -upgrade

# Validate configuration
echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}Step 2: Terraform Validate${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
terraform validate

# Plan deployment
echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}Step 3: Terraform Plan${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
terraform plan -var-file="$TFVARS_FILE" -out=tfplan

# Review and confirm
echo ""
echo -e "${YELLOW}📋 Review the plan above carefully.${NC}"
read -p "Proceed with deployment? (yes/no): " CONFIRM

if [ "$CONFIRM" != "yes" ]; then
    echo -e "${RED}❌ Deployment cancelled${NC}"
    rm -f tfplan
    exit 0
fi

# Apply deployment
echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}Step 4: Terraform Apply${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
terraform apply tfplan

# Clean up plan file
rm -f tfplan

# Display outputs
echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                    DEPLOYMENT COMPLETED                              ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${CYAN}📊 Deployment Summary:${NC}"
terraform output -json deployment_summary | jq -r 'to_entries | .[] | "\(.key): \(.value)"'

echo ""
echo -e "${YELLOW}🎯 Next Steps:${NC}"
terraform output -raw next_steps

echo ""
echo -e "${YELLOW}💰 Cost Estimate:${NC}"
echo "   Estimated Monthly Cost: $(terraform output -raw estimated_monthly_cost_usd) USD"

echo ""
echo -e "${GREEN}✅ Deployment completed successfully!${NC}"
echo ""
