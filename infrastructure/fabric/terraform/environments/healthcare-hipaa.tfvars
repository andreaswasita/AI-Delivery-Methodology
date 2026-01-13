# Example: Healthcare/HIPAA Compliance Environment

capacity_name    = "fabric-health-prod"
capacity_sku     = "F128"
region           = "eastus"  # HIPAA-compliant region
workspace_prefix = "healthcare-ai"
project_name     = "healthcare-platform"
environment      = "prod"

# Administrator configuration
capacity_admin_emails = [
  "hipaa-admin@healthcorp.com",
  "compliance-team@healthcorp.com",
  "security-officer@healthcorp.com"
]
alert_email_address = "healthcare-security-alerts@healthcorp.com"

# Create production workspaces
environments = ["test", "prod"]  # No dev with real PHI

# Healthcare compliance (HIPAA + HITECH)
compliance_profile = "Healthcare"

# HIPAA security requirements
enable_private_link            = true   # Required
enable_customer_managed_keys   = true   # Required for PHI
require_mfa                    = true   # Required

# Governance settings
enable_purview     = true  # Required for PHI tracking
enable_dlp         = true  # Required to prevent PHI leakage
log_retention_days = 2190  # 6 years for HIPAA

# Cost management
monthly_budget      = 20000
enable_cost_alerts  = true
enable_auto_scale   = false

# Additional tags
additional_tags = {
  Environment       = "Production"
  Industry          = "Healthcare"
  DataClassification = "PHI"
  Compliance        = "HIPAA-HITECH"
  CostCenter        = "IT-Healthcare"
  Owner             = "hipaa-admin@healthcorp.com"
  Criticality       = "Critical"
  BackupPolicy      = "Hourly"
  DisasterRecovery  = "Multi-Region"
  AuditRequired     = "true"
}
