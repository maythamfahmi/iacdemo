using 'main.bicep'

param environment = 'dev'
param location = 'swedencentral'
param sequenceNumber = '003'
param retentionPolicy = 30
param tags = {
  Environment: environment
  Owner: 'Maytham Fahmi'
  SequenceNumber: sequenceNumber
  Purpose: 'Development'
  Project: 'IacDemo'
  RetentionPolicy: retentionPolicy
}
