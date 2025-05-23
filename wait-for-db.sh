#!/bin/bash
set -e

echo "⏳ Esperando a que PostgreSQL esté disponible en $MOODLE_DATABASE_HOST:$MOODLE_DATABASE_PORT_NUMBER..."

until PGPASSWORD=$MOODLE_DATABASE_PASSWORD psql -h "$MOODLE_DATABASE_HOST" -U "$MOODLE_DATABASE_USER" -d "$MOODLE_DATABASE_NAME" -c '\q' > /dev/null 2>&1; do
  echo "❌ Aún no disponible - esperando..."
  sleep 5
done

echo "✅ Base de datos disponible, iniciando Moodle..."
exec /opt/bitnami/scripts/moodle/entrypoint.sh /opt/bitnami/scripts/moodle/run.sh
