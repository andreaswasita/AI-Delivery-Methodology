# Microsoft Fabric Landing Zone
## Standardized, Compliance-Ready Data Platform for AI Use Cases

**Purpose**: Production-ready Microsoft Fabric deployment templates with built-in compliance for all AI/data use cases  
**Compliance**: GDPR, SOC 2, ISO 27001, PCI-DSS, APRA CPS 234, HIPAA, industry-specific regulations  
**Last Updated**: January 13, 2026

---

## Overview

This Microsoft Fabric landing zone provides **standardized, secure, compliant unified analytics platform** that can be deployed for any AI/data use case with minimal customization. Microsoft Fabric consolidates Data Factory, Synapse Data Engineering, Data Science, Real-Time Analytics, Data Warehouse, and Power BI into a single SaaS platform.

### Key Features

✅ **Compliance-First Design**
- GDPR data residency and privacy controls (capacity regions)
- SOC 2 Type II audit-ready logging and monitoring
- ISO 27001 security controls
- PCI-DSS Level 1 (for payment data workloads)
- APRA CPS 234 (for Australian financial services)
- HIPAA-ready (for healthcare data)
- Financial Services compliance (banking, insurance)

✅ **Security Hardening**
- Workspace-level isolation with security groups
- Azure AD integration with conditional access
- Private Link connectivity (Fabric Private Endpoints)
- Encryption at rest (Microsoft-managed or customer-managed keys)
- Encryption in transit (TLS 1.3)
- Data Loss Prevention (DLP) policies
- Customer Lockbox for Microsoft support access
- Information Protection sensitivity labels

✅ **Data Governance**
- Built-in data catalog with Microsoft Purview integration
- Data lineage tracking across all Fabric items
- Sensitivity labels for classification
- Data retention policies (OneLake governance)
- Row-level security (RLS) and object-level security (OLS)
- Dynamic data masking for PII protection
- Audit logs for all data access operations

✅ **Observability**
- Centralized monitoring via Azure Monitor integration
- Capacity metrics and performance insights
- User activity tracking and audit logs
- Cost management and chargeback reporting
- Alert rules for capacity throttling and overages
- Integration with Microsoft Sentinel for security monitoring

✅ **High Availability & Disaster Recovery**
- 99.9% SLA for Fabric capacity
- Geo-redundant OneLake storage (RA-GRS)
- Automated backup of Fabric items (Git integration)
- Cross-region disaster recovery planning
- Business continuity via Fabric workspace lifecycle management

---

## Architecture Overview

```
┌─────────────────────────────────────────────────────────────────────────┐
│                        Microsoft Fabric Landing Zone                     │
│                     (Unified SaaS Analytics Platform)                    │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
        ┌───────────────────────────┴───────────────────────────┐
        │                                                       │
┌───────▼───────┐                                     ┌────────▼────────┐
│  Capacity     │                                     │  Azure AD       │
│  Management   │                                     │  Integration    │
│               │                                     │                 │
│ • F2-F2048    │                                     │ • Conditional   │
│ • Region      │                                     │   Access        │
│ • Admin Portal│                                     │ • MFA Required  │
└───────────────┘                                     │ • RBAC          │
                                                      └─────────────────┘
┌─────────────────────────────────────────────────────────────────────────┐
│                         Workspace Hierarchy                              │
│  ┌────────────────┐  ┌────────────────┐  ┌────────────────┐           │
│  │  DEV Workspace │  │ TEST Workspace │  │ PROD Workspace │           │
│  │  (Isolated)    │  │  (Isolated)    │  │  (Isolated)    │           │
│  └────────────────┘  └────────────────┘  └────────────────┘           │
└─────────────────────────────────────────────────────────────────────────┘
                                    │
        ┌───────────────────────────┴───────────────────────────┐
        │                    OneLake Storage                     │
        │         (Unified Data Lake - ADLS Gen2 Compatible)    │
        │                                                       │
        │  ┌─────────┐  ┌─────────┐  ┌─────────┐             │
        │  │ Bronze  │→ │ Silver  │→ │  Gold   │  Medallion  │
        │  │ Layer   │  │ Layer   │  │ Layer   │  Architecture│
        │  └─────────┘  └─────────┘  └─────────┘             │
        └───────────────────────────────────────────────────────┘
                                    │
        ┌───────────────────────────┴───────────────────────────┐
        │                                                       │
┌───────▼─────────┐  ┌──────────────┐  ┌──────────────────┐  │
│ Data Factory    │  │ Synapse Data │  │ Data Warehouse   │  │
│ (Data Ingestion)│  │ Engineering  │  │ (SQL Analytics)  │  │
│                 │  │ (Transform)  │  │                  │  │
│ • Pipelines     │  │ • Notebooks  │  │ • Star Schema    │  │
│ • Dataflows Gen2│  │ • Spark Jobs │  │ • T-SQL Queries  │  │
└─────────────────┘  └──────────────┘  └──────────────────┘  │
                                                              │
┌───────▼─────────┐  ┌──────────────┐  ┌──────────────────┐  │
│ Data Science    │  │ Real-Time    │  │ Power BI         │  │
│ (ML/AI)         │  │ Analytics    │  │ (Reporting)      │  │
│                 │  │ (Streaming)  │  │                  │  │
│ • Notebooks     │  │ • Event      │  │ • Dashboards     │  │
│ • ML Models     │  │   Streams    │  │ • Reports        │  │
│ • Experiments   │  │ • KQL DB     │  │ • Semantic       │  │
└─────────────────┘  └──────────────┘  │   Models         │  │
                                       └──────────────────┘  │
                                                              │
        ┌─────────────────────────────────────────────────────┤
        │                  Security & Governance               │
        │                                                       │
        │  ┌──────────────┐  ┌──────────────┐  ┌───────────┐ │
        │  │ Microsoft    │  │ Sensitivity  │  │ Audit     │ │
        │  │ Purview      │  │ Labels       │  │ Logs      │ │
        │  │ (Catalog)    │  │ (DLP)        │  │ (SIEM)    │ │
        │  └──────────────┘  └──────────────┘  └───────────┘ │
        └───────────────────────────────────────────────────────┘
```

---

## Deployment Structure

```
infrastructure/fabric/
├── README.md                                    # This file
├── powershell/
│   ├── Deploy-FabricLandingZone.ps1            # Main deployment orchestration
│   ├── modules/
│   │   ├── Create-FabricCapacity.ps1           # Capacity provisioning
│   │   ├── Create-FabricWorkspaces.ps1         # Workspace creation (Dev/Test/Prod)
│   │   ├── Configure-Security.ps1              # RBAC, Azure AD, Private Link
│   │   ├── Configure-Governance.ps1            # Purview, DLP, sensitivity labels
│   │   ├── Configure-Monitoring.ps1            # Azure Monitor, alerts, logging
│   │   ├── Configure-OneLake.ps1               # OneLake folder structure, retention
│   │   └── Configure-Compliance.ps1            # Compliance policies per industry
│   └── parameters/
│       ├── dev.parameters.json
│       ├── test.parameters.json
│       ├── uat.parameters.json
│       └── prod.parameters.json
│
├── terraform/                                   # Terraform alternative (Azure RM Provider)
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── modules/
│       ├── fabric-capacity/
│       ├── fabric-workspace/
│       ├── security/
│       ├── governance/
│       └── monitoring/
│
├── templates/
│   ├── workspace-templates/
│   │   ├── data-engineering-workspace.json     # Standard DE workspace
│   │   ├── data-science-workspace.json         # Standard DS workspace
│   │   ├── reporting-workspace.json            # Standard Power BI workspace
│   │   └── streaming-analytics-workspace.json  # Real-Time Analytics workspace
│   │
│   ├── lakehouse-templates/
│   │   ├── medallion-architecture/
│   │   │   ├── bronze-layer.json               # Raw data ingestion
│   │   │   ├── silver-layer.json               # Cleansed, conformed data
│   │   │   └── gold-layer.json                 # Business-ready aggregates
│   │   └── feature-store/
│   │       └── ml-feature-store.json           # ML feature engineering
│   │
│   └── pipeline-templates/
│       ├── batch-ingestion-pipeline.json       # Batch data ingestion
│       ├── streaming-ingestion-pipeline.json   # Real-time ingestion
│       └── transformation-pipeline.json        # Data transformation
│
├── policies/
│   ├── workspace-policies/
│   │   ├── admin-only-workspace-creation.json
│   │   ├── workspace-naming-convention.json
│   │   └── workspace-retention-policy.json
│   │
│   ├── data-policies/
│   │   ├── data-residency-policy.json          # GDPR: Data must stay in region
│   │   ├── encryption-required-policy.json     # All data encrypted at rest
│   │   ├── pii-detection-policy.json           # PII auto-detection and masking
│   │   └── retention-policy.json               # Data retention per compliance
│   │
│   └── security-policies/
│       ├── conditional-access-policy.json      # Azure AD conditional access
│       ├── mfa-required-policy.json            # MFA for all admin access
│       ├── private-link-required.json          # Private Link for sensitive workloads
│       └── row-level-security-policy.json      # RLS enforcement template
│
├── scripts/
│   ├── deploy-landing-zone.ps1                 # One-click deployment
│   ├── validate-compliance.ps1                 # Compliance validation scan
│   ├── setup-monitoring.ps1                    # Configure monitoring
│   ├── backup-fabric-items.ps1                 # Git integration for DR
│   ├── migrate-from-synapse.ps1                # Migration from Azure Synapse
│   └── cost-optimization.ps1                   # Capacity right-sizing
│
└── docs/
    ├── architecture-decision-records/
    │   ├── 001-capacity-sizing.md
    │   ├── 002-workspace-hierarchy.md
    │   ├── 003-security-model.md
    │   └── 004-disaster-recovery.md
    │
    ├── compliance/
    │   ├── gdpr-compliance-guide.md
    │   ├── soc2-compliance-guide.md
    │   ├── pci-dss-compliance-guide.md
    │   ├── hipaa-compliance-guide.md
    │   └── industry-specific/
    │       ├── financial-services-compliance.md
    │       ├── healthcare-compliance.md
    │       ├── retail-compliance.md
    │       └── public-sector-compliance.md
    │
    ├── runbooks/
    │   ├── capacity-management-runbook.md
    │   ├── incident-response-runbook.md
    │   ├── disaster-recovery-runbook.md
    │   └── security-breach-runbook.md
    │
    └── best-practices/
        ├── onelake-organization.md
        ├── workspace-governance.md
        ├── cost-optimization.md
        └── performance-tuning.md
```

---

## Quick Start (15 Minutes to Production)

### Prerequisites

- **Azure Subscription** with Contributor or Owner role
- **Microsoft Fabric Capacity** enabled in subscription (F2 minimum for dev, F64+ recommended for production)
- **Azure AD Global Administrator** or Privileged Role Administrator (for security setup)
- **Power BI Premium** (included with Fabric capacity)
- **PowerShell 7+** installed
- **Azure CLI** installed and authenticated
- **Fabric Admin Portal** access

### Step-by-Step Deployment

```powershell
# ═══════════════════════════════════════════════════════════════════════════
# Step 1: Prerequisites Check
# ═══════════════════════════════════════════════════════════════════════════

# Login to Azure
Connect-AzAccount
Set-AzContext -Subscription "Your-Subscription-Name"

# Verify Fabric is enabled
$subscription = Get-AzSubscription
Write-Host "Subscription: $($subscription.Name)"
Write-Host "Fabric Provider Registered: " -NoNewline
(Get-AzResourceProvider -ProviderNamespace Microsoft.Fabric).RegistrationState

# If not registered, register Fabric provider
Register-AzResourceProvider -ProviderNamespace Microsoft.Fabric

# ═══════════════════════════════════════════════════════════════════════════
# Step 2: Clone Repository
# ═══════════════════════════════════════════════════════════════════════════

git clone https://github.com/andreaswasita/AI-Delivery-Methodology.git
cd AI-Delivery-Methodology/infrastructure/fabric

# ═══════════════════════════════════════════════════════════════════════════
# Step 3: Configure Deployment Parameters
# ═══════════════════════════════════════════════════════════════════════════

$config = @{
    # Capacity Configuration
    CapacityName       = "fabric-ai-prod"
    CapacitySKU        = "F64"              # F2, F4, F8, F16, F32, F64, F128, F256, F512, F1024, F2048
    Region             = "australiaeast"    # Or your compliance region
    
    # Workspace Configuration
    WorkspacePrefix    = "ai-platform"
    Environments       = @("dev", "test", "prod")
    
    # Security Configuration
    EnablePrivateLink  = $true
    EnableCMK          = $false             # Customer-Managed Keys (set true for HIPAA/PCI-DSS)
    RequireMFA         = $true
    
    # Governance Configuration
    EnablePurview      = $true              # Microsoft Purview integration
    EnableDLP          = $true              # Data Loss Prevention
    EnableAuditLogs    = $true
    LogRetentionDays   = 365                # GDPR/SOC2 requirement
    
    # Compliance Profiles
    ComplianceProfile  = "FinancialServices" # GDPR, SOC2, HIPAA, PCI-DSS, FinancialServices, Healthcare, Retail, PublicSector
    
    # Cost Management
    EnableAutoScale    = $false             # Keep false for production (predictable costs)
    EnableCostAlerts   = $true
    MonthlyBudget      = 5000               # USD
}

# ═══════════════════════════════════════════════════════════════════════════
# Step 4: Deploy Fabric Landing Zone (ONE COMMAND!)
# ═══════════════════════════════════════════════════════════════════════════

./scripts/deploy-landing-zone.ps1 -Config $config -Verbose

# ⏱️ Deployment Timeline:
# • Capacity provisioning: 2-3 minutes
# • Workspace creation: 2 minutes
# • Security configuration: 3-4 minutes
# • Governance setup: 3-4 minutes
# • Monitoring configuration: 2-3 minutes
# • Compliance validation: 2 minutes
# ✅ Total: ~15 minutes to production-ready environment

# ═══════════════════════════════════════════════════════════════════════════
# Step 5: Validate Deployment
# ═══════════════════════════════════════════════════════════════════════════

./scripts/validate-compliance.ps1 -CapacityName "fabric-ai-prod" -ComplianceProfile "FinancialServices"

# Output example:
# ✅ GDPR Compliance: PASSED
#    ├─ Data residency: australiaeast (PASSED)
#    ├─ Encryption at rest: Enabled (PASSED)
#    ├─ PII detection: Enabled (PASSED)
#    └─ Audit logging: 365 days retention (PASSED)
# 
# ✅ SOC 2 Compliance: PASSED
#    ├─ Access controls: MFA enabled (PASSED)
#    ├─ Audit logs: Enabled and forwarded to Log Analytics (PASSED)
#    ├─ Monitoring: Azure Monitor integration active (PASSED)
#    └─ Incident response: Runbooks configured (PASSED)
# 
# ✅ Financial Services Compliance: PASSED
#    ├─ APRA CPS 234: Network isolation via Private Link (PASSED)
#    ├─ Data retention: 7 years (PASSED)
#    ├─ Backup: Automated daily backups enabled (PASSED)
#    └─ Disaster recovery: Cross-region DR configured (PASSED)

# ═══════════════════════════════════════════════════════════════════════════
# Step 6: Access Fabric Workspaces
# ═══════════════════════════════════════════════════════════════════════════

# Open Fabric Portal
Start-Process "https://app.fabric.microsoft.com"

# Your deployed workspaces:
# • ai-platform-dev   (Development environment)
# • ai-platform-test  (Testing environment)
# • ai-platform-prod  (Production environment)
```

---

## What Gets Deployed

### Core Components

| Component | Description | Compliance Controls | Cost Estimate |
|-----------|-------------|---------------------|---------------|
| **Fabric Capacity** | F64 SKU (dedicated compute) | SOC 2, ISO 27001, GDPR | $5,000/month |
| **Workspaces** | Dev, Test, Prod (isolated) | RBAC, Conditional Access | Included in capacity |
| **OneLake Storage** | Unified data lake (multi-region RA-GRS) | GDPR data residency, encryption | $0.018/GB/month |
| **Lakehouse** | Medallion architecture (Bronze/Silver/Gold) | Row-level security, lineage tracking | Included in capacity |
| **Data Factory** | Pipelines, Dataflows Gen2 | Audit logs, PII masking | Included in capacity |
| **Synapse Data Engineering** | Spark notebooks, libraries | Isolated compute pools | Included in capacity |
| **Data Warehouse** | SQL analytics engine | TDE encryption, dynamic masking | Included in capacity |
| **Data Science** | ML notebooks, models, experiments | Model governance, versioning | Included in capacity |
| **Real-Time Analytics** | Event streams, KQL database | Streaming audit logs | Included in capacity |
| **Power BI** | Reports, dashboards, semantic models | RLS, OLS, sensitivity labels | Included in capacity |
| **Microsoft Purview** | Data catalog, lineage, classifications | GDPR compliance mapping | $0.25/vCore-hour (optional) |
| **Azure Monitor** | Metrics, logs, alerts | 365-day retention for SOC 2 | ~$200/month |
| **Azure AD Integration** | SSO, MFA, Conditional Access | ISO 27001, SOC 2 | Included |
| **Private Link** | Private network connectivity | PCI-DSS, HIPAA | $0.01/GB processed |

**Total Estimated Monthly Cost (Production)**:
- **Small (F64)**: ~$5,500/month (10-20 users, <10TB data)
- **Medium (F128-F256)**: ~$10,000-20,000/month (50-100 users, 10-50TB data)
- **Large (F512+)**: ~$40,000+/month (100+ users, 50TB+ data)

---

## Compliance Coverage by Industry

### 1. Financial Services (Banking, Insurance, Wealth Management)

**Regulations**: APRA CPS 234, PCI-DSS, SOC 2, ISO 27001, Basel III, MiFID II

✅ **Controls Implemented**:

| Control | Implementation | Evidence Location |
|---------|----------------|-------------------|
| **Data Residency** | Capacity deployed in australiaeast region, data does not leave Australia | Capacity settings → Region |
| **Network Isolation** | Private Link enabled, no public internet access | Workspace settings → Security |
| **Encryption** | AES-256 at rest, TLS 1.3 in transit | OneLake settings → Encryption |
| **Access Controls** | MFA required, conditional access (location, device compliance) | Azure AD → Conditional Access policies |
| **Audit Logging** | All data access logged, 7-year retention for APRA | Azure Monitor → Logs (365 days), Archive Storage (7 years) |
| **Incident Response** | Automated alerting, 15-minute RTO/RPO | Runbooks → Incident Response |
| **Data Masking** | PII auto-detection, dynamic masking for non-prod | Data Warehouse → Dynamic Data Masking |
| **Disaster Recovery** | Cross-region replication, automated failover | OneLake → Geo-redundancy settings |
| **Third-Party Risk** | Microsoft Fabric SOC 2 Type II audit report | [Azure Compliance Documentation](https://aka.ms/fabriccompliance) |
| **Model Risk Management** | Model versioning, A/B testing, rollback capability | Data Science → ML models → Version history |

**Deployment Configuration**:
```powershell
$config = @{
    ComplianceProfile = "FinancialServices"
    Region            = "australiaeast"
    EnablePrivateLink = $true
    EnableCMK         = $true  # Customer-managed keys for sensitive data
    LogRetentionDays  = 2555   # 7 years for APRA CPS 234
    RequireMFA        = $true
}
```

---

### 2. Healthcare & Life Sciences

**Regulations**: HIPAA, HITECH, FDA 21 CFR Part 11, GDPR (for EU patients)

✅ **Controls Implemented**:

| Control | Implementation | Evidence Location |
|---------|----------------|-------------------|
| **PHI Protection** | Sensitivity labels (Highly Confidential - PHI), access restricted | Information Protection → Sensitivity labels |
| **Encryption** | FIPS 140-2 compliant encryption, customer-managed keys | OneLake → Encryption settings |
| **Access Logging** | All PHI access logged with user identity, timestamp | Azure Monitor → Audit logs |
| **Minimum Necessary** | Role-based access control (RBAC), row-level security (RLS) | Workspace → Security settings |
| **Business Associate Agreement** | Microsoft BAA for HIPAA compliance | [Microsoft HIPAA BAA](https://aka.ms/hipaa) |
| **Data Retention** | 6-year retention for HIPAA, automated deletion post-retention | OneLake → Retention policies |
| **Patient Consent** | Consent metadata stored, enforced via RLS | Lakehouse → Consent tracking table |
| **Audit Reports** | Quarterly audit reports generated automatically | Power BI → Compliance dashboards |

**Deployment Configuration**:
```powershell
$config = @{
    ComplianceProfile = "Healthcare"
    Region            = "eastus"           # HIPAA-compliant region
    EnablePrivateLink = $true
    EnableCMK         = $true              # Required for HIPAA
    LogRetentionDays  = 2190               # 6 years
    RequireMFA        = $true
    EnableDLP         = $true              # Detect and block PHI leakage
}
```

---

### 3. Retail & E-Commerce

**Regulations**: PCI-DSS (for payment data), GDPR, CCPA, SOC 2

✅ **Controls Implemented**:

| Control | Implementation | Evidence Location |
|---------|----------------|-------------------|
| **Cardholder Data** | Payment data stored in separate workspace, tokenized | Workspace → PCI-DSS dedicated workspace |
| **Network Segmentation** | PCI workspace isolated via Private Link | Azure networking → Private endpoints |
| **Encryption** | PCI-DSS compliant encryption (AES-256, TLS 1.2+) | OneLake → Encryption |
| **Access Logging** | All payment data access logged, quarterly reviews | Azure Monitor → Logs |
| **Vulnerability Scanning** | Automated scanning via Microsoft Defender | Azure Security Center |
| **Customer Consent** | GDPR/CCPA consent flags, right to deletion workflow | Lakehouse → Consent management |
| **Data Retention** | GDPR 30-day deletion SLA, automated workflows | OneLake → Retention policies |

**Deployment Configuration**:
```powershell
$config = @{
    ComplianceProfile = "Retail"
    Region            = "westus2"
    EnablePrivateLink = $true              # PCI-DSS requirement
    EnableCMK         = $true              # PCI-DSS for encrypted cardholder data
    LogRetentionDays  = 365                # PCI-DSS requires 1 year
    RequireMFA        = $true
    EnableDLP         = $true              # Prevent credit card leakage
}
```

---

### 4. Public Sector & Government

**Regulations**: FedRAMP (US), IRAP (Australia), ISO 27001, NIST 800-53

✅ **Controls Implemented**:

| Control | Implementation | Evidence Location |
|---------|----------------|-------------------|
| **Data Sovereignty** | Capacity deployed in government-approved regions | Capacity → Region settings |
| **Access Controls** | Multi-factor authentication, role-based access | Azure AD → Conditional Access |
| **Audit Logging** | Comprehensive audit logs, tamper-proof storage | Azure Monitor → Immutable logs |
| **Incident Response** | NIST 800-61 compliant incident response plan | Runbooks → Incident Response |
| **Continuous Monitoring** | Real-time monitoring, automated alerts | Azure Monitor → Alerts |
| **Supply Chain Risk** | Microsoft Fabric Supply Chain Security documentation | [Azure Government Compliance](https://aka.ms/azuregovcompliance) |
| **Data Classification** | Sensitivity labels (Unclassified, Protected, Secret) | Information Protection → Labels |

**Deployment Configuration**:
```powershell
$config = @{
    ComplianceProfile = "PublicSector"
    Region            = "australiacentral"  # IRAP-certified region
    EnablePrivateLink = $true
    EnableCMK         = $true               # Government data protection
    LogRetentionDays  = 2555                # 7 years for government records
    RequireMFA        = $true
    EnablePurview     = $true               # Data classification required
}
```

---

## Security Architecture

### 1. Identity & Access Management

```
Azure AD Tenant
│
├─── Security Groups (Synced from on-premises AD or cloud-only)
│    ├─── Fabric-Admins (Capacity management, tenant settings)
│    ├─── Fabric-DataEngineers (Workspace Admin, create/modify pipelines)
│    ├─── Fabric-DataScientists (Workspace Contributor, notebooks, models)
│    ├─── Fabric-Analysts (Workspace Viewer, read-only access)
│    └─── Fabric-Auditors (Read-only audit logs, compliance reports)
│
├─── Conditional Access Policies
│    ├─── Require MFA for all Fabric access
│    ├─── Block access from non-corporate devices
│    ├─── Require compliant device (Intune-managed)
│    └─── Geo-fencing (block access from non-approved countries)
│
└─── Privileged Identity Management (PIM)
     ├─── Just-In-Time (JIT) admin access (max 8 hours)
     ├─── Approval workflow for Fabric Admin role
     └─── Audit logs for all privileged operations
```

### 2. Network Security

```
┌─────────────────────────────────────────────────────────────────┐
│  Azure Virtual Network (Hub-and-Spoke Topology)                  │
│                                                                  │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Hub VNet (Shared Services)                               │  │
│  │  ├─ Azure Firewall (egress filtering)                     │  │
│  │  ├─ Azure Bastion (secure RDP/SSH)                        │  │
│  │  └─ Azure Monitor (centralized logging)                   │  │
│  └──────────────────────────────────────────────────────────┘  │
│                            │                                     │
│       ┌────────────────────┴────────────────────┐               │
│       │                                         │               │
│  ┌────▼────────────────┐              ┌────────▼─────────────┐ │
│  │ Spoke VNet (Prod)   │              │ Spoke VNet (Non-Prod)│ │
│  │                     │              │                      │ │
│  │ • Private Endpoint  │              │ • Private Endpoint   │ │
│  │   to Fabric         │              │   to Fabric          │ │
│  │   (prod workspace)  │              │   (dev/test)         │ │
│  │                     │              │                      │ │
│  │ • NSG Rules:        │              │ • NSG Rules:         │ │
│  │   - Allow 443 HTTPS │              │   - Allow 443 HTTPS  │ │
│  │   - Deny all else   │              │   - Deny all else    │ │
│  └─────────────────────┘              └──────────────────────┘ │
└─────────────────────────────────────────────────────────────────┘
```

**Key Security Controls**:
- **Private Link**: All Fabric traffic over private IP addresses (no public internet)
- **Service Endpoints**: OneLake accessed via Azure Backbone network (not public internet)
- **TLS 1.3**: All data in transit encrypted
- **Certificate Pinning**: Prevent man-in-the-middle attacks

### 3. Data Protection

```
┌───────────────────────────────────────────────────────────────────┐
│                       OneLake Data Lake                            │
│                                                                    │
│  Encryption at Rest:                                              │
│  ├─ Microsoft-Managed Keys (default, FIPS 140-2)                  │
│  └─ Customer-Managed Keys (CMK) via Azure Key Vault               │
│     └─ Key rotation: Automatic every 90 days                      │
│                                                                    │
│  Encryption in Transit:                                           │
│  └─ TLS 1.3 (all connections)                                     │
│                                                                    │
│  Data Classification (Sensitivity Labels):                        │
│  ├─ Public                                                        │
│  ├─ Internal                                                      │
│  ├─ Confidential                                                  │
│  └─ Highly Confidential (PII, PHI, Payment Data)                 │
│                                                                    │
│  Data Loss Prevention (DLP):                                      │
│  ├─ Block sharing of Highly Confidential data outside org        │
│  ├─ Alert on PII/PHI detection in reports                        │
│  └─ Prevent screenshot/download of sensitive data                │
│                                                                    │
│  Row-Level Security (RLS):                                        │
│  └─ Users only see data for their region/department              │
│                                                                    │
│  Object-Level Security (OLS):                                     │
│  └─ Hide sensitive columns (e.g., SSN, credit card) from analysts│
└───────────────────────────────────────────────────────────────────┘
```

---

## Governance Framework

### 1. Data Catalog (Microsoft Purview Integration)

```
Microsoft Purview <──────┐
                         │ (Automatic scanning & lineage)
                         │
    ┌────────────────────┴─────────────────────┐
    │         Fabric Workspace (Prod)           │
    │                                          │
    │  Lakehouse: CustomerData                 │
    │  ├─ Tables (auto-cataloged)              │
    │  │  ├─ customers (PII detected)          │
    │  │  │  └─ Sensitivity: Highly Confidential│
    │  │  │  └─ Owner: Data Engineering Team    │
    │  │  │  └─ Lineage: CRM → Pipeline → Table │
    │  │  └─ transactions (Financial data)      │
    │  │     └─ Sensitivity: Confidential       │
    │  └─ Data Quality: 95% (auto-scored)       │
    │                                          │
    │  Data Warehouse: SalesAnalytics          │
    │  └─ Lineage: Lakehouse → Transformation  │
    │     └─ Power BI Report: Monthly Sales    │
    └───────────────────────────────────────────┘
```

**Governance Policies**:
- **Automated Scanning**: All Fabric items scanned daily, PII detected automatically
- **Lineage Tracking**: End-to-end lineage from source system to Power BI report
- **Ownership**: Every dataset has assigned owner (auto-assigned or manual)
- **Data Quality Scores**: Automated profiling, completeness/accuracy scores
- **Retention Policies**: Automated deletion after retention period (GDPR compliance)

### 2. Workspace Governance

```
┌─────────────────────────────────────────────────────────────────┐
│  Workspace Hierarchy & Governance Model                          │
│                                                                  │
│  Production Workspace (ai-platform-prod)                         │
│  ├─ Access: Restricted to Production Admins only                │
│  ├─ Deployment: Git-based CI/CD (Azure DevOps or GitHub Actions)│
│  ├─ Approval: Change Advisory Board (CAB) approval required     │
│  ├─ Monitoring: Real-time alerts on failures, SLA breaches      │
│  └─ Backup: Daily automated backup to Git repository            │
│                                                                  │
│  Test Workspace (ai-platform-test)                               │
│  ├─ Access: Data Engineers, Data Scientists (Contributor)       │
│  ├─ Deployment: Automated from Dev workspace                    │
│  ├─ Data: Anonymized production data (GDPR-compliant)           │
│  └─ Monitoring: Performance testing, load testing               │
│                                                                  │
│  Dev Workspace (ai-platform-dev)                                 │
│  ├─ Access: All developers (Contributor)                        │
│  ├─ Deployment: Manual, ad-hoc testing                          │
│  ├─ Data: Synthetic data only (no real PII/PHI)                 │
│  └─ Monitoring: Basic error logs                                │
└─────────────────────────────────────────────────────────────────┘
```

---

## Monitoring & Alerting

### 1. Azure Monitor Integration

```powershell
# Fabric metrics exported to Azure Monitor Log Analytics

# Key Metrics Monitored:
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Capacity Metrics:
• CPU Utilization (alert if >80% for 10 minutes)
• Memory Utilization (alert if >85% for 10 minutes)
• Throttling Events (alert immediately on any throttling)
• Capacity Units Consumed (track against monthly budget)

# Workspace Metrics:
• Pipeline Success Rate (alert if <95%)
• Notebook Execution Failures (alert on any failure)
• Data Refresh Failures (alert immediately)
• Query Performance (alert if p95 latency >5 seconds)

# Security Metrics:
• Failed Login Attempts (alert if >5 failed attempts in 5 minutes)
• Unauthorized Access Attempts (alert immediately)
• Data Exfiltration (alert on large data downloads >1GB)
• Privilege Escalation (alert on any admin role assignment)

# Compliance Metrics:
• PII Access Count (daily report)
• Audit Log Completeness (alert if logs missing)
• Retention Policy Violations (alert on data past retention)
```

### 2. Alert Rules

| Alert | Severity | Threshold | Action |
|-------|----------|-----------|--------|
| **Capacity Throttling** | Critical | Any throttling event | Page on-call engineer, auto-scale capacity (if enabled) |
| **Data Pipeline Failure** | High | Any pipeline failure | Notify Data Engineering team, run retry logic |
| **Security Breach Attempt** | Critical | >5 failed logins in 5 min | Lock account, notify Security team, trigger incident response |
| **Compliance Violation** | High | PII accessed without justification | Notify Compliance team, generate audit report |
| **Cost Overrun** | Medium | Monthly spend >110% of budget | Notify Finance team, recommend capacity downgrade |
| **Performance Degradation** | Medium | Query latency p95 >5 seconds | Notify Data Engineering, investigate query optimization |

### 3. Compliance Dashboards (Power BI)

```
Power BI Workspace: Compliance & Governance

Dashboards:
├─ GDPR Compliance Dashboard
│  ├─ Data Residency Map (all data locations)
│  ├─ PII Access Log (who accessed, when, why)
│  ├─ Data Subject Requests (GDPR deletion requests)
│  └─ Consent Management (active consents, expirations)
│
├─ SOC 2 Audit Dashboard
│  ├─ Access Control Review (quarterly certification)
│  ├─ Security Incident Tracker (open incidents)
│  ├─ Audit Log Completeness (365-day retention verified)
│  └─ Penetration Test Results (quarterly pen tests)
│
├─ Financial Services Compliance
│  ├─ APRA CPS 234 Controls Matrix (status of all controls)
│  ├─ Incident Response Time (RTO/RPO metrics)
│  ├─ Third-Party Risk Register (Microsoft Fabric risk assessment)
│  └─ Model Risk Management (model performance, drift detection)
│
└─ Cost & Usage Dashboard
   ├─ Capacity Utilization (by workspace, by user)
   ├─ Monthly Cost Trends (vs budget)
   ├─ Chargeback Report (cost allocation by department)
   └─ Optimization Recommendations (right-sizing capacity)
```

---

## Disaster Recovery & Business Continuity

### 1. Backup Strategy

| Item Type | Backup Frequency | Retention | Recovery Method |
|-----------|-----------------|-----------|-----------------|
| **Lakehouse Data** | Continuous (OneLake versioning) | 30 days snapshot history | Point-in-time restore via OneLake API |
| **Fabric Items** | Daily (Git sync) | Indefinite in Git repo | Redeploy from Git repository |
| **Data Warehouse** | Daily full backup | 7 days | Restore from backup file |
| **Power BI Reports** | On change (Git sync) | Indefinite in Git repo | Redeploy from Git repository |
| **Workspace Config** | On change (IaC) | Indefinite in Git repo | Redeploy via Terraform/PowerShell |

### 2. Disaster Recovery Plan

```
┌─────────────────────────────────────────────────────────────────┐
│  Disaster Recovery Architecture (Cross-Region)                   │
│                                                                  │
│  Primary Region: australiaeast                                   │
│  ├─ Fabric Capacity: fabric-ai-prod (F64)                       │
│  ├─ OneLake Storage: RA-GRS (read-access geo-redundant)         │
│  └─ Workspaces: ai-platform-dev, ai-platform-test, ai-platform-prod│
│                                                                  │
│  Secondary Region: australiasoutheast (DR region)                │
│  ├─ Fabric Capacity: fabric-ai-dr (F32 - standby)               │
│  ├─ OneLake Storage: Geo-replicated (automatic)                 │
│  └─ Workspaces: DR copies (cold standby, activated on failover) │
│                                                                  │
│  Failover Process (RTO: 15 minutes, RPO: 5 minutes)             │
│  1. Detect outage (automated monitoring)                        │
│  2. Promote secondary OneLake to primary (automatic)            │
│  3. Activate DR capacity (scale up from F32 to F64)             │
│  4. Update DNS/Private Link to point to DR region               │
│  5. Notify users of failover (SMS/email)                        │
│  6. Resume operations in DR region                              │
└─────────────────────────────────────────────────────────────────┘
```

**DR Testing Schedule**:
- **Quarterly**: Full DR failover test (non-business hours)
- **Monthly**: DR capacity verification (ensure DR capacity can scale)
- **Weekly**: Backup restoration test (restore 1 lakehouse table)

---

## Cost Optimization Strategies

### 1. Capacity Right-Sizing

| Scenario | Recommended SKU | Monthly Cost | Users Supported | Data Volume |
|----------|----------------|--------------|-----------------|-------------|
| **Proof of Concept** | F2 | $262 | 1-5 users | <1TB |
| **Development** | F8-F16 | $1,048-$2,096 | 5-20 users | 1-10TB |
| **Production (Small)** | F64 | $8,384 | 20-50 users | 10-50TB |
| **Production (Medium)** | F128-F256 | $16,768-$33,536 | 50-200 users | 50-200TB |
| **Production (Large)** | F512-F1024 | $67,072-$134,144 | 200-1000 users | 200TB-1PB |
| **Enterprise** | F2048 | $268,288 | 1000+ users | 1PB+ |

**Cost Optimization Tips**:
1. **Pause Capacity During Off-Hours**: Pause capacity on weekends/nights (dev/test environments)
   - Savings: ~70% reduction for non-production environments
2. **OneLake Lifecycle Management**: Archive cold data to lower-cost tiers (Cool, Archive)
   - Savings: ~50% storage costs for data >90 days old
3. **Query Optimization**: Optimize Spark/SQL queries to reduce compute time
   - Savings: 20-30% reduction in capacity consumption
4. **Incremental Processing**: Use incremental refresh instead of full refresh
   - Savings: 50-80% reduction in pipeline runtime
5. **Chargeback Model**: Implement chargeback to business units (incentivizes efficiency)

### 2. Cost Monitoring & Alerts

```powershell
# Set up cost alerts

# Alert 1: 80% of monthly budget
New-AzMetricAlert -Name "Fabric-Cost-80Percent" `
    -ResourceId "/subscriptions/{sub-id}/resourceGroups/{rg}/providers/Microsoft.Fabric/capacities/fabric-ai-prod" `
    -MetricName "CapacityUnitsConsumed" `
    -Threshold 0.8 `
    -Operator GreaterThan `
    -WindowSize 1d `
    -Frequency 1h `
    -ActionGroupId "/subscriptions/{sub-id}/resourceGroups/{rg}/providers/microsoft.insights/actionGroups/CostAlerts"

# Alert 2: 100% of monthly budget
New-AzMetricAlert -Name "Fabric-Cost-100Percent" `
    -ResourceId "/subscriptions/{sub-id}/resourceGroups/{rg}/providers/Microsoft.Fabric/capacities/fabric-ai-prod" `
    -MetricName "CapacityUnitsConsumed" `
    -Threshold 1.0 `
    -Operator GreaterThan `
    -WindowSize 1d `
    -Frequency 1h `
    -ActionGroupId "/subscriptions/{sub-id}/resourceGroups/{rg}/providers/microsoft.insights/actionGroups/CriticalCostAlerts" `
    -Severity Critical
```

---

## Migration Paths

### 1. From Azure Synapse Analytics to Fabric

```powershell
# Migration script: Synapse → Fabric
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Use provided migration script
./scripts/migrate-from-synapse.ps1 `
    -SourceSynapseWorkspace "synapse-prod" `
    -TargetFabricWorkspace "ai-platform-prod" `
    -MigrateData $true `
    -MigratePipelines $true `
    -MigrateNotebooks $true `
    -MigrateSQL $true `
    -Verbose

# Migration Timeline:
# • Inventory Synapse assets: 1 hour
# • Create Fabric workspace: 5 minutes
# • Migrate data (copy to OneLake): 2-8 hours (depends on data size)
# • Migrate pipelines (convert to Fabric pipelines): 1 hour
# • Migrate notebooks (convert to Fabric notebooks): 30 minutes
# • Migrate SQL scripts (convert to Data Warehouse): 1 hour
# • Testing: 4-8 hours
# • Cutover: 1 hour
# ✅ Total: 1-2 days for most workloads
```

### 2. From Azure Databricks to Fabric

```powershell
# Migration script: Databricks → Fabric
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

./scripts/migrate-from-databricks.ps1 `
    -SourceDatabricksWorkspace "databricks-prod" `
    -TargetFabricWorkspace "ai-platform-prod" `
    -MigrateNotebooks $true `
    -MigrateJobs $true `
    -MigrateDelta $true `
    -Verbose

# Key Considerations:
# • Databricks notebooks → Fabric notebooks (PySpark, Scala supported)
# • Databricks Delta tables → OneLake Delta tables (compatible)
# • Databricks Jobs → Fabric Data Factory pipelines
# • Databricks MLflow → Fabric ML models (requires re-training)
```

### 3. From Power BI Premium to Fabric

```powershell
# Migration: Power BI Premium → Fabric (seamless upgrade)
# ━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

# Fabric includes Power BI Premium (no migration needed!)
# Simply purchase Fabric capacity, workspaces auto-migrate

# 1. Purchase Fabric capacity (F64 or higher)
New-AzFabricCapacity -Name "fabric-ai-prod" -ResourceGroup "rg-fabric" -Location "australiaeast" -Sku "F64"

# 2. Assign existing Power BI workspaces to Fabric capacity
Set-PowerBIWorkspace -Id "workspace-id" -CapacityId "fabric-capacity-id"

# 3. Enable Fabric features in workspace settings
# Done! All Power BI workspaces now have Fabric capabilities (Lakehouse, Data Factory, etc.)
```

---

## Best Practices

### 1. OneLake Organization

```
OneLake (Root)
│
├─ bronze/                      # Raw data (immutable, source of truth)
│  ├─ crm/
│  │  ├─ customers/
│  │  └─ transactions/
│  ├─ erp/
│  └─ iot/
│
├─ silver/                      # Cleansed, conformed data
│  ├─ customer_360/
│  ├─ product_catalog/
│  └─ transactions_enriched/
│
├─ gold/                        # Business-ready aggregates
│  ├─ sales_analytics/
│  ├─ customer_churn/
│  └─ financial_reporting/
│
├─ ml-features/                 # Feature store for ML models
│  ├─ customer_features/
│  └─ product_features/
│
└─ archives/                    # Historical data (>2 years old)
   ├─ bronze_archive/
   └─ silver_archive/
```

### 2. Workspace Naming Convention

```
{environment}-{domain}-{purpose}

Examples:
• prod-sales-analytics       (Production sales analytics workspace)
• dev-finance-reporting      (Development finance reporting workspace)
• test-customer-churn-ml     (Test customer churn ML workspace)
• prod-shared-data-platform  (Production shared data platform)
```

### 3. Security Best Practices

```
✅ DO:
• Use Azure AD groups for access control (never individual users)
• Enable MFA for all admin accounts
• Use Private Link for production workspaces
• Enable audit logging with 365-day retention minimum
• Classify all data with sensitivity labels
• Implement row-level security (RLS) for multi-tenant scenarios
• Use customer-managed keys (CMK) for highly sensitive data
• Rotate service principal secrets every 90 days
• Conduct quarterly access reviews (remove stale accounts)

❌ DON'T:
• Share workspace credentials via email
• Grant Admin access to non-administrators
• Store PII/PHI in workspace names or descriptions
• Use production data in dev/test environments (use anonymized data)
• Disable audit logging (compliance requirement)
• Allow public internet access to sensitive workspaces
• Hardcode connection strings in notebooks/pipelines
```

### 4. Performance Tuning

```
┌─────────────────────────────────────────────────────────────────┐
│  Fabric Performance Optimization Guide                           │
│                                                                  │
│  1. Lakehouse Optimization                                       │
│     • Partition large tables by date (year/month/day)           │
│     • Use Delta format (not Parquet) for ACID transactions      │
│     • Enable V-Order for 3x faster read performance             │
│     • Set optimal file size (128MB-1GB per file)                │
│                                                                  │
│  2. Data Warehouse Optimization                                  │
│     • Use columnstore indexes for analytics queries             │
│     • Implement materialized views for frequently-run queries   │
│     • Partition fact tables by date                             │
│     • Use table distribution (HASH) for large tables            │
│                                                                  │
│  3. Spark Optimization (Notebooks)                               │
│     • Cache frequently-accessed DataFrames                      │
│     • Use broadcast joins for small dimension tables            │
│     • Avoid Spark collect() on large datasets (OOM errors)      │
│     • Set spark.sql.adaptive.enabled = true (adaptive query)    │
│                                                                  │
│  4. Pipeline Optimization (Data Factory)                         │
│     • Use incremental load patterns (not full refresh)          │
│     • Parallelize independent pipeline activities               │
│     • Use Dataflow Gen2 for complex transformations             │
│     • Minimize data movement (process data in-place)            │
│                                                                  │
│  5. Power BI Optimization                                        │
│     • Use DirectLake mode (fastest, no import/DirectQuery)      │
│     • Minimize DAX calculated columns (use source transforms)   │
│     • Set up incremental refresh for large datasets             │
│     • Use aggregations for billion-row tables                   │
└─────────────────────────────────────────────────────────────────┘
```

---

## Troubleshooting & Support

### Common Issues

| Issue | Cause | Solution |
|-------|-------|----------|
| **Capacity throttling** | Exceeded capacity limits | Scale up capacity or optimize queries |
| **Pipeline failures** | Connection timeout, data quality issues | Review pipeline logs, add retry logic |
| **Slow query performance** | Missing indexes, large table scans | Add indexes, partition tables, use V-Order |
| **Access denied errors** | RBAC misconfiguration | Review workspace security settings, check Azure AD groups |
| **Data not refreshing** | Expired credentials, source system down | Refresh credentials, check source connectivity |
| **High costs** | Inefficient queries, unused capacity | Run cost optimization script, pause unused capacity |

### Support Channels

1. **Microsoft Support**: Open support ticket via Azure Portal (Premier Support recommended for production)
2. **Fabric Community**: [https://community.fabric.microsoft.com](https://community.fabric.microsoft.com)
3. **Microsoft Docs**: [https://learn.microsoft.com/fabric](https://learn.microsoft.com/fabric)
4. **Internal Support**: Contact your organization's Fabric Center of Excellence

---

## Roadmap

| Quarter | Feature | Description |
|---------|---------|-------------|
| **Q1 2026** | Git Integration (GA) | Full CI/CD support for Fabric items |
| **Q2 2026** | Fabric Copilot | AI-powered data insights, query generation |
| **Q3 2026** | Multi-cloud OneLake | OneLake access from AWS/GCP |
| **Q4 2026** | Fabric API Enhancements | RESTful APIs for all Fabric items |

---

## Additional Resources

- **Microsoft Fabric Documentation**: [https://learn.microsoft.com/fabric](https://learn.microsoft.com/fabric)
- **Fabric Adoption Roadmap**: [https://aka.ms/FabricAdoption](https://aka.ms/FabricAdoption)
- **Compliance & Security**: [https://aka.ms/FabricCompliance](https://aka.ms/FabricCompliance)
- **Fabric Pricing Calculator**: [https://azure.microsoft.com/pricing/details/microsoft-fabric/](https://azure.microsoft.com/pricing/details/microsoft-fabric/)
- **GitHub Repository**: [https://github.com/andreaswasita/AI-Delivery-Methodology](https://github.com/andreaswasita/AI-Delivery-Methodology)

---

## License

This Fabric Landing Zone is part of the AI Delivery Methodology repository.

**Copyright © 2026**  
Licensed under MIT License

---

## Changelog

| Version | Date | Changes |
|---------|------|---------|
| 1.0.0 | 2026-01-13 | Initial release with compliance coverage for Financial Services, Healthcare, Retail, Public Sector |

---

**Questions or Issues?**  
Open an issue on GitHub: [https://github.com/andreaswasita/AI-Delivery-Methodology/issues](https://github.com/andreaswasita/AI-Delivery-Methodology/issues)
