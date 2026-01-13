# Example: Financial Services (APRA CPS 234) Compliance Environment

capacity_name    = "fabric-finance-prod"
capacity_sku     = "F256"
region           = "australiaeast"  # Australia for APRA compliance
workspace_prefix = "finance-ai"
project_name     = "financial-services-platform"
environment      = "prod"

# Administrator configuration
capacity_admin_emails = [
  "fabric-admin@financialcorp.com.au",
  "risk-management@financialcorp.com.au",
  "compliance-officer@financialcorp.com.au",
  "ciso@financialcorp.com.au"
]
alert_email_address = "finance-critical-alerts@financialcorp.com.au"

# Create all environments with strict separation
environments = ["dev", "test", "prod"]

# Financial Services compliance (APRA CPS 234, Basel III, MiFID II)
compliance_profile = "FinancialServices"

# Financial Services security requirements
enable_private_link            = true   # Required for APRA CPS 234
enable_customer_managed_keys   = true   # Required for sensitive financial data
require_mfa                    = true   # Required

# Governance settings
enable_purview     = true  # Required for data lineage and audit
enable_dlp         = true  # Required to prevent data leakage
log_retention_days = 2555  # 7 years for APRA CPS 234 requirement

# Cost management (higher budget for compliance overhead)
monthly_budget      = 30000
enable_cost_alerts  = true
enable_auto_scale   = false  # Predictable performance for SLA

# Additional tags
additional_tags = {
  Environment          = "Production"
  Industry             = "FinancialServices"
  DataClassification   = "Confidential-Financial"
  Compliance           = "APRA-CPS234-Basel-III"
  Regulator            = "APRA"
  CostCenter           = "IT-RiskManagement"
  Owner                = "risk-management@financialcorp.com.au"
  Criticality          = "Mission-Critical"
  BackupPolicy         = "Continuous"
  DisasterRecovery     = "Cross-Region-15min-RTO"
  AuditRequired        = "true"
  DataSovereignty      = "Australia"
  ThirdPartyRisk       = "Reviewed"
  IncidentResponsePlan = "Documented"
}
