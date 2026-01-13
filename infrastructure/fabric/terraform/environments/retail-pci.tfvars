# Example: Retail/PCI-DSS Compliance Environment

capacity_name    = "fabric-retail-prod"
capacity_sku     = "F64"
region           = "westus2"
workspace_prefix = "retail-ai"
project_name     = "retail-analytics-platform"
environment      = "prod"

# Administrator configuration
capacity_admin_emails = [
  "data-admin@retailcorp.com",
  "pci-compliance@retailcorp.com",
  "security-team@retailcorp.com"
]
alert_email_address = "retail-security-alerts@retailcorp.com"

# Create separate workspaces (PCI data in dedicated workspace)
environments = ["prod", "pci-prod"]  # Separate workspace for cardholder data

# Retail compliance (PCI-DSS, GDPR, CCPA)
compliance_profile = "Retail"

# PCI-DSS security requirements
enable_private_link            = true   # Required for PCI-DSS
enable_customer_managed_keys   = true   # Required for cardholder data
require_mfa                    = true   # Required

# Governance settings
enable_purview     = true  # Required for data classification
enable_dlp         = true  # Required to prevent credit card leakage
log_retention_days = 365   # PCI-DSS requires 1 year minimum

# Cost management
monthly_budget      = 12000
enable_cost_alerts  = true
enable_auto_scale   = false

# Additional tags
additional_tags = {
  Environment        = "Production"
  Industry           = "Retail"
  DataClassification = "PCI-DSS-Level1"
  Compliance         = "PCI-DSS-GDPR-CCPA"
  CostCenter         = "IT-Retail"
  Owner              = "data-admin@retailcorp.com"
  Criticality        = "High"
  BackupPolicy       = "Daily"
  DisasterRecovery   = "Enabled"
  PCICompliance      = "true"
  QuarterlyASVScan   = "Required"
  AnnualPenTest      = "Required"
}
