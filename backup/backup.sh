#!/bin/bash

# ========= Configuración =========
FECHA=$(date +'%Y-%m-%d_%H-%M')
BACKUP_DIR="/home/hector/server/backup"
DESTINO="$BACKUP_DIR/server_backup_$FECHA.tar.gz"
RCLONE_REMOTE_NAME="remote_drive"
RCLONE_FOLDER="backups"

# ========= Qué se incluye =========
INCLUIR="/home/hector/server/.env \
         /home/hector/server/README.md \
         /home/hector/server/docker-compose.yml \
         /home/hector/server/bots \
         /home/hector/server/scripts \
         /home/hector/server/data"

echo "[INFO] Creando backup local..."
mkdir -p "$BACKUP_DIR"
tar -czf "$DESTINO" $INCLUIR

echo "[INFO] Subiendo backup a Google Drive..."
rclone copy "$DESTINO" "$RCLONE_REMOTE_NAME:$RCLONE_FOLDER" --progress

echo "[OK] Backup completado: $DESTINO"
