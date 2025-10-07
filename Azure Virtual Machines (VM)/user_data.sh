#!/bin/bash
sudo su
apt-get -y update
apt-get -y install nginx
echo "<h1>Hola Mundo desde $(hostname)</h1>" > /var/www/html/index.html