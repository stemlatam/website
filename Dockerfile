# Usa la imagen base Alpine de Nginx.
FROM nginx:alpine

# CRÍTICO: Instala gettext (que incluye 'envsubst') para sustituir la variable $PORT.
# Mantenemos esta instalación, aunque ya estaba correcta.
RUN apk update && apk add gettext --no-cache

# Copia tu archivo HTML.
COPY index.html /usr/share/nginx/html/index.html

# Copia el archivo de configuración TEMPLATE.
COPY nginx.conf.template /etc/nginx/conf.d/default.conf.template

# EXPONE el puerto 8080, que Cloud Run espera.
EXPOSE 8080

# CRÍTICO: Usa un script de shell simple para ejecutar envsubst y Nginx.
ENTRYPOINT ["/bin/sh", "-c"]
CMD ["envsubst '$$PORT' < /etc/nginx/conf.d/default.conf.template > /etc/nginx/conf.d/default.conf && exec nginx -g 'daemon off;'"]
