# Usa una imagen base de Nginx muy ligera.
FROM nginxinc/nginx-unprivileged:alpine-perl

# CRÍTICO: Copia el index.html de la raíz de tu proyecto a la carpeta raíz de Nginx.
COPY index.html /usr/share/nginx/html/

# Copia la configuración de Nginx (usa un template para leer el puerto de Cloud Run)
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

# Cloud Run automáticamente expone el puerto definido por la variable de entorno $PORT.
CMD ["/docker-entrypoint.sh", "nginx", "-g", "daemon off;"]
