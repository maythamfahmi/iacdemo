targetScope = 'subscription'

@description('The environment for the deployment.')
param environment string

@description('The location for the deployment.')
param location string

@description('The sequence number for the deployment.')
param sequenceNumber string

@description('Tags to apply to resources.')
param tags object

param retentionPolicy int

resource rg 'Microsoft.Resources/resourceGroups@2025-04-01' = {
  name: 'rg-demo-ps-rule-${environment}'
  location: location
  tags: tags
}

module storageAccountRaw './modules/storageAccountWithBlob.bicep' = {
  name: 'storage-raw-deployment'
  scope: rg
  params: {
    storageAccountName: 'sademo${sequenceNumber}psruleraw${environment}'
    blobContainerName: 'default'
    location: location
    retentionPolicy: retentionPolicy
    tags: tags
  }
}

output environment string = environment
