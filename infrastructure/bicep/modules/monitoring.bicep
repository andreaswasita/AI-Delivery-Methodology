// Monitoring Module
// Deploys Log Analytics, Application Insights, Azure Monitor, Sentinel
// Compliance: Audit logging, security monitoring, alerting

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

@description('Enable Microsoft Sentinel')
param enableSentinel bool

@description('Log retention days')
param logRetentionDays int

@description('Resource tags')
param tags object

// ============================================================================
// VARIABLES
// ============================================================================

var logAnalyticsName = 'log-${projectName}-${environment}'
var applicationInsightsName = 'appi-${projectName}-${environment}'
var actionGroupName = 'ag-${projectName}-${environment}'

// ============================================================================
// LOG ANALYTICS WORKSPACE
// ============================================================================

resource logAnalytics 'Microsoft.OperationalInsights/workspaces@2022-10-01' = {
  name: logAnalyticsName
  location: location
  tags: tags
  properties: {
    sku: {
      name: 'PerGB2018'
    }
    retentionInDays: logRetentionDays
    features: {
      enableLogAccessUsingOnlyResourcePermissions: true
    }
    workspaceCapping: {
      dailyQuotaGb: environment == 'prod' ? 50 : (environment == 'test' ? 10 : 5)
    }
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

// ============================================================================
// LOG ANALYTICS SOLUTIONS
// ============================================================================

// Security and Audit Solution
resource securitySolution 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = {
  name: 'SecurityInsights(${logAnalytics.name})'
  location: location
  tags: tags
  plan: {
    name: 'SecurityInsights(${logAnalytics.name})'
    publisher: 'Microsoft'
    product: 'OMSGallery/SecurityInsights'
    promotionCode: ''
  }
  properties: {
    workspaceResourceId: logAnalytics.id
  }
}

// Azure Activity Solution
resource activitySolution 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = {
  name: 'AzureActivity(${logAnalytics.name})'
  location: location
  tags: tags
  plan: {
    name: 'AzureActivity(${logAnalytics.name})'
    publisher: 'Microsoft'
    product: 'OMSGallery/AzureActivity'
    promotionCode: ''
  }
  properties: {
    workspaceResourceId: logAnalytics.id
  }
}

// Container Insights Solution
resource containerInsightsSolution 'Microsoft.OperationsManagement/solutions@2015-11-01-preview' = {
  name: 'ContainerInsights(${logAnalytics.name})'
  location: location
  tags: tags
  plan: {
    name: 'ContainerInsights(${logAnalytics.name})'
    publisher: 'Microsoft'
    product: 'OMSGallery/ContainerInsights'
    promotionCode: ''
  }
  properties: {
    workspaceResourceId: logAnalytics.id
  }
}

// ============================================================================
// MICROSOFT SENTINEL
// ============================================================================

resource sentinel 'Microsoft.SecurityInsights/onboardingStates@2023-02-01' = if (enableSentinel) {
  scope: logAnalytics
  name: 'default'
  properties: {
  }
}

// Sentinel Data Connectors
resource azureActivityConnector 'Microsoft.SecurityInsights/dataConnectors@2023-02-01' = if (enableSentinel) {
  scope: logAnalytics
  name: guid(logAnalytics.id, 'azureactivity')
  kind: 'AzureActivity'
  properties: {
    subscriptionId: subscription().subscriptionId
    dataTypes: {
      logs: {
        state: 'Enabled'
      }
    }
  }
  dependsOn: [
    sentinel
  ]
}

// ============================================================================
// APPLICATION INSIGHTS
// ============================================================================

resource applicationInsights 'Microsoft.Insights/components@2020-02-02' = {
  name: applicationInsightsName
  location: location
  tags: tags
  kind: 'web'
  properties: {
    Application_Type: 'web'
    WorkspaceResourceId: logAnalytics.id
    RetentionInDays: logRetentionDays
    publicNetworkAccessForIngestion: 'Enabled'
    publicNetworkAccessForQuery: 'Enabled'
  }
}

// ============================================================================
// ACTION GROUP
// ============================================================================

resource actionGroup 'Microsoft.Insights/actionGroups@2023-01-01' = {
  name: actionGroupName
  location: 'global'
  tags: tags
  properties: {
    groupShortName: substring(projectName, 0, 12)
    enabled: true
    emailReceivers: []
    smsReceivers: []
    webhookReceivers: []
    azureAppPushReceivers: []
    automationRunbookReceivers: []
    voiceReceivers: []
    logicAppReceivers: []
    azureFunctionReceivers: []
    armRoleReceivers: [
      {
        name: 'MonitoringContributor'
        roleId: '749f88d5-cbae-40b8-bcfc-e573ddc772fa' // Monitoring Contributor
        useCommonAlertSchema: true
      }
    ]
  }
}

// ============================================================================
// METRIC ALERTS
// ============================================================================

// High CPU Alert
resource highCpuAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'alert-high-cpu-${environment}'
  location: 'global'
  tags: tags
  properties: {
    description: 'Alert when CPU usage exceeds 80%'
    severity: 2
    enabled: true
    scopes: [
      resourceGroup().id
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'HighCPU'
          metricName: 'Percentage CPU'
          dimensions: []
          operator: 'GreaterThan'
          threshold: 80
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
    autoMitigate: true
    actions: [
      {
        actionGroupId: actionGroup.id
      }
    ]
  }
}

// High Memory Alert
resource highMemoryAlert 'Microsoft.Insights/metricAlerts@2018-03-01' = {
  name: 'alert-high-memory-${environment}'
  location: 'global'
  tags: tags
  properties: {
    description: 'Alert when memory usage exceeds 80%'
    severity: 2
    enabled: true
    scopes: [
      resourceGroup().id
    ]
    evaluationFrequency: 'PT5M'
    windowSize: 'PT15M'
    criteria: {
      'odata.type': 'Microsoft.Azure.Monitor.MultipleResourceMultipleMetricCriteria'
      allOf: [
        {
          name: 'HighMemory'
          metricName: 'Available Memory Bytes'
          dimensions: []
          operator: 'LessThan'
          threshold: 1073741824 // 1 GB
          timeAggregation: 'Average'
          criterionType: 'StaticThresholdCriterion'
        }
      ]
    }
    autoMitigate: true
    actions: [
      {
        actionGroupId: actionGroup.id
      }
    ]
  }
}

// ============================================================================
// WORKBOOKS
// ============================================================================

// Security Workbook
resource securityWorkbook 'Microsoft.Insights/workbooks@2022-04-01' = {
  name: guid(resourceGroup().id, 'security-workbook')
  location: location
  tags: tags
  kind: 'shared'
  properties: {
    displayName: 'Security Dashboard - ${environment}'
    serializedData: '''
    {
      "version": "Notebook/1.0",
      "items": [
        {
          "type": 1,
          "content": {
            "json": "# Security Dashboard\\n\\nMonitor security events, threats, and compliance status."
          }
        }
      ]
    }
    '''
    category: 'security'
    sourceId: logAnalytics.id
  }
}

// ============================================================================
// OUTPUTS
// ============================================================================

output logAnalyticsWorkspaceId string = logAnalytics.id
output logAnalyticsWorkspaceName string = logAnalytics.name
output logAnalyticsCustomerId string = logAnalytics.properties.customerId
output applicationInsightsId string = applicationInsights.id
output applicationInsightsName string = applicationInsights.name
output applicationInsightsInstrumentationKey string = applicationInsights.properties.InstrumentationKey
output applicationInsightsConnectionString string = applicationInsights.properties.ConnectionString
output actionGroupId string = actionGroup.id
