#!/bin/bash

# Adjuntar estos comandos a la VM de imagen
sudo mkdir /var/www/html/imagen
sudo sh -c 'echo "Esto son mis imagenes" > /var/www/html/imagen/index.html'

# Adjuntar estos comandos a la VM de video
sudo mkdir /var/www/html/video
sudo sh -c 'echo "Esto son mis videos" > /var/www/html/video/index.html'