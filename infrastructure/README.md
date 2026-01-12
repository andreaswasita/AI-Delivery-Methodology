# Azure Platform Infrastructure Setup
## Standardized, Compliance-Ready Infrastructure for AI Use Cases

**Purpose**: Production-ready Azure infrastructure templates with built-in compliance for all AI use cases  
**Compliance**: GDPR, SOC 2, ISO 27001, PCI-DSS, APRA CPS 234, industry-specific regulations  
**Last Updated**: January 13, 2026

---

## Overview

This infrastructure setup provides **standardized, secure, compliant Azure environments** that can be deployed for any AI use case with minimal customization.

### Key Features

✅ **Compliance-First Design**
- GDPR data residency and privacy controls
- SOC 2 Type II audit-ready logging and monitoring
- ISO 27001 security controls
- PCI-DSS Level 1 (for payment data)
- APRA CPS 234 (for Australian financial services)
- HIPAA-ready (for healthcare)

✅ **Security Hardening**
- Network isolation (private endpoints, no public access)
- Encryption at rest and in transit
- Key management with Azure Key Vault
- Managed identities (no credentials in code)
- Azure DDoS Protection
- Azure Defender for Cloud enabled

✅ **Data Governance**
- Data classification and labeling
- Data lineage tracking
- PII detection and masking
- Data retention policies
- Backup and disaster recovery

✅ **Observability**
- Centralized logging (Azure Log Analytics)
- Application monitoring (Application Insights)
- Security monitoring (Microsoft Sentinel)
- Cost management and alerting
- Audit trail for all operations

✅ **High Availability**
- Multi-zone deployment
- Automated failover
- 99.9% SLA for core services
- Disaster recovery tested

---

## Repository Structure

```
infrastructure/
├── README.md                          # This file
├── bicep/                             # Bicep templates (recommended)
│   ├── main.bicep                     # Main orchestration
│   ├── modules/
│   │   ├── networking.bicep           # VNet, NSG, Private Endpoints
│   │   ├── compute.bicep              # AKS, VM Scale Sets
│   │   ├── ai-services.bicep          # Azure ML, OpenAI, Cognitive Services
│   │   ├── data.bicep                 # Storage, SQL, Cosmos DB, Data Lake
│   │   ├── security.bicep             # Key Vault, Managed Identity, RBAC
│   │   ├── monitoring.bicep           # Log Analytics, App Insights, Sentinel
│   │   └── governance.bicep           # Policies, Tags, Cost Management
│   └── parameters/
│       ├── dev.parameters.json
│       ├── test.parameters.json
│       ├── uat.parameters.json
│       └── prod.parameters.json
│
├── terraform/                         # Terraform alternative
│   ├── main.tf
│   ├── variables.tf
│   ├── outputs.tf
│   └── modules/
│       ├── networking/
│       ├── compute/
│       ├── ai-services/
│       ├── data/
│       ├── security/
│       ├── monitoring/
│       └── governance/
│
├── scripts/                           # Deployment and setup scripts
│   ├── deploy.ps1                     # PowerShell deployment
│   ├── deploy.sh                      # Bash deployment
│   ├── configure-rbac.ps1             # RBAC configuration
│   ├── setup-monitoring.ps1           # Monitoring setup
│   └── compliance-scan.ps1            # Compliance validation
│
├── policies/                          # Azure Policy definitions
│   ├── data-residency.json
│   ├── encryption-required.json
│   ├── network-isolation.json
│   ├── logging-required.json
│   └── tag-enforcement.json
│
└── docs/
    ├── architecture-diagram.md        # Architecture overview
    ├── compliance-mapping.md          # Compliance controls mapping
    ├── security-baseline.md           # Security configuration
    └── runbook.md                     # Operations guide
```

---

## Quick Start

### Prerequisites

- Azure subscription (with Owner or Contributor role)
- Azure CLI installed (`az --version`)
- PowerShell 7+ (Windows/Linux/Mac)
- Bicep CLI installed (`az bicep version`)

### Deploy Standard Environment (15 minutes)

```powershell
# 1. Clone repository
git clone https://github.com/andreaswasita/AI-Delivery-Methodology.git
cd AI-Delivery-Methodology/infrastructure

# 2. Login to Azure
az login
az account set --subscription "Your-Subscription-Name"

# 3. Set deployment parameters
$resourceGroup = "rg-ai-platform-prod"
$location = "australiaeast"  # Or your preferred region
$environment = "prod"

# 4. Deploy infrastructure (one command!)
./scripts/deploy.ps1 `
    -ResourceGroupName $resourceGroup `
    -Location $location `
    -Environment $environment `
    -EnableCompliance $true `
    -EnableMonitoring $true

# ⏱️ Deployment time: ~15 minutes
# ✅ Result: Full production-ready environment
```

---

## What Gets Deployed

### Core Infrastructure

| Component | Service | Purpose | Compliance |
|-----------|---------|---------|------------|
| **Networking** | Virtual Network | Isolated network for all resources | ISO 27001, SOC 2 |
| | Network Security Groups | Traffic filtering and segmentation | ISO 27001 |
| | Private Endpoints | No public internet access | GDPR, SOC 2 |
| | Azure Firewall | Centralized egress filtering | PCI-DSS |
| | DDoS Protection | Distributed denial-of-service protection | ISO 27001 |
| **AI Services** | Azure Machine Learning | ML model training and deployment | SOC 2, ISO 27001 |
| | Azure OpenAI | GPT-4, embeddings, chat | GDPR, SOC 2 |
| | Cognitive Services | Vision, Speech, Language | GDPR, HIPAA |
| **Data Layer** | Azure Data Lake Gen2 | Data storage with hierarchical namespace | GDPR, PCI-DSS |
| | Azure SQL Database | Relational data with TDE | PCI-DSS, SOC 2 |
| | Cosmos DB | NoSQL for low-latency scenarios | GDPR, SOC 2 |
| | Azure Synapse | Data warehousing and analytics | GDPR, ISO 27001 |
| **Compute** | Azure Kubernetes Service | Container orchestration | SOC 2, ISO 27001 |
| | GPU VM Scale Sets | High-performance model training | ISO 27001 |
| **Security** | Azure Key Vault | Secrets, keys, certificates management | PCI-DSS, SOC 2 |
| | Managed Identity | Passwordless authentication | ISO 27001 |
| | Azure AD | Identity and access management | SOC 2, ISO 27001 |
| | Microsoft Defender | Cloud security posture management | SOC 2, ISO 27001 |
| **Monitoring** | Log Analytics | Centralized logging (365-day retention) | GDPR, SOC 2, APRA |
| | Application Insights | Application performance monitoring | SOC 2 |
| | Microsoft Sentinel | Security information and event management | ISO 27001, SOC 2 |
| | Azure Monitor | Metrics, alerts, dashboards | SOC 2 |
| **Governance** | Azure Policy | Compliance and governance automation | All standards |
| | Cost Management | Budget tracking and alerting | Financial governance |
| | Azure Purview | Data catalog and lineage | GDPR, ISO 27001 |

---

## Compliance Coverage

### GDPR (General Data Protection Regulation)

✅ **Data Residency**
- All data stored in specified region (e.g., Australia East, Southeast Asia)
- No cross-border data transfer without consent
- Data location tracking in Azure Purview

✅ **Data Privacy**
- PII detection and automatic masking
- Data encryption at rest (AES-256) and in transit (TLS 1.3)
- Data anonymization for non-production environments

✅ **Data Subject Rights**
- Data discovery across all services
- Export functionality (JSON, CSV)
- Delete functionality with audit trail
- Consent tracking and management

✅ **Security Measures**
- Multi-factor authentication required
- Role-based access control (least privilege)
- Audit logging for all data access
- Breach notification automation

---

### SOC 2 Type II

✅ **Security**
- Network segmentation and isolation
- Encryption for data at rest and in transit
- Regular vulnerability scanning
- Penetration testing quarterly

✅ **Availability**
- 99.9% uptime SLA
- Multi-zone deployment
- Automated backup every 4 hours
- Disaster recovery tested quarterly

✅ **Processing Integrity**
- Data validation at ingestion
- Model versioning and lineage
- Change management workflow
- Audit trail for all changes

✅ **Confidentiality**
- Data classification (Public, Internal, Confidential, Restricted)
- Access controls based on classification
- Data loss prevention policies
- Encrypted communication channels

✅ **Privacy**
- Privacy impact assessments
- Consent management
- Data retention policies
- Secure data deletion

---

### ISO 27001

✅ **Access Control (A.9)**
- Azure AD authentication required
- MFA enforced for all users
- Privileged Identity Management (PIM)
- Access reviews quarterly

✅ **Cryptography (A.10)**
- TLS 1.3 for all connections
- AES-256 encryption at rest
- Azure Key Vault for key management
- Key rotation every 90 days

✅ **Operations Security (A.12)**
- Change management process
- Capacity management and monitoring
- Malware protection (Defender)
- Backup and recovery procedures

✅ **Communications Security (A.13)**
- Network segmentation via NSGs
- Private endpoints (no public access)
- Azure Firewall for egress filtering
- Secure API gateways

✅ **Incident Management (A.16)**
- Security incident detection (Sentinel)
- Automated alerting (< 15 minutes)
- Incident response playbooks
- Post-incident reviews

---

### PCI-DSS Level 1 (Payment Card Industry)

✅ **Network Security (Req 1-2)**
- Firewall configuration and management
- No default passwords/security parameters
- Network segmentation for cardholder data
- Encrypted wireless networks

✅ **Cardholder Data Protection (Req 3-4)**
- Encryption of stored cardholder data
- Encryption of transmitted cardholder data
- Tokenization for credit card numbers
- Secure key management (Key Vault)

✅ **Vulnerability Management (Req 5-6)**
- Anti-malware (Microsoft Defender)
- Secure systems and applications
- Regular vulnerability scans
- Patch management automation

✅ **Access Control (Req 7-8)**
- Role-based access control
- Unique ID for each user
- Multi-factor authentication
- Access logging and monitoring

✅ **Monitoring and Testing (Req 10-11)**
- Audit trails for all access
- 365-day log retention
- Security testing quarterly
- Intrusion detection (Sentinel)

✅ **Security Policy (Req 12)**
- Information security policy
- Risk assessment annually
- Security awareness training
- Incident response plan

---

### APRA CPS 234 (Australian Prudential Regulation Authority)

✅ **Information Security Capability**
- Board-approved information security strategy
- Dedicated security resources
- Security awareness training program
- Third-party risk management

✅ **Information Asset Identification**
- Data classification framework
- Asset inventory (Azure Purview)
- Data flow mapping
- Critical asset identification

✅ **Implementation Controls**
- Defense-in-depth security architecture
- Access controls (least privilege)
- Encryption (at rest and in transit)
- Security monitoring and logging

✅ **Incident Management**
- Incident response plan
- APRA notification within 72 hours
- Business continuity plan
- Disaster recovery tested semi-annually

---

## Environment Configurations

### Development Environment

**Purpose**: Development and experimentation

**Configuration**:
- Single availability zone
- Smaller compute sizes (cost-optimized)
- Synthetic/anonymized data only
- Public endpoints allowed (with IP restrictions)
- Basic monitoring
- 30-day log retention

**Cost**: ~$1,500-3,000/month

---

### Test/UAT Environment

**Purpose**: User acceptance testing and integration testing

**Configuration**:
- Single availability zone
- Production-like compute sizes
- Masked production data
- Private endpoints required
- Standard monitoring
- 90-day log retention

**Cost**: ~$3,000-5,000/month

---

### Production Environment

**Purpose**: Live customer-facing services

**Configuration**:
- Multi-availability zone (3 zones)
- Production compute sizes with auto-scaling
- Real customer data (encrypted)
- Private endpoints only (no public access)
- Advanced monitoring (Sentinel + Defender)
- 365-day log retention (compliance)
- Geo-redundant backup
- Disaster recovery to secondary region

**Cost**: ~$10,000-25,000/month (varies by usage)

---

## Security Baseline

### Network Security

```
┌─────────────────────────────────────────────────────┐
│         Internet (Public Traffic)                    │
└─────────────────┬───────────────────────────────────┘
                  │
        ┌─────────▼──────────┐
        │  Azure Firewall    │ ← Egress filtering
        │  + DDoS Protection │
        └─────────┬──────────┘
                  │
        ┌─────────▼──────────────────────────────────┐
        │  Virtual Network (10.0.0.0/16)             │
        │                                             │
        │  ┌────────────────────────────────────┐   │
        │  │  Management Subnet                 │   │
        │  │  (10.0.1.0/24)                     │   │
        │  │  - Bastion Host (Jump Box)         │   │
        │  │  - Azure DevOps Agent              │   │
        │  └────────────────────────────────────┘   │
        │                                             │
        │  ┌────────────────────────────────────┐   │
        │  │  AI Services Subnet                │   │
        │  │  (10.0.2.0/24)                     │   │
        │  │  - Azure ML Workspace              │   │
        │  │  - Azure OpenAI (Private Endpoint) │   │
        │  │  - Cognitive Services              │   │
        │  └────────────────────────────────────┘   │
        │                                             │
        │  ┌────────────────────────────────────┐   │
        │  │  Data Subnet                       │   │
        │  │  (10.0.3.0/24)                     │   │
        │  │  - Data Lake (Private Endpoint)    │   │
        │  │  - SQL Database (Private Endpoint) │   │
        │  │  - Cosmos DB (Private Endpoint)    │   │
        │  └────────────────────────────────────┘   │
        │                                             │
        │  ┌────────────────────────────────────┐   │
        │  │  Compute Subnet                    │   │
        │  │  (10.0.4.0/23)                     │   │
        │  │  - AKS Cluster (private)           │   │
        │  │  - GPU VM Scale Set                │   │
        │  └────────────────────────────────────┘   │
        │                                             │
        └─────────────────────────────────────────────┘

All subnets have Network Security Groups (NSGs) with:
- Deny all inbound by default
- Allow specific ports/protocols only
- Logging enabled for all rules
```

### Encryption

**At Rest**:
- Azure Storage: AES-256 with customer-managed keys
- SQL Database: Transparent Data Encryption (TDE)
- Cosmos DB: Automatic encryption
- VM Disks: Azure Disk Encryption

**In Transit**:
- TLS 1.3 for all HTTPS connections
- TLS 1.2 minimum (1.0/1.1 disabled)
- VPN/ExpressRoute for on-premises connectivity
- Private Link for Azure service connections

### Identity & Access

**Authentication**:
- Azure AD only (no local accounts)
- Multi-factor authentication enforced
- Conditional access policies
- Privileged Identity Management (PIM)

**Authorization**:
- Role-Based Access Control (RBAC)
- Least privilege principle
- Custom roles for specific scenarios
- Just-in-time access for privileged operations

---

## Monitoring & Alerting

### Critical Alerts (P1 - 15 min response)

- Service availability < 99%
- Security incident detected
- Data breach suspected
- Cost exceeds 150% of budget
- Compliance violation detected

### High Alerts (P2 - 1 hour response)

- Model accuracy degradation > 5%
- Data drift detected
- Failed backup
- Certificate expiring < 30 days
- API latency > 2 seconds

### Medium Alerts (P3 - 4 hour response)

- Resource utilization > 80%
- Cost exceeds budget
- Failed deployment
- Integration test failure

### Dashboards

1. **Executive Dashboard**: KPIs, cost, compliance status
2. **Operations Dashboard**: Service health, incidents, capacity
3. **Security Dashboard**: Threats, vulnerabilities, compliance
4. **Model Performance Dashboard**: Accuracy, drift, latency

---

## Cost Management

### Budget Tracking

```yaml
Environment: Production
Monthly Budget: $20,000

Breakdown:
  Compute (AKS, VMs):     $8,000  (40%)
  Data Storage:           $2,000  (10%)
  AI Services:            $6,000  (30%)
  Networking:             $1,500  (7.5%)
  Monitoring & Security:  $1,500  (7.5%)
  Backup & DR:            $1,000  (5%)
```

### Cost Optimization

✅ **Auto-Scaling**: Scale compute based on demand
✅ **Reserved Instances**: 30-50% savings for predictable workloads
✅ **Azure Hybrid Benefit**: Use existing licenses
✅ **Spot VMs**: 80% savings for interruptible workloads
✅ **Storage Tiering**: Hot/Cool/Archive tiers based on access patterns
✅ **Cleanup**: Automated deletion of unused resources

---

## Disaster Recovery

### Recovery Objectives

- **RPO (Recovery Point Objective)**: 4 hours (maximum data loss)
- **RTO (Recovery Time Objective)**: 8 hours (maximum downtime)

### Backup Strategy

| Resource | Frequency | Retention | Location |
|----------|-----------|-----------|----------|
| **SQL Database** | Continuous (Point-in-time) | 35 days | Geo-redundant |
| **Data Lake** | Every 4 hours | 30 days | Geo-redundant |
| **ML Models** | Every deployment | 90 days | Geo-redundant |
| **Configuration** | Every change | 365 days | Git repository |
| **VM Disks** | Daily | 30 days | Geo-redundant |

### DR Testing

- **Quarterly**: Full DR drill with failover to secondary region
- **Monthly**: Backup restoration test
- **Weekly**: Configuration recovery test

---

## Next Steps

1. **Review Architecture**: [See detailed architecture diagram](./docs/architecture-diagram.md)
2. **Deploy Environment**: Follow Quick Start guide above
3. **Configure Compliance**: [Review compliance mapping](./docs/compliance-mapping.md)
4. **Setup Monitoring**: [Configure alerts and dashboards](./docs/runbook.md)
5. **Use Case Deployment**: Choose use case and deploy on top of this infrastructure

---

## Support

- **Issues**: Open GitHub issue in this repository
- **Questions**: Contact AI Delivery Methodology team
- **Security Concerns**: security@your-organization.com

---

**Document Version**: 1.0  
**Last Updated**: January 13, 2026  
**Maintained By**: AI Delivery Methodology Team
