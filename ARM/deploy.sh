#!/bin/bash
# Script de despliegue con Azure CLI

# Variables
RESOURCE_GROUP_NAME="rg-demo-arm"
LOCATION="westeurope"
TEMPLATE_FILE="storage-account-template.json"
PARAMETERS_FILE="parameters.json"
DEPLOYMENT_NAME="demo-storage-deployment-$(date +%Y%m%d-%H%M%S)"

# Mostrar información
echo "=== Despliegue de ARM Template ==="
echo "Resource Group: $RESOURCE_GROUP_NAME"
echo "Ubicación: $LOCATION"
echo ""

# Verificar que los archivos existen
if [ ! -f "$TEMPLATE_FILE" ]; then
    echo "Error: No se encuentra el archivo $TEMPLATE_FILE"
    exit 1
fi

if [ ! -f "$PARAMETERS_FILE" ]; then
    echo "Error: No se encuentra el archivo $PARAMETERS_FILE"
    exit 1
fi

# Paso 1: Crear Resource Group
echo "Creando Resource Group..."
az group create \
    --name $RESOURCE_GROUP_NAME \
    --location $LOCATION

# Paso 2: Validar el template
echo ""
echo "Validando ARM Template..."
az deployment group validate \
    --resource-group $RESOURCE_GROUP_NAME \
    --template-file $TEMPLATE_FILE \
    --parameters @$PARAMETERS_FILE

if [ $? -eq 0 ]; then
    echo "Validación exitosa"
else
    echo "Error en la validación"
    exit 1
fi

# Paso 3: Desplegar el template
echo ""
echo "Desplegando ARM Template..."
az deployment group create \
    --resource-group $RESOURCE_GROUP_NAME \
    --template-file $TEMPLATE_FILE \
    --parameters @$PARAMETERS_FILE \
    --name $DEPLOYMENT_NAME

if [ $? -eq 0 ]; then
    echo ""
    echo "Despliegue completado exitosamente"
    echo ""
    
    # Mostrar los outputs
    echo "Outputs del despliegue:"
    az deployment group show \
        --resource-group $RESOURCE_GROUP_NAME \
        --name $DEPLOYMENT_NAME \
        --query properties.outputs \
        --output json
else
    echo ""
    echo "Error en el despliegue"
    exit 1
fi

echo ""
echo "=== Comandos útiles ==="
echo "Ver recursos: az resource list --resource-group $RESOURCE_GROUP_NAME --output table"
echo "Ver despliegues: az deployment group list --resource-group $RESOURCE_GROUP_NAME --output table"
echo "Eliminar todo: az group delete --name $RESOURCE_GROUP_NAME --yes --no-wait"
