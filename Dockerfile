# Usa una imagen base de Nginx muy ligera y segura para Cloud Run.
FROM nginxinc/nginx-unprivileged:alpine-perl

# CRÍTICO 1: Copia el archivo de la raíz del proyecto local (Website Stem)
# al directorio donde Nginx busca los archivos web.
COPY index.html /usr/share/nginx/html/index.html

# CRÍTICO 2: Copia el template de configuración de Nginx al lugar exacto donde
# la imagen base lo espera para procesar la variable $PORT.
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

# Cloud Run expone el puerto definido por la variable de entorno $PORT.
# El entrypoint de la imagen base se encarga de aplicar esa variable a la configuración.
CMD ["/docker-entrypoint.sh", "nginx", "-g", "daemon off;"]
