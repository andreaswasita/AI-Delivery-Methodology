#!/bin/bash
#
# Deploy Microsoft Fabric Landing Zone using Azure CLI
# This script provides a Bash/Linux alternative to the PowerShell deployment
#

set -e  # Exit on error

# Colors for output
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
NC='\033[0m' # No Color

# Script version
SCRIPT_VERSION="1.0.0"

echo -e "${CYAN}╔══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${CYAN}║     Microsoft Fabric Landing Zone Deployment Script v${SCRIPT_VERSION}       ║${NC}"
echo -e "${CYAN}║     Bash/Azure CLI Version (Linux/macOS/WSL)                         ║${NC}"
echo -e "${CYAN}╚══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

# Parse command line arguments
CAPACITY_NAME=""
CAPACITY_SKU="F64"
REGION="australiaeast"
WORKSPACE_PREFIX=""
COMPLIANCE_PROFILE="GDPR"
ENABLE_PRIVATE_LINK=false
ENABLE_CMK=false
LOG_RETENTION_DAYS=365
MONTHLY_BUDGET=5000

usage() {
    echo "Usage: $0 [OPTIONS]"
    echo ""
    echo "Options:"
    echo "  --capacity-name NAME          Fabric capacity name (required)"
    echo "  --capacity-sku SKU            Capacity SKU (default: F64)"
    echo "  --region REGION               Azure region (default: australiaeast)"
    echo "  --workspace-prefix PREFIX     Workspace prefix (required)"
    echo "  --compliance PROFILE          Compliance profile (default: GDPR)"
    echo "  --enable-private-link         Enable Private Link"
    echo "  --enable-cmk                  Enable customer-managed keys"
    echo "  --log-retention DAYS          Log retention days (default: 365)"
    echo "  --budget AMOUNT               Monthly budget USD (default: 5000)"
    echo "  --help                        Show this help message"
    echo ""
    echo "Example:"
    echo "  $0 --capacity-name fabric-ai-prod --capacity-sku F64 \\"
    echo "     --region australiaeast --workspace-prefix ai-platform \\"
    echo "     --compliance FinancialServices --enable-private-link"
    exit 0
}

# Parse arguments
while [[ $# -gt 0 ]]; do
    case $1 in
        --capacity-name)
            CAPACITY_NAME="$2"
            shift 2
            ;;
        --capacity-sku)
            CAPACITY_SKU="$2"
            shift 2
            ;;
        --region)
            REGION="$2"
            shift 2
            ;;
        --workspace-prefix)
            WORKSPACE_PREFIX="$2"
            shift 2
            ;;
        --compliance)
            COMPLIANCE_PROFILE="$2"
            shift 2
            ;;
        --enable-private-link)
            ENABLE_PRIVATE_LINK=true
            shift
            ;;
        --enable-cmk)
            ENABLE_CMK=true
            shift
            ;;
        --log-retention)
            LOG_RETENTION_DAYS="$2"
            shift 2
            ;;
        --budget)
            MONTHLY_BUDGET="$2"
            shift 2
            ;;
        --help)
            usage
            ;;
        *)
            echo -e "${RED}Unknown option: $1${NC}"
            usage
            ;;
    esac
done

# Validate required parameters
if [ -z "$CAPACITY_NAME" ] || [ -z "$WORKSPACE_PREFIX" ]; then
    echo -e "${RED}Error: --capacity-name and --workspace-prefix are required${NC}"
    usage
fi

# ============================================================================
# PREREQUISITES CHECK
# ============================================================================

echo -e "${YELLOW}🔍 Checking prerequisites...${NC}"

# Check Azure CLI
if ! command -v az &> /dev/null; then
    echo -e "${RED}❌ Azure CLI not found. Please install: https://docs.microsoft.com/cli/azure/install-azure-cli${NC}"
    exit 1
fi
echo -e "${GREEN}✅ Azure CLI installed: $(az version --query '"azure-cli"' -o tsv)${NC}"

# Check jq for JSON processing
if ! command -v jq &> /dev/null; then
    echo -e "${YELLOW}⚠️  jq not found. Installing...${NC}"
    if [[ "$OSTYPE" == "linux-gnu"* ]]; then
        sudo apt-get update && sudo apt-get install -y jq
    elif [[ "$OSTYPE" == "darwin"* ]]; then
        brew install jq
    fi
fi

# ============================================================================
# AZURE AUTHENTICATION
# ============================================================================

echo ""
echo -e "${YELLOW}🔐 Checking Azure authentication...${NC}"

ACCOUNT_NAME=$(az account show --query user.name -o tsv 2>/dev/null)
if [ -z "$ACCOUNT_NAME" ]; then
    echo -e "${YELLOW}Not authenticated. Logging in...${NC}"
    az login
fi

SUBSCRIPTION_NAME=$(az account show --query name -o tsv)
SUBSCRIPTION_ID=$(az account show --query id -o tsv)
echo -e "${GREEN}✅ Authenticated to subscription: $SUBSCRIPTION_NAME${NC}"
echo -e "${GREEN}✅ Account: $ACCOUNT_NAME${NC}"

# ============================================================================
# VALIDATE FABRIC PROVIDER
# ============================================================================

echo ""
echo -e "${YELLOW}🔍 Validating Fabric provider registration...${NC}"

PROVIDER_STATE=$(az provider show -n Microsoft.Fabric --query registrationState -o tsv 2>/dev/null || echo "NotRegistered")

if [ "$PROVIDER_STATE" != "Registered" ]; then
    echo -e "${YELLOW}⚠️  Microsoft.Fabric provider not registered. Registering...${NC}"
    az provider register --namespace Microsoft.Fabric
    
    # Wait for registration
    echo -e "${YELLOW}⏳ Waiting for provider registration...${NC}"
    while [ "$(az provider show -n Microsoft.Fabric --query registrationState -o tsv)" != "Registered" ]; do
        sleep 10
        echo -e "${YELLOW}   Still waiting...${NC}"
    done
    echo -e "${GREEN}✅ Microsoft.Fabric provider registered${NC}"
else
    echo -e "${GREEN}✅ Microsoft.Fabric provider already registered${NC}"
fi

# ============================================================================
# CONFIGURATION SUMMARY
# ============================================================================

# Calculate estimated cost
case $CAPACITY_SKU in
    F2) MONTHLY_COST=262 ;;
    F4) MONTHLY_COST=524 ;;
    F8) MONTHLY_COST=1048 ;;
    F16) MONTHLY_COST=2096 ;;
    F32) MONTHLY_COST=4192 ;;
    F64) MONTHLY_COST=8384 ;;
    F128) MONTHLY_COST=16768 ;;
    F256) MONTHLY_COST=33536 ;;
    F512) MONTHLY_COST=67072 ;;
    F1024) MONTHLY_COST=134144 ;;
    F2048) MONTHLY_COST=268288 ;;
    *) MONTHLY_COST=0 ;;
esac

echo ""
echo -e "${CYAN}📋 Deployment Configuration:${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "  Capacity Name:              $CAPACITY_NAME"
echo -e "  Capacity SKU:               $CAPACITY_SKU"
echo -e "  Region:                     $REGION"
echo -e "  Workspace Prefix:           $WORKSPACE_PREFIX"
echo -e "  Compliance Profile:         $COMPLIANCE_PROFILE"
echo -e "  Private Link:               $ENABLE_PRIVATE_LINK"
echo -e "  Customer-Managed Keys:      $ENABLE_CMK"
echo -e "  Log Retention (days):       $LOG_RETENTION_DAYS"
echo -e "  Monthly Budget (USD):       \$$MONTHLY_BUDGET"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo ""
echo -e "${YELLOW}💰 Estimated Monthly Cost: \$$MONTHLY_COST USD (capacity only)${NC}"
echo ""

read -p "Proceed with deployment? (yes/no): " CONFIRM
if [ "$CONFIRM" != "yes" ]; then
    echo -e "${RED}❌ Deployment cancelled${NC}"
    exit 0
fi

# ============================================================================
# STEP 1: CREATE RESOURCE GROUP
# ============================================================================

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}STEP 1: Creating Resource Group${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"

RESOURCE_GROUP="rg-fabric-$WORKSPACE_PREFIX"

if az group show -n "$RESOURCE_GROUP" &>/dev/null; then
    echo -e "${GREEN}✅ Resource group already exists: $RESOURCE_GROUP${NC}"
else
    echo -e "${YELLOW}📦 Creating resource group: $RESOURCE_GROUP${NC}"
    az group create \
        --name "$RESOURCE_GROUP" \
        --location "$REGION" \
        --tags Environment=prod ManagedBy=FabricLandingZone ComplianceProfile="$COMPLIANCE_PROFILE"
    echo -e "${GREEN}✅ Resource group created${NC}"
fi

# ============================================================================
# STEP 2: CREATE KEY VAULT (if CMK enabled)
# ============================================================================

KEY_VAULT_NAME=""

if [ "$ENABLE_CMK" = true ]; then
    echo ""
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
    echo -e "${CYAN}STEP 2: Creating Azure Key Vault for Customer-Managed Keys${NC}"
    echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"

    KEY_VAULT_NAME="kv-fabric-$WORKSPACE_PREFIX-$RANDOM"
    
    echo -e "${YELLOW}🔑 Creating Key Vault: $KEY_VAULT_NAME${NC}"
    az keyvault create \
        --name "$KEY_VAULT_NAME" \
        --resource-group "$RESOURCE_GROUP" \
        --location "$REGION" \
        --enable-purge-protection true \
        --enable-soft-delete true \
        --retention-days 90 \
        --sku premium \
        --tags Purpose=FabricCMK
    
    echo -e "${YELLOW}🔑 Creating encryption key...${NC}"
    az keyvault key create \
        --vault-name "$KEY_VAULT_NAME" \
        --name "fabric-encryption-key" \
        --kty RSA \
        --size 2048 \
        --ops encrypt decrypt wrapKey unwrapKey
    
    echo -e "${GREEN}✅ Key Vault and encryption key created${NC}"
fi

# ============================================================================
# STEP 3: CREATE FABRIC CAPACITY
# ============================================================================

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}STEP 3: Creating Fabric Capacity${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"

echo -e "${YELLOW}🚀 Creating Fabric capacity: $CAPACITY_NAME (SKU: $CAPACITY_SKU)${NC}"
echo -e "${YELLOW}⏳ This may take 2-5 minutes...${NC}"

# Create ARM template for Fabric capacity
TEMPLATE_FILE="/tmp/fabric-capacity-$RANDOM.json"
cat > "$TEMPLATE_FILE" <<EOF
{
  "\$schema": "https://schema.management.azure.com/schemas/2019-04-01/deploymentTemplate.json#",
  "contentVersion": "1.0.0.0",
  "resources": [
    {
      "type": "Microsoft.Fabric/capacities",
      "apiVersion": "2023-11-01",
      "name": "$CAPACITY_NAME",
      "location": "$REGION",
      "sku": {
        "name": "$CAPACITY_SKU",
        "tier": "Fabric"
      },
      "properties": {
        "administration": {
          "members": ["$ACCOUNT_NAME"]
        }
      },
      "tags": {
        "Environment": "production",
        "ComplianceProfile": "$COMPLIANCE_PROFILE",
        "ManagedBy": "FabricLandingZone"
      }
    }
  ]
}
EOF

az deployment group create \
    --resource-group "$RESOURCE_GROUP" \
    --template-file "$TEMPLATE_FILE" \
    --name "fabric-capacity-$(date +%Y%m%d%H%M%S)" \
    --no-wait

rm -f "$TEMPLATE_FILE"

echo -e "${GREEN}✅ Fabric capacity deployment initiated${NC}"
echo -e "${YELLOW}ℹ️  Capacity creation is asynchronous. Check status in Azure Portal.${NC}"

# ============================================================================
# STEP 4: CREATE LOG ANALYTICS WORKSPACE
# ============================================================================

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}STEP 4: Creating Log Analytics Workspace${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"

LOG_ANALYTICS_NAME="log-fabric-$WORKSPACE_PREFIX"

echo -e "${YELLOW}📊 Creating Log Analytics Workspace: $LOG_ANALYTICS_NAME${NC}"
az monitor log-analytics workspace create \
    --resource-group "$RESOURCE_GROUP" \
    --workspace-name "$LOG_ANALYTICS_NAME" \
    --location "$REGION" \
    --retention-time "$LOG_RETENTION_DAYS" \
    --tags Purpose=FabricMonitoring

echo -e "${GREEN}✅ Log Analytics Workspace created${NC}"

# ============================================================================
# STEP 5: CREATE WORKSPACES (via Power BI REST API)
# ============================================================================

echo ""
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"
echo -e "${CYAN}STEP 5: Creating Fabric Workspaces${NC}"
echo -e "${CYAN}═══════════════════════════════════════════════════════════════════════${NC}"

echo -e "${YELLOW}ℹ️  Workspace creation requires Power BI REST API access${NC}"
echo -e "${YELLOW}ℹ️  You can create workspaces manually in Fabric Portal: https://app.fabric.microsoft.com${NC}"
echo ""
echo -e "${YELLOW}Workspace names:${NC}"
echo -e "  - ${WORKSPACE_PREFIX}-dev"
echo -e "  - ${WORKSPACE_PREFIX}-test"
echo -e "  - ${WORKSPACE_PREFIX}-prod"

# ============================================================================
# DEPLOYMENT SUMMARY
# ============================================================================

echo ""
echo -e "${GREEN}╔══════════════════════════════════════════════════════════════════════╗${NC}"
echo -e "${GREEN}║                    DEPLOYMENT COMPLETED                              ║${NC}"
echo -e "${GREEN}╚══════════════════════════════════════════════════════════════════════╝${NC}"
echo ""

echo -e "${CYAN}📊 Deployment Summary:${NC}"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"
echo -e "  ✅ Resource Group:        $RESOURCE_GROUP"
echo -e "  ✅ Fabric Capacity:       $CAPACITY_NAME ($CAPACITY_SKU)"
echo -e "  ✅ Region:                $REGION"
echo -e "  ✅ Log Analytics:         $LOG_ANALYTICS_NAME"
if [ "$ENABLE_CMK" = true ]; then
    echo -e "  ✅ Key Vault:             $KEY_VAULT_NAME"
fi
echo -e "  ✅ Compliance Profile:    $COMPLIANCE_PROFILE"
echo -e "${CYAN}━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━${NC}"

echo ""
echo -e "${YELLOW}🎯 Next Steps:${NC}"
echo "  1. Access Fabric Portal: https://app.fabric.microsoft.com"
echo "  2. Create workspaces: ${WORKSPACE_PREFIX}-dev, ${WORKSPACE_PREFIX}-test, ${WORKSPACE_PREFIX}-prod"
echo "  3. Assign workspaces to capacity: $CAPACITY_NAME"
echo "  4. Configure security settings (MFA, Private Link)"
echo "  5. Set up Microsoft Purview integration"
echo "  6. Create OneLake structure (Bronze/Silver/Gold)"

echo ""
echo -e "${YELLOW}💰 Estimated Monthly Cost: \$$MONTHLY_COST USD${NC}"
echo ""
echo -e "${GREEN}✅ Deployment completed at: $(date '+%Y-%m-%d %H:%M:%S')${NC}"
echo ""
