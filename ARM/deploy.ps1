# Script de despliegue con PowerShell

# Variables
$resourceGroupName = "rg-demo-arm"
$location = "westeurope"
$templateFile = "storage-account-template.json"
$parametersFile = "parameters.json"

# Mostrar información
Write-Host "=== Despliegue de ARM Template ==="
Write-Host "Resource Group: $resourceGroupName"
Write-Host "Ubicación: $location"
Write-Host ""

# Verificar que los archivos existen
if (-not (Test-Path $templateFile)) {
    Write-Host "Error: No se encuentra el archivo $templateFile"
    exit 1
}

if (-not (Test-Path $parametersFile)) {
    Write-Host "Error: No se encuentra el archivo $parametersFile"
    exit 1
}

# Crear Resource Group
Write-Host "Creando Resource Group..."
az group create `
    --name $resourceGroupName `
    --location $location

# Validar el template
Write-Host ""
Write-Host "Validando ARM Template..."
az deployment group validate `
    --resource-group $resourceGroupName `
    --template-file $templateFile `
    --parameters $parametersFile

if ($LASTEXITCODE -eq 0) {
    Write-Host "Validación exitosa"
} else {
    Write-Host "Error en la validación"
    exit 1
}

# Desplegar el template
Write-Host ""
Write-Host "Desplegando ARM Template..."
az deployment group create `
    --resource-group $resourceGroupName `
    --template-file $templateFile `
    --parameters $parametersFile `
    --name "demo-storage-deployment-$(Get-Date -Format 'yyyyMMdd-HHmmss')"

if ($LASTEXITCODE -eq 0) {
    Write-Host ""
    Write-Host "Despliegue completado exitosamente"
    Write-Host ""
    
    # Mostrar los outputs
    Write-Host "Obteniendo outputs del despliegue..."
    az deployment group show `
        --resource-group $resourceGroupName `
        --name "demo-storage-deployment-$(Get-Date -Format 'yyyyMMdd-HHmmss')" `
        --query properties.outputs
} else {
    Write-Host ""
    Write-Host "Error en el despliegue"
    exit 1
}

Write-Host ""
Write-Host "=== Comandos útiles ==="
Write-Host "Ver recursos: az resource list --resource-group $resourceGroupName --output table"
Write-Host "Eliminar todo: az group delete --name $resourceGroupName --yes --no-wait"
