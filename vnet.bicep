// vnet.bicep
// Create a virtual network with a subnet

// Parameters
param location string
param vnetName string
param vnetAddressPrefix string
param subnetName string
param subnetAddressPrefix string

// Deploy the virtual network and subnet
resource vnet 'Microsoft.Network/virtualNetworks@2021-02-01' = {
  name: vnetName
  location: location
  properties: {
    addressSpace: {
      addressPrefixes: [vnetAddressPrefix]
    }
    subnets: [
      {
        name: subnetName
        properties: {
          addressPrefix: subnetAddressPrefix
        }
      }
    ]
  }
}

// Outputs
output subnetId string = vnet.properties.subnets[0].id



