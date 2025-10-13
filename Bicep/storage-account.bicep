// Nombre único para la Storage Account
param storageAccountName string = 'stdemobicep${uniqueString(resourceGroup().id)}'

// Usa la ubicación del Resource Group
param location string = resourceGroup().location

// Recurso: Storage Account estándar con replicación local
resource storageAccount 'Microsoft.Storage/storageAccounts@2023-01-01' = {
  name: storageAccountName
  location: location
  sku: {
    name: 'Standard_LRS'   // SKU estándar LRS
  }
  kind: 'StorageV2'        // Tipo recomendado
}

// ID de la Storage Account
output storageId string = storageAccount.id

// URL del endpoint de Blob
output blobEndpoint string = storageAccount.properties.primaryEndpoints.blob
