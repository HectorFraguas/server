#!/bin/bash

echo "==============================="
echo "  🚀 INICIANDO INSTALACIÓN...  "
echo "==============================="

# Paso 1: Actualizar el sistema e instalar Docker + Docker Compose
echo "[INFO] Verificando Docker..."
if ! command -v docker &> /dev/null; then
  echo "[INFO] Instalando Docker y Docker Compose..."
  sudo apt update
  sudo apt install -y docker.io docker-compose
  sudo systemctl enable docker
  sudo systemctl start docker
else
  echo "[OK] Docker ya está instalado."
fi

# Paso 2: Crear volúmenes persistentes
echo "[INFO] Creando volúmenes persistentes necesarios..."
docker volume create mongodb_data >/dev/null
docker volume create n8n_data >/dev/null

# Volumen para Portainer
if ! docker volume ls | grep -q portainer_data; then
  echo "[INFO] Creando volumen portainer_data..."
  docker volume create portainer_data
else
  echo "[OK] Volumen portainer_data ya existe."
fi

# Paso 3: Levantar servicios con docker-compose
read -p "¿Quieres levantar todos los servicios ahora? (s/n): " launch
if [[ $launch == "s" ]]; then
  echo "[INFO] Levantando servicios con docker-compose..."
  docker-compose up -d
else
  echo "[OK] Saltando arranque de servicios por elección del usuario."
fi

# Paso 4: Instalar cronjob del sistema para backup
if [ -f "./backup/setup_cron.sh" ]; then
  echo "[INFO] Instalando cronjob de backup..."
  bash ./backup/setup_cron.sh
else
  echo "[WARNING] No se encontró backup/setup_cron.sh"
fi

# Paso 5: Instalar y configurar UFW (Firewall)
echo "[INFO] Instalando y configurando UFW (firewall)..."
sudo apt-get install -y ufw
# Permitir servicios esenciales
sudo ufw allow OpenSSH
sudo ufw allow 9000/tcp   # Portainer
sudo ufw allow 9090/tcp   # Cockpit
sudo ufw allow 5678/tcp   # N8n
sudo ufw allow 80/tcp     # HTTP (necesario para Let's Encrypt)
sudo ufw allow 443/tcp    # HTTPS

sudo ufw --force enable
echo "[OK] UFW configurado correctamente."

# Paso 6: Instalar Cockpit directamente en el sistema
echo "[INFO] Instalando Cockpit en el sistema..."
sudo apt-get install -y cockpit
sudo systemctl enable --now cockpit.socket

echo "=================================="
echo "✅ INSTALACIÓN COMPLETA"
echo "Puedes acceder a:"
echo "- Portainer: http://TU-IP:9000"
echo "- Cockpit:   http://TU-IP:9090"
echo "- N8n:       http://TU-IP:5678"
echo "=================================="