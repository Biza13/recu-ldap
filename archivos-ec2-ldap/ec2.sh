#!/bin/bash

# Actualizar los paquetes del sistema
sudo yum -y update

# Instalar Docker usando amazon-linux-extras
sudo amazon-linux-extras install docker -y

# Iniciar e habilitar el servicio Docker
sudo systemctl enable --now docker

# Añadir ec2-user al grupo docker para usar Docker sin sudo
sudo usermod -aG docker ec2-user

# Construir y ejecutar el contenedor LDAP
cd /home/ec2-user/archivos-ldap || exit 1
sudo docker build -t ldap-img -f ./Dockerfile.LDAP .
sudo docker run -d --name ldap-container -p 636:636 -p 389:389 -e LDAP_ADMIN_PASSWORD="admin" ldap-img

# Verificar que el contenedor esté corriendo
sudo docker ps