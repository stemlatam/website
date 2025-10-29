# Usa una imagen base de Nginx muy ligera.
FROM nginx:stable-alpine

# Copia tu archivo HTML a la ubicación donde Nginx sirve contenido.
# CRÍTICO: Asegurarse de que index.html esté en la raíz del proyecto local.
COPY index.html /usr/share/nginx/html/index.html

# Copia el archivo de configuración de Nginx.
COPY nginx.conf.template /etc/nginx/conf.d/default.conf

# EXPONE el puerto 8080, que es el que Cloud Run espera por convención.
# Cloud Run se encargará de mapear este puerto al exterior.
EXPOSE 80

# El comando de inicio de Nginx.
CMD ["nginx", "-g", "daemon off;"]