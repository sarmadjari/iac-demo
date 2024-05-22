targetScope = 'subscription'


// General parameters
param location string = deployment().location
param resourceGroupName string = 'myTestRG-US'

// VNet parameters
param vnetName string = 'myVnet'
param vnetAddressPrefix string = '10.0.0.0/16'
param subnetName string = 'mySubnet1'
param subnetAddressPrefix string = '10.0.1.0/24'

// VM parameters
param vmName string = 'myVm'
param vmSize string = 'Standard_B1s'
param vmAdminUsername string = 'sjadmin'
@secure()
param vmAdminPassword string


// Deplo the resource group
resource rg 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: resourceGroupName
  location: location
}

// VNet module
module vnet 'vnet.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: 'deployVNet'
  params: {
    location: location
    vnetName: vnetName
    vnetAddressPrefix: vnetAddressPrefix
    subnetName: subnetName
    subnetAddressPrefix: subnetAddressPrefix
  }
  dependsOn: [
    rg
  ]
}


// VM module
module vm 'vm.bicep' = {
  scope: resourceGroup(resourceGroupName)
  name: 'deployVM'
  params: {
    location: location
    subnetId: vnet.outputs.subnetId
    vmName: vmName
    vmSize: vmSize
    vmAdminUsername: vmAdminUsername
    vmAdminPassword: vmAdminPassword
  }
  dependsOn: [
    vnet
  ]
}
