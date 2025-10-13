# Ejemplo de ARM Template

Ejemplo de ARM (Azure Resource Manager) Template para crear una Storage Account.

## Archivos

- **storage-account-template.json** - Plantilla ARM principal (autosuficiente)
- **deploy.ps1** - Script PowerShell
- **deploy.sh** - Script Bash

## Uso rápido

```bash
# Dar permisos
chmod +x deploy.sh

# Desplegar
./deploy.sh
```

## Uso manual

```bash
# Crear Resource Group
az group create \
    --name rg-demo-arm \
    --location westeurope

# Validar template
az deployment group validate \
    --resource-group rg-demo-arm \
    --template-file storage-account-template.json

# Desplegar
az deployment group create \
    --resource-group rg-demo-arm \
    --template-file storage-account-template.json
```

## Estructura de un ARM Template

```json
{
  "$schema": "...",
  "contentVersion": "1.0.0.0",
  "parameters": { },      // Inputs configurables
  "variables": { },       // Variables internas
  "resources": [ ],       // Recursos a crear
  "outputs": { }         // Valores de salida
}
```

## Conceptos clave

**Parameters**: Valores configurables con valores por defecto
- storageAccountName: Se genera automáticamente usando `uniqueString()`
- location: Usa la ubicación del Resource Group por defecto
- sku: Standard_LRS por defecto

**Variables**: Valores calculados dentro del template

**Resources**: Definición de recursos de Azure a crear

**Outputs**: Información devuelta después del despliegue

## Comandos útiles

```bash
# Ver recursos creados
az resource list --resource-group rg-demo-arm --output table

# Ver despliegues
az deployment group list --resource-group rg-demo-arm --output table

# Ver outputs
az deployment group show \
    --resource-group rg-demo-arm \
    --name demo-deployment \
    --query properties.outputs

# What-If (ver cambios sin aplicar)
az deployment group what-if \
    --resource-group rg-demo-arm \
    --template-file storage-account-template.json

# Exportar template de recursos existentes
az group export \
    --resource-group rg-demo-arm \
    --output json > exported-template.json
```

## Limpieza

```bash
az group delete --name rg-demo-arm --yes
```

## Ventajas de ARM Templates

- **Idempotencia**: Ejecutar múltiples veces da el mismo resultado
- **Declarativo**: Describes el estado final deseado
- **Validación**: Detecta errores antes de desplegar
- **Orquestación**: Maneja dependencias automáticamente

## Importante

- El template es autosuficiente: no necesita archivo de parámetros
- El nombre de la storage account se genera automáticamente
- Recuerda eliminar recursos después de la demostración
