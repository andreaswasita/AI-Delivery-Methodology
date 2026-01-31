# Compliance Controls Mapping

## 🎯 Purpose

This document maps Azure infrastructure components and configurations to specific regulatory compliance requirements including GDPR, SOC 2, ISO 27001, PCI-DSS, and APRA CPS 234.

---

## 📊 Compliance Framework Overview

| Framework | Scope | Implementation Status |
|-----------|-------|----------------------|
| **GDPR** | Data protection and privacy | ✅ Implemented |
| **SOC 2 Type II** | Security, availability, confidentiality | ✅ Implemented |
| **ISO 27001:2013** | Information security management | ✅ Implemented |
| **PCI-DSS v4.0** | Payment card data security | ⚠️ Conditional (if processing payments) |
| **APRA CPS 234** | Information security (Australia) | ✅ Implemented |
| **HIPAA** | Healthcare data protection | ⚠️ Conditional (if processing PHI) |

---

## 🇪🇺 GDPR (General Data Protection Regulation)

### Article 5: Principles of Data Processing

| Principle | Azure Control | Implementation |
|-----------|---------------|----------------|
| **Lawfulness, fairness, transparency** | Azure Policy | Consent management in application layer |
| **Purpose limitation** | Data classification tags | Tags: `DataPurpose=Training`, `DataPurpose=Inference` |
| **Data minimization** | Column-level security (SQL) | Only necessary fields accessible to models |
| **Accuracy** | Data validation pipelines | Azure Data Factory data quality checks |
| **Storage limitation** | Lifecycle management | Auto-delete after retention period (configurable) |
| **Integrity & confidentiality** | Encryption at rest/transit | AES-256 (rest), TLS 1.3 (transit) |

**Azure Policy**: `require-data-classification-tags.json`

### Article 17: Right to Erasure (Right to be Forgotten)

| Requirement | Azure Control | Implementation |
|-------------|---------------|----------------|
| **Data deletion** | Storage soft delete + purge | API endpoint for hard delete requests |
| **Backup deletion** | Immutable storage exceptions | Manual approval process for backup purge |
| **Model retraining** | Azure ML pipeline | Remove PII, retrain model if necessary |
| **Audit trail** | Log Analytics | 90-day retention of deletion requests |

**Script**: `infrastructure/scripts/gdpr-delete-request.ps1`

### Article 30: Records of Processing Activities

| Requirement | Azure Control | Implementation |
|-------------|---------------|----------------|
| **Data catalog** | Azure Purview | Automated data discovery and lineage |
| **Processing logs** | Azure Monitor | All data access logged with user identity |
| **Data flows** | Network flow logs | NSG flow logs (90-day retention) |

### Article 32: Security of Processing

| Requirement | Azure Control | Implementation |
|-------------|---------------|----------------|
| **Pseudonymization** | Azure SQL dynamic data masking | PII fields masked for non-privileged users |
| **Encryption** | Customer-managed keys (CMK) | Azure Key Vault + Disk Encryption |
| **Resilience** | Geo-redundant storage (GRS) | RPO: 1 hour, RTO: 4 hours |
| **Testing** | Microsoft Defender | Continuous vulnerability scanning |

### Article 33: Breach Notification

| Requirement | Azure Control | Implementation |
|-------------|---------------|----------------|
| **Detection** | Azure Sentinel | Real-time threat detection (SIEM) |
| **72-hour notification** | Automated alerting | PagerDuty integration → Security team |
| **Incident log** | Log Analytics Workspace | Immutable audit trail |

**Policy File**: `infrastructure/policies/data-residency.json`

---

## 🛡️ SOC 2 Type II

### Common Criteria (CC)

#### CC6.1: Logical Access Controls

| Control | Azure Implementation | Evidence |
|---------|---------------------|----------|
| **User authentication** | Azure AD + MFA | Conditional Access Policies |
| **Role-based access (RBAC)** | Azure RBAC | Custom roles per principle of least privilege |
| **Session management** | Azure AD token expiry | 1-hour token lifetime, refresh rotation |
| **Password policy** | Azure AD Password Protection | Complexity requirements, breach detection |

**Azure Role Assignments**:
```json
{
  "Contributor": ["dev-team@company.com"],
  "Reader": ["business-users@company.com"],
  "ML Ops": ["data-scientists@company.com"],
  "Security Admin": ["infosec@company.com"]
}
```

#### CC6.6: Logical Access - Removal

| Control | Azure Implementation | Evidence |
|---------|---------------------|----------|
| **Termination process** | Automated deprovisioning | Azure AD HR integration |
| **Access review** | Quarterly access reviews | Azure AD Access Reviews |
| **Privileged access** | Just-In-Time (JIT) access | Azure PIM (Privileged Identity Management) |

#### CC7.2: System Monitoring

| Control | Azure Implementation | Evidence |
|---------|---------------------|----------|
| **Log collection** | Azure Monitor + Log Analytics | 90-day retention (hot), 2-year archive |
| **Anomaly detection** | Azure Sentinel | ML-powered threat detection |
| **Alerting** | Action Groups | Email, SMS, PagerDuty, webhook |
| **SIEM** | Azure Sentinel | Real-time correlation rules |

**Monitored Events**:
- Failed login attempts (threshold: 5 in 10 minutes)
- Privilege escalation
- Data exfiltration (large downloads)
- Configuration changes
- Policy violations

#### CC8.1: Change Management

| Control | Azure Implementation | Evidence |
|---------|---------------------|----------|
| **Infrastructure as Code** | Bicep templates + GitHub | All changes version-controlled |
| **Approval workflow** | Pull request reviews | 2 approvers required for production |
| **Automated testing** | Azure DevOps pipelines | Unit tests, security scans, policy checks |
| **Rollback capability** | ARM deployment history | One-click rollback to previous version |

**Change Approval Matrix**:
- Development: Self-service
- UAT: Team lead approval
- Production: Security + Architecture approval

---

## 🏆 ISO 27001:2013

### Annex A Controls

#### A.9.1 Access Control Policy

| Control ID | Control | Azure Implementation |
|------------|---------|---------------------|
| **A.9.1.1** | Access control policy | Azure RBAC + conditional access |
| **A.9.1.2** | Access to networks and services | NSG rules, private endpoints |
| **A.9.2.1** | User registration | Azure AD provisioning |
| **A.9.2.2** | Privileged access management | Azure PIM with approval workflow |
| **A.9.2.3** | User password management | Azure AD Password Protection |
| **A.9.4.1** | Information access restriction | Column-level security (SQL) |

#### A.10 Cryptography

| Control ID | Control | Azure Implementation |
|------------|---------|---------------------|
| **A.10.1.1** | Cryptographic controls | TLS 1.3 (transit), AES-256 (rest) |
| **A.10.1.2** | Key management | Azure Key Vault (FIPS 140-2 Level 2) |

**Encryption Configuration**:
```json
{
  "StorageAccount": {
    "encryption": {
      "services": {
        "blob": { "enabled": true, "keyType": "Account" },
        "file": { "enabled": true, "keyType": "Account" }
      },
      "keySource": "Microsoft.Keyvault",
      "keyvaultproperties": {
        "keyname": "storage-encryption-key",
        "keyvaulturi": "https://kv-aiplatform.vault.azure.net"
      }
    }
  }
}
```

#### A.12 Operations Security

| Control ID | Control | Azure Implementation |
|------------|---------|---------------------|
| **A.12.1.2** | Change management | GitOps + pull request workflow |
| **A.12.4.1** | Event logging | Azure Monitor (centralized) |
| **A.12.4.2** | Protection of log information | Immutable storage, WORM policy |
| **A.12.6.1** | Management of technical vulnerabilities | Microsoft Defender for Cloud |

#### A.18 Compliance

| Control ID | Control | Azure Implementation |
|------------|---------|---------------------|
| **A.18.1.1** | Identification of applicable legislation | Compliance Manager dashboard |
| **A.18.1.5** | Regulation of cryptographic controls | FIPS 140-2 validated modules |

---

## 💳 PCI-DSS v4.0

### Requirement 1: Install and Maintain Network Security Controls

| Sub-Requirement | Azure Implementation | Evidence |
|----------------|---------------------|----------|
| **1.2.1** | Network segmentation | VNet subnets + NSGs |
| **1.2.2** | Restrict inbound traffic | NSG deny-by-default rules |
| **1.2.3** | Restrict outbound traffic | Azure Firewall + application rules |
| **1.4.1** | Separate cardholder data | Dedicated subnet (10.0.6.0/24) |

**NSG Rules (Cardholder Data Subnet)**:
```json
{
  "securityRules": [
    {
      "name": "DenyInternetInbound",
      "priority": 100,
      "direction": "Inbound",
      "access": "Deny",
      "protocol": "*",
      "sourceAddressPrefix": "Internet"
    },
    {
      "name": "AllowApplicationSubnet",
      "priority": 200,
      "direction": "Inbound",
      "access": "Allow",
      "sourceAddressPrefix": "10.0.2.0/24"
    }
  ]
}
```

### Requirement 3: Protect Stored Account Data

| Sub-Requirement | Azure Implementation | Evidence |
|----------------|---------------------|----------|
| **3.5.1** | Encryption of cardholder data | AES-256, customer-managed keys |
| **3.6.1** | Key management | Azure Key Vault (HSM-backed) |
| **3.7.1** | Access controls | RBAC + dynamic data masking |

### Requirement 10: Log and Monitor All Access

| Sub-Requirement | Azure Implementation | Evidence |
|----------------|---------------------|----------|
| **10.2.1** | Audit log implementation | Log Analytics (all access events) |
| **10.3.4** | Log retention | 1-year hot storage, 7-year archive |
| **10.4.1** | Log review | Azure Sentinel automation rules |

---

## 🇦🇺 APRA CPS 234 (Australia)

### Information Security Capability

| Requirement | Azure Implementation | Evidence |
|-------------|---------------------|----------|
| **Board accountability** | Quarterly security reports | Azure Advisor + Security Center |
| **Information security capability** | Microsoft Defender for Cloud | Secure score: >85/100 |
| **Information asset identification** | Azure Purview | Data catalog + classification |
| **Implementation of controls** | Azure Policy | 15+ policy assignments |

### Incident Management

| Requirement | Azure Implementation | Evidence |
|-------------|---------------------|----------|
| **Incident response plan** | Runbook documentation | [runbook.md](./runbook.md) |
| **72-hour breach notification** | Automated alerting | Sentinel → PagerDuty → APRA portal |
| **Root cause analysis** | Log Analytics + Workbooks | Post-incident reports |

### Testing of Controls

| Requirement | Azure Implementation | Evidence |
|-------------|---------------------|----------|
| **Annual penetration testing** | Third-party engagement | Annual pen test reports |
| **Vulnerability management** | Microsoft Defender | Continuous scanning |
| **Compliance monitoring** | Azure Policy compliance | Monthly compliance dashboard |

### Third-Party Arrangements

| Requirement | Azure Implementation | Evidence |
|-------------|---------------------|----------|
| **Due diligence** | Microsoft Trust Center | SOC 2, ISO certifications |
| **Contractual arrangements** | Azure Service Level Agreement | 99.9% uptime SLA |
| **Ongoing monitoring** | Service Health Dashboard | Real-time status monitoring |

---

## 📋 Compliance Evidence Package

### Automated Evidence Collection

```powershell
# Generate compliance evidence package
./infrastructure/scripts/generate-compliance-report.ps1 `
  -SubscriptionId "xxxxx" `
  -Framework "GDPR,SOC2,ISO27001" `
  -OutputPath "./compliance-reports/"
```

**Generated Artifacts**:
1. **Access Control Report**: RBAC assignments, role definitions
2. **Encryption Report**: Encryption status for all storage accounts
3. **Network Security Report**: NSG rules, private endpoint status
4. **Audit Log Report**: Key security events (last 90 days)
5. **Policy Compliance Report**: Policy assignment compliance %
6. **Vulnerability Report**: Security findings from Defender
7. **Backup Report**: Backup status, retention configuration

---

## 🔄 Continuous Compliance Monitoring

### Azure Policy Compliance Dashboard

Real-time compliance tracking via Azure Policy:

```json
{
  "complianceState": "Compliant",
  "policyAssignments": [
    { "name": "Require data residency", "compliance": 100 },
    { "name": "Encryption required", "compliance": 100 },
    { "name": "Network isolation", "compliance": 98 },
    { "name": "Tagging enforcement", "compliance": 95 },
    { "name": "Audit logging", "compliance": 100 }
  ]
}
```

### Monthly Compliance Review Checklist

- [ ] Review access control assignments (quarterly access review)
- [ ] Validate encryption status for all storage accounts
- [ ] Check Azure Policy compliance scores (target: >95%)
- [ ] Review security alerts from Sentinel (resolve within SLA)
- [ ] Update compliance documentation (any architecture changes?)
- [ ] Test disaster recovery procedures (quarterly)
- [ ] Conduct vulnerability assessments (monthly scans)
- [ ] Update risk register (new threats or vulnerabilities?)

---

## 📞 Compliance Support

| Framework | Contact | SLA |
|-----------|---------|-----|
| **GDPR** | privacy@company.com | 48 hours |
| **SOC 2** | audit@company.com | 72 hours |
| **ISO 27001** | infosec@company.com | 24 hours |
| **PCI-DSS** | compliance@company.com | 24 hours |
| **APRA CPS 234** | risk@company.com | 12 hours |

---

## 📚 Reference Documents

- [Architecture Diagram](./architecture-diagram.md) - Infrastructure overview
- [Security Baseline](./security-baseline.md) - Security configuration standards
- [Azure Policy Definitions](../policies/) - Policy JSON files
- [Microsoft Compliance](https://aka.ms/AzureCompliance) - Azure compliance certifications

---

**Version**: 1.0  
**Last Updated**: January 27, 2026  
**Owner**: Compliance & Risk Team  
**Review Cycle**: Quarterly (or upon regulatory changes)
