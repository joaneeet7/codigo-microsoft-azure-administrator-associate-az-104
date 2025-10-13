## Uso manual

```bash
# Crear Resource Group
az group create --name rg-demo-bicep --location westeurope

# Desplegar
az deployment group create \
  --resource-group rg-demo-bicep \
  --template-file storage-account.bicep

# Ver recursos creados
az resource list --resource-group rg-demo-bicep --output table

# Limpiar
az group delete --name rg-demo-bicep --yes
```

## Comandos útiles

```bash
# Compilar Bicep a ARM (para ver el JSON generado)
az bicep build --file storage-account.bicep

# Ver el JSON sin guardarlo
az bicep build --file storage-account.bicep --stdout

# Descompilar ARM JSON a Bicep
az bicep decompile --file storage-account.json

# Validar antes de desplegar
az deployment group validate \
  --resource-group rg-demo-bicep \
  --template-file storage-account.bicep
```