#!/bin/bash
set -e

echo "⏳ Esperando a que PostgreSQL esté disponible en $MOODLE_DATABASE_HOST:$MOODLE_DATABASE_PORT_NUMBER..."

until nc -z -v -w30 "$MOODLE_DATABASE_HOST" "$MOODLE_DATABASE_PORT_NUMBER"; do
  echo "❌ Aún no disponible - esperando..."
  sleep 5
done

echo "✅ Base de datos disponible, iniciando Moodle..."
exec /opt/bitnami/scripts/moodle/entrypoint.sh /opt/bitnami/scripts/moodle/run.sh
