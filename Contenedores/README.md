# Ejemplo de Docker - Hola Mundo

Aplicación web simple que se ejecuta en un contenedor Docker.

## Archivos

- **Dockerfile** - Configuración del contenedor
- **index.js** - Aplicación Node.js
- **package.json** - Dependencias del proyecto

## Uso

### Construir la imagen

```bash
docker build -t hola-mundo .
```

### Ejecutar el contenedor

```bash
docker run -p 3000:3000 hola-mundo
```

### Ver la aplicación

Abre tu navegador en: http://localhost:3000

## Comandos útiles

```bash
# Ver imágenes
docker images

# Ver contenedores en ejecución
docker ps

# Parar contenedor
docker stop <container-id>

# Eliminar contenedor
docker rm <container-id>

# Eliminar imagen
docker rmi hola-mundo

# Ejecutar en segundo plano
docker run -d -p 3000:3000 --name mi-app hola-mundo

# Ver logs
docker logs mi-app
```
