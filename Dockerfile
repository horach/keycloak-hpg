FROM quay.io/keycloak/keycloak:latest as builder

# Enable health and metrics support
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configure a database vendor
ENV KC_DB=postgres

# Para desarrollo, habilitar el modo dev (desactivar algunas optimizaciones)
ENV KEYCLOAK_DEV=true

# No ejecutar el proceso de migración en la base de datos (porque el esquema ya está creado)
ENV KEYCLOAK_DB_MIGRATION=false

# El punto de entrada de Keycloak en modo dev
ENTRYPOINT ["/opt/keycloak/bin/kc.sh"]

# Ejecutar Keycloak con el comando 'start' en modo dev
CMD ["start-dev", "--http-port", "8080"]
