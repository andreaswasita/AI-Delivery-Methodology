# Azure AI Platform - Architecture Overview

## 🏗️ Purpose

This document provides a comprehensive architectural overview of the Azure AI platform infrastructure deployed by this methodology. It details the components, network topology, security controls, and data flows for enterprise-grade AI workloads.

---

## 📊 High-Level Architecture

```
┌─────────────────────────────────────────────────────────────────────────┐
│                         PRESENTATION LAYER                               │
│  ┌──────────────┐  ┌──────────────┐  ┌──────────────┐                 │
│  │  Web Apps    │  │  Power BI    │  │  Teams Bots  │                 │
│  │  (Frontend)  │  │ Dashboards   │  │  (Chatbots)  │                 │
│  └──────┬───────┘  └──────┬───────┘  └──────┬───────┘                 │
└─────────┼──────────────────┼──────────────────┼────────────────────────┘
          │                  │                  │
          └──────────────────┼──────────────────┘
                             │ HTTPS (TLS 1.3)
          ┌──────────────────┴──────────────────┐
          │     Azure Front Door + WAF          │  ← DDoS Protection
          └──────────────────┬──────────────────┘
                             │
┌─────────────────────────────┼─────────────────────────────────────────┐
│                    APPLICATION LAYER                                    │
│                             │                                           │
│  ┌──────────────────────────┴───────────────────────────┐             │
│  │            Azure API Management (APIM)                │             │
│  │  • Rate Limiting  • OAuth 2.0  • API Versioning      │             │
│  └──────────────────────┬───────────────────────────────┘             │
│                         │                                               │
│    ┌────────────────────┼────────────────────┐                        │
│    │                    │                    │                        │
│  ┌─▼──────────┐  ┌─────▼─────┐  ┌──────────▼────┐                   │
│  │ App Service│  │ Container  │  │  Azure        │                   │
│  │ (REST APIs)│  │ Instances  │  │  Functions    │                   │
│  │            │  │ (AKS/ACI)  │  │  (Serverless) │                   │
│  └─────┬──────┘  └─────┬─────┘  └──────┬────────┘                   │
└────────┼───────────────┼────────────────┼─────────────────────────────┘
         │               │                │
         │               │ Private Endpoints Only
         │               │                │
┌────────┼───────────────┼────────────────┼─────────────────────────────┐
│                     AI/ML LAYER                                         │
│        │               │                │                              │
│  ┌─────▼────────┐ ┌───▼──────────┐ ┌──▼──────────────┐              │
│  │ Azure        │ │  Azure ML    │ │  Cognitive      │              │
│  │ OpenAI       │ │  Workspace   │ │  Services       │              │
│  │ (GPT-4,      │ │              │ │  - Vision       │              │
│  │  Embeddings) │ │ • Training   │ │  - Speech       │              │
│  │              │ │ • Endpoints  │ │  - Language     │              │
│  └─────┬────────┘ └───┬──────────┘ └──┬──────────────┘              │
│        │              │               │                              │
│        │              │ Managed VNet  │                              │
│        └──────────────┼───────────────┘                              │
└───────────────────────┼──────────────────────────────────────────────┘
                        │
┌───────────────────────┼──────────────────────────────────────────────┐
│                   DATA LAYER                                           │
│                       │                                                │
│  ┌────────────────────┴─────────────────────────────┐                │
│  │         Microsoft Fabric (Optional)              │                │
│  │  • Lakehouse  • Data Warehouse  • Data Science  │                │
│  └────────────────────┬─────────────────────────────┘                │
│                       │                                                │
│  ┌────────────┬───────┴────────┬────────────┐                       │
│  │            │                │            │                       │
│ ┌▼─────────┐ ┌▼──────────┐ ┌──▼────────┐ ┌▼──────────┐            │
│ │ Azure    │ │  Cosmos DB │ │  SQL DB   │ │  Blob     │            │
│ │ Data Lake│ │ (NoSQL)    │ │ (Rel.)    │ │  Storage  │            │
│ │ Gen2     │ │            │ │           │ │           │            │
│ └────┬─────┘ └────┬───────┘ └───┬───────┘ └───┬───────┘            │
└──────┼────────────┼─────────────┼─────────────┼─────────────────────┘
       │            │             │             │
       │         Private Endpoints + Encryption at Rest
       │            │             │             │
┌──────┼────────────┼─────────────┼─────────────┼─────────────────────┐
│                 SECURITY & GOVERNANCE LAYER                            │
│      │            │             │             │                       │
│  ┌───▼────────────▼─────────────▼─────────────▼────┐                 │
│  │           Azure Key Vault                        │                 │
│  │  • API Keys  • Certificates  • Secrets          │                 │
│  └───────────────────────┬──────────────────────────┘                 │
│                          │                                             │
│  ┌───────────────────────┴──────────────────────────┐                 │
│  │           Azure Monitor + Sentinel                │                 │
│  │  • Log Analytics  • Application Insights         │                 │
│  │  • Alerts  • Security Threats  • Compliance      │                 │
│  └──────────────────────────────────────────────────┘                 │
│                                                                         │
│  ┌──────────────────────────────────────────────────┐                 │
│  │           Azure Policy + RBAC                     │                 │
│  │  • Compliance Enforcement  • Access Control      │                 │
│  └──────────────────────────────────────────────────┘                 │
└─────────────────────────────────────────────────────────────────────────┘
```

---

## 🌐 Network Architecture

### Network Topology

```
┌─────────────────────────────────────────────────────────────────┐
│                    VIRTUAL NETWORK (VNet)                        │
│                    Address Space: 10.0.0.0/16                    │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Frontend Subnet (10.0.1.0/24)                           │  │
│  │  • App Services                                          │  │
│  │  • Application Gateway                                   │  │
│  │  NSG: Allow HTTPS (443), Deny all inbound by default    │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Application Subnet (10.0.2.0/24)                        │  │
│  │  • Container Instances                                   │  │
│  │  • Azure Functions                                       │  │
│  │  NSG: Allow from Frontend, Private Endpoints only       │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  AI/ML Subnet (10.0.3.0/24)                              │  │
│  │  • Azure ML Compute                                      │  │
│  │  • Azure OpenAI (Private Endpoint)                       │  │
│  │  • Cognitive Services (Private Endpoint)                 │  │
│  │  NSG: Deny internet, allow only from Application subnet │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Data Subnet (10.0.4.0/24)                               │  │
│  │  • SQL Database (Private Endpoint)                       │  │
│  │  • Storage Accounts (Private Endpoint)                   │  │
│  │  • Cosmos DB (Private Endpoint)                          │  │
│  │  NSG: Deny all inbound except from AI/ML subnet         │  │
│  └──────────────────────────────────────────────────────────┘  │
│                                                                   │
│  ┌──────────────────────────────────────────────────────────┐  │
│  │  Management Subnet (10.0.5.0/24)                         │  │
│  │  • Bastion Host                                          │  │
│  │  • Jump Box                                              │  │
│  │  NSG: Allow RDP/SSH from corporate network only         │  │
│  └──────────────────────────────────────────────────────────┘  │
└───────────────────────────────────────────────────────────────────┘
```

### Key Network Features

- **Private Endpoints**: All PaaS services accessible only via private IPs
- **Network Security Groups (NSGs)**: Enforce least-privilege access between subnets
- **Service Endpoints**: Optimized routing for Azure services
- **Azure Firewall**: Centralized outbound traffic filtering
- **DDoS Protection Standard**: Enterprise-grade DDoS mitigation

---

## 🔒 Security Architecture

### Defense in Depth

```
Layer 7: USER AUTHENTICATION
├─ Azure AD B2C / Entra ID
├─ Multi-Factor Authentication (MFA)
└─ Conditional Access Policies

Layer 6: PERIMETER SECURITY
├─ Azure Front Door + WAF
├─ DDoS Protection Standard
└─ Rate Limiting via APIM

Layer 5: NETWORK SECURITY
├─ Network Security Groups (NSGs)
├─ Azure Firewall
└─ Private Endpoints (no public IPs)

Layer 4: COMPUTE SECURITY
├─ Managed Identity (no credentials in code)
├─ Just-In-Time (JIT) VM Access
└─ Container Image Scanning

Layer 3: APPLICATION SECURITY
├─ API Management (OAuth 2.0)
├─ Input Validation & Sanitization
└─ Secure Coding Practices

Layer 2: DATA SECURITY
├─ Encryption at Rest (AES-256)
├─ Encryption in Transit (TLS 1.3)
├─ Customer-Managed Keys (CMK)
└─ Data Classification & DLP

Layer 1: MONITORING & RESPONSE
├─ Azure Sentinel (SIEM)
├─ Microsoft Defender for Cloud
├─ Log Analytics
└─ 24/7 SOC Alerts
```

### Identity & Access Management

```
┌──────────────────────────────────────────────────────┐
│           Azure Active Directory (Entra ID)          │
│                                                       │
│  ┌────────────────────────────────────────────────┐ │
│  │  Role-Based Access Control (RBAC)             │ │
│  ├────────────────────────────────────────────────┤ │
│  │  • Contributor: Dev Team                      │ │
│  │  • Reader: Business Stakeholders              │ │
│  │  • ML Ops: Data Scientists                    │ │
│  │  • Security Admin: InfoSec Team               │ │
│  └────────────────────────────────────────────────┘ │
│                                                       │
│  ┌────────────────────────────────────────────────┐ │
│  │  Managed Identity                              │ │
│  ├────────────────────────────────────────────────┤ │
│  │  App Services → Key Vault                     │ │
│  │  Azure ML → Storage Account                   │ │
│  │  Functions → Cosmos DB                        │ │
│  └────────────────────────────────────────────────┘ │
└──────────────────────────────────────────────────────┘
```

---

## 📊 Data Flow Diagrams

### Training Pipeline (ML Model Development)

```
1. Data Ingestion
   ├─ Source Systems → Data Lake Gen2 (Raw Zone)
   ├─ Validation & Quality Checks
   └─ Metadata Catalog (Purview)

2. Data Preparation
   ├─ Azure ML Compute → Read from Data Lake
   ├─ Feature Engineering (Python/Spark)
   ├─ Data Transformation
   └─ Write to Data Lake (Curated Zone)

3. Model Training
   ├─ Azure ML Workspace
   ├─ Experiment Tracking (MLflow)
   ├─ GPU Compute Clusters
   └─ Model Registry

4. Model Validation
   ├─ Automated Testing (Bias, Fairness, Performance)
   ├─ Model Explainability (SHAP)
   └─ Approval Workflow

5. Model Deployment
   ├─ Deploy to Azure ML Endpoint (Staging)
   ├─ Integration Testing
   ├─ Production Deployment (Blue/Green)
   └─ Monitoring & Alerting
```

### Inference Pipeline (Production)

```
User Request (HTTPS)
  ↓
Azure Front Door + WAF
  ↓
API Management (Auth + Rate Limit)
  ↓
App Service / Function
  ↓
Azure ML Endpoint (Managed VNet)
  ↓
Model Inference (GPU/CPU)
  ↓
Result + Telemetry
  ↓
Response to User
```

---

## 🗄️ Data Architecture

### Data Zones (Medallion Architecture)

```
┌────────────────────────────────────────────────────┐
│            Bronze Layer (Raw Data)                 │
│  • Immutable, append-only                          │
│  • Original format from source                     │
│  • Retention: 7 years                              │
│  Storage: Data Lake Gen2 (Hot Tier)                │
└────────────────────────────────────────────────────┘
                      ↓ ETL
┌────────────────────────────────────────────────────┐
│            Silver Layer (Cleaned Data)             │
│  • Validated, deduplicated                         │
│  • Schema enforcement                              │
│  • Retention: 3 years                              │
│  Storage: Data Lake Gen2 (Hot Tier)                │
└────────────────────────────────────────────────────┘
                      ↓ Feature Engineering
┌────────────────────────────────────────────────────┐
│            Gold Layer (Curated Data)               │
│  • Business-ready, aggregated                      │
│  • Feature store for ML                            │
│  • Retention: 2 years                              │
│  Storage: Data Lake Gen2 (Hot) + Cosmos DB         │
└────────────────────────────────────────────────────┘
```

### Data Governance

- **Azure Purview**: Data catalog, lineage, and classification
- **Data Classification**: Public, Internal, Confidential, Restricted
- **Retention Policies**: Automated lifecycle management
- **Backup Strategy**: 
  - Daily incremental backups (retained 30 days)
  - Weekly full backups (retained 12 weeks)
  - Monthly archives (retained 7 years)

---

## 🛡️ Compliance & Governance

### Regulatory Compliance

| Framework | Components | Evidence |
|-----------|------------|----------|
| **GDPR** | Encryption, Data Residency, Right to Erasure | Azure Policy, Data Maps |
| **SOC 2** | Access Controls, Audit Logs, Change Management | Azure Monitor, Sentinel |
| **ISO 27001** | Risk Management, Security Controls | Microsoft Defender |
| **PCI-DSS** | Network Segmentation, Encryption | NSGs, Key Vault |
| **APRA CPS 234** | Information Security (Australia) | Compliance Dashboard |

### Azure Policy Assignments

1. **Data Residency Policy**: Enforce Australia region for all resources
2. **Encryption Required**: All storage accounts must use encryption at rest
3. **Network Isolation**: Private endpoints mandatory for PaaS services
4. **Tagging Enforcement**: Cost center, owner, environment tags required
5. **Audit Logging**: 90-day retention minimum for all diagnostic logs

---

## 📈 Scalability & Performance

### Compute Scaling

- **App Services**: Auto-scale based on CPU (50-80%), Request Count
- **Azure ML**: Auto-scale compute clusters (0-10 nodes)
- **Container Instances**: Horizontal pod autoscaling (HPA)
- **Azure Functions**: Consumption plan (automatic)

### Data Scaling

- **Cosmos DB**: Autoscale throughput (400-4000 RU/s)
- **SQL Database**: Serverless compute tier (auto-pause)
- **Data Lake**: Unlimited storage (petabyte-scale)

### Global Distribution

- **Primary Region**: Australia East
- **Secondary Region**: Australia Southeast (DR)
- **CDN**: Azure Front Door (global edge locations)
- **RPO**: 1 hour (Recovery Point Objective)
- **RTO**: 4 hours (Recovery Time Objective)

---

## 🔧 Disaster Recovery

### High Availability

- **Azure ML**: Zone-redundant storage for models
- **Storage Accounts**: GRS (Geo-Redundant Storage)
- **Cosmos DB**: Multi-region writes
- **SQL Database**: Active geo-replication

### Backup Strategy

```
Daily Backups (Automated)
  ├─ SQL Database: Point-in-time restore (35 days)
  ├─ Cosmos DB: Continuous backup (30 days)
  ├─ Blob Storage: Soft delete (14 days)
  └─ Azure ML: Model versioning (unlimited)

Weekly Backups (Snapshots)
  ├─ Full disk images (12 weeks)
  └─ Configuration backups (Infrastructure as Code)

Monthly Archives
  ├─ Long-term retention (7 years)
  └─ Compliance archives (immutable storage)
```

---

## 📊 Monitoring & Observability

### Key Metrics

**Performance**:
- API Response Time (p50, p95, p99)
- Model Inference Latency
- Request Throughput (req/sec)

**Reliability**:
- Service Availability (SLA: 99.9%)
- Error Rate (< 0.1%)
- Model Drift Score

**Security**:
- Failed Authentication Attempts
- Policy Violations
- Security Alerts (Sentinel)

**Cost**:
- Daily Spend by Resource Group
- Cost per API Call
- GPU Utilization

### Alerting

- **Critical**: PagerDuty → On-call Engineer (5 min SLA)
- **Warning**: Email → Team Lead (30 min SLA)
- **Info**: Dashboard → Weekly Review

---

## 🔗 Integration Points

### External Systems

- **Corporate AD**: Azure AD Connect (hybrid identity)
- **SAP/ERP**: Logic Apps + Service Bus
- **CRM (Salesforce/Dynamics)**: Power Automate + API
- **Data Warehouse**: Azure Data Factory pipelines
- **BI Tools**: Power BI Direct Query

---

## 📚 Reference Documents

- [Compliance Mapping](./compliance-mapping.md) - Detailed control mapping
- [Security Baseline](./security-baseline.md) - Security configuration standards
- [Runbook](./runbook.md) - Operational procedures
- [Bicep Templates](../bicep/) - Infrastructure as Code

---

## 📞 Support

- **Architecture Questions**: [email architecture team]
- **Security Concerns**: [email security team]
- **Operational Issues**: [file support ticket]

---

**Version**: 1.0  
**Last Updated**: January 27, 2026  
**Owner**: Cloud Architecture Team  
**Review Cycle**: Quarterly
