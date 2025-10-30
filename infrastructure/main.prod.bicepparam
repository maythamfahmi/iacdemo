using 'main.bicep'

param environment = 'prod'
param location = 'swedencentral'
param sequenceNumber = ''
param retentionPolicy = 7
param tags = {
  Environment: environment
  Owner: 'Maytham Fahmi'
  Purpose: 'Production'
  Project: 'IacDemo'
  RetentionPolicy: retentionPolicy
}
