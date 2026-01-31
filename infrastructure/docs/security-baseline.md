# Security Baseline Configuration

## 🎯 Purpose

This document defines the security configuration standards and baseline controls for the Azure AI platform. All deployments must adhere to these minimum security requirements.

---

## 📊 Security Posture Overview

### Target Security Metrics

| Metric | Target | Current | Status |
|--------|--------|---------|--------|
| **Azure Secure Score** | ≥85/100 | 92/100 | ✅ |
| **Policy Compliance** | ≥95% | 98% | ✅ |
| **Vulnerability Severity** | 0 Critical/High | 0 | ✅ |
| **MFA Adoption** | 100% privileged accounts | 100% | ✅ |
| **Encryption Coverage** | 100% data at rest | 100% | ✅ |
| **Private Endpoint Coverage** | 100% PaaS services | 100% | ✅ |

---

## 🔐 Identity & Access Management

### Azure Active Directory Configuration

#### Baseline Requirements

```json
{
  "tenantSettings": {
    "mfaRequired": true,
    "passwordPolicy": {
      "minimumLength": 14,
      "complexity": true,
      "historyCount": 24,
      "maxAge": 90,
      "minAge": 1,
      "accountLockout": {
        "threshold": 5,
        "duration": 30,
        "resetAfter": 30
      }
    },
    "conditionalAccess": {
      "mfaForAdmins": true,
      "mfaForAllUsers": true,
      "blockLegacyAuth": true,
      "requireCompliantDevice": true,
      "blockRiskySignIns": true
    },
    "identityProtection": {
      "riskPolicy": "Medium",
      "userRiskPolicy": "High",
      "signInRiskPolicy": "High"
    }
  }
}
```

#### Conditional Access Policies

| Policy Name | Users | Conditions | Controls |
|-------------|-------|------------|----------|
| **Require MFA for all users** | All users | All cloud apps | MFA required |
| **Block legacy authentication** | All users | Legacy auth protocols | Block access |
| **Require compliant devices** | All users | All cloud apps | Device compliance |
| **Require MFA from untrusted locations** | All users | Outside corporate network | MFA + approved app |
| **Block high-risk sign-ins** | All users | Sign-in risk: High | Block access |
| **Admin protection** | Global Admins | Any location | MFA + PIM |

**Implementation Script**: `infrastructure/scripts/configure-conditional-access.ps1`

---

### Role-Based Access Control (RBAC)

#### Custom Role Definitions

##### ML Ops Engineer

```json
{
  "Name": "ML Ops Engineer",
  "IsCustom": true,
  "Description": "Can manage ML workspaces, models, and deployments",
  "Actions": [
    "Microsoft.MachineLearningServices/workspaces/*",
    "Microsoft.MachineLearningServices/workspaces/computes/*",
    "Microsoft.MachineLearningServices/workspaces/datastores/*",
    "Microsoft.Storage/storageAccounts/blobServices/containers/*",
    "Microsoft.KeyVault/vaults/secrets/read"
  ],
  "NotActions": [
    "Microsoft.MachineLearningServices/workspaces/delete",
    "Microsoft.Authorization/*/write"
  ],
  "AssignableScopes": [
    "/subscriptions/{subscription-id}/resourceGroups/rg-ai-prod"
  ]
}
```

##### Data Scientist

```json
{
  "Name": "Data Scientist",
  "IsCustom": true,
  "Description": "Can run experiments and train models, read-only infrastructure",
  "Actions": [
    "Microsoft.MachineLearningServices/workspaces/experiments/*",
    "Microsoft.MachineLearningServices/workspaces/runs/*",
    "Microsoft.MachineLearningServices/workspaces/read",
    "Microsoft.Storage/storageAccounts/blobServices/containers/read"
  ],
  "NotActions": [
    "Microsoft.MachineLearningServices/workspaces/computes/write",
    "Microsoft.MachineLearningServices/workspaces/computes/delete"
  ],
  "AssignableScopes": [
    "/subscriptions/{subscription-id}/resourceGroups/rg-ai-dev",
    "/subscriptions/{subscription-id}/resourceGroups/rg-ai-test"
  ]
}
```

##### Security Reader

```json
{
  "Name": "Security Reader",
  "IsCustom": true,
  "Description": "Read-only access to security logs and configurations",
  "Actions": [
    "Microsoft.Security/*/read",
    "Microsoft.SecurityInsights/*/read",
    "Microsoft.OperationalInsights/workspaces/*/read",
    "Microsoft.Authorization/policyDefinitions/read",
    "Microsoft.Authorization/policyAssignments/read"
  ],
  "NotActions": [],
  "AssignableScopes": [
    "/subscriptions/{subscription-id}"
  ]
}
```

**Deployment**: `infrastructure/scripts/configure-rbac.ps1`

---

## 🌐 Network Security

### Virtual Network Configuration

#### Network Security Group (NSG) Rules

##### Frontend Subnet NSG

```json
{
  "securityRules": [
    {
      "name": "Allow-HTTPS-Inbound",
      "priority": 100,
      "direction": "Inbound",
      "access": "Allow",
      "protocol": "Tcp",
      "sourcePortRange": "*",
      "destinationPortRange": "443",
      "sourceAddressPrefix": "Internet",
      "destinationAddressPrefix": "10.0.1.0/24"
    },
    {
      "name": "Deny-All-Inbound",
      "priority": 4096,
      "direction": "Inbound",
      "access": "Deny",
      "protocol": "*",
      "sourcePortRange": "*",
      "destinationPortRange": "*",
      "sourceAddressPrefix": "*",
      "destinationAddressPrefix": "*"
    }
  ]
}
```

##### AI/ML Subnet NSG

```json
{
  "securityRules": [
    {
      "name": "Allow-From-Application-Subnet",
      "priority": 100,
      "direction": "Inbound",
      "access": "Allow",
      "protocol": "*",
      "sourcePortRange": "*",
      "destinationPortRange": "*",
      "sourceAddressPrefix": "10.0.2.0/24",
      "destinationAddressPrefix": "10.0.3.0/24"
    },
    {
      "name": "Deny-Internet-Outbound",
      "priority": 200,
      "direction": "Outbound",
      "access": "Deny",
      "protocol": "*",
      "sourcePortRange": "*",
      "destinationPortRange": "*",
      "sourceAddressPrefix": "10.0.3.0/24",
      "destinationAddressPrefix": "Internet"
    },
    {
      "name": "Deny-All-Inbound",
      "priority": 4096,
      "direction": "Inbound",
      "access": "Deny",
      "protocol": "*",
      "sourcePortRange": "*",
      "destinationPortRange": "*",
      "sourceAddressPrefix": "*",
      "destinationAddressPrefix": "*"
    }
  ]
}
```

**Bicep Module**: `infrastructure/bicep/modules/networking.bicep`

---

### Private Endpoints

**Mandatory Private Endpoints** (No public access allowed):

| Service | Private Endpoint Required | DNS Zone |
|---------|--------------------------|----------|
| Storage Accounts | ✅ Yes | privatelink.blob.core.windows.net |
| Azure ML Workspace | ✅ Yes | privatelink.api.azureml.ms |
| Azure OpenAI | ✅ Yes | privatelink.openai.azure.com |
| Cognitive Services | ✅ Yes | privatelink.cognitiveservices.azure.com |
| Key Vault | ✅ Yes | privatelink.vaultcore.azure.net |
| SQL Database | ✅ Yes | privatelink.database.windows.net |
| Cosmos DB | ✅ Yes | privatelink.documents.azure.com |
| Container Registry | ✅ Yes | privatelink.azurecr.io |

**Validation Script**: `infrastructure/scripts/validate-private-endpoints.ps1`

---

### Azure Firewall Rules

#### Application Rules

```json
{
  "applicationRuleCollections": [
    {
      "name": "AllowAzureServices",
      "priority": 100,
      "action": "Allow",
      "rules": [
        {
          "name": "AllowAzureML",
          "protocols": [{ "protocolType": "Https", "port": 443 }],
          "targetFqdns": [
            "*.api.azureml.ms",
            "*.notebooks.azure.net",
            "*.instances.azureml.ms"
          ],
          "sourceAddresses": ["10.0.0.0/16"]
        },
        {
          "name": "AllowPythonPackages",
          "protocols": [{ "protocolType": "Https", "port": 443 }],
          "targetFqdns": ["pypi.org", "files.pythonhosted.org"],
          "sourceAddresses": ["10.0.3.0/24"]
        }
      ]
    },
    {
      "name": "DenyInternetAccess",
      "priority": 200,
      "action": "Deny",
      "rules": [
        {
          "name": "BlockInternet",
          "protocols": [{ "protocolType": "Any" }],
          "targetFqdns": ["*"],
          "sourceAddresses": ["10.0.0.0/16"]
        }
      ]
    }
  ]
}
```

---

## 🔒 Data Protection

### Encryption Standards

#### Encryption at Rest

| Resource Type | Encryption Method | Key Management |
|---------------|------------------|----------------|
| **Blob Storage** | AES-256 | Customer-managed (Azure Key Vault) |
| **SQL Database** | TDE (Transparent Data Encryption) | Customer-managed |
| **Cosmos DB** | AES-256 | Service-managed (default) |
| **Disk Storage** | Azure Disk Encryption | Customer-managed |
| **Azure ML** | AES-256 | Customer-managed |

**Key Vault Configuration**:
```json
{
  "keyVaultName": "kv-aiplatform-prod",
  "sku": "Premium",
  "enabledForDiskEncryption": true,
  "enabledForDeployment": true,
  "enabledForTemplateDeployment": true,
  "enableSoftDelete": true,
  "softDeleteRetentionInDays": 90,
  "enablePurgeProtection": true,
  "networkAcls": {
    "defaultAction": "Deny",
    "bypass": "AzureServices",
    "virtualNetworkRules": [
      { "subnetId": "/subscriptions/.../subnets/ApplicationSubnet" }
    ]
  }
}
```

#### Encryption in Transit

| Protocol | Minimum Version | Cipher Suites |
|----------|----------------|---------------|
| **TLS** | 1.3 (1.2 minimum) | TLS_AES_256_GCM_SHA384 |
| **SSH** | 2.0 | aes256-gcm@openssh.com |
| **HTTPS** | TLS 1.3 | Strong ciphers only |

**Azure Policy**: Enforce TLS 1.2 minimum on all services

---

### Data Classification & Labeling

| Classification | Description | Encryption | Retention | Access Control |
|---------------|-------------|------------|-----------|---------------|
| **Public** | Non-sensitive | TLS | 1 year | All authenticated users |
| **Internal** | Business data | TLS + AES-256 | 3 years | Role-based |
| **Confidential** | PII, sensitive | TLS + AES-256 + CMK | 7 years | Need-to-know basis |
| **Restricted** | Legal, payment data | TLS + AES-256 + CMK + HSM | 7+ years | Executive approval |

**Azure Information Protection Labels**:
- Automatic classification based on content (regex patterns)
- Manual classification by data owners
- Label persistence across Azure services

---

### Data Loss Prevention (DLP)

**Microsoft Purview DLP Policies**:

1. **Credit Card Numbers**: Block/Quarantine emails/files containing 10+ credit card numbers
2. **Social Security Numbers**: Alert when SSN detected in Azure Storage
3. **API Keys/Secrets**: Block commits to GitHub containing API keys
4. **Large Data Transfers**: Alert on downloads >10 GB in 24 hours

**Implementation**: Azure Purview Data Loss Prevention policies

---

## 🛡️ Threat Protection

### Microsoft Defender for Cloud

#### Required Plans

| Plan | Status | Purpose |
|------|--------|---------|
| **Defender for Servers** | ✅ Enabled | VM vulnerability scanning |
| **Defender for App Service** | ✅ Enabled | Web app security |
| **Defender for Storage** | ✅ Enabled | Malware scanning, anomaly detection |
| **Defender for SQL** | ✅ Enabled | SQL vulnerability assessment |
| **Defender for Key Vault** | ✅ Enabled | Secret access monitoring |
| **Defender for Containers** | ✅ Enabled | Container image scanning |

**Cost**: ~$15/resource/month (varies by service)

---

### Azure Sentinel (SIEM)

#### Analytics Rules (Enabled)

| Rule | Severity | Action |
|------|----------|--------|
| **Brute force attack detected** | High | Alert + Block IP (1 hour) |
| **Privilege escalation** | Critical | Alert + Disable account |
| **Anomalous data download** | Medium | Alert + Require MFA |
| **Multiple failed logins** | Low | Alert (monitoring only) |
| **Policy violation** | Medium | Alert + Create incident |
| **Malware detected** | Critical | Quarantine + Alert |

**Playbooks (Automated Response)**:
1. Block malicious IP addresses (Azure Firewall)
2. Disable compromised user accounts (Azure AD)
3. Isolate infected VMs (NSG rule change)
4. Notify security team (Email + Teams + PagerDuty)

**Retention**: 90 days (hot), 2 years (archive)

---

### Vulnerability Management

#### Scanning Schedule

| Scan Type | Frequency | Tool | Remediation SLA |
|-----------|-----------|------|-----------------|
| **Infrastructure** | Continuous | Microsoft Defender | Critical: 24h, High: 7d |
| **Application Code** | Every commit | GitHub Advanced Security | Critical: 48h, High: 14d |
| **Container Images** | Every build | Defender for Containers | Before deployment |
| **Dependencies** | Daily | Dependabot | Critical: 48h, High: 30d |
| **Penetration Testing** | Annual | 3rd party | Per findings |

**Severity Definitions**:
- **Critical**: Active exploit available, high impact
- **High**: Exploit likely, significant impact
- **Medium**: Exploit possible, moderate impact
- **Low**: Exploit unlikely, minimal impact

---

## 📊 Logging & Monitoring

### Diagnostic Settings

**Mandatory Logging** for all resources:

```json
{
  "logs": [
    { "category": "AuditLogs", "enabled": true, "retentionDays": 90 },
    { "category": "SignInLogs", "enabled": true, "retentionDays": 90 },
    { "category": "NonInteractiveUserSignInLogs", "enabled": true },
    { "category": "ServicePrincipalSignInLogs", "enabled": true },
    { "category": "ManagedIdentitySignInLogs", "enabled": true },
    { "category": "ProvisioningLogs", "enabled": true }
  ],
  "metrics": [
    { "category": "AllMetrics", "enabled": true, "retentionDays": 30 }
  ],
  "workspaceId": "/subscriptions/.../workspaces/log-analytics-prod"
}
```

---

### Security Alerts

#### Alerting Thresholds

| Metric | Threshold | Severity | Notification |
|--------|-----------|----------|--------------|
| **Failed logins** | >5 in 10 min | High | PagerDuty |
| **Privilege escalation** | Any | Critical | PagerDuty + Email |
| **Data exfiltration** | >10 GB download | High | Email + Teams |
| **VM compromised** | Malware detected | Critical | PagerDuty |
| **Key Vault access** | >100 req/min | Medium | Email |
| **Policy violation** | Any non-compliance | Low | Email (daily digest) |

**Alert Action Groups**:
- **Critical**: PagerDuty + Email + SMS + Teams
- **High**: Email + Teams
- **Medium**: Email
- **Low**: Daily digest email

---

## 🔄 Security Operations

### Incident Response Runbook

**Phase 1: Detection** (0-15 minutes)
1. Sentinel alert triggered
2. Automated playbook executes (containment actions)
3. Incident created in ServiceNow
4. On-call engineer notified (PagerDuty)

**Phase 2: Triage** (15-60 minutes)
5. Security analyst reviews alert
6. Determines false positive vs. true positive
7. Escalates to Incident Commander if true positive

**Phase 3: Containment** (1-4 hours)
8. Isolate affected resources (NSG rules)
9. Disable compromised accounts
10. Preserve evidence (snapshots, logs)

**Phase 4: Eradication** (4-24 hours)
11. Remove malware/threat
12. Patch vulnerabilities
13. Reset credentials

**Phase 5: Recovery** (24-48 hours)
14. Restore services
15. Monitor for re-infection
16. Update security controls

**Phase 6: Post-Incident** (48-72 hours)
17. Root cause analysis
18. Update runbooks
19. Lessons learned session
20. Compliance reporting (GDPR, APRA)

**Detailed Runbook**: [runbook.md](./runbook.md)

---

### Backup & Recovery

#### Backup Configuration

| Resource | Backup Frequency | Retention | RPO | RTO |
|----------|------------------|-----------|-----|-----|
| **SQL Database** | Automated (hourly) | 35 days | 5 min | 1 hour |
| **Blob Storage** | Continuous (snapshots) | 14 days | 1 hour | 2 hours |
| **Cosmos DB** | Continuous | 30 days | 1 hour | 4 hours |
| **VM Disks** | Daily | 30 days | 24 hours | 4 hours |
| **Azure ML Models** | On-demand (versioning) | Unlimited | Manual | 1 hour |

**Long-term Archival**:
- Monthly backups retained for 7 years (compliance)
- Immutable storage (WORM policy)
- Stored in geo-redundant storage (GRS)

---

## ✅ Security Validation Checklist

### Pre-Deployment

- [ ] All Azure Policies assigned and compliant
- [ ] RBAC roles configured per least privilege
- [ ] MFA enabled for all admin accounts
- [ ] Private endpoints configured for all PaaS services
- [ ] NSG rules reviewed and approved
- [ ] Encryption at rest enabled (customer-managed keys)
- [ ] TLS 1.2+ enforced for all services
- [ ] Diagnostic logs enabled and routed to Log Analytics
- [ ] Microsoft Defender for Cloud enabled (all plans)
- [ ] Azure Sentinel analytics rules configured
- [ ] Backup policies configured and tested
- [ ] Disaster recovery plan documented

### Post-Deployment

- [ ] Vulnerability scan completed (no critical findings)
- [ ] Penetration test scheduled
- [ ] Security baseline validated
- [ ] Compliance evidence collected
- [ ] Incident response runbook tested
- [ ] Security training completed for team
- [ ] Access review scheduled (quarterly)

**Validation Script**: `infrastructure/scripts/validate-security-baseline.ps1`

---

## 📚 Reference Documents

- [Architecture Diagram](./architecture-diagram.md) - Infrastructure overview
- [Compliance Mapping](./compliance-mapping.md) - Regulatory control mapping
- [Runbook](./runbook.md) - Operational procedures
- [Azure Security Benchmark](https://aka.ms/azsecbm) - Microsoft baseline

---

## 📞 Security Contacts

| Role | Contact | Escalation SLA |
|------|---------|---------------|
| **Security Operations Center** | soc@company.com | 24/7 |
| **Incident Commander** | +61 XXX XXX XXX | Critical: 15 min |
| **CISO** | ciso@company.com | Executive escalation |
| **Compliance Officer** | compliance@company.com | Regulatory matters |

---

**Version**: 1.0  
**Last Updated**: January 27, 2026  
**Owner**: Information Security Team  
**Review Cycle**: Quarterly (or after security incidents)
