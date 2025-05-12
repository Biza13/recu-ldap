FROM httpd:2.4

# Crear usuario y grupo
RUN addgroup --system apache && adduser --system --ingroup apache apache

# Copiar configuración personalizada
COPY httpd1.conf /usr/local/apache2/conf/httpd.conf

# Copiar los certificados
COPY cert-begona /usr/local/apache2/certs/begona

# Usar el nuevo usuario para ejecutar Apache
USER apache
