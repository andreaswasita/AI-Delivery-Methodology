# Example: Production Environment

capacity_name    = "fabric-ai-prod"
capacity_sku     = "F64"
region           = "australiaeast"
workspace_prefix = "ai-platform"
project_name     = "ai-platform"
environment      = "prod"

# Administrator configuration
capacity_admin_emails = [
  "fabric-admin@company.com",
  "data-platform-team@company.com",
  "cto@company.com"
]
alert_email_address = "fabric-prod-alerts@company.com"

# Create all environments
environments = ["dev", "test", "prod"]

# SOC 2 compliance
compliance_profile = "SOC2"

# Production security settings
enable_private_link            = true
enable_customer_managed_keys   = true
require_mfa                    = true

# Governance settings
enable_purview     = true
enable_dlp         = true
log_retention_days = 365  # SOC 2 requirement

# Cost management
monthly_budget      = 10000
enable_cost_alerts  = true
enable_auto_scale   = false  # Keep false for production

# Additional tags
additional_tags = {
  Environment     = "Production"
  BusinessUnit    = "Data & Analytics"
  CostCenter      = "CC-12345"
  Owner           = "data-platform-team@company.com"
  Criticality     = "High"
  BackupPolicy    = "Daily"
  DisasterRecovery = "Enabled"
}
