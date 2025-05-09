#!/bin/bash
# Actualizar sistema
sudo yum update -y

# Instalar Docker
sudo amazon-linux-extras install docker -y
sudo systemctl enable --now docker

# Configurar usuario docker sin sudo
sudo usermod -aG docker ec2-user

# Instalar Docker Compose v2 (última versión estable)
DOCKER_CONFIG=${DOCKER_CONFIG:-$HOME/.docker}
mkdir -p $DOCKER_CONFIG/cli-plugins
curl -SL "https://github.com/docker/compose/releases/latest/download/docker-compose-linux-$(uname -m)" \
  -o $DOCKER_CONFIG/cli-plugins/docker-compose
chmod +x $DOCKER_CONFIG/cli-plugins/docker-compose

# Crear enlace simbólico para acceso global
sudo ln -s $DOCKER_CONFIG/cli-plugins/docker-compose /usr/local/bin/docker-compose

# Instalar dependencias útiles
sudo yum install -y git awscli

# Configurar Docker para usar overlay2
sudo mkdir -p /etc/docker
sudo tee /etc/docker/daemon.json <<EOF
{
  "exec-opts": ["native.cgroupdriver=systemd"],
  "log-driver": "json-file",
  "log-opts": {
    "max-size": "100m"
  },
  "storage-driver": "overlay2"
}
EOF

# Reiniciar docker para aplicar cambios
sudo systemctl restart docker

# Verificar instalaciones
echo "=== Versiones instaladas ==="
docker --version
docker compose version
aws --version