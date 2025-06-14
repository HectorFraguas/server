🧠 Servidor Personal con Docker y Automatización

Este proyecto te permite montar en tu servidor personal (PC o Raspberry Pi) una estructura organizada y profesional con:

Bots de Telegram

Scripts con tareas programadas (cron)

N8n para automatizaciones visuales

MongoDB como base de datos centralizada

Backup automático en Google Drive (con rclone)

Acceso externo por DuckDNS

Paneles de administración vía Portainer y Cockpit

Acceso remoto seguro por SSH con clave pública (opcional)

🔥 Firewall (UFW) con puertos abiertos específicos

🌐 HTTPS y gestión de dominios con Nginx Proxy Manager

📁 Estructura de carpetas

server/
├── bots/
│   ├── bot1/
│   └── bot2/
├── scripts/
│   ├── api_checker/
│   └── cronjob/
├── data/
│   ├── mongo/
│   ├── n8n/
│   ├── portainer/
│   ├── nginx/
│   └── cockpit/  # (mantener por estructura aunque no se usa directamente)
├── n8n/
│   └── docker.env
├── duckdns/
│   └── duck.sh
├── backup/
│   ├── backup.sh
│   ├── backup.crontab
│   └── setup_cron.sh
├── ssh/
│   └── README.md (explicación de uso de claves SSH)
├── docker-compose.yml
├── .env
└── setup.sh

⚙️ setup.sh

Script que automatiza toda la instalación inicial. Ejecuta:

Instalación de Docker y Docker Compose

Creación de volúmenes persistentes

Arranque de todos los contenedores

Instalación del cron de backups

🔥 Configuración del firewall con UFW

🖥️ Instalación del panel Cockpit directamente en el sistema

🌐 Creación del volumen portainer_data y configuración básica de Nginx Proxy Manager

🔧 Uso

chmod +x setup.sh
./setup.sh

🔐 Acceso SSH con clave (opcional pero recomendado)

Ventajas:

Mucho más seguro que contraseña

Solo tú puedes conectarte con tu clave privada

Puedes deshabilitar el login por contraseña más adelante

Pasos para activar SSH con clave:

En tu PC local:

ssh-keygen -t rsa -b 4096 -C "tu_email@example.com"

Copia la clave pública al servidor:

ssh-copy-id usuario@ip_del_servidor

Verifica que puedes entrar:

ssh usuario@ip_del_servidor

(Opcional) Desactivar acceso por contraseña en /etc/ssh/sshd_config:

PasswordAuthentication no

Reinicia SSH:

sudo systemctl restart sshd

📝 Este paso se puede hacer más adelante. Por defecto, el sistema está preparado para funcionar con usuario y contraseña.

🔥 UFW (Uncomplicated Firewall)

UFW es un firewall simple para bloquear todo lo que no se haya permitido.

Se activa por defecto con:

sudo ufw allow OpenSSH
sudo ufw allow 9000/tcp   # Portainer
sudo ufw allow 9090/tcp   # Cockpit
sudo ufw allow 5678/tcp   # N8n
sudo ufw allow 80/tcp     # HTTP para Nginx
sudo ufw allow 443/tcp    # HTTPS para Nginx
sudo ufw allow 81/tcp     # Admin Nginx Proxy Manager
sudo ufw enable

Esto se incluye en setup.sh para que se configure automáticamente.

📝 Abrir puertos en el router (port forwarding)

Si accedes al servidor desde fuera (vía DuckDNS), debes abrir puertos en tu router:

Puertos que puedes abrir:

Puerto

Servicio

Recomendado

22

SSH

✅

9000

Portainer

✅

5678

N8n

✅

9090

Cockpit

✅

80

HTTP (Nginx)

✅

443

HTTPS (Nginx)

✅

81

Admin Nginx Manager

✅

Pasos generales (varía según tu router):

Entra al panel del router (suele ser 192.168.1.1 o similar)

Busca "Port forwarding" o "NAT"

Añade reglas con:

Puerto externo = Puerto interno

IP local del servidor (ej: 192.168.1.100)

Protocolo: TCP

Guarda y reinicia si es necesario

📊 Interfaces web

Portainer → http://IP-SERVIDOR:9000

Cockpit → http://IP-SERVIDOR:9090

N8n → http://IP-SERVIDOR:5678 o https://n8n.tuservidor.duckdns.org

Nginx Proxy Manager → http://IP-SERVIDOR:81 o https://tuservidor.duckdns.org:81

🤖 Futuras mejoras (opcional en el futuro)

Estos componentes no están incluidos por defecto, pero podrían añadirse más adelante:

🔐 Proxy inverso (Traefik o Nginx) → para usar dominios tipo n8n.tuservidor.duckdns.org (✅ Nginx incluido)

📈 Sistema de logs (Grafana + Loki) → para tener visualización de métricas y logs

🛡️ VPN (Tailscale o WireGuard) → para acceso privado desde fuera sin exponer puertos

✅ Migración a otro servidor o Raspberry Pi

Para mover todo a otro equipo:

Instala Linux Server (Ubuntu Server recomendado)

Instala Docker y Docker Compose (si no están ya)

Copia todo el proyecto (scp, pendrive, etc)

Lanza ./setup.sh

¡Listo! Tendrás exactamente lo mismo corriendo en la nueva máquina

