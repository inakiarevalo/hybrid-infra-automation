#!/bin/bash

# Carpeta donde se guardarán los backups
BACKUP_DIR="/home/sysadmin01/backups"
mkdir -p "$BACKUP_DIR"

# Nombre del archivo de backup con fecha y hora
DATE=$(date +%Y%m%d_%H%M%S)

# Directorios a respaldar
WEB_DIR="/var/www/infra-cloud"
NGINX_DIR="/etc/nginx"

# Crear copia comprimida del sitio web
sudo tar -czf "$BACKUP_DIR/infra-cloud_$DATE.tar.gz" -C / "${WEB_DIR:1}"

# Crear copia comprimida de la configuración de Nginx
sudo tar -czf "$BACKUP_DIR/nginx_$DATE.tar.gz" -C / "${NGINX_DIR:1}"

echo "Backups creados en $BACKUP_DIR"
