// Data Module
// Deploys Storage Account, Azure SQL, Cosmos DB, Data Lake, Synapse
// Compliance: Encryption at rest, data residency, backup

targetScope = 'resourceGroup'

// ============================================================================
// PARAMETERS
// ============================================================================

@description('Primary Azure region')
param location string

@description('Secondary region for DR')
param secondaryLocation string

@description('Environment')
param environment string

@description('Project name')
param projectName string

@description('VNet ID')
param vnetId string

@description('Data Subnet ID')
param dataSubnetId string

@description('Private Endpoint Subnet ID')
param privateEndpointSubnetId string

@description('Key Vault name')
param keyVaultName string

@description('Enable geo-redundancy')
param enableGeoRedundancy bool

@description('Enable compliance features')
param enableCompliance bool

@description('Log Analytics Workspace ID')
param logAnalyticsWorkspaceId string

@description('Resource tags')
param tags object

// ============================================================================
// VARIABLES
// ============================================================================

var storageAccountName = 'st${projectName}${environment}${uniqueString(resourceGroup().id)}'
var dataLakeName = 'dl${projectName}${environment}${uniqueString(resourceGroup().id)}'
var sqlServerName = 'sql-${projectName}-${environment}-${uniqueString(resourceGroup().id)}'
var sqlDatabaseName = 'sqldb-${projectName}-${environment}'
var cosmosDbAccountName = 'cosmos-${projectName}-${environment}-${uniqueString(resourceGroup().id)}'
var synapseWorkspaceName = 'syn-${projectName}-${environment}-${uniqueString(resourceGroup().id)}'

// ============================================================================
// STORAGE ACCOUNT (General Purpose)
// ============================================================================

resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  tags: tags
  sku: {
    name: enableGeoRedundancy ? 'Standard_GRS' : 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_3'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
    publicNetworkAccess: enableCompliance ? 'Disabled' : 'Enabled'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: enableCompliance ? 'Deny' : 'Allow'
      virtualNetworkRules: [
        {
          id: dataSubnetId
          action: 'Allow'
        }
      ]
    }
    encryption: {
      services: {
        blob: {
          enabled: true
          keyType: 'Account'
        }
        file: {
          enabled: true
          keyType: 'Account'
        }
        table: {
          enabled: true
          keyType: 'Account'
        }
        queue: {
          enabled: true
          keyType: 'Account'
        }
      }
      keySource: 'Microsoft.Storage'
      requireInfrastructureEncryption: environment == 'prod'
    }
  }
}

// Storage Account - Blob Service
resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2023-01-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    deleteRetentionPolicy: {
      enabled: true
      days: environment == 'prod' ? 30 : 7
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: environment == 'prod' ? 30 : 7
    }
    changeFeed: {
      enabled: enableCompliance
      retentionInDays: 90
    }
    isVersioningEnabled: enableCompliance
  }
}

// Storage Account - Containers
resource modelContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: 'models'
  properties: {
    publicAccess: 'None'
  }
}

resource dataContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: 'data'
  properties: {
    publicAccess: 'None'
  }
}

resource artifactsContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  parent: blobService
  name: 'artifacts'
  properties: {
    publicAccess: 'None'
  }
}

// Private Endpoint for Storage Account
resource storagePrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = if (enableCompliance) {
  name: 'pe-${storageAccountName}-blob'
  location: location
  tags: tags
  properties: {
    subnet: {
      id: privateEndpointSubnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'pe-${storageAccountName}-blob-connection'
        properties: {
          privateLinkServiceId: storageAccount.id
          groupIds: [
            'blob'
          ]
        }
      }
    ]
  }
}

// ============================================================================
// DATA LAKE STORAGE GEN2
// ============================================================================

resource dataLake 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: dataLakeName
  location: location
  tags: tags
  sku: {
    name: enableGeoRedundancy ? 'Standard_RAGRS' : 'Standard_LRS'
  }
  kind: 'StorageV2'
  properties: {
    accessTier: 'Hot'
    minimumTlsVersion: 'TLS1_3'
    supportsHttpsTrafficOnly: true
    allowBlobPublicAccess: false
    isHnsEnabled: true // Hierarchical namespace for Data Lake
    publicNetworkAccess: enableCompliance ? 'Disabled' : 'Enabled'
    networkAcls: {
      bypass: 'AzureServices'
      defaultAction: enableCompliance ? 'Deny' : 'Allow'
      virtualNetworkRules: [
        {
          id: dataSubnetId
          action: 'Allow'
        }
      ]
    }
    encryption: {
      services: {
        blob: {
          enabled: true
          keyType: 'Account'
        }
        file: {
          enabled: true
          keyType: 'Account'
        }
      }
      keySource: 'Microsoft.Storage'
      requireInfrastructureEncryption: environment == 'prod'
    }
  }
}

// Data Lake - File System
resource dataLakeFileSystem 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  name: '${dataLake.name}/default/raw'
  properties: {
    publicAccess: 'None'
  }
}

resource dataLakeProcessedFileSystem 'Microsoft.Storage/storageAccounts/blobServices/containers@2023-01-01' = {
  name: '${dataLake.name}/default/processed'
  properties: {
    publicAccess: 'None'
  }
}

// ============================================================================
// AZURE SQL DATABASE
// ============================================================================

resource sqlServer 'Microsoft.Sql/servers@2022-05-01-preview' = {
  name: sqlServerName
  location: location
  tags: tags
  properties: {
    administratorLogin: 'sqladmin'
    administratorLoginPassword: 'P@ssw0rd123!' // Should be retrieved from Key Vault in production
    version: '12.0'
    minimalTlsVersion: '1.3'
    publicNetworkAccess: enableCompliance ? 'Disabled' : 'Enabled'
  }
}

// SQL Database
resource sqlDatabase 'Microsoft.Sql/servers/databases@2022-05-01-preview' = {
  parent: sqlServer
  name: sqlDatabaseName
  location: location
  tags: tags
  sku: {
    name: environment == 'prod' ? 'S3' : 'S1'
    tier: 'Standard'
  }
  properties: {
    collation: 'SQL_Latin1_General_CP1_CI_AS'
    maxSizeBytes: environment == 'prod' ? 268435456000 : 10737418240 // 250GB or 10GB
    zoneRedundant: environment == 'prod'
    requestedBackupStorageRedundancy: enableGeoRedundancy ? 'Geo' : 'Local'
  }
}

// SQL Server - Transparent Data Encryption
resource sqlTDE 'Microsoft.Sql/servers/databases/transparentDataEncryption@2022-05-01-preview' = {
  parent: sqlDatabase
  name: 'current'
  properties: {
    state: 'Enabled'
  }
}

// SQL Server - Auditing
resource sqlAuditing 'Microsoft.Sql/servers/auditingSettings@2022-05-01-preview' = {
  parent: sqlServer
  name: 'default'
  properties: {
    state: 'Enabled'
    storageEndpoint: storageAccount.properties.primaryEndpoints.blob
    storageAccountAccessKey: storageAccount.listKeys().keys[0].value
    retentionDays: environment == 'prod' ? 90 : 30
    auditActionsAndGroups: [
      'SUCCESSFUL_DATABASE_AUTHENTICATION_GROUP'
      'FAILED_DATABASE_AUTHENTICATION_GROUP'
      'BATCH_COMPLETED_GROUP'
    ]
    isStorageSecondaryKeyInUse: false
    isAzureMonitorTargetEnabled: true
  }
}

// SQL Server - Advanced Data Security
resource sqlSecurityAlert 'Microsoft.Sql/servers/securityAlertPolicies@2022-05-01-preview' = {
  parent: sqlServer
  name: 'default'
  properties: {
    state: 'Enabled'
    emailAccountAdmins: true
  }
}

// Private Endpoint for SQL Server
resource sqlPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = if (enableCompliance) {
  name: 'pe-${sqlServerName}'
  location: location
  tags: tags
  properties: {
    subnet: {
      id: privateEndpointSubnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'pe-${sqlServerName}-connection'
        properties: {
          privateLinkServiceId: sqlServer.id
          groupIds: [
            'sqlServer'
          ]
        }
      }
    ]
  }
}

// ============================================================================
// COSMOS DB
// ============================================================================

resource cosmosDbAccount 'Microsoft.DocumentDB/databaseAccounts@2023-04-15' = {
  name: cosmosDbAccountName
  location: location
  tags: tags
  kind: 'GlobalDocumentDB'
  properties: {
    databaseAccountOfferType: 'Standard'
    consistencyPolicy: {
      defaultConsistencyLevel: 'Session'
    }
    locations: [
      {
        locationName: location
        failoverPriority: 0
        isZoneRedundant: environment == 'prod'
      }
      {
        locationName: secondaryLocation
        failoverPriority: 1
        isZoneRedundant: false
      }
    ]
    enableMultipleWriteLocations: enableGeoRedundancy && environment == 'prod'
    publicNetworkAccess: enableCompliance ? 'Disabled' : 'Enabled'
    networkAclBypass: 'AzureServices'
    disableKeyBasedMetadataWriteAccess: true
    enableFreeTier: environment == 'dev'
    enableAnalyticalStorage: true
    analyticalStorageConfiguration: {
      schemaType: 'WellDefined'
    }
    backupPolicy: {
      type: environment == 'prod' ? 'Continuous' : 'Periodic'
      periodicModeProperties: environment == 'prod' ? null : {
        backupIntervalInMinutes: 240
        backupRetentionIntervalInHours: 720 // 30 days
        backupStorageRedundancy: enableGeoRedundancy ? 'Geo' : 'Local'
      }
    }
  }
}

// Cosmos DB - SQL Database
resource cosmosDatabase 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases@2023-04-15' = {
  parent: cosmosDbAccount
  name: 'aiprojects'
  properties: {
    resource: {
      id: 'aiprojects'
    }
    options: {
      throughput: environment == 'prod' ? 1000 : 400
    }
  }
}

// Cosmos DB - Container
resource cosmosContainer 'Microsoft.DocumentDB/databaseAccounts/sqlDatabases/containers@2023-04-15' = {
  parent: cosmosDatabase
  name: 'metadata'
  properties: {
    resource: {
      id: 'metadata'
      partitionKey: {
        paths: [
          '/projectId'
        ]
        kind: 'Hash'
      }
      indexingPolicy: {
        indexingMode: 'consistent'
        automatic: true
        includedPaths: [
          {
            path: '/*'
          }
        ]
        excludedPaths: [
          {
            path: '/"_etag"/?'
          }
        ]
      }
    }
  }
}

// Private Endpoint for Cosmos DB
resource cosmosPrivateEndpoint 'Microsoft.Network/privateEndpoints@2023-05-01' = if (enableCompliance) {
  name: 'pe-${cosmosDbAccountName}'
  location: location
  tags: tags
  properties: {
    subnet: {
      id: privateEndpointSubnetId
    }
    privateLinkServiceConnections: [
      {
        name: 'pe-${cosmosDbAccountName}-connection'
        properties: {
          privateLinkServiceId: cosmosDbAccount.id
          groupIds: [
            'Sql'
          ]
        }
      }
    ]
  }
}

// ============================================================================
// SYNAPSE ANALYTICS (Prod only)
// ============================================================================

resource synapseWorkspace 'Microsoft.Synapse/workspaces@2021-06-01' = if (environment == 'prod') {
  name: synapseWorkspaceName
  location: location
  tags: tags
  identity: {
    type: 'SystemAssigned'
  }
  properties: {
    defaultDataLakeStorage: {
      accountUrl: dataLake.properties.primaryEndpoints.dfs
      filesystem: 'raw'
    }
    managedResourceGroupName: 'rg-${projectName}-${environment}-synapse-managed'
    sqlAdministratorLogin: 'sqladmin'
    sqlAdministratorLoginPassword: 'P@ssw0rd123!' // Should be retrieved from Key Vault in production
    publicNetworkAccess: enableCompliance ? 'Disabled' : 'Enabled'
    managedVirtualNetwork: enableCompliance ? 'default' : ''
  }
}

// ============================================================================
// DIAGNOSTIC SETTINGS
// ============================================================================

resource storageDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: storageAccount
  name: 'diag-${storageAccountName}'
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    metrics: [
      {
        category: 'Transaction'
        enabled: true
        retentionPolicy: {
          enabled: true
          days: environment == 'prod' ? 90 : 30
        }
      }
    ]
  }
}

resource sqlDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: sqlDatabase
  name: 'diag-${sqlDatabaseName}'
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs: [
      {
        category: 'SQLInsights'
        enabled: true
      }
      {
        category: 'AutomaticTuning'
        enabled: true
      }
      {
        category: 'QueryStoreRuntimeStatistics'
        enabled: true
      }
      {
        category: 'QueryStoreWaitStatistics'
        enabled: true
      }
      {
        category: 'Errors'
        enabled: true
      }
      {
        category: 'DatabaseWaitStatistics'
        enabled: true
      }
      {
        category: 'Timeouts'
        enabled: true
      }
      {
        category: 'Blocks'
        enabled: true
      }
      {
        category: 'Deadlocks'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'Basic'
        enabled: true
      }
      {
        category: 'InstanceAndAppAdvanced'
        enabled: true
      }
    ]
  }
}

resource cosmosDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: cosmosDbAccount
  name: 'diag-${cosmosDbAccountName}'
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs: [
      {
        category: 'DataPlaneRequests'
        enabled: true
      }
      {
        category: 'QueryRuntimeStatistics'
        enabled: true
      }
      {
        category: 'PartitionKeyStatistics'
        enabled: true
      }
      {
        category: 'PartitionKeyRUConsumption'
        enabled: true
      }
      {
        category: 'ControlPlaneRequests'
        enabled: true
      }
    ]
    metrics: [
      {
        category: 'Requests'
        enabled: true
      }
    ]
  }
}

// ============================================================================
// OUTPUTS
// ============================================================================

output storageAccountId string = storageAccount.id
output storageAccountName string = storageAccount.name
output dataLakeId string = dataLake.id
output dataLakeName string = dataLake.name
output sqlServerId string = sqlServer.id
output sqlServerName string = sqlServer.name
output sqlDatabaseId string = sqlDatabase.id
output sqlDatabaseName string = sqlDatabase.name
output cosmosDbAccountId string = cosmosDbAccount.id
output cosmosDbAccountName string = cosmosDbAccount.name
output synapseWorkspaceId string = environment == 'prod' ? synapseWorkspace.id : ''
output synapseWorkspaceName string = environment == 'prod' ? synapseWorkspace.name : ''
