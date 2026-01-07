#!/bin/bash

# Carpeta donde están los backups
BACKUP_DIR="/home/sysadmin01/backups"
mkdir -p "$BACKUP_DIR"

# Comprobación de argumento
if [ -z "$1" ]; then
   echo "Uso: $0 <nombre_del_backup_sin_extension>"
   echo "Ejemplo: $0 infra-cloud_20251001_153000"
   echo "Últimos backups disponibles:"
   sudo ls -1t /home/sysadmin01/backups/ | head -n 10
   exit 1
fi

BACKUP_NAME="$1"

# Directorios originales
WEB_DIR="/var/www/infra-cloud"
NGINX_DIR="/etc/nginx"

# Restaurar sitio web/configuración nginx
echo "Restaurando desde $BACKUP_DIR/${BACKUP_NAME}.tar.gz..."
sudo tar -xzf "$BACKUP_DIR/${BACKUP_NAME}.tar.gz" -C /

# Mensaje de éxito
echo "Backup restaurado con éxito"
