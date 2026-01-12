// Networking Module
// Deploys VNet, Subnets, NSGs, Azure Firewall, Private Endpoints
// Compliance: Network isolation, secure connectivity

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

@description('Enable compliance features')
param enableCompliance bool

@description('Resource tags')
param tags object

// ============================================================================
// VARIABLES
// ============================================================================

var vnetName = 'vnet-${projectName}-${environment}'
var vnetAddressPrefix = '10.0.0.0/16'

// Subnets
var managementSubnetName = 'snet-management'
var managementSubnetPrefix = '10.0.1.0/24'

var aiServicesSubnetName = 'snet-ai-services'
var aiServicesSubnetPrefix = '10.0.2.0/24'

var dataSubnetName = 'snet-data'
var dataSubnetPrefix = '10.0.3.0/24'

var computeSubnetName = 'snet-compute'
var computeSubnetPrefix = '10.0.4.0/23' // Larger for AKS

var privateEndpointSubnetName = 'snet-private-endpoints'
var privateEndpointSubnetPrefix = '10.0.6.0/24'

var firewallSubnetName = 'AzureFirewallSubnet'
var firewallSubnetPrefix = '10.0.7.0/26'

var bastionSubnetName = 'AzureBastionSubnet'
var bastionSubnetPrefix = '10.0.7.64/26'

// NSG Names
var managementNsgName = 'nsg-management-${environment}'
var aiServicesNsgName = 'nsg-ai-services-${environment}'
var dataNsgName = 'nsg-data-${environment}'
var computeNsgName = 'nsg-compute-${environment}'
var privateEndpointNsgName = 'nsg-private-endpoints-${environment}'

// ============================================================================
// NETWORK SECURITY GROUPS
// ============================================================================

// Management NSG
resource managementNsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: managementNsgName
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'AllowBastionInbound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '22-3389'
          sourceAddressPrefix: bastionSubnetPrefix
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
      {
        name: 'DenyAllInbound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Deny'
          priority: 4096
          direction: 'Inbound'
        }
      }
    ]
  }
}

// AI Services NSG
resource aiServicesNsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: aiServicesNsgName
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'AllowHttpsFromCompute'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '443'
          sourceAddressPrefix: computeSubnetPrefix
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
      {
        name: 'DenyAllInbound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Deny'
          priority: 4096
          direction: 'Inbound'
        }
      }
    ]
  }
}

// Data NSG
resource dataNsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: dataNsgName
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'AllowSqlFromAIServices'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '1433'
          sourceAddressPrefix: aiServicesSubnetPrefix
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
      {
        name: 'AllowSqlFromCompute'
        properties: {
          protocol: 'Tcp'
          sourcePortRange: '*'
          destinationPortRange: '1433'
          sourceAddressPrefix: computeSubnetPrefix
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
        }
      }
      {
        name: 'DenyAllInbound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Deny'
          priority: 4096
          direction: 'Inbound'
        }
      }
    ]
  }
}

// Compute NSG
resource computeNsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: computeNsgName
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'AllowLoadBalancerInbound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: 'AzureLoadBalancer'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
      {
        name: 'AllowVnetInbound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: 'VirtualNetwork'
          access: 'Allow'
          priority: 110
          direction: 'Inbound'
        }
      }
      {
        name: 'DenyAllInbound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: '*'
          destinationAddressPrefix: '*'
          access: 'Deny'
          priority: 4096
          direction: 'Inbound'
        }
      }
    ]
  }
}

// Private Endpoint NSG
resource privateEndpointNsg 'Microsoft.Network/networkSecurityGroups@2023-05-01' = {
  name: privateEndpointNsgName
  location: location
  tags: tags
  properties: {
    securityRules: [
      {
        name: 'AllowVnetInbound'
        properties: {
          protocol: '*'
          sourcePortRange: '*'
          destinationPortRange: '*'
          sourceAddressPrefix: 'VirtualNetwork'
          destinationAddressPrefix: '*'
          access: 'Allow'
          priority: 100
          direction: 'Inbound'
        }
      }
    ]
  }
}

// ============================================================================
// VIRTUAL NETWORK
// ============================================================================

resource vnet 'Microsoft.Network/virtualNetworks@2023-05-01' = {
  name: vnetName
  location: location
  tags: tags
  properties: {
    addressSpace: {
      addressPrefixes: [
        vnetAddressPrefix
      ]
    }
    enableDdosProtection: environment == 'prod' ? true : false
    subnets: [
      {
        name: managementSubnetName
        properties: {
          addressPrefix: managementSubnetPrefix
          networkSecurityGroup: {
            id: managementNsg.id
          }
          serviceEndpoints: [
            {
              service: 'Microsoft.KeyVault'
            }
            {
              service: 'Microsoft.Storage'
            }
          ]
        }
      }
      {
        name: aiServicesSubnetName
        properties: {
          addressPrefix: aiServicesSubnetPrefix
          networkSecurityGroup: {
            id: aiServicesNsg.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          serviceEndpoints: [
            {
              service: 'Microsoft.CognitiveServices'
            }
            {
              service: 'Microsoft.Storage'
            }
          ]
        }
      }
      {
        name: dataSubnetName
        properties: {
          addressPrefix: dataSubnetPrefix
          networkSecurityGroup: {
            id: dataNsg.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
          serviceEndpoints: [
            {
              service: 'Microsoft.Sql'
            }
            {
              service: 'Microsoft.Storage'
            }
            {
              service: 'Microsoft.AzureCosmosDB'
            }
          ]
        }
      }
      {
        name: computeSubnetName
        properties: {
          addressPrefix: computeSubnetPrefix
          networkSecurityGroup: {
            id: computeNsg.id
          }
          serviceEndpoints: [
            {
              service: 'Microsoft.ContainerRegistry'
            }
            {
              service: 'Microsoft.Storage'
            }
          ]
        }
      }
      {
        name: privateEndpointSubnetName
        properties: {
          addressPrefix: privateEndpointSubnetPrefix
          networkSecurityGroup: {
            id: privateEndpointNsg.id
          }
          privateEndpointNetworkPolicies: 'Disabled'
          privateLinkServiceNetworkPolicies: 'Enabled'
        }
      }
      {
        name: firewallSubnetName
        properties: {
          addressPrefix: firewallSubnetPrefix
        }
      }
      {
        name: bastionSubnetName
        properties: {
          addressPrefix: bastionSubnetPrefix
        }
      }
    ]
  }
}

// ============================================================================
// AZURE FIREWALL (Production only)
// ============================================================================

resource firewallPublicIp 'Microsoft.Network/publicIPAddresses@2023-05-01' = if (environment == 'prod' && enableCompliance) {
  name: 'pip-firewall-${environment}'
  location: location
  tags: tags
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
  }
}

resource firewall 'Microsoft.Network/azureFirewalls@2023-05-01' = if (environment == 'prod' && enableCompliance) {
  name: 'afw-${projectName}-${environment}'
  location: location
  tags: tags
  properties: {
    sku: {
      name: 'AZFW_VNet'
      tier: 'Standard'
    }
    ipConfigurations: [
      {
        name: 'firewallConfig'
        properties: {
          publicIPAddress: {
            id: firewallPublicIp.id
          }
          subnet: {
            id: '${vnet.id}/subnets/${firewallSubnetName}'
          }
        }
      }
    ]
    threatIntelMode: 'Alert'
    networkRuleCollections: [
      {
        name: 'AllowAzureServices'
        properties: {
          priority: 100
          action: {
            type: 'Allow'
          }
          rules: [
            {
              name: 'AllowAzureML'
              protocols: [
                'TCP'
              ]
              sourceAddresses: [
                vnetAddressPrefix
              ]
              destinationAddresses: [
                'AzureMachineLearning'
              ]
              destinationPorts: [
                '443'
              ]
            }
            {
              name: 'AllowAzureOpenAI'
              protocols: [
                'TCP'
              ]
              sourceAddresses: [
                vnetAddressPrefix
              ]
              destinationFqdns: [
                '*.openai.azure.com'
              ]
              destinationPorts: [
                '443'
              ]
            }
          ]
        }
      }
    ]
    applicationRuleCollections: [
      {
        name: 'AllowAzureServices'
        properties: {
          priority: 100
          action: {
            type: 'Allow'
          }
          rules: [
            {
              name: 'AllowAzureMgmt'
              protocols: [
                {
                  protocolType: 'Https'
                  port: 443
                }
              ]
              sourceAddresses: [
                vnetAddressPrefix
              ]
              targetFqdns: [
                '*.azure.com'
                '*.microsoft.com'
                '*.windows.net'
              ]
            }
          ]
        }
      }
    ]
  }
}

// ============================================================================
// AZURE BASTION (Prod and UAT)
// ============================================================================

resource bastionPublicIp 'Microsoft.Network/publicIPAddresses@2023-05-01' = if (environment == 'prod' || environment == 'uat') {
  name: 'pip-bastion-${environment}'
  location: location
  tags: tags
  sku: {
    name: 'Standard'
  }
  properties: {
    publicIPAllocationMethod: 'Static'
    publicIPAddressVersion: 'IPv4'
  }
}

resource bastion 'Microsoft.Network/bastionHosts@2023-05-01' = if (environment == 'prod' || environment == 'uat') {
  name: 'bas-${projectName}-${environment}'
  location: location
  tags: tags
  sku: {
    name: 'Standard'
  }
  properties: {
    ipConfigurations: [
      {
        name: 'bastionConfig'
        properties: {
          publicIPAddress: {
            id: bastionPublicIp.id
          }
          subnet: {
            id: '${vnet.id}/subnets/${bastionSubnetName}'
          }
        }
      }
    ]
    enableFileCopy: true
    enableTunneling: true
  }
}

// ============================================================================
// OUTPUTS
// ============================================================================

output vnetId string = vnet.id
output vnetName string = vnet.name
output managementSubnetId string = '${vnet.id}/subnets/${managementSubnetName}'
output aiServicesSubnetId string = '${vnet.id}/subnets/${aiServicesSubnetName}'
output dataSubnetId string = '${vnet.id}/subnets/${dataSubnetName}'
output computeSubnetId string = '${vnet.id}/subnets/${computeSubnetName}'
output privateEndpointSubnetId string = '${vnet.id}/subnets/${privateEndpointSubnetName}'
output firewallPrivateIp string = enableCompliance && environment == 'prod' ? firewall.properties.ipConfigurations[0].properties.privateIPAddress : ''
