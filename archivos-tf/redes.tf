#Poner el proveedor de terraform, en este caso aws
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
  }
}

# Configurar la region de aws.
provider "aws" {
  region = var.region
}

# Crear una VPC.
resource "aws_vpc" "Desarrollo-web-VPC" {
  cidr_block = var.vpc
  tags = {
    "Name" = "VPC"
  }
} 

#SUBRED PÚBLICA

#red pública.
resource "aws_subnet" "subred-publica" {
  vpc_id = aws_vpc.Desarrollo-web-VPC.id
  cidr_block = var.cidrSubredPublica
  map_public_ip_on_launch = true        #necesario para las redes publicas
  tags = {
    "Name" = "subred-publica"
  }
}

#creacion de la internet gateway
resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.Desarrollo-web-VPC.id
  tags = {
    Name = "internet_gateway"
  }
}

#creacion de la tabla de enrutamiento
resource "aws_route_table" "public-rt" {
  vpc_id = aws_vpc.Desarrollo-web-VPC.id

  route {   //definir la ruta
    cidr_block = "0.0.0.0/0"   //permitir el trafico desde cualquier direccion ip hacia fuera de la vpc
    gateway_id = aws_internet_gateway.igw.id
  }

  tags = {
    Name = "Tabla Enrutamiento para Internet gateway"
  }
}

#asociar la tabla de enrutamiento a la subred publica
resource "aws_route_table_association" "rt-asociacion-publica" {
  subnet_id = aws_subnet.subred-publica.id
  route_table_id = aws_route_table.public-rt.id
}

# SUBRED PRIVADA

#subred privada
resource "aws_subnet" "subred-privada" {
  vpc_id = aws_vpc.Desarrollo-web-VPC.id
  cidr_block = var.cidrSubredPrivada
  tags = {
    "Name" = "subred-privada"
  }
}

#asociar la ip elastica que tengo en aws con la instancia
resource "aws_eip_association" "eip_assoc_fedora" {
  allocation_id = var.id_eip
  instance_id   = aws_instance.instancia_fedora.id
}

#Crear un ip elastica para la NAT gateway
/* resource "aws_eip" "NAt-gateway" {
  depends_on = [ aws_route_table_association.rt-asociacion-publica ]
  domain = "vpc"
} */

#crear la nat
resource "aws_nat_gateway" "nat-gateway" {
  allocation_id = aws_eip.NAt-gateway.id
  subnet_id     = aws_subnet.subred-publica.id  //se pone la subred publica para que tenga acceso hacia afuera

  tags = {
    Name = "NAT gateway"
  }
  depends_on = [aws_internet_gateway.igw]
}

#creamos la tabla de rutas para la nat gateway
resource "aws_route_table" "nat-gateway-rt" {
    //depends_on = [ aws_nat_gateway.nat-gateway ]
  vpc_id = aws_vpc.Desarrollo-web-VPC.id

  route {
    cidr_block = "0.0.0.0/0"    //permitir el trafico desde cualquier direccion hacia afuera de la vpc
    nat_gateway_id = aws_nat_gateway.nat-gateway.id
  }

  tags = {
    Name = "Tabla Enrutamiento para el NAT gateway"
  }
}

#asociar la tabla de enrutamiento con el nat gateway
resource "aws_route_table_association" "rt-asociacion-NAT" {
    //depends_on = [ aws_route_table.nat-gateway-rt ]
  subnet_id = aws_subnet.subred-privada.id
  route_table_id = aws_route_table.nat-gateway-rt.id
}