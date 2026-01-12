// AI Services Module
// Deploys Azure ML, Azure OpenAI, Cognitive Services, Container Registry
// Compliance: Model governance, audit trails, secure access

targetScope = 'resourceGroup'

// ============================================================================
// PARAMETERS
// ============================================================================

@description('Azure region')
param location string

@description('Environment')
param environment string

@description('Project name')
param projectName string

@description('VNet ID')
param vnetId string

@description('AI Services Subnet ID')
param aiServicesSubnetId string

@description('Private Endpoint Subnet ID')
param privateEndpointSubnetId string

@description('Key Vault name')
param keyVaultName string

@description('Storage Account ID')
param storageAccountId string

@description('Log Analytics Workspace ID')
param logAnalyticsWorkspaceId string

@description('Application Insights ID')
param applicationInsightsId string

@description('Enable compliance features')
param enableCompliance bool

@description('Resource tags')
param tags object

// ============================================================================
// VARIABLES
// ============================================================================

var azureMLWorkspaceName = 'mlw-${projectName}-${environment}'
var openAIAccountName = 'oai-${projectName}-${environment}-${uniqueString(resourceGroup().id)}'
var cognitiveServicesName = 'cog-${projectName}-${environment}-${uniqueString(resourceGroup().id)}'
var containerRegistryName = 'cr${projectName}${environment}${uniqueString(resourceGroup().id)}'

// ============================================================================
// CONTAINER REGISTRY
// ============================================================================

resource containerRegistry 'Microsoft.ContainerRegistry/registries@2023-07-01' = {
  name: containerRegistryName
  location: location
  tags: tags
  sku: {
    name: environment == 'prod' ? 'Premium' : 'Standard'
  }
  properties: {
    adminUserEnabled: false
    publicNetworkAccess: enableCompliance ? 'Disabled' : 'Enabled'
    networkRuleBypassOptions: 'AzureServices'
    policies: {
      quarantinePolicy: {
        status: 'enabled'
      }
      trustPolicy: {
        type: 'Notary'
        status: environment == 'prod' ? 'enabled' : 'disabled'
      }
      retentionPolicy: {
        days: environment == 'prod' ? 30 : 7
        status: 'enabled'
      }
    }
    encryption: {
      status: 'disabled' // Can be enabled with Key Vault
    }
    dataEndpointEnabled: true
    zoneRedundancy: environment == 'prod' ? 'Enabled' : 'Disabled'
  }
}

// Container Registry - Private Endpoint
resource acrPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = if (enableCompliance) {
  name: 'pe-${containerRegistryName}'
  location: location
  tags: tags
  properties: {
    subnet: {
      id: privateEndpointSubnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'pe-${containerRegistryName}-connection'
        properties: {
          privateLinkServiceId: containerRegistry.id
          groupIds: [
            'registry'
          ]
        }
      }
    ]
  }
}

// ============================================================================
// AZURE MACHINE LEARNING WORKSPACE
// ============================================================================

resource azureMLWorkspace 'Microsoft.MachineLearningServices/workspaces@2023-06-01-preview' = {
  name: azureMLWorkspaceName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    friendlyName: '${projectName} ML Workspace - ${environment}'
    description: 'Azure ML Workspace for ${projectName} (${environment})'
    storageAccount: storageAccountId
    keyVault: resourceId('Microsoft.KeyVault/vaults', keyVaultName)
    applicationInsights: applicationInsightsId
    containerRegistry: containerRegistry.id
    publicNetworkAccess: enableCompliance ? 'Disabled' : 'Enabled'
    imageBuildCompute: 'cpu-cluster'
    hbiWorkspace: enableCompliance // High Business Impact workspace for compliance
    v1LegacyMode: false
    discoveryUrl: 'https://${location}.api.azureml.ms/discovery'
  }
}

// Azure ML - Private Endpoint
resource amlPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = if (enableCompliance) {
  name: 'pe-${azureMLWorkspaceName}'
  location: location
  tags: tags
  properties: {
    subnet: {
      id: privateEndpointSubnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'pe-${azureMLWorkspaceName}-connection'
        properties: {
          privateLinkServiceId: azureMLWorkspace.id
          groupIds: [
            'amlworkspace'
          ]
        }
      }
    ]
  }
}

// Azure ML - Compute Cluster (CPU)
resource cpuComputeCluster 'Microsoft.MachineLearningServices/workspaces/computes@2023-06-01-preview' = {
  parent: azureMLWorkspace
  name: 'cpu-cluster'
  location: location
  tags: tags
  properties: {
    computeType: 'AmlCompute'
    properties: {
      vmSize: 'Standard_DS3_v2'
      vmPriority: 'Dedicated'
      scaleSettings: {
        minNodeCount: 0
        maxNodeCount: environment == 'prod' ? 10 : 4
        nodeIdleTimeBeforeScaleDown: 'PT120S'
      }
      subnet: enableCompliance ? {
        id: aiServicesSubnetId
      } : null
      remoteLoginPortPublicAccess: 'Disabled'
    }
  }
}

// Azure ML - Compute Cluster (GPU)
resource gpuComputeCluster 'Microsoft.MachineLearningServices/workspaces/computes@2023-06-01-preview' = if (environment == 'prod' || environment == 'uat') {
  parent: azureMLWorkspace
  name: 'gpu-cluster'
  location: location
  tags: tags
  properties: {
    computeType: 'AmlCompute'
    properties: {
      vmSize: 'Standard_NC6s_v3'
      vmPriority: 'LowPriority'
      scaleSettings: {
        minNodeCount: 0
        maxNodeCount: environment == 'prod' ? 4 : 2
        nodeIdleTimeBeforeScaleDown: 'PT300S'
      }
      subnet: enableCompliance ? {
        id: aiServicesSubnetId
      } : null
      remoteLoginPortPublicAccess: 'Disabled'
    }
  }
}

// ============================================================================
// AZURE OPENAI
// ============================================================================

resource openAIAccount 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: openAIAccountName
  location: location
  tags: tags
  kind: 'OpenAI'
  sku: {
    name: 'S0'
  }
  properties: {
    customSubDomainName: openAIAccountName
    publicNetworkAccess: enableCompliance ? 'Disabled' : 'Enabled'
    networkAcls: {
      defaultAction: enableCompliance ? 'Deny' : 'Allow'
      virtualNetworkRules: [
        {
          id: aiServicesSubnetId
          ignoreMissingVnetServiceEndpoint: false
        }
      ]
    }
    disableLocalAuth: enableCompliance
  }
}

// Azure OpenAI - Deployments
resource gpt4Deployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  parent: openAIAccount
  name: 'gpt-4'
  sku: {
    name: 'Standard'
    capacity: environment == 'prod' ? 30 : 10
  }
  properties: {
    model: {
      format: 'OpenAI'
      name: 'gpt-4'
      version: '0613'
    }
    raiPolicyName: 'Microsoft.Default'
  }
}

resource gpt35TurboDeployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  parent: openAIAccount
  name: 'gpt-35-turbo'
  sku: {
    name: 'Standard'
    capacity: environment == 'prod' ? 50 : 20
  }
  properties: {
    model: {
      format: 'OpenAI'
      name: 'gpt-35-turbo'
      version: '0613'
    }
    raiPolicyName: 'Microsoft.Default'
  }
  dependsOn: [
    gpt4Deployment
  ]
}

resource embeddingsDeployment 'Microsoft.CognitiveServices/accounts/deployments@2023-05-01' = {
  parent: openAIAccount
  name: 'text-embedding-ada-002'
  sku: {
    name: 'Standard'
    capacity: environment == 'prod' ? 100 : 30
  }
  properties: {
    model: {
      format: 'OpenAI'
      name: 'text-embedding-ada-002'
      version: '2'
    }
    raiPolicyName: 'Microsoft.Default'
  }
  dependsOn: [
    gpt35TurboDeployment
  ]
}

// Azure OpenAI - Private Endpoint
resource openAIPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = if (enableCompliance) {
  name: 'pe-${openAIAccountName}'
  location: location
  tags: tags
  properties: {
    subnet: {
      id: privateEndpointSubnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'pe-${openAIAccountName}-connection'
        properties: {
          privateLinkServiceId: openAIAccount.id
          groupIds: [
            'account'
          ]
        }
      }
    ]
  }
}

// ============================================================================
// COGNITIVE SERVICES (Multi-service)
// ============================================================================

resource cognitiveServices 'Microsoft.CognitiveServices/accounts@2023-05-01' = {
  name: cognitiveServicesName
  location: location
  tags: tags
  kind: 'CognitiveServices'
  sku: {
    name: 'S0'
  }
  properties: {
    customSubDomainName: cognitiveServicesName
    publicNetworkAccess: enableCompliance ? 'Disabled' : 'Enabled'
    networkAcls: {
      defaultAction: enableCompliance ? 'Deny' : 'Allow'
      virtualNetworkRules: [
        {
          id: aiServicesSubnetId
          ignoreMissingVnetServiceEndpoint: false
        }
      ]
    }
    disableLocalAuth: enableCompliance
  }
}

// Cognitive Services - Private Endpoint
resource cognitiveServicesPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = if (enableCompliance) {
  name: 'pe-${cognitiveServicesName}'
  location: location
  tags: tags
  properties: {
    subnet: {
      id: privateEndpointSubnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'pe-${cognitiveServicesName}-connection'
        properties: {
          privateLinkServiceId: cognitiveServices.id
          groupIds: [
            'account'
          ]
        }
      }
    ]
  }
}

// ============================================================================
// DIAGNOSTIC SETTINGS
// ============================================================================

resource acrDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: containerRegistry
  name: 'diag-${containerRegistryName}'
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs: [
      {
        category: 'ContainerRegistryRepositoryEvents'
        enabled: true
      }
      {
        category: 'ContainerRegistryLoginEvents'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}

resource amlDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: azureMLWorkspace
  name: 'diag-${azureMLWorkspaceName}'
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs: [
      {
        category: 'AmlComputeClusterEvent'
        enabled: true
      }
      {
        category: 'AmlComputeClusterNodeEvent'
        enabled: true
      }
      {
        category: 'AmlComputeJobEvent'
        enabled: true
      }
      {
        category: 'AmlComputeCpuGpuUtilization'
        enabled: true
      }
      {
        category: 'AmlRunStatusChangedEvent'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}

resource openAIDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: openAIAccount
  name: 'diag-${openAIAccountName}'
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs: [
      {
        category: 'Audit'
        enabled: true
      }
      {
        category: 'RequestResponse'
        enabled: true
      }
      {
        category: 'Trace'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'AllMetrics'
        enabled: true
      }
    ]
  }
}

// ============================================================================
// OUTPUTS
// ============================================================================

output containerRegistryId string = containerRegistry.id
output containerRegistryName string = containerRegistry.name
output containerRegistryLoginServer string = containerRegistry.properties.loginServer
output azureMLWorkspaceId string = azureMLWorkspace.id
output azureMLWorkspaceName string = azureMLWorkspace.name
output openAIAccountId string = openAIAccount.id
output openAIAccountName string = openAIAccount.name
output openAIEndpoint string = openAIAccount.properties.endpoint
output cognitiveServicesId string = cognitiveServices.id
output cognitiveServicesName string = cognitiveServices.name
output cognitiveServicesEndpoint string = cognitiveServices.properties.endpoint
