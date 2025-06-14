#!/bin/bash
echo "[INFO] Buscando requirements.txt en subcarpetas..."

for d in */ ; do
  if [ -f "$d/requirements.txt" ]; then
    echo "[INFO] Instalando $d/requirements.txt"
    pip install --no-cache-dir -r "$d/requirements.txt"
  fi
done

echo "[INFO] Instalación de requirements completa."
