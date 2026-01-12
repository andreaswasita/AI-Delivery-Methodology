// Compute Module
// Deploys Azure Kubernetes Service (AKS), VM Scale Sets
// Compliance: Secure compute, monitoring, scaling

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

@description('Compute Subnet ID')
param computeSubnetId string

@description('Managed Identity ID')
param managedIdentityId string

@description('Log Analytics Workspace ID')
param logAnalyticsWorkspaceId string

@description('Enable compliance features')
param enableCompliance bool

@description('Resource tags')
param tags object

// ============================================================================
// VARIABLES
// ============================================================================

var aksClusterName = 'aks-${projectName}-${environment}'
var vmssName = 'vmss-${projectName}-${environment}'

// AKS node pool configurations by environment
var nodePoolConfig = {
  dev: {
    minCount: 1
    maxCount: 3
    vmSize: 'Standard_D4s_v3'
  }
  test: {
    minCount: 2
    maxCount: 5
    vmSize: 'Standard_D4s_v3'
  }
  uat: {
    minCount: 2
    maxCount: 8
    vmSize: 'Standard_D8s_v3'
  }
  prod: {
    minCount: 3
    maxCount: 10
    vmSize: 'Standard_D8s_v3'
  }
}

// ============================================================================
// AZURE KUBERNETES SERVICE (AKS)
// ============================================================================

resource aksCluster 'Microsoft.ContainerService/managedClusters@2023-07-01' = {
  name: aksClusterName
  location: location
  tags: tags
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedIdentityId}': {}
    }
  }
  sku: {
    name: 'Base'
    tier: environment == 'prod' ? 'Standard' : 'Free'
  }
  properties: {
    dnsPrefix: '${projectName}-${environment}'
    kubernetesVersion: '1.28.3'
    enableRBAC: true
    networkProfile: {
      networkPlugin: 'azure'
      networkPolicy: 'azure'
      serviceCidr: '10.1.0.0/16'
      dnsServiceIP: '10.1.0.10'
      outboundType: enableCompliance ? 'userDefinedRouting' : 'loadBalancer'
      loadBalancerSku: 'standard'
    }
    agentPoolProfiles: [
      {
        name: 'systempool'
        mode: 'System'
        count: nodePoolConfig[environment].minCount
        minCount: nodePoolConfig[environment].minCount
        maxCount: nodePoolConfig[environment].maxCount
        enableAutoScaling: true
        vmSize: nodePoolConfig[environment].vmSize
        osDiskSizeGB: 128
        osDiskType: 'Managed'
        osType: 'Linux'
        vnetSubnetID: computeSubnetId
        maxPods: 30
        type: 'VirtualMachineScaleSets'
        availabilityZones: environment == 'prod' ? [
          '1'
          '2'
          '3'
        ] : []
        enableNodePublicIP: false
        upgradeSettings: {
          maxSurge: '33%'
        }
      }
    ]
    addonProfiles: {
      azureKeyvaultSecretsProvider: {
        enabled: true
        config: {
          enableSecretRotation: 'true'
          rotationPollInterval: '2m'
        }
      }
      azurepolicy: {
        enabled: enableCompliance
      }
      omsagent: {
        enabled: true
        config: {
          logAnalyticsWorkspaceResourceID: logAnalyticsWorkspaceId
        }
      }
    }
    apiServerAccessProfile: {
      enablePrivateCluster: enableCompliance
      enablePrivateClusterPublicFQDN: false
    }
    aadProfile: {
      managed: true
      enableAzureRBAC: true
      adminGroupObjectIDs: [] // Add Azure AD group IDs for admin access
      tenantID: subscription().tenantId
    }
    autoUpgradeProfile: {
      upgradeChannel: environment == 'prod' ? 'stable' : 'patch'
    }
    disableLocalAccounts: enableCompliance
    securityProfile: {
      defender: {
        logAnalyticsWorkspaceResourceId: logAnalyticsWorkspaceId
        securityMonitoring: {
          enabled: true
        }
      }
    }
    oidcIssuerProfile: {
      enabled: true
    }
    workloadAutoScalerProfile: {
      keda: {
        enabled: true
      }
    }
  }
}

// AKS - User Node Pool (for workloads)
resource aksUserPool 'Microsoft.ContainerService/managedClusters/agentPools@2023-07-01' = {
  parent: aksCluster
  name: 'userpool'
  properties: {
    mode: 'User'
    count: nodePoolConfig[environment].minCount
    minCount: nodePoolConfig[environment].minCount
    maxCount: nodePoolConfig[environment].maxCount
    enableAutoScaling: true
    vmSize: nodePoolConfig[environment].vmSize
    osDiskSizeGB: 128
    osDiskType: 'Managed'
    osType: 'Linux'
    vnetSubnetID: computeSubnetId
    maxPods: 50
    type: 'VirtualMachineScaleSets'
    availabilityZones: environment == 'prod' ? [
      '1'
      '2'
      '3'
    ] : []
    enableNodePublicIP: false
    upgradeSettings: {
      maxSurge: '33%'
    }
    nodeTaints: []
    nodeLabels: {
      workloadType: 'general'
    }
  }
}

// AKS - GPU Node Pool (Prod and UAT only)
resource aksGpuPool 'Microsoft.ContainerService/managedClusters/agentPools@2023-07-01' = if (environment == 'prod' || environment == 'uat') {
  parent: aksCluster
  name: 'gpupool'
  properties: {
    mode: 'User'
    count: 0
    minCount: 0
    maxCount: environment == 'prod' ? 4 : 2
    enableAutoScaling: true
    vmSize: 'Standard_NC6s_v3'
    osDiskSizeGB: 128
    osDiskType: 'Managed'
    osType: 'Linux'
    vnetSubnetID: computeSubnetId
    maxPods: 20
    type: 'VirtualMachineScaleSets'
    availabilityZones: []
    enableNodePublicIP: false
    upgradeSettings: {
      maxSurge: '33%'
    }
    nodeTaints: [
      'sku=gpu:NoSchedule'
    ]
    nodeLabels: {
      workloadType: 'gpu'
      'kubernetes.azure.com/accelerator': 'nvidia'
    }
  }
}

// ============================================================================
// VIRTUAL MACHINE SCALE SET (for batch processing)
// ============================================================================

resource vmss 'Microsoft.Compute/virtualMachineScaleSets@2023-07-01' = if (environment == 'prod' || environment == 'uat') {
  name: vmssName
  location: location
  tags: tags
  sku: {
    name: 'Standard_D4s_v3'
    tier: 'Standard'
    capacity: 0 // Start with zero instances
  }
  properties: {
    overprovision: true
    upgradePolicy: {
      mode: 'Rolling'
      rollingUpgradePolicy: {
        maxBatchInstancePercent: 20
        maxUnhealthyInstancePercent: 20
        maxUnhealthyUpgradedInstancePercent: 5
        pauseTimeBetweenBatches: 'PT0S'
      }
    }
    automaticRepairsPolicy: {
      enabled: true
      gracePeriod: 'PT30M'
    }
    virtualMachineProfile: {
      osProfile: {
        computerNamePrefix: substring(vmssName, 0, 9)
        adminUsername: 'azureuser'
        linuxConfiguration: {
          disablePasswordAuthentication: true
          ssh: {
            publicKeys: [
              {
                path: '/home/azureuser/.ssh/authorized_keys'
                keyData: 'ssh-rsa PLACEHOLDER' // Replace with actual SSH public key
              }
            ]
          }
        }
      }
      storageProfile: {
        imageReference: {
          publisher: 'Canonical'
          offer: '0001-com-ubuntu-server-jammy'
          sku: '22_04-lts-gen2'
          version: 'latest'
        }
        osDisk: {
          createOption: 'FromImage'
          caching: 'ReadWrite'
          managedDisk: {
            storageAccountType: 'Premium_LRS'
          }
        }
      }
      networkProfile: {
        networkInterfaceConfigurations: [
          {
            name: '${vmssName}-nic'
            properties: {
              primary: true
              ipConfigurations: [
                {
                  name: 'ipconfig1'
                  properties: {
                    subnet: {
                      id: computeSubnetId
                    }
                    privateIPAddressVersion: 'IPv4'
                  }
                }
              ]
              enableAcceleratedNetworking: true
            }
          }
        ]
      }
      diagnosticsProfile: {
        bootDiagnostics: {
          enabled: true
        }
      }
      extensionProfile: {
        extensions: [
          {
            name: 'OMSExtension'
            properties: {
              publisher: 'Microsoft.EnterpriseCloud.Monitoring'
              type: 'OmsAgentForLinux'
              typeHandlerVersion: '1.17'
              autoUpgradeMinorVersion: true
              settings: {
                workspaceId: reference(logAnalyticsWorkspaceId, '2022-10-01').customerId
              }
              protectedSettings: {
                workspaceKey: listKeys(logAnalyticsWorkspaceId, '2022-10-01').primarySharedKey
              }
            }
          }
        ]
      }
    }
  }
  identity: {
    type: 'UserAssigned'
    userAssignedIdentities: {
      '${managedIdentityId}': {}
    }
  }
}

// VMSS - Auto-scale settings
resource vmssAutoscale 'Microsoft.Insights/autoscalesettings@2022-10-01' = if (environment == 'prod' || environment == 'uat') {
  name: '${vmssName}-autoscale'
  location: location
  tags: tags
  properties: {
    enabled: true
    targetResourceUri: vmss.id
    profiles: [
      {
        name: 'Auto-scale based on CPU'
        capacity: {
          minimum: '0'
          maximum: environment == 'prod' ? '10' : '5'
          default: '0'
        }
        rules: [
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: vmss.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'GreaterThan'
              threshold: 70
            }
            scaleAction: {
              direction: 'Increase'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT5M'
            }
          }
          {
            metricTrigger: {
              metricName: 'Percentage CPU'
              metricResourceUri: vmss.id
              timeGrain: 'PT1M'
              statistic: 'Average'
              timeWindow: 'PT5M'
              timeAggregation: 'Average'
              operator: 'LessThan'
              threshold: 30
            }
            scaleAction: {
              direction: 'Decrease'
              type: 'ChangeCount'
              value: '1'
              cooldown: 'PT5M'
            }
          }
        ]
      }
    ]
  }
}

// ============================================================================
// DIAGNOSTIC SETTINGS
// ============================================================================

resource aksDiagnostics 'Microsoft.Insights/diagnosticSettings@2021-05-01-preview' = {
  scope: aksCluster
  name: 'diag-${aksClusterName}'
  properties: {
    workspaceId: logAnalyticsWorkspaceId
    logs: [
      {
        category: 'kube-apiserver'
        enabled: true
      }
      {
        category: 'kube-audit'
        enabled: true
      }
      {
        category: 'kube-controller-manager'
        enabled: true
      }
      {
        category: 'kube-scheduler'
        enabled: true
      }
      {
        category: 'cluster-autoscaler'
        enabled: true
      }
      {
        category: 'guard'
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

output aksClusterId string = aksCluster.id
output aksClusterName string = aksCluster.name
output aksFqdn string = aksCluster.properties.fqdn
output aksIdentityPrincipalId string = aksCluster.identity.principalId
output vmssId string = (environment == 'prod' || environment == 'uat') ? vmss.id : ''
output vmssName string = (environment == 'prod' || environment == 'uat') ? vmss.name : ''
