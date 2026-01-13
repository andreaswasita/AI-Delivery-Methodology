# Terraform Variables for Microsoft Fabric Landing Zone

# ============================================================================
# REQUIRED VARIABLES
# ============================================================================

variable "capacity_name" {
  description = "Name of the Fabric capacity (must be globally unique, 3-63 characters)"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z0-9-]{3,63}$", var.capacity_name))
    error_message = "Capacity name must be 3-63 characters, lowercase letters, numbers, and hyphens only."
  }
}

variable "capacity_sku" {
  description = "Fabric capacity SKU"
  type        = string
  default     = "F64"
  
  validation {
    condition     = contains(["F2", "F4", "F8", "F16", "F32", "F64", "F128", "F256", "F512", "F1024", "F2048"], var.capacity_sku)
    error_message = "Capacity SKU must be one of: F2, F4, F8, F16, F32, F64, F128, F256, F512, F1024, F2048."
  }
}

variable "region" {
  description = "Azure region for resource deployment"
  type        = string
  default     = "australiaeast"
}

variable "workspace_prefix" {
  description = "Prefix for workspace names (3-20 characters)"
  type        = string
  
  validation {
    condition     = can(regex("^[a-z0-9-]{3,20}$", var.workspace_prefix))
    error_message = "Workspace prefix must be 3-20 characters, lowercase letters, numbers, and hyphens only."
  }
}

variable "capacity_admin_emails" {
  description = "List of email addresses for capacity administrators"
  type        = list(string)
}

variable "alert_email_address" {
  description = "Email address for alerts and notifications"
  type        = string
}

# ============================================================================
# OPTIONAL VARIABLES
# ============================================================================

variable "project_name" {
  description = "Name of the project (used for tagging)"
  type        = string
  default     = "ai-platform"
}

variable "environment" {
  description = "Environment name (dev, test, uat, prod)"
  type        = string
  default     = "prod"
  
  validation {
    condition     = contains(["dev", "test", "uat", "prod"], var.environment)
    error_message = "Environment must be one of: dev, test, uat, prod."
  }
}

variable "environments" {
  description = "List of environments for workspace creation"
  type        = list(string)
  default     = ["dev", "test", "prod"]
}

variable "compliance_profile" {
  description = "Compliance profile to apply"
  type        = string
  default     = "GDPR"
  
  validation {
    condition     = contains(["GDPR", "SOC2", "HIPAA", "PCIDSS", "FinancialServices", "Healthcare", "Retail", "PublicSector"], var.compliance_profile)
    error_message = "Compliance profile must be one of: GDPR, SOC2, HIPAA, PCIDSS, FinancialServices, Healthcare, Retail, PublicSector."
  }
}

# ============================================================================
# SECURITY VARIABLES
# ============================================================================

variable "enable_private_link" {
  description = "Enable Private Link for secure connectivity"
  type        = bool
  default     = false
}

variable "enable_customer_managed_keys" {
  description = "Enable customer-managed keys via Azure Key Vault"
  type        = bool
  default     = false
}

variable "require_mfa" {
  description = "Require MFA for all Fabric access (configured via Azure AD)"
  type        = bool
  default     = true
}

# ============================================================================
# GOVERNANCE VARIABLES
# ============================================================================

variable "enable_purview" {
  description = "Enable Microsoft Purview integration"
  type        = bool
  default     = false
}

variable "enable_dlp" {
  description = "Enable Data Loss Prevention policies"
  type        = bool
  default     = false
}

variable "log_retention_days" {
  description = "Number of days to retain audit logs (90-2555)"
  type        = number
  default     = 365
  
  validation {
    condition     = var.log_retention_days >= 90 && var.log_retention_days <= 2555
    error_message = "Log retention must be between 90 and 2555 days."
  }
}

# ============================================================================
# COST MANAGEMENT VARIABLES
# ============================================================================

variable "monthly_budget" {
  description = "Monthly budget in USD for cost alerts"
  type        = number
  default     = 5000
  
  validation {
    condition     = var.monthly_budget >= 100 && var.monthly_budget <= 1000000
    error_message = "Monthly budget must be between 100 and 1,000,000 USD."
  }
}

variable "enable_auto_scale" {
  description = "Enable auto-scaling for capacity (not recommended for production)"
  type        = bool
  default     = false
}

variable "enable_cost_alerts" {
  description = "Enable cost threshold alerts"
  type        = bool
  default     = true
}

# ============================================================================
# NETWORKING VARIABLES
# ============================================================================

variable "vnet_address_space" {
  description = "Address space for virtual network (if Private Link enabled)"
  type        = list(string)
  default     = ["10.0.0.0/16"]
}

variable "subnet_address_prefix" {
  description = "Address prefix for private endpoint subnet"
  type        = list(string)
  default     = ["10.0.1.0/24"]
}

# ============================================================================
# TAGS
# ============================================================================

variable "additional_tags" {
  description = "Additional tags to apply to all resources"
  type        = map(string)
  default     = {}
}
