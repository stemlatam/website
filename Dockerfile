# Usa la imagen base Alpine de Nginx.
FROM nginx:alpine

# CRÍTICO: Instala gettext (que incluye 'envsubst') para sustituir la variable $PORT.
RUN apk add --no-cache gettext

# Copia tu archivo HTML.
COPY index.html /usr/share/nginx/html/index.html

# Copia el archivo de configuración TEMPLATE.
COPY nginx.conf.template /etc/nginx/conf.d/default.conf.template

# EXPONE el puerto 8080, que Cloud Run espera.
EXPOSE 8080

# CRÍTICO: El comando de inicio usa envsubst para reemplazar ${PORT} en el template 
# y guarda el resultado en el archivo final de configuración antes de iniciar Nginx.
CMD ["/bin/sh", "-c", "envsubst '$$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"]
