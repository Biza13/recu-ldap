output "instance_public_ip" {
  description = "IP publica de instancia EC2"
  value = aws_instance.instancia_fedora.public_ip
}

output "instance_public_ip_ldap" {
  description = "IP publica de instancia EC2 de ldap"
  value = aws_instance.instancia_ldap.public_ip
}