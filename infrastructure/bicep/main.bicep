// Main Bicep template for standardized AI platform infrastructure
// Compliance-ready: GDPR, SOC 2, ISO 27001, PCI-DSS, APRA CPS 234
// Version: 1.0
// Last Updated: January 13, 2026

targetScope = 'subscription'

// ============================================================================
// PARAMETERS
// ============================================================================

@description('Environment name (dev, test, uat, prod)')
@allowed([
  'dev'
  'test'
  'uat'
  'prod'
])
param environment string = 'prod'

@description('Primary Azure region')
param location string = 'australiaeast'

@description('Secondary region for DR')
param secondaryLocation string = 'australiasoutheast'

@description('Project name for resource naming')
@minLength(3)
@maxLength(10)
param projectName string

@description('Organization name for tagging')
param organizationName string

@description('Cost center for billing')
param costCenter string

@description('Enable compliance features')
param enableCompliance bool = true

@description('Enable advanced monitoring (Sentinel)')
param enableSentinel bool = true

@description('Enable geo-redundancy')
param enableGeoRedundancy bool = true

@description('Data residency requirement')
@allowed([
  'Australia'
  'Singapore'
  'Japan'
  'India'
  'None'
])
param dataResidency string = 'Australia'

// ============================================================================
// VARIABLES
// ============================================================================

var resourceGroupName = 'rg-${projectName}-${environment}'
var tags = {
  Environment: environment
  Project: projectName
  Organization: organizationName
  CostCenter: costCenter
  ManagedBy: 'Bicep-IaC'
  Compliance: enableCompliance ? 'Enabled' : 'Disabled'
  DataResidency: dataResidency
  DeploymentDate: utcNow('yyyy-MM-dd')
}

// ============================================================================
// RESOURCE GROUP
// ============================================================================

resource resourceGroup 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

// ============================================================================
// MODULES
// ============================================================================

// 1. Networking - VNet, NSGs, Private Endpoints
module networking './modules/networking.bicep' = {
  scope: resourceGroup
  name: 'networking-deployment'
  params: {
    location: location
    environment: environment
    projectName: projectName
    enableCompliance: enableCompliance
    tags: tags
  }
}

// 2. Security - Key Vault, Managed Identity, RBAC
module security './modules/security.bicep' = {
  scope: resourceGroup
  name: 'security-deployment'
  params: {
    location: location
    environment: environment
    projectName: projectName
    vnetId: networking.outputs.vnetId
    privateEndpointSubnetId: networking.outputs.privateEndpointSubnetId
    enableCompliance: enableCompliance
    tags: tags
  }
}

// 3. Monitoring - Log Analytics, Application Insights, Sentinel
module monitoring './modules/monitoring.bicep' = {
  scope: resourceGroup
  name: 'monitoring-deployment'
  params: {
    location: location
    environment: environment
    projectName: projectName
    enableSentinel: enableSentinel
    logRetentionDays: environment == 'prod' ? 365 : (environment == 'test' ? 90 : 30)
    tags: tags
  }
}

// 4. Data Layer - Storage, SQL, Cosmos DB, Data Lake
module data './modules/data.bicep' = {
  scope: resourceGroup
  name: 'data-deployment'
  params: {
    location: location
    secondaryLocation: secondaryLocation
    environment: environment
    projectName: projectName
    vnetId: networking.outputs.vnetId
    dataSubnetId: networking.outputs.dataSubnetId
    privateEndpointSubnetId: networking.outputs.privateEndpointSubnetId
    keyVaultName: security.outputs.keyVaultName
    enableGeoRedundancy: enableGeoRedundancy
    enableCompliance: enableCompliance
    logAnalyticsWorkspaceId: monitoring.outputs.logAnalyticsWorkspaceId
    tags: tags
  }
}

// 5. AI Services - Azure ML, OpenAI, Cognitive Services
module aiServices './modules/ai-services.bicep' = {
  scope: resourceGroup
  name: 'ai-services-deployment'
  params: {
    location: location
    environment: environment
    projectName: projectName
    vnetId: networking.outputs.vnetId
    aiServicesSubnetId: networking.outputs.aiServicesSubnetId
    privateEndpointSubnetId: networking.outputs.privateEndpointSubnetId
    keyVaultName: security.outputs.keyVaultName
    storageAccountId: data.outputs.storageAccountId
    logAnalyticsWorkspaceId: monitoring.outputs.logAnalyticsWorkspaceId
    applicationInsightsId: monitoring.outputs.applicationInsightsId
    enableCompliance: enableCompliance
    tags: tags
  }
}

// 6. Compute - AKS, VM Scale Sets
module compute './modules/compute.bicep' = {
  scope: resourceGroup
  name: 'compute-deployment'
  params: {
    location: location
    environment: environment
    projectName: projectName
    vnetId: networking.outputs.vnetId
    computeSubnetId: networking.outputs.computeSubnetId
    managedIdentityId: security.outputs.managedIdentityId
    logAnalyticsWorkspaceId: monitoring.outputs.logAnalyticsWorkspaceId
    enableCompliance: enableCompliance
    tags: tags
  }
}

// 7. Governance - Policies, Budgets, Alerts
module governance './modules/governance.bicep' = {
  scope: resourceGroup
  name: 'governance-deployment'
  params: {
    environment: environment
    projectName: projectName
    resourceGroupId: resourceGroup.id
    enableCompliance: enableCompliance
    monthlyBudget: environment == 'prod' ? 20000 : (environment == 'test' ? 5000 : 3000)
    tags: tags
  }
}

// ============================================================================
// OUTPUTS
// ============================================================================

output resourceGroupName string = resourceGroup.name
output location string = location
output vnetId string = networking.outputs.vnetId
output keyVaultName string = security.outputs.keyVaultName
output logAnalyticsWorkspaceId string = monitoring.outputs.logAnalyticsWorkspaceId
output storageAccountName string = data.outputs.storageAccountName
output azureMLWorkspaceName string = aiServices.outputs.azureMLWorkspaceName
output aksClusterName string = compute.outputs.aksClusterName
output deploymentTimestamp string = utcNow()
output complianceEnabled bool = enableCompliance
output dataResidency string = dataResidency
