# Operations Runbook

## 🎯 Purpose

This runbook provides step-by-step operational procedures for managing the Azure AI platform infrastructure. It covers deployment, monitoring, troubleshooting, incident response, and maintenance activities.

---

## 📑 Table of Contents

1. [Deployment Procedures](#-deployment-procedures)
2. [Daily Operations](#-daily-operations)
3. [Monitoring & Alerting](#-monitoring--alerting)
4. [Incident Response](#-incident-response)
5. [Troubleshooting Guide](#-troubleshooting-guide)
6. [Maintenance Windows](#-maintenance-windows)
7. [Disaster Recovery](#-disaster-recovery)
8. [Contact Information](#-contact-information)

---

## 🚀 Deployment Procedures

### Initial Infrastructure Deployment

#### Prerequisites

- [ ] Azure subscription with Owner or Contributor role
- [ ] Azure CLI installed (`az --version >= 2.50.0`)
- [ ] Git repository cloned locally
- [ ] Service principal created for automation (if applicable)
- [ ] Parameters file customized for environment

#### Step 1: Validate Parameters

```powershell
# Navigate to bicep directory
cd infrastructure/bicep

# Review and customize parameters
code parameters/prod.parameters.json

# Validate required parameters
$params = Get-Content parameters/prod.parameters.json | ConvertFrom-Json
if (-not $params.parameters.projectName.value) {
    Write-Error "projectName is required"
}
```

#### Step 2: Validate Bicep Template

```powershell
# Test bicep compilation
az bicep build --file main.bicep

# Run what-if analysis (dry run)
az deployment sub create `
  --location australiaeast `
  --template-file main.bicep `
  --parameters @parameters/prod.parameters.json `
  --what-if

# Review output for unexpected changes
```

#### Step 3: Deploy Infrastructure

```powershell
# Deploy to Azure
az deployment sub create `
  --name "ai-platform-$(Get-Date -Format 'yyyyMMdd-HHmmss')" `
  --location australiaeast `
  --template-file main.bicep `
  --parameters @parameters/prod.parameters.json `
  --verbose

# Expected duration: 15-25 minutes
# Monitor progress in Azure Portal > Deployments
```

#### Step 4: Post-Deployment Configuration

```powershell
# Configure RBAC roles
cd ../scripts
.\configure-rbac.ps1 -Environment prod

# Setup monitoring and alerts
.\setup-monitoring.ps1 -Environment prod

# Run compliance scan
.\compliance-scan.ps1 -Environment prod

# Validate security baseline
.\validate-security-baseline.ps1 -Environment prod
```

#### Step 5: Deployment Verification

```bash
# Verify resources created
az resource list \
  --resource-group rg-aiplatform-prod \
  --output table

# Check Azure ML workspace
az ml workspace show \
  --name mlw-aiplatform-prod \
  --resource-group rg-aiplatform-prod

# Verify private endpoints
az network private-endpoint list \
  --resource-group rg-aiplatform-prod \
  --output table

# Test connectivity (from VM in VNet)
curl https://<storage-account>.blob.core.windows.net
# Should resolve to private IP (10.0.x.x)
```

---

### Application Deployment

#### Deploy Static Web Apps (Calculators)

```powershell
cd infrastructure/scripts
.\deploy-calculators.ps1 -Environment prod

# Or manually:
cd calculators
az staticwebapp create `
  --name swa-calculators-prod `
  --resource-group rg-aiplatform-prod `
  --source https://github.com/andreaswasita/AI-Delivery-Methodology `
  --location australiaeast `
  --branch main `
  --app-location "/calculators" `
  --api-location "" `
  --output-location "/"
```

#### Deploy ML Models

```python
# From Azure ML workspace
from azureml.core import Workspace, Model
from azureml.core.webservice import AciWebservice, Webservice

# Connect to workspace
ws = Workspace.from_config()

# Register model
model = Model.register(
    workspace=ws,
    model_path="./model.pkl",
    model_name="fraud-detection-v1",
    tags={"version": "1.0", "type": "classification"}
)

# Deploy to endpoint
deployment_config = AciWebservice.deploy_configuration(
    cpu_cores=2,
    memory_gb=4,
    auth_enabled=True
)

service = Model.deploy(
    workspace=ws,
    name="fraud-detection-service",
    models=[model],
    deployment_config=deployment_config
)

service.wait_for_deployment(show_output=True)
print(f"Scoring URI: {service.scoring_uri}")
```

---

## 🔄 Daily Operations

### Morning Health Check (15 minutes)

#### Azure Portal Review

1. **Azure Service Health Dashboard**
   - Navigate to: portal.azure.com → Service Health
   - Check for active incidents in Australia East/Southeast
   - Review planned maintenance notifications

2. **Resource Health**
   - Portal → All resources → Health status column
   - Investigate any "Degraded" or "Unavailable" resources

3. **Cost Management**
   - Portal → Cost Management → Cost analysis
   - Verify daily spend within budget (+/- 10%)
   - Investigate anomalies (>20% spike)

#### Azure Monitor Review

```powershell
# Check for critical alerts in last 24 hours
az monitor alert list \
  --resource-group rg-aiplatform-prod \
  --query "[?properties.severity=='Critical' || properties.severity=='Error'].{Name:name, Severity:properties.severity, Time:properties.lastUpdatedTime}" \
  --output table

# Review error rate
az monitor metrics list \
  --resource <resource-id> \
  --metric "Http5xx" \
  --start-time (Get-Date).AddDays(-1).ToString("yyyy-MM-ddTHH:mm:ssZ") \
  --interval PT1H \
  --aggregation Total
```

#### Sentinel Security Review

- Navigate to: portal.azure.com → Microsoft Sentinel
- Review **Incidents** dashboard (active incidents)
- Check **Hunting** queries for anomalies
- Verify **Playbooks** ran successfully (automated responses)

---

### Weekly Maintenance (1 hour)

#### Access Review

```powershell
# List role assignments
az role assignment list \
  --resource-group rg-aiplatform-prod \
  --output table

# Identify stale accounts (no sign-in >30 days)
az ad user list \
  --filter "accountEnabled eq true" \
  --query "[?signInActivity.lastSignInDateTime < '$(Get-Date).AddDays(-30).ToString(\"yyyy-MM-dd\")'].{UPN:userPrincipalName, LastSignIn:signInActivity.lastSignInDateTime}"
```

#### Backup Verification

```bash
# Verify SQL backups
az sql db list-backups \
  --resource-group rg-aiplatform-prod \
  --server sql-aiplatform-prod \
  --database db-aiplatform-prod

# Test restore (to temp database)
az sql db restore \
  --dest-name db-restore-test-$(date +%Y%m%d) \
  --resource-group rg-aiplatform-prod \
  --server sql-aiplatform-prod \
  --name db-aiplatform-prod \
  --time "2026-01-26T10:00:00Z"
```

#### Vulnerability Scan Review

- Navigate to: Microsoft Defender for Cloud → Recommendations
- Filter by severity: Critical, High
- Assign remediation tasks to engineering team
- Track in Azure DevOps / Jira

---

### Monthly Activities

#### Compliance Reporting

```powershell
# Generate compliance report
cd infrastructure/scripts
.\generate-compliance-report.ps1 `
  -SubscriptionId "<subscription-id>" `
  -Framework "GDPR,SOC2,ISO27001" `
  -OutputPath "C:\compliance-reports\$(Get-Date -Format 'yyyy-MM')\"

# Review policy compliance
az policy state list `
  --resource-group rg-aiplatform-prod `
  --query "[?complianceState=='NonCompliant'].{Policy:policyDefinitionName, Resource:resourceId}" `
  --output table
```

#### Cost Optimization Review

1. **Identify unused resources**:
   - Stopped VMs not deallocated
   - Unattached disks
   - Orphaned public IPs
   - Unused storage accounts

2. **Right-sizing recommendations**:
   - Azure Advisor → Cost recommendations
   - Downsize over-provisioned VMs
   - Convert to reserved instances (1-year/3-year)

3. **Budget alerts**:
   - Verify budget alerts configured
   - Adjust forecasts based on trends

#### Security Review

- Rotate service principal secrets (90-day policy)
- Review firewall logs for suspicious traffic
- Update vulnerability management dashboard
- Conduct tabletop security exercise

---

## 📊 Monitoring & Alerting

### Key Metrics Dashboard

#### Application Performance

| Metric | Threshold | Alert Severity |
|--------|-----------|---------------|
| **API Response Time (p95)** | >2 seconds | Warning |
| **API Response Time (p99)** | >5 seconds | Critical |
| **Error Rate (5xx)** | >1% | Critical |
| **Availability** | <99.9% | Critical |
| **Request Rate** | >10,000 req/min | Info (scaling trigger) |

**Kusto Query**:
```kusto
AppRequests
| where TimeGenerated > ago(1h)
| summarize 
    P50 = percentile(DurationMs, 50),
    P95 = percentile(DurationMs, 95),
    P99 = percentile(DurationMs, 99),
    ErrorRate = countif(Success == false) * 100.0 / count()
| project P50, P95, P99, ErrorRate
```

#### Infrastructure Health

| Metric | Threshold | Alert Severity |
|--------|-----------|---------------|
| **CPU Utilization** | >80% | Warning |
| **Memory Utilization** | >85% | Warning |
| **Disk I/O** | >90% | Critical |
| **Network Throughput** | >80% capacity | Warning |
| **Storage Account** | >80% capacity | Warning |

**Azure CLI**:
```bash
# CPU utilization
az monitor metrics list \
  --resource <vm-resource-id> \
  --metric "Percentage CPU" \
  --aggregation Average \
  --interval PT1M

# Storage capacity
az storage account show \
  --name staaiplatformprod \
  --query "primaryEndpoints"
```

#### ML Model Performance

| Metric | Threshold | Alert Severity |
|--------|-----------|---------------|
| **Model Accuracy** | <85% | Critical |
| **Inference Latency** | >500ms | Warning |
| **Data Drift Score** | >0.3 | Warning |
| **Prediction Volume** | <100/hour (expected >1000) | Warning |

**Azure ML Monitoring**:
```python
from azureml.core import Workspace
from azureml.core.model import Model

ws = Workspace.from_config()
model = Model(ws, name="fraud-detection-v1")

# Get model metrics
metrics = model.get_metrics()
print(f"Accuracy: {metrics.get('accuracy')}")
print(f"Precision: {metrics.get('precision')}")
print(f"Recall: {metrics.get('recall')}")
```

---

### Alert Configuration

#### Critical Alert Action Group

```json
{
  "name": "ag-critical-alerts",
  "emailReceivers": [
    { "name": "OnCallEngineer", "emailAddress": "oncall@company.com" }
  ],
  "smsReceivers": [
    { "name": "OnCallSMS", "phoneNumber": "+61XXXXXXXXX" }
  ],
  "webhookReceivers": [
    { 
      "name": "PagerDuty", 
      "serviceUri": "https://events.pagerduty.com/integration/xxx/enqueue"
    }
  ]
}
```

**Setup Command**:
```bash
az monitor action-group create \
  --name ag-critical-alerts \
  --resource-group rg-aiplatform-prod \
  --action email oncall oncall@company.com \
  --action sms oncall +61XXXXXXXXX
```

---

## 🚨 Incident Response

### Severity Classification

| Severity | Impact | Response Time | Escalation |
|----------|--------|---------------|------------|
| **P1 (Critical)** | Service down, data breach | 15 minutes | Incident Commander + CISO |
| **P2 (High)** | Degraded performance, partial outage | 1 hour | Team Lead |
| **P3 (Medium)** | Minor issues, workaround available | 4 hours | Standard support |
| **P4 (Low)** | Informational, no user impact | 24 hours | Best effort |

---

### Incident Response Procedures

#### P1 - Service Down

**Symptoms**:
- Application returning 500 errors
- Azure ML endpoint not responding
- Database connection failures

**Immediate Actions** (0-15 minutes):

1. **Declare Incident**
   ```powershell
   # Create incident in ServiceNow (or ticketing system)
   # Set severity: P1
   # Assign: On-call engineer
   # Notify: Incident Commander
   ```

2. **Check Service Health**
   - Azure Portal → Service Health → Check for platform issues
   - If Azure outage: Follow Microsoft guidance, communicate to stakeholders

3. **Check Application Health**
   ```bash
   # Test API endpoint
   curl -i https://api.aiplatform.company.com/health
   
   # Check application logs
   az monitor app-insights query \
     --app <app-insights-id> \
     --analytics-query "traces | where severityLevel >= 3 | top 50 by timestamp desc"
   ```

4. **Initial Containment**
   - If security incident: Isolate affected resources
   - If performance issue: Scale up resources
   - If config issue: Rollback to last known good deployment

**Investigation** (15-60 minutes):

5. **Root Cause Analysis**
   - Review recent changes (Git commits, ARM deployments)
   - Check for configuration drift
   - Analyze error patterns in Application Insights
   - Review database performance metrics

6. **Gather Evidence**
   ```powershell
   # Export logs
   az monitor activity-log list \
     --resource-group rg-aiplatform-prod \
     --start-time (Get-Date).AddHours(-4) \
     --output json > incident-logs.json
   
   # Capture network traces (if needed)
   # Take snapshots of affected VMs
   ```

**Resolution** (1-4 hours):

7. **Implement Fix**
   - Apply hotfix or rollback
   - Restart services if necessary
   - Validate fix in staging first (if possible)

8. **Verify Resolution**
   - Test all critical user flows
   - Monitor error rates return to baseline
   - Check with stakeholders

**Recovery** (4-24 hours):

9. **Post-Incident Activities**
   - Update status page
   - Send post-mortem email
   - Schedule post-incident review meeting (within 48 hours)

---

#### P2 - Performance Degradation

**Symptoms**:
- API response times >5 seconds
- High CPU/memory utilization
- Increased error rate (but <1%)

**Response Steps**:

1. **Identify Bottleneck**
   ```kusto
   // Application Insights query
   requests
   | where timestamp > ago(1h)
   | where duration > 5000 // 5 seconds
   | summarize count() by operation_Name
   | order by count_ desc
   ```

2. **Scale Resources** (if resource exhaustion)
   ```bash
   # Scale App Service
   az appservice plan update \
     --name plan-aiplatform-prod \
     --resource-group rg-aiplatform-prod \
     --sku P2V2
   
   # Scale Azure ML compute
   az ml compute update \
     --name compute-cluster \
     --max-instances 10 \
     --workspace-name mlw-aiplatform-prod \
     --resource-group rg-aiplatform-prod
   ```

3. **Optimize Code** (if application issue)
   - Review slow database queries
   - Check for memory leaks
   - Optimize ML inference code

---

#### P1 - Security Incident (Data Breach)

**CRITICAL**: Follow regulatory notification requirements (GDPR: 72 hours)

**Immediate Actions** (0-30 minutes):

1. **Containment**
   ```powershell
   # Disable compromised account
   az ad user update --id user@company.com --account-enabled false
   
   # Block suspicious IP
   az network firewall application-rule create \
     --collection-name "BlockMaliciousIPs" \
     --firewall-name azfw-aiplatform-prod \
     --name "BlockAttacker" \
     --source-addresses "x.x.x.x" \
     --protocols Http=80 Https=443 \
     --target-fqdns "*" \
     --action Deny
   
   # Isolate affected VM
   az network nsg rule update \
     --resource-group rg-aiplatform-prod \
     --nsg-name nsg-isolated \
     --name DenyAllInbound \
     --access Deny
   ```

2. **Preserve Evidence**
   ```bash
   # Take VM snapshot
   az snapshot create \
     --resource-group rg-aiplatform-prod \
     --name snapshot-incident-$(date +%Y%m%d) \
     --source <vm-disk-id>
   
   # Export security logs (immutable)
   # DO NOT modify logs
   ```

3. **Notifications**
   - Notify CISO immediately
   - Notify legal/compliance team
   - Prepare for regulatory notification (GDPR: 72 hours)
   - External notification (customers) if PII exposed

**Investigation** (1-72 hours):

4. **Forensic Analysis**
   - Engage cyber forensics team
   - Analyze attack vector
   - Identify compromised data
   - Determine scope (number of affected records)

5. **Regulatory Notification** (within 72 hours for GDPR)
   - Notify data protection authority
   - Prepare breach notification letter
   - Post on website if >500 individuals affected

**Recovery** (3-7 days):

6. **Remediation**
   - Patch vulnerabilities
   - Reset all credentials
   - Enhance security controls
   - Conduct security audit

7. **Post-Incident**
   - Conduct thorough post-mortem
   - Update incident response plan
   - Provide security training to team
   - Implement additional monitoring

---

## 🔧 Troubleshooting Guide

### Common Issues & Resolutions

#### Issue: Azure ML Workspace Not Accessible

**Symptoms**:
- `az ml workspace show` returns error
- Portal shows "Loading..." indefinitely

**Troubleshooting Steps**:

1. Check network connectivity
   ```bash
   # Verify private endpoint DNS resolution
   nslookup <workspace-name>.api.azureml.ms
   # Should resolve to 10.0.x.x (private IP)
   
   # If resolves to public IP (13.x.x.x), DNS not configured
   ```

2. Verify private endpoint connection
   ```bash
   az network private-endpoint list \
     --resource-group rg-aiplatform-prod \
     --query "[?name=='pe-mlworkspace'].{Name:name, State:privateLinkServiceConnections[0].privateLinkServiceConnectionState.status}"
   ```

3. Check NSG rules
   ```bash
   # Verify subnet allows outbound to Azure ML control plane
   az network nsg rule list \
     --resource-group rg-aiplatform-prod \
     --nsg-name nsg-aiml-subnet
   ```

**Resolution**:
- Configure private DNS zone
- Approve private endpoint connection
- Update NSG rules to allow Azure ML traffic

---

#### Issue: Storage Account Access Denied

**Symptoms**:
- ML training job fails with "BlobNotFound" or "Unauthorized"
- Application cannot write to Blob Storage

**Troubleshooting Steps**:

1. Check authentication method
   ```python
   # Verify managed identity has access
   from azure.identity import DefaultAzureCredential
   from azure.storage.blob import BlobServiceClient
   
   credential = DefaultAzureCredential()
   blob_service = BlobServiceClient(
       account_url="https://staaiplatform.blob.core.windows.net",
       credential=credential
   )
   
   # List containers (will fail if no access)
   for container in blob_service.list_containers():
       print(container.name)
   ```

2. Verify RBAC assignments
   ```bash
   az role assignment list \
     --assignee <managed-identity-object-id> \
     --scope /subscriptions/.../resourceGroups/rg-aiplatform-prod/providers/Microsoft.Storage/storageAccounts/staaiplatform \
     --output table
   ```

3. Check firewall rules
   ```bash
   az storage account show \
     --name staaiplatform \
     --query "networkRuleSet"
   ```

**Resolution**:
- Assign "Storage Blob Data Contributor" role to managed identity
- Add VNet subnet to storage account firewall allow list
- Verify private endpoint status

---

#### Issue: High API Latency

**Symptoms**:
- API response times >5 seconds
- Users reporting slow page loads

**Troubleshooting Steps**:

1. Identify slow endpoints
   ```kusto
   requests
   | where timestamp > ago(1h)
   | summarize avg(duration), max(duration), count() by operation_Name
   | where avg_duration > 2000
   | order by avg_duration desc
   ```

2. Check dependencies
   ```kusto
   dependencies
   | where timestamp > ago(1h)
   | summarize avg(duration) by target, type
   | where avg_duration > 500
   ```

3. Check database performance
   ```bash
   # SQL Database DTU usage
   az sql db show \
     --name db-aiplatform-prod \
     --server sql-aiplatform-prod \
     --resource-group rg-aiplatform-prod \
     --query "currentServiceObjectiveName"
   
   # Check for blocking queries
   # Login to SQL Server Management Studio
   # Run: sp_who2
   ```

**Resolution**:
- Scale up App Service plan
- Optimize slow database queries
- Implement caching (Azure Redis Cache)
- Enable CDN for static content

---

## 🔄 Maintenance Windows

### Planned Maintenance Schedule

| Activity | Frequency | Window | Impact |
|----------|-----------|--------|--------|
| **OS Patching** | Monthly (2nd Tuesday) | 02:00-04:00 AEST | VM restarts |
| **Database Maintenance** | Weekly (Sunday) | 01:00-02:00 AEST | None (automatic) |
| **Certificate Renewal** | 30 days before expiry | Business hours | None (automated) |
| **Backup Testing** | Monthly (last Sunday) | 03:00-06:00 AEST | None (test env) |
| **DR Failover Test** | Quarterly | Scheduled with stakeholders | Brief service disruption |

---

### Maintenance Procedure Template

#### Pre-Maintenance Checklist

- [ ] Change request approved (CAB)
- [ ] Stakeholders notified (7 days notice)
- [ ] Status page updated
- [ ] Rollback plan documented
- [ ] Backup verified (within 24 hours)
- [ ] On-call engineer assigned

#### During Maintenance

- [ ] Start maintenance window
- [ ] Update status page: "Maintenance in progress"
- [ ] Execute change
- [ ] Validate changes
- [ ] Run smoke tests
- [ ] Monitor error rates

#### Post-Maintenance Checklist

- [ ] Validate all services operational
- [ ] Review monitoring dashboard (30 minutes)
- [ ] Update status page: "Maintenance complete"
- [ ] Send completion email to stakeholders
- [ ] Document lessons learned

---

## 💾 Disaster Recovery

### Disaster Recovery Plan

**RPO (Recovery Point Objective)**: 1 hour  
**RTO (Recovery Time Objective)**: 4 hours

---

### DR Failover Procedure (Region Failure)

**Scenario**: Australia East region unavailable

**Step 1: Assess Impact** (0-15 minutes)

```bash
# Check Azure Service Health
az rest --method get --url "https://management.azure.com/subscriptions/<sub-id>/providers/Microsoft.ResourceHealth/availabilityStatuses?api-version=2020-05-01" \
  --query "value[?properties.availabilityState!='Available']"

# Determine failover necessity
# Criteria: Region unavailable >1 hour OR Microsoft recommends failover
```

**Step 2: Activate DR** (15-60 minutes)

```powershell
# Failover SQL Database
az sql db failover \
  --resource-group rg-aiplatform-prod \
  --server sql-aiplatform-prod \
  --name db-aiplatform-prod

# Failover Cosmos DB (automatic if multi-region write enabled)
# Manual priority change:
az cosmosdb failover-priority-change \
  --name cosmos-aiplatform-prod \
  --resource-group rg-aiplatform-prod \
  --failover-policies "australiasoutheast=0 australiaeast=1"

# Update Traffic Manager to point to secondary region
az network traffic-manager endpoint update \
  --name endpoint-secondary \
  --profile-name tm-aiplatform-prod \
  --resource-group rg-aiplatform-prod \
  --type azureEndpoints \
  --priority 1
```

**Step 3: Verify Services** (60-120 minutes)

```bash
# Test application endpoint
curl https://api.aiplatform.company.com/health

# Verify data consistency
# Run validation queries against database

# Test ML model inference
curl -X POST https://mlendpoint.azureml.ms/score \
  -H "Content-Type: application/json" \
  -d '{"data": [test_data]}'
```

**Step 4: Communication** (throughout)

- Update status page every 30 minutes
- Send email updates to stakeholders
- Post on internal Slack/Teams channel

---

### DR Failback Procedure (Return to Primary Region)

**When**: Primary region restored and stable for >24 hours

```powershell
# Reverse failover steps
az sql db failover \
  --resource-group rg-aiplatform-prod \
  --server sql-aiplatform-prod \
  --name db-aiplatform-prod

# Update Traffic Manager priority
az network traffic-manager endpoint update \
  --name endpoint-primary \
  --priority 1 \
  --profile-name tm-aiplatform-prod \
  --resource-group rg-aiplatform-prod

# Verify data sync complete
# Monitor for 2 hours post-failback
```

---

## 📞 Contact Information

### On-Call Rotation

| Role | Primary | Secondary | Escalation |
|------|---------|-----------|------------|
| **Platform Engineer** | John Smith (+61 XXX XXX XXX) | Jane Doe (+61 XXX XXX XXX) | Team Lead |
| **Security Engineer** | Security Team (security@company.com) | CISO (+61 XXX XXX XXX) | Executive Team |
| **Database Administrator** | DBA Team (dba@company.com) | Senior DBA | Platform Lead |
| **Network Engineer** | Network Team (network@company.com) | Network Manager | Infrastructure Lead |

### Escalation Path

```
P1 Incident
    ↓
On-Call Engineer (15 min)
    ↓
Team Lead (30 min)
    ↓
Incident Commander (1 hour)
    ↓
CTO (2 hours)
```

---

### External Contacts

| Service | Contact | Purpose |
|---------|---------|---------|
| **Microsoft Azure Support** | portal.azure.com → Support | Platform issues |
| **Microsoft TAM** | tam@microsoft.com | Technical guidance |
| **PagerDuty** | support@pagerduty.com | Alerting platform |
| **Security Vendor** | SOC provider | Threat intelligence |

---

## 📚 Reference Documents

- [Architecture Diagram](./architecture-diagram.md)
- [Security Baseline](./security-baseline.md)
- [Compliance Mapping](./compliance-mapping.md)
- [Bicep Templates](../bicep/)

---

## 📝 Runbook Maintenance

**Review Frequency**: Quarterly  
**Last Updated**: January 27, 2026  
**Next Review**: April 27, 2026  
**Owner**: Platform Engineering Team

**Change Log**:
- 2026-01-27: Initial version created
- [Future updates documented here]

---

**For urgent incidents, call the on-call engineer via PagerDuty: 1-800-XXX-XXXX**
