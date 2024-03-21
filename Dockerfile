FROM postgres:latest

# Instalar pgAgent
RUN apt-get update \
    && apt-get install -y --no-install-recommends \
       pgagent \
    && apt-get clean \
    && rm -rf /var/lib/apt/lists/*

# Exponer el puerto de PostgreSQL
EXPOSE 5432

# Configurar pgAgent para que se ejecute
RUN pg_createcluster 13 main --start

# Copiar el script de inicialización de pgAgent
COPY init_pgagent.sh /docker-entrypoint-initdb.d/init_pgagent.sh

# Dar permisos de ejecución al script
RUN chmod +x /docker-entrypoint-initdb.d/init_pgagent.sh
