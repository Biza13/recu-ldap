echo "Actualizando los paquetes del sistema..."
sudo yum -y update

echo "Instalando Docker..."
sudo amazon-linux-extras install docker -y

echo "Habilitando y arrancando el servicio Docker..."
sudo systemctl enable --now docker

echo "Agregando ec2-user al grupo docker..."
sudo usermod -aG docker ec2-user

echo "Verificando la carpeta de archivos LDAP..."
if [ ! -d "/home/ec2-user/archivos-ldap" ]; then
  echo "La carpeta /home/ec2-user/archivos-ldap no existe. Abortando."
  exit 1
fi
cd /home/ec2-user/archivos-ldap || exit 1

echo "Construyendo la imagen Docker para LDAP..."
sudo docker build -t ldap-img -f ./Dockerfile.LDAP .

echo "Ejecutando el contenedor LDAP..."
sudo docker run -d --name ldap-container -p 636:636 -p 389:389 -e LDAP_ADMIN_PASSWORD="admin" ldap-img

echo "Verificando que el contenedor esté corriendo..."
sudo docker ps