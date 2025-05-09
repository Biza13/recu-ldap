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