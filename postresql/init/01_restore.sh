#!/bin/bash
set -e

echo ">>> Buscando archivo de backup..."
BACKUP=$(ls /docker-entrypoint-initdb.d/*.sql 2>/dev/null | head -1)

if [ -z "$BACKUP" ]; then
    echo ">>> No se encontro archivo .sql"
    exit 0
fi

echo ">>> Creando bases de datos..."

# Extraer nombres de bases del backup y crearlas
grep "^\\\\connect" "$BACKUP" | awk '{print $2}' | while read BASE; do
    echo ">>> Creando base: $BASE"
    psql -U "$POSTGRES_USER" -d postgres \
        --set ON_ERROR_STOP=0 \
        -c "CREATE DATABASE \"$BASE\";" 2>/dev/null || true
done

echo ">>> Restaurando backup: $BACKUP"
psql -U "$POSTGRES_USER" -d postgres \
    --set ON_ERROR_STOP=0 \
    -f "$BACKUP"

echo ">>> Restauracion completada."
ENDOFSCRIPT

chmod +x ./init/01_restore.sh