# Terraform Configuration for Microsoft Fabric Landing Zone
# Version: 1.0.0

terraform {
  required_version = ">= 1.5.0"
  
  required_providers {
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.80"
    }
    azapi = {
      source  = "azure/azapi"
      version = "~> 1.9"
    }
  }

  # Optional: Configure remote state storage
  # backend "azurerm" {
  #   resource_group_name  = "rg-terraform-state"
  #   storage_account_name = "tfstatestorageaccount"
  #   container_name       = "tfstate"
  #   key                  = "fabric-landing-zone.tfstate"
  # }
}

provider "azurerm" {
  features {
    key_vault {
      purge_soft_delete_on_destroy    = false
      recover_soft_deleted_key_vaults = true
    }
    resource_group {
      prevent_deletion_if_contains_resources = false
    }
  }
}

provider "azapi" {}

# ============================================================================
# LOCALS
# ============================================================================

locals {
  common_tags = {
    Environment       = var.environment
    ManagedBy         = "Terraform"
    ComplianceProfile = var.compliance_profile
    Project           = var.project_name
    CreatedDate       = timestamp()
  }

  # Workspace names
  workspace_names = [for env in var.environments : "${var.workspace_prefix}-${env}"]

  # Calculate monthly cost
  monthly_cost_map = {
    "F2"    = 262
    "F4"    = 524
    "F8"    = 1048
    "F16"   = 2096
    "F32"   = 4192
    "F64"   = 8384
    "F128"  = 16768
    "F256"  = 33536
    "F512"  = 67072
    "F1024" = 134144
    "F2048" = 268288
  }
  estimated_monthly_cost = lookup(local.monthly_cost_map, var.capacity_sku, 0)
}

# ============================================================================
# DATA SOURCES
# ============================================================================

data "azurerm_client_config" "current" {}

data "azurerm_subscription" "current" {}

# ============================================================================
# RESOURCE GROUP
# ============================================================================

resource "azurerm_resource_group" "fabric" {
  name     = "rg-fabric-${var.workspace_prefix}-${var.environment}"
  location = var.region
  tags     = local.common_tags
}

# ============================================================================
# KEY VAULT (for Customer-Managed Keys)
# ============================================================================

resource "azurerm_key_vault" "fabric" {
  count = var.enable_customer_managed_keys ? 1 : 0

  name                        = "kv-fabric-${substr(replace(var.workspace_prefix, "-", ""), 0, 15)}-${random_integer.kv_suffix[0].result}"
  location                    = azurerm_resource_group.fabric.location
  resource_group_name         = azurerm_resource_group.fabric.name
  enabled_for_disk_encryption = true
  tenant_id                   = data.azurerm_client_config.current.tenant_id
  soft_delete_retention_days  = 90
  purge_protection_enabled    = true
  sku_name                    = "premium"

  network_acls {
    default_action = var.enable_private_link ? "Deny" : "Allow"
    bypass         = "AzureServices"
  }

  tags = merge(local.common_tags, {
    Purpose = "FabricCMK"
  })
}

resource "random_integer" "kv_suffix" {
  count = var.enable_customer_managed_keys ? 1 : 0
  min   = 1000
  max   = 9999
}

resource "azurerm_key_vault_access_policy" "terraform" {
  count = var.enable_customer_managed_keys ? 1 : 0

  key_vault_id = azurerm_key_vault.fabric[0].id
  tenant_id    = data.azurerm_client_config.current.tenant_id
  object_id    = data.azurerm_client_config.current.object_id

  key_permissions = [
    "Get", "List", "Create", "Delete", "Update",
    "Encrypt", "Decrypt", "WrapKey", "UnwrapKey"
  ]

  secret_permissions = [
    "Get", "List", "Set", "Delete"
  ]
}

resource "azurerm_key_vault_key" "fabric_encryption" {
  count = var.enable_customer_managed_keys ? 1 : 0

  name         = "fabric-encryption-key"
  key_vault_id = azurerm_key_vault.fabric[0].id
  key_type     = "RSA"
  key_size     = 2048

  key_opts = [
    "encrypt",
    "decrypt",
    "wrapKey",
    "unwrapKey"
  ]

  depends_on = [
    azurerm_key_vault_access_policy.terraform
  ]
}

# ============================================================================
# LOG ANALYTICS WORKSPACE
# ============================================================================

resource "azurerm_log_analytics_workspace" "fabric" {
  name                = "log-fabric-${var.workspace_prefix}-${var.environment}"
  location            = azurerm_resource_group.fabric.location
  resource_group_name = azurerm_resource_group.fabric.name
  sku                 = "PerGB2018"
  retention_in_days   = var.log_retention_days

  tags = merge(local.common_tags, {
    Purpose = "FabricMonitoring"
  })
}

# ============================================================================
# ACTION GROUP (for Alerts)
# ============================================================================

resource "azurerm_monitor_action_group" "fabric_alerts" {
  name                = "ag-fabric-${var.workspace_prefix}"
  resource_group_name = azurerm_resource_group.fabric.name
  short_name          = "FabricAlert"

  email_receiver {
    name          = "Admin Email"
    email_address = var.alert_email_address
  }

  tags = local.common_tags
}

# ============================================================================
# FABRIC CAPACITY (using azapi provider)
# ============================================================================

resource "azapi_resource" "fabric_capacity" {
  type      = "Microsoft.Fabric/capacities@2023-11-01"
  name      = var.capacity_name
  parent_id = azurerm_resource_group.fabric.id
  location  = var.region

  body = jsonencode({
    sku = {
      name = var.capacity_sku
      tier = "Fabric"
    }
    properties = {
      administration = {
        members = var.capacity_admin_emails
      }
    }
  })

  tags = local.common_tags

  timeouts {
    create = "30m"
    delete = "30m"
  }
}

# ============================================================================
# VIRTUAL NETWORK (for Private Link)
# ============================================================================

resource "azurerm_virtual_network" "fabric" {
  count = var.enable_private_link ? 1 : 0

  name                = "vnet-fabric-${var.workspace_prefix}-${var.environment}"
  location            = azurerm_resource_group.fabric.location
  resource_group_name = azurerm_resource_group.fabric.name
  address_space       = ["10.0.0.0/16"]

  tags = local.common_tags
}

resource "azurerm_subnet" "private_endpoints" {
  count = var.enable_private_link ? 1 : 0

  name                 = "snet-private-endpoints"
  resource_group_name  = azurerm_resource_group.fabric.name
  virtual_network_name = azurerm_virtual_network.fabric[0].name
  address_prefixes     = ["10.0.1.0/24"]

  private_endpoint_network_policies_enabled = false
}

# ============================================================================
# BUDGET ALERT
# ============================================================================

resource "azurerm_consumption_budget_resource_group" "fabric" {
  name              = "budget-fabric-${var.workspace_prefix}"
  resource_group_id = azurerm_resource_group.fabric.id

  amount     = var.monthly_budget
  time_grain = "Monthly"

  time_period {
    start_date = formatdate("YYYY-MM-01'T'00:00:00Z", timestamp())
  }

  notification {
    enabled   = true
    threshold = 80
    operator  = "GreaterThan"

    contact_emails = [
      var.alert_email_address
    ]
  }

  notification {
    enabled   = true
    threshold = 100
    operator  = "GreaterThan"

    contact_emails = [
      var.alert_email_address
    ]
  }
}

# ============================================================================
# OUTPUTS
# ============================================================================

# Outputs are defined in outputs.tf for better organization
