#!/bin/bash

# Script simplificado para instalar Docker y Docker Compose
# y luego ejecutar docker compose up

# Instalar Docker
echo "Instalando Docker..."
sudo yum install -y docker

# Iniciar y habilitar Docker
echo "Configurando Docker..."
sudo systemctl enable --now docker

# Añadir usuario ec2-user al grupo docker
sudo usermod -aG docker ec2-user

# Instalar Docker Compose v2
echo "Instalando Docker Compose..."
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL https://github.com/docker/compose/releases/latest/download/docker-compose-linux-x86_64 -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# Verificar instalaciones
echo "Verificando instalaciones..."
docker --version
docker compose version

# Ejecutar docker compose
echo "Ejecutando docker compose up..."
sudo docker compose -f /home/ec2-user/archivos-conf-script/docker-compose.yml up -d

echo "Proceso completado. Contenedores en ejecución:"
docker ps