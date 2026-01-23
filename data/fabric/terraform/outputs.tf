# Terraform Outputs for Microsoft Fabric Landing Zone

# ============================================================================
# RESOURCE GROUP OUTPUTS
# ============================================================================

output "resource_group_name" {
  description = "Name of the resource group"
  value       = azurerm_resource_group.fabric.name
}

output "resource_group_id" {
  description = "ID of the resource group"
  value       = azurerm_resource_group.fabric.id
}

output "resource_group_location" {
  description = "Location of the resource group"
  value       = azurerm_resource_group.fabric.location
}

# ============================================================================
# FABRIC CAPACITY OUTPUTS
# ============================================================================

output "capacity_name" {
  description = "Name of the Fabric capacity"
  value       = azapi_resource.fabric_capacity.name
}

output "capacity_id" {
  description = "ID of the Fabric capacity"
  value       = azapi_resource.fabric_capacity.id
}

output "capacity_sku" {
  description = "SKU of the Fabric capacity"
  value       = var.capacity_sku
}

output "capacity_region" {
  description = "Region where capacity is deployed"
  value       = var.region
}

# ============================================================================
# WORKSPACE OUTPUTS
# ============================================================================

output "workspace_names" {
  description = "Names of workspaces to create manually in Fabric portal"
  value       = local.workspace_names
}

output "workspace_creation_command" {
  description = "PowerShell commands to create workspaces"
  value = join("\n", [
    "Connect-PowerBIServiceAccount",
    for ws in local.workspace_names : "New-PowerBIWorkspace -Name '${ws}'"
  ])
}

# ============================================================================
# MONITORING OUTPUTS
# ============================================================================

output "log_analytics_workspace_id" {
  description = "ID of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.fabric.id
}

output "log_analytics_workspace_name" {
  description = "Name of the Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.fabric.name
}

output "log_analytics_workspace_key" {
  description = "Primary shared key for Log Analytics workspace"
  value       = azurerm_log_analytics_workspace.fabric.primary_shared_key
  sensitive   = true
}

output "action_group_id" {
  description = "ID of the action group for alerts"
  value       = azurerm_monitor_action_group.fabric_alerts.id
}

# ============================================================================
# SECURITY OUTPUTS
# ============================================================================

output "key_vault_id" {
  description = "ID of the Key Vault (if CMK enabled)"
  value       = var.enable_customer_managed_keys ? azurerm_key_vault.fabric[0].id : null
}

output "key_vault_name" {
  description = "Name of the Key Vault (if CMK enabled)"
  value       = var.enable_customer_managed_keys ? azurerm_key_vault.fabric[0].name : null
}

output "key_vault_uri" {
  description = "URI of the Key Vault (if CMK enabled)"
  value       = var.enable_customer_managed_keys ? azurerm_key_vault.fabric[0].vault_uri : null
}

output "encryption_key_id" {
  description = "ID of the encryption key (if CMK enabled)"
  value       = var.enable_customer_managed_keys ? azurerm_key_vault_key.fabric_encryption[0].id : null
}

# ============================================================================
# NETWORKING OUTPUTS
# ============================================================================

output "virtual_network_id" {
  description = "ID of the virtual network (if Private Link enabled)"
  value       = var.enable_private_link ? azurerm_virtual_network.fabric[0].id : null
}

output "virtual_network_name" {
  description = "Name of the virtual network (if Private Link enabled)"
  value       = var.enable_private_link ? azurerm_virtual_network.fabric[0].name : null
}

output "private_endpoint_subnet_id" {
  description = "ID of the private endpoint subnet (if Private Link enabled)"
  value       = var.enable_private_link ? azurerm_subnet.private_endpoints[0].id : null
}

# ============================================================================
# COST MANAGEMENT OUTPUTS
# ============================================================================

output "budget_id" {
  description = "ID of the budget alert"
  value       = azurerm_consumption_budget_resource_group.fabric.id
}

output "monthly_budget_usd" {
  description = "Configured monthly budget in USD"
  value       = var.monthly_budget
}

output "estimated_monthly_cost_usd" {
  description = "Estimated monthly cost in USD (capacity only, excludes OneLake storage)"
  value       = local.estimated_monthly_cost
}

output "cost_breakdown" {
  description = "Estimated cost breakdown"
  value = {
    capacity_monthly_usd = local.estimated_monthly_cost
    onelake_storage_per_gb_monthly_usd = 0.018
    log_analytics_ingestion_per_gb_usd = 2.30
    total_estimate_note = "Actual costs depend on OneLake storage usage and log volume"
  }
}

# ============================================================================
# COMPLIANCE OUTPUTS
# ============================================================================

output "compliance_profile" {
  description = "Compliance profile applied to the deployment"
  value       = var.compliance_profile
}

output "log_retention_days" {
  description = "Configured log retention in days"
  value       = var.log_retention_days
}

output "compliance_controls" {
  description = "Compliance controls enabled"
  value = {
    profile                    = var.compliance_profile
    private_link_enabled       = var.enable_private_link
    customer_managed_keys      = var.enable_customer_managed_keys
    mfa_required               = var.require_mfa
    purview_enabled            = var.enable_purview
    dlp_enabled                = var.enable_dlp
    log_retention_days         = var.log_retention_days
    audit_logging_enabled      = true
    encryption_at_rest         = true
    encryption_in_transit      = true
  }
}

# ============================================================================
# ACCESS OUTPUTS
# ============================================================================

output "fabric_portal_url" {
  description = "URL to Fabric portal"
  value       = "https://app.fabric.microsoft.com"
}

output "azure_portal_resource_group_url" {
  description = "Direct link to resource group in Azure Portal"
  value       = "https://portal.azure.com/#@${data.azurerm_client_config.current.tenant_id}/resource${azurerm_resource_group.fabric.id}"
}

output "capacity_admin_emails" {
  description = "Email addresses configured as capacity administrators"
  value       = var.capacity_admin_emails
}

# ============================================================================
# DEPLOYMENT SUMMARY
# ============================================================================

output "deployment_summary" {
  description = "Complete deployment summary"
  value = {
    # Resource Information
    resource_group        = azurerm_resource_group.fabric.name
    capacity_name         = azapi_resource.fabric_capacity.name
    capacity_sku          = var.capacity_sku
    region                = var.region
    
    # Workspaces
    workspaces_to_create  = local.workspace_names
    
    # Compliance
    compliance_profile    = var.compliance_profile
    log_retention_days    = var.log_retention_days
    
    # Security
    private_link_enabled  = var.enable_private_link
    cmk_enabled           = var.enable_customer_managed_keys
    mfa_required          = var.require_mfa
    
    # Governance
    purview_enabled       = var.enable_purview
    dlp_enabled           = var.enable_dlp
    
    # Cost
    estimated_monthly_cost = "$${local.estimated_monthly_cost} USD"
    monthly_budget        = "$${var.monthly_budget} USD"
    
    # Access
    fabric_portal         = "https://app.fabric.microsoft.com"
    
    # Tags
    environment           = var.environment
    project               = var.project_name
  }
}

# ============================================================================
# NEXT STEPS OUTPUT
# ============================================================================

output "next_steps" {
  description = "Next steps to complete the deployment"
  value = [
    "1. Access Fabric Portal: https://app.fabric.microsoft.com",
    "2. Create workspaces using PowerShell:",
    "   Connect-PowerBIServiceAccount",
    join("\n   ", [for ws in local.workspace_names : "New-PowerBIWorkspace -Name '${ws}'"]),
    "3. Assign workspaces to capacity: ${azapi_resource.fabric_capacity.name}",
    "4. Configure Azure AD Conditional Access for MFA (if enabled)",
    "5. Set up Private Link connection (if enabled)",
    "6. Configure Microsoft Purview integration (if enabled)",
    "7. Create OneLake folder structure (Bronze/Silver/Gold layers)",
    "8. Set up data pipelines and lakehouses",
    "9. Configure sensitivity labels and DLP policies",
    "10. Review compliance dashboard and monitoring alerts"
  ]
}

# ============================================================================
# TROUBLESHOOTING OUTPUT
# ============================================================================

output "troubleshooting_info" {
  description = "Troubleshooting information and support resources"
  value = {
    subscription_id = data.azurerm_subscription.current.subscription_id
    tenant_id       = data.azurerm_client_config.current.tenant_id
    deployment_time = timestamp()
    
    support_links = {
      fabric_docs       = "https://learn.microsoft.com/fabric"
      compliance_docs   = "https://aka.ms/FabricCompliance"
      pricing_calculator = "https://azure.microsoft.com/pricing/details/microsoft-fabric/"
      github_issues     = "https://github.com/andreaswasita/AI-Delivery-Methodology/issues"
    }
    
    common_issues = {
      provider_not_registered = "Run: az provider register --namespace Microsoft.Fabric"
      insufficient_permissions = "Ensure you have Fabric Admin or Capacity Admin role"
      capacity_name_exists = "Capacity names are globally unique - choose a different name"
      workspace_creation_fails = "Create workspaces manually via Power BI REST API or Fabric portal"
    }
  }
}
