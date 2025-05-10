

#imagen para amazon linux fedora
data "aws_ami" "amazon_linux" {
  most_recent = true

  filter {
    name   = "name"
    values = ["amzn2-ami-hvm-*-x86_64-gp2"]
  }

  filter {
    name   = "virtualization-type"
    values = ["hvm"]
  }

  owners = ["137112412989"]
}

#GRUPO DE SEGURIDAD PARA EC2 DE SERVIDOR WEB Y SERVIDOS DE APLICACIONES
#grupo de seguridad para ssh y http/https
resource "aws_security_group" "security" {
  name = "seguridad"
  description = "Security group para permitir SSH y HTTP/HTTPS"
  vpc_id      = aws_vpc.Desarrollo-web-VPC.id  # Asegúrate de que esto apunte a la VPC correcta

  # ingres reglas de entrada
  ingress {
    from_port = 22
    to_port = 22
    protocol="tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 8080
    to_port = 8080
    protocol="tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port = 80
    to_port = 80
    protocol = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = 443
    to_port     = 443
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  
  #egress reglas de salida
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#EC2 PARA SERVIDOR WEB Y SERVIDOS DE APLICACIONES
#instancia con amazon linux
resource "aws_instance" "instancia_fedora" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"    #poner el t2
  subnet_id = aws_subnet.subred-publica.id
  vpc_security_group_ids = [aws_security_group.security.id]
  key_name = "deployer-key"  # coje el par de claves que ya estan en aws por el nombre

  tags = {
    Name = "instancia-amazon-linux"
  }

  user_data = file("../archivos-conf-script/ec2.sh")

  #Provisionador para copiar solo archivos !!!!solo funciona en local
  #provisioner "file" {
  #  source      = "../archivos-conf-script/Dockerfile"  # Ruta del directorio en tu máquina local
  #  destination = "/home/ec2-user/Dockerfile"  # Ruta donde debe ir el directorio en la instancia

    #connection {
    #  type        = "ssh"
    #  user        = "ec2-user"  # Asegúrate de que sea "ec2-user" para Amazon Linux
    #  private_key = file("C:/Users/serra/.ssh/deployer-key.pem")  # Ruta a tu clave privada .pem
    #  host        = self.public_ip  # Usa la IP pública de la instancia EC2
    #}
  #}
}

#GRUPO DE SEGURIDAD PARA EC2 DE LDAP
#grupo de seguridad para ssh y http/https
resource "aws_security_group" "security-ldap" {
  name = "seguridad-ldap"
  description = "Security group para ldap"
  vpc_id      = aws_vpc.Desarrollo-web-VPC.id  # Asegúrate de que esto apunte a la VPC correcta

  # ingres reglas de entrada
  ingress {
    from_port = 22
    to_port = 22
    protocol="tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  # Permitir tráfico LDAP desde el grupo de seguridad del servidor web y aplicaciones
  ingress {
    from_port = 389
    to_port = 389
    protocol = "tcp"
    security_groups = [aws_security_group.security.id]
  }
  
  #egress reglas de salida
  egress {
    from_port = 0
    to_port = 0
    protocol = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

#EC2 PARA LDAP
#instancia con amazon linux
resource "aws_instance" "instancia_ldap" {
  ami           = data.aws_ami.amazon_linux.id
  instance_type = "t2.micro"    #poner el t2
  subnet_id = aws_subnet.subred-privada.id
  vpc_security_group_ids = [aws_security_group.security-ldap.id]
  key_name = "deployer-key"  # coje el par de claves que ya estan en aws por el nombre

  tags = {
    Name = "instancia LDAP"
  }

  user_data = file("../archivos-ec2-ldap/ec2.sh")
}

#bucket s3 para guardar tf state
resource "aws_s3_bucket" "s3"{    
  bucket = var.s3  #nombre que le pondremos al bucket

  tags = {
    name = "bucket"
    Enviroment = "Dev"
  }
}