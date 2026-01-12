// Governance Module
// Deploys Azure Policies, Cost Management, Budgets, Tags
// Compliance: Policy enforcement, cost controls, tagging standards

targetScope = 'resourceGroup'

// ============================================================================
// PARAMETERS
// ============================================================================

@description('Environment')
param environment string

@description('Project name')
param projectName string

@description('Resource Group ID')
param resourceGroupId string

@description('Enable compliance features')
param enableCompliance bool

@description('Monthly budget in USD')
param monthlyBudget int

@description('Resource tags')
param tags object

// ============================================================================
// VARIABLES
// ============================================================================

var budgetName = 'budget-${projectName}-${environment}'
var actionGroupName = 'ag-budget-${projectName}-${environment}'

// ============================================================================
// BUDGET
// ============================================================================

resource budget 'Microsoft.Consumption/budgets@2023-05-01' = {
  name: budgetName
  properties: {
    category: 'Cost'
    amount: monthlyBudget
    timeGrain: 'Monthly'
    timePeriod: {
      startDate: '2025-01-01'
      endDate: '2026-12-31'
    }
    filter: {
      dimensions: {
        name: 'ResourceGroupName'
        operator: 'In'
        values: [
          last(split(resourceGroupId, '/'))
        ]
      }
    }
    notifications: {
      'Actual_GreaterThan_50_Percent': {
        enabled: true
        operator: 'GreaterThan'
        threshold: 50
        contactEmails: [] // Add email addresses
        contactRoles: [
          'Owner'
          'Contributor'
        ]
        thresholdType: 'Actual'
      }
      'Actual_GreaterThan_75_Percent': {
        enabled: true
        operator: 'GreaterThan'
        threshold: 75
        contactEmails: []
        contactRoles: [
          'Owner'
          'Contributor'
        ]
        thresholdType: 'Actual'
      }
      'Actual_GreaterThan_90_Percent': {
        enabled: true
        operator: 'GreaterThan'
        threshold: 90
        contactEmails: []
        contactRoles: [
          'Owner'
          'Contributor'
        ]
        thresholdType: 'Actual'
      }
      'Forecasted_GreaterThan_100_Percent': {
        enabled: true
        operator: 'GreaterThan'
        threshold: 100
        contactEmails: []
        contactRoles: [
          'Owner'
          'Contributor'
        ]
        thresholdType: 'Forecasted'
      }
    }
  }
}

// ============================================================================
// AZURE POLICY ASSIGNMENTS (if compliance enabled)
// ============================================================================

// Policy: Require tag on resources
resource requireTagPolicy 'Microsoft.Authorization/policyAssignments@2022-06-01' = if (enableCompliance) {
  name: 'require-tags-${environment}'
  properties: {
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/96670d01-0a4d-4649-9c89-2d3abc0a5025'
    displayName: 'Require Environment tag on resources'
    description: 'Enforce Environment tag on all resources'
    enforcementMode: 'Default'
    parameters: {
      tagName: {
        value: 'Environment'
      }
    }
  }
}

// Policy: Allowed locations (data residency)
resource allowedLocationsPolicy 'Microsoft.Authorization/policyAssignments@2022-06-01' = if (enableCompliance) {
  name: 'allowed-locations-${environment}'
  properties: {
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/e56962a6-4747-49cd-b67b-bf8b01975c4c'
    displayName: 'Allowed locations for data residency'
    description: 'Restrict resource locations for compliance'
    enforcementMode: 'Default'
    parameters: {
      listOfAllowedLocations: {
        value: [
          'australiaeast'
          'australiasoutheast'
          'australiacentral'
        ]
      }
    }
  }
}

// Policy: Require encryption at rest
resource encryptionPolicy 'Microsoft.Authorization/policyAssignments@2022-06-01' = if (enableCompliance) {
  name: 'require-encryption-${environment}'
  properties: {
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/0961003e-5a0a-4549-abde-af6a37f2724d'
    displayName: 'Require encryption for storage accounts'
    description: 'Ensure all storage accounts use encryption'
    enforcementMode: 'Default'
  }
}

// Policy: Require secure transfer
resource secureTransferPolicy 'Microsoft.Authorization/policyAssignments@2022-06-01' = if (enableCompliance) {
  name: 'require-secure-transfer-${environment}'
  properties: {
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/404c3081-a854-4457-ae30-26a93ef643f9'
    displayName: 'Secure transfer to storage accounts should be enabled'
    description: 'Require HTTPS for storage accounts'
    enforcementMode: 'Default'
  }
}

// Policy: Require diagnostic logs
resource diagnosticLogsPolicy 'Microsoft.Authorization/policyAssignments@2022-06-01' = if (enableCompliance) {
  name: 'require-diagnostic-logs-${environment}'
  properties: {
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/7f89b1eb-583c-429a-8828-af049802c1d9'
    displayName: 'Diagnostic logs should be enabled'
    description: 'Ensure diagnostic logging is enabled for audit'
    enforcementMode: 'Default'
  }
}

// Policy: Require private endpoints
resource privateEndpointPolicy 'Microsoft.Authorization/policyAssignments@2022-06-01' = if (enableCompliance && environment == 'prod') {
  name: 'require-private-endpoints-${environment}'
  properties: {
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/7595c971-233d-4bcf-bd18-596129188c49'
    displayName: 'Private endpoint should be enabled for Key Vault'
    description: 'Enforce private endpoints for Key Vault'
    enforcementMode: 'Default'
  }
}

// Policy: Require managed identity
resource managedIdentityPolicy 'Microsoft.Authorization/policyAssignments@2022-06-01' = if (enableCompliance) {
  name: 'require-managed-identity-${environment}'
  properties: {
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/8b18e4c0-71cc-45d2-9c15-9e6b3c8e5f35'
    displayName: 'Virtual machines should use managed identity'
    description: 'Enforce managed identity for VMs'
    enforcementMode: 'Default'
  }
}

// Policy: Deny public network access
resource denyPublicNetworkPolicy 'Microsoft.Authorization/policyAssignments@2022-06-01' = if (enableCompliance && environment == 'prod') {
  name: 'deny-public-network-${environment}'
  properties: {
    policyDefinitionId: '/providers/Microsoft.Authorization/policyDefinitions/b52376f7-9612-48a1-81cd-1ffe4b61032c'
    displayName: 'Public network access should be disabled for Cognitive Services'
    description: 'Deny public access for AI services in production'
    enforcementMode: 'Default'
  }
}

// ============================================================================
// RESOURCE LOCKS (Production only)
// ============================================================================

resource resourceGroupLock 'Microsoft.Authorization/locks@2020-05-01' = if (environment == 'prod') {
  name: 'lock-${projectName}-${environment}'
  properties: {
    level: 'CanNotDelete'
    notes: 'Prevent accidental deletion of production resources'
  }
}

// ============================================================================
// OUTPUTS
// ============================================================================

output budgetId string = budget.id
output budgetName string = budget.name
output compliancePoliciesApplied int = enableCompliance ? 8 : 0
output resourceLockApplied bool = environment == 'prod'
