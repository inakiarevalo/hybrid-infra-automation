#!/bin/bash

# Archivo de log donde se registran todas las ejecuciones
LOG_FILE="/home/sysadmin01/restart_nginx.log"

# Mostrar fecha y hora del inicio del script
echo "$(date '+%Y-%m-%d %H:%M:%S') - Inicio del script de reinicio de Nginx" >> "$LOG_FILE"

# Comprobar si nginx está activo
if systemctl is-active --quiet nginx; then
   echo "El servicio está activo. REINICIANDO..." | tee -a "$LOG_FILE"
else
   echo "El servicio no está activo. INICIANDO..." | tee -a "$LOG_FILE"
fi

# Reinicio de Nginx
if sudo systemctl restart nginx; then
   echo "Reinicio completado con éxito." | tee -a "$LOG_FILE"
else
   echo "Error al reiniciar Nginx. Revisa el estado del servicio." | tee -a "$LOG_FILE"
fi

# Fin de script
echo "Fin del script de reinicio de Nginx" >> "$LOG_FILE"

# Estado del servicio
STATUS=$(systemctl is-active nginx)
if [ "$STATUS" = "active" ]; then
    echo -e "\e[32m● Nginx ACTIVO\e[0m"
else
    echo -e "\e[31m● Nginx NO ACTIVO\e[0m"
fi
