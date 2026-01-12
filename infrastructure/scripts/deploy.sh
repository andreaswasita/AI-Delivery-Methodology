#!/bin/bash
################################################################################
# Deploy standardized AI platform infrastructure to Azure
# 
# Usage:
#   ./deploy.sh -e <environment> -p <project-name> [-l <location>] [-s <subscription-id>] [-w]
#
# Options:
#   -e    Environment (dev, test, uat, prod)
#   -p    Project name (3-10 characters)
#   -l    Azure region (default: australiaeast)
#   -s    Azure subscription ID
#   -w    What-if mode (preview changes without deploying)
#   -h    Show help
#
# Example:
#   ./deploy.sh -e prod -p myaiproj -s "your-subscription-id"
################################################################################

set -euo pipefail

# ============================================================================
# CONFIGURATION
# ============================================================================

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
BICEP_PATH="$(dirname "$SCRIPT_DIR")/bicep/main.bicep"

ENVIRONMENT=""
PROJECT_NAME=""
LOCATION="australiaeast"
SUBSCRIPTION_ID=""
WHAT_IF=false

# Colors
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
CYAN='\033[0;36m'
GRAY='\033[0;37m'
NC='\033[0m' # No Color

# ============================================================================
# FUNCTIONS
# ============================================================================

print_header() {
    echo -e "\n${CYAN}========================================${NC}"
    echo -e "${CYAN}$1${NC}"
    echo -e "${CYAN}========================================${NC}\n"
}

print_step() {
    echo -e "${GRAY}[$(date +%H:%M:%S)]${NC} $1"
}

print_success() {
    echo -e "${GRAY}[$(date +%H:%M:%S)]${NC} ${GREEN}✓${NC} $1"
}

print_error() {
    echo -e "${GRAY}[$(date +%H:%M:%S)]${NC} ${RED}✗${NC} $1"
}

show_usage() {
    cat << EOF
AI Platform Infrastructure Deployment

Usage:
  ./deploy.sh -e <environment> -p <project-name> [options]

Required:
  -e    Environment (dev, test, uat, prod)
  -p    Project name (3-10 characters)

Optional:
  -l    Azure region (default: australiaeast)
  -s    Azure subscription ID
  -w    What-if mode (preview changes without deploying)
  -h    Show this help message

Examples:
  ./deploy.sh -e prod -p myaiproj -s "your-subscription-id"
  ./deploy.sh -e dev -p testai -w

EOF
}

validate_prerequisites() {
    print_header "Validating Prerequisites"
    
    # Check Azure CLI
    if command -v az &> /dev/null; then
        AZ_VERSION=$(az version --query '"azure-cli"' -o tsv)
        print_success "Azure CLI installed (version $AZ_VERSION)"
    else
        print_error "Azure CLI not found. Please install: https://aka.ms/azure-cli"
        exit 1
    fi
    
    # Check Bicep CLI
    if az bicep version &> /dev/null; then
        print_success "Bicep CLI installed"
    else
        print_step "Installing Bicep CLI..."
        az bicep install
        print_success "Bicep CLI installed"
    fi
    
    # Check Bicep template
    if [ ! -f "$BICEP_PATH" ]; then
        print_error "Bicep template not found: $BICEP_PATH"
        exit 1
    fi
    print_success "Bicep template found"
    
    # Check parameters file
    PARAMETERS_PATH="$(dirname "$SCRIPT_DIR")/bicep/parameters/${ENVIRONMENT}.parameters.json"
    if [ ! -f "$PARAMETERS_PATH" ]; then
        print_error "Parameters file not found: $PARAMETERS_PATH"
        exit 1
    fi
    print_success "Parameters file found"
}

azure_login() {
    print_header "Azure Authentication"
    
    # Check if already logged in
    if az account show &> /dev/null; then
        ACCOUNT_NAME=$(az account show --query user.name -o tsv)
        SUBSCRIPTION_NAME=$(az account show --query name -o tsv)
        TENANT_ID=$(az account show --query tenantId -o tsv)
        
        print_success "Logged in as: $ACCOUNT_NAME"
        echo -e "  Subscription: ${GRAY}$SUBSCRIPTION_NAME${NC}"
        echo -e "  Tenant:       ${GRAY}$TENANT_ID${NC}"
    else
        print_step "Logging in to Azure..."
        az login
        print_success "Login successful"
    fi
    
    # Set subscription if provided
    if [ -n "$SUBSCRIPTION_ID" ]; then
        print_step "Setting subscription: $SUBSCRIPTION_ID"
        az account set --subscription "$SUBSCRIPTION_ID"
        print_success "Subscription set"
    fi
}

validate_bicep() {
    print_header "Validating Bicep Template"
    
    print_step "Running Bicep validation..."
    if az bicep build --file "$BICEP_PATH" 2>&1 > /dev/null; then
        print_success "Bicep template is valid"
    else
        print_error "Bicep validation failed"
        exit 1
    fi
}

deploy_infrastructure() {
    print_header "Deploying Infrastructure"
    
    DEPLOYMENT_NAME="ai-platform-${ENVIRONMENT}-$(date +%Y%m%d-%H%M%S)"
    print_step "Deployment name: $DEPLOYMENT_NAME"
    
    DEPLOY_ARGS=(
        "deployment" "sub" "create"
        "--name" "$DEPLOYMENT_NAME"
        "--location" "$LOCATION"
        "--template-file" "$BICEP_PATH"
        "--parameters" "$PARAMETERS_PATH"
        "--parameters" "projectName=$PROJECT_NAME"
    )
    
    if [ "$WHAT_IF" = true ]; then
        DEPLOY_ARGS+=("--what-if")
        echo -e "\n${YELLOW}Running What-If analysis...${NC}\n"
    else
        echo -e "\n${YELLOW}Starting deployment (this may take 30-45 minutes)...${NC}\n"
    fi
    
    START_TIME=$(date +%s)
    
    if az "${DEPLOY_ARGS[@]}"; then
        END_TIME=$(date +%s)
        DURATION=$(( (END_TIME - START_TIME) / 60 ))
        print_success "Deployment completed in $DURATION minutes"
    else
        print_error "Deployment failed"
        exit 1
    fi
    
    # Get deployment outputs
    if [ "$WHAT_IF" = false ]; then
        print_header "Deployment Outputs"
        
        OUTPUTS=$(az deployment sub show --name "$DEPLOYMENT_NAME" --query properties.outputs --output json)
        
        echo -e "${YELLOW}Resource Group:${NC}       $(echo "$OUTPUTS" | jq -r '.resourceGroupName.value')"
        echo -e "${YELLOW}Key Vault:${NC}            $(echo "$OUTPUTS" | jq -r '.keyVaultName.value')"
        echo -e "${YELLOW}Storage Account:${NC}      $(echo "$OUTPUTS" | jq -r '.storageAccountName.value')"
        echo -e "${YELLOW}Azure ML Workspace:${NC}   $(echo "$OUTPUTS" | jq -r '.azureMLWorkspaceName.value')"
        echo -e "${YELLOW}AKS Cluster:${NC}          $(echo "$OUTPUTS" | jq -r '.aksClusterName.value')"
        echo -e "${YELLOW}Compliance Enabled:${NC}   $(echo "$OUTPUTS" | jq -r '.complianceEnabled.value')"
        echo -e "${YELLOW}Data Residency:${NC}       $(echo "$OUTPUTS" | jq -r '.dataResidency.value')"
        
        # Save outputs to file
        OUTPUTS_DIR="$(dirname "$SCRIPT_DIR")/bicep/outputs"
        mkdir -p "$OUTPUTS_DIR"
        OUTPUTS_FILE="$OUTPUTS_DIR/${ENVIRONMENT}-outputs.json"
        echo "$OUTPUTS" > "$OUTPUTS_FILE"
        print_success "Outputs saved to: $OUTPUTS_FILE"
    fi
}

show_next_steps() {
    print_header "Deployment Complete"
    
    echo -e "\n${YELLOW}Next Steps:${NC}"
    echo -e "${GRAY}1.${NC} Configure RBAC permissions for your team"
    echo -e "${GRAY}2.${NC} Set up Azure DevOps or GitHub Actions for CI/CD"
    echo -e "${GRAY}3.${NC} Configure monitoring alerts and dashboards"
    echo -e "${GRAY}4.${NC} Deploy your AI use cases to the platform"
    echo -e "\n${CYAN}Documentation: https://github.com/andreaswasita/AI-Delivery-Methodology${NC}\n"
}

# ============================================================================
# MAIN SCRIPT
# ============================================================================

# Parse command line arguments
while getopts "e:p:l:s:wh" opt; do
    case $opt in
        e) ENVIRONMENT="$OPTARG" ;;
        p) PROJECT_NAME="$OPTARG" ;;
        l) LOCATION="$OPTARG" ;;
        s) SUBSCRIPTION_ID="$OPTARG" ;;
        w) WHAT_IF=true ;;
        h) show_usage; exit 0 ;;
        *) show_usage; exit 1 ;;
    esac
done

# Validate required parameters
if [ -z "$ENVIRONMENT" ] || [ -z "$PROJECT_NAME" ]; then
    print_error "Missing required parameters"
    show_usage
    exit 1
fi

# Validate environment
if [[ ! "$ENVIRONMENT" =~ ^(dev|test|uat|prod)$ ]]; then
    print_error "Invalid environment: $ENVIRONMENT (must be dev, test, uat, or prod)"
    exit 1
fi

# Validate project name length
if [ ${#PROJECT_NAME} -lt 3 ] || [ ${#PROJECT_NAME} -gt 10 ]; then
    print_error "Project name must be 3-10 characters"
    exit 1
fi

print_header "AI Platform Infrastructure Deployment"

echo -e "${YELLOW}Configuration:${NC}"
echo -e "  Environment:   ${GRAY}$ENVIRONMENT${NC}"
echo -e "  Location:      ${GRAY}$LOCATION${NC}"
echo -e "  Project Name:  ${GRAY}$PROJECT_NAME${NC}"
echo -e "  What-If Mode:  ${GRAY}$WHAT_IF${NC}"

# Execute deployment steps
validate_prerequisites
azure_login
validate_bicep
deploy_infrastructure
show_next_steps
