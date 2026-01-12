// Azure Static Web Apps module for calculator website
// Simple, cost-effective hosting for static sites
// Version: 1.0
// Last Updated: January 13, 2026

@description('Static Web App name')
param staticWebAppName string

@description('Location for the Static Web App')
param location string = 'eastus2'

@description('SKU for Static Web App')
@allowed([
  'Free'
  'Standard'
])
param sku string = 'Free'

@description('Tags for the resource')
param tags object = {}

@description('GitHub repository URL (optional)')
param repositoryUrl string = ''

@description('GitHub branch name')
param repositoryBranch string = 'main'

@description('App location in repository')
param appLocation string = '/calculators'

// ============================================================================
// STATIC WEB APP
// ============================================================================

resource staticWebApp 'Microsoft.Web/staticSites@2023-01-01' = {
  name: staticWebAppName
  location: location
  tags: tags
  sku: {
    name: sku
    tier: sku
  }
  properties: {
    repositoryUrl: repositoryUrl
    branch: repositoryBranch
    buildProperties: {
      appLocation: appLocation
      skipGithubActionWorkflowGeneration: true
    }
    stagingEnvironmentPolicy: 'Enabled'
    allowConfigFileUpdates: true
    provider: 'GitHub'
  }
}

// ============================================================================
// CUSTOM DOMAIN (Optional)
// ============================================================================

// Uncomment and configure if you have a custom domain
// resource customDomain 'Microsoft.Web/staticSites/customDomains@2023-01-01' = {
//   parent: staticWebApp
//   name: 'www.yourdomain.com'
//   properties: {}
// }

// ============================================================================
// OUTPUTS
// ============================================================================

output staticWebAppId string = staticWebApp.id
output staticWebAppName string = staticWebApp.name
output defaultHostname string = staticWebApp.properties.defaultHostname
output deploymentToken string = staticWebApp.listSecrets().properties.apiKey
