#!/bin/bash

# Esperar a que el servicio LDAP esté completamente disponible
sleep 10

# Añadir los datos desde los archivos LDIF
ldapadd -x -D "cn=admin,dc=begona,dc=work,dc=gd" -w "$LDAP_ADMIN_PASSWORD" -f /empleados.ldif
ldapadd -x -D "cn=admin,dc=begona,dc=work,dc=gd" -w "$LDAP_ADMIN_PASSWORD" -f /usuario.ldif

# Salir
exit 0