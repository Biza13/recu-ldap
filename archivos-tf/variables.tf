variable "vpc" {
    description = "rango de vpc"
    type = string
}

variable "region" {
  description = "AWS Region"
  type = string
}

variable "cidrSubredPublica"{
    description = "Rango de ips de la subred pública"
    type = string
}

variable "cidrSubredPrivada"{
    description = "Rango de ips de la subred privada"
    type = string
}

variable "s3"{
  description = "Nombre del bucket s3"
  type = string
}

variable "public_key" {
  description = "Public key"
  type        = string
  default = ""
}

variable "id_eip" {
  description = "id de la ip elastica"
  type = string
}

variable "id_eip_NAT" {
  description = "id de la ip elastica para la nat"
  type = string
}