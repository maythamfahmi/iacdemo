@description('Location of the data factory.')
param location string = resourceGroup().location

@description('Name of the Azure storage account')
param storageAccountName string

@description('Name of the blob container in the Azure Storage account.')
param blobContainerName string

param retentionPolicy int = 7

param tags object

resource storageAccount 'Microsoft.Storage/storageAccounts@2025-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'
  }
  kind: 'StorageV2'
  tags: tags
  properties: {
    allowSharedKeyAccess: false
    minimumTlsVersion: 'TLS1_2' // try 'TLS1_1'
    networkAcls: {
      defaultAction: 'Deny' // Try 'Allow'
    }
  }
}

resource blobService 'Microsoft.Storage/storageAccounts/blobServices@2025-01-01' = {
  parent: storageAccount
  name: 'default'
  properties: {
    deleteRetentionPolicy: {
      enabled: true
      days: retentionPolicy
    }
    containerDeleteRetentionPolicy: {
      enabled: true
      days: retentionPolicy
    }
  }
}

resource blobContainer 'Microsoft.Storage/storageAccounts/blobServices/containers@2025-01-01' = {
  parent: blobService
  name: blobContainerName
}

// ----------- outputs ------------
output id string = storageAccount.id
