#!/bin/bash

echo "[INFO] Instalando cron del backup..."
crontab backup.crontab
echo "[OK] Cron instalado correctamente."
