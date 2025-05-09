#!/bin/bash

# Actualizar los paquetes del sistema
sudo yum -y update

# Instalar Docker usando amazon-linux-extras
sudo amazon-linux-extras install docker -y

# Iniciar e habilitar el servicio Docker
sudo systemctl enable --now docker

# Añadir ec2-user al grupo docker para usar Docker sin sudo
sudo usermod -aG docker ec2-user

# Verificación de los servicios
sudo systemctl status docker --no-pager

# Crear directorio para plugins de Docker si no existe
sudo mkdir -p /usr/local/lib/docker/cli-plugins

# Descargar Docker Compose v2 como plugin
sudo curl -SL https://github.com/docker/compose/releases/download/v2.35.1/docker-compose-linux-x86_64 \
  -o /usr/local/lib/docker/cli-plugins/docker-compose

# Establecer permisos de ejecución para Docker Compose
sudo chmod +x /usr/local/lib/docker/cli-plugins/docker-compose

sleep 30