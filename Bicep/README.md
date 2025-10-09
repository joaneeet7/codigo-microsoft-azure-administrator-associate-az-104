# Ejemplo de Bicep

Para tu clase de demostración, usa estos archivos:

## Archivos

- **storage-account.bicep** - Template Bicep minimalista (15 líneas)
- **storage-account.bicepparam** - Parámetros
- **deploy.sh** - Script de despliegue

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
az group create --name rg-demo-bicep --location westeurope

# Desplegar
az deployment group create \
  --resource-group rg-demo-bicep \
  --template-file storage-account.bicep \
  --parameters storage-account.bicepparam

# Ver recursos creados
az resource list --resource-group rg-demo-bicep --output table

# Limpiar
az group delete --name rg-demo-bicep --yes
```

## Conceptos clave

**storage-account.bicep** muestra:
- Declaración de parámetros
- Creación de un recurso
- Outputs básicos

**15 líneas de código** vs 130 en ARM JSON - Bicep es mucho más limpio.

## Ejercicio

Modifica storage-account.bicep para:
1. Cambiar el SKU a Standard_GRS
2. Añadir un tag con tu nombre
3. Añadir un output con el nombre de la storage account

## Comandos útiles

```bash
# Compilar Bicep a ARM (para ver el JSON generado)
az bicep build --file storage-account.bicep

# Ver el JSON sin guardarlo
az bicep build --file storage-account.bicep --stdout

# Validar antes de desplegar
az deployment group validate \
  --resource-group rg-demo-bicep \
  --template-file storage-account.bicep \
  --parameters storage-account.bicepparam
```

---

Este ejemplo demuestra los conceptos fundamentales de Bicep para Infrastructure as Code en Azure.

