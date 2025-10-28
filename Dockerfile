# --- Fase 1: Usar la imagen base oficial de Nginx ---
# Usamos 'alpine' porque es una versión muy ligera
FROM nginx:1.25-alpine

# --- Fase 2: Configuración para Cloud Run ---

# Cloud Run requiere que el contenedor escuche en el puerto definido por la variable de entorno $PORT.
# Nginx no puede leer variables de entorno en sus archivos .conf directamente.
# La solución estándar es usar 'envsubst' (un sustituto de variables) en el script de inicio.

# 1. Copiamos nuestra plantilla de configuración (que usa la variable ${PORT})
# al directorio de plantillas de Nginx.
COPY nginx.conf.template /etc/nginx/templates/default.conf.template

# 2. Copiamos el contenido de nuestro sitio web (solo el index.html en este caso)
# al directorio donde Nginx sirve los archivos estáticos.
COPY index.html /usr/share/nginx/html/index.html

# --- Fase 3: Comando de Inicio ---
# Este comando se ejecuta cuando Cloud Run inicia el contenedor.
# 1. Ejecuta 'envsubst' para leer la variable $PORT de Cloud Run y la reemplaza en nuestra plantilla.
# 2. Guarda el resultado como el archivo de configuración 'default.conf' que Nginx usará.
# 3. Inicia Nginx en primer plano ('daemon off;') para que el contenedor permanezca activo.
CMD /bin/sh -c "envsubst < /etc/nginx/templates/default.conf.template > /etc/nginx/conf.d/default.conf && nginx -g 'daemon off;'"
