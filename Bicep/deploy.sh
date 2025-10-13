#!/bin/bash
# Script para desplegar Bicep

RG="rg-demo-bicep"
LOCATION="westeurope"

echo "Creando Resource Group..."
az group create --name $RG --location $LOCATION

echo "Desplegando Bicep..."
az deployment group create \
  --resource-group $RG \
  --template-file storage-account.bicep

echo ""
echo "Hecho! Ver recursos:"
echo "az resource list --resource-group $RG --output table"
echo ""
echo "Eliminar todo:"
echo "az group delete --name $RG --yes"
