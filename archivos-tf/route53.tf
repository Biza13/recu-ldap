#Zona privada para route 53
resource "aws_route53_zone" "private_zone" {
  name = "begona.internal"
  vpc {
    vpc_id = aws_vpc.Desarrollo-web-VPC.id
  }
  comment = "Zona DNS privada para LDAP"
}

#registro a con dns
resource "aws_route53_record" "ldap_record" {
  zone_id = aws_route53_zone.private_zone.zone_id
  name    = "ldap.begona.internal"
  type    = "A"
  ttl     = 60
  records = [aws_instance.instancia_ldap.private_ip] #apunta a la ip privada y le dara un dns a esta instancia
}