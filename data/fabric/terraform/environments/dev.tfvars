# Example: Development Environment

capacity_name    = "fabric-ai-dev"
capacity_sku     = "F8"
region           = "eastus"
workspace_prefix = "dev-ai"
project_name     = "ai-platform"
environment      = "dev"

# Administrator configuration
capacity_admin_emails = [
  "dev-admin@company.com"
]
alert_email_address = "dev-alerts@company.com"

# Only create dev workspace
environments = ["dev"]

# Basic compliance
compliance_profile = "GDPR"

# Minimal security for development
enable_private_link            = false
enable_customer_managed_keys   = false
require_mfa                    = false

# Governance settings
enable_purview     = false
enable_dlp         = false
log_retention_days = 90

# Cost management
monthly_budget      = 1000
enable_cost_alerts  = true
enable_auto_scale   = false

# Additional tags
additional_tags = {
  Environment  = "Development"
  CostCenter   = "Engineering"
  Owner        = "dev-team@company.com"
  AutoShutdown = "true"
}
