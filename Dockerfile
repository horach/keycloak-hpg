FROM quay.io/keycloak/keycloak:22.0.5 # Usa la versión más reciente disponible

# Cambia al modo de distribución Quarkus
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configurar Keycloak para usar la base de datos externa
ENV KC_DB=postgres
ENV KC_HOSTNAME=${RAILWAY_PUBLIC_DOMAIN}

WORKDIR /opt/keycloak

# Configura Keycloak para iniciar en modo demo (puedes cambiarlo para producción)
RUN ./bin/kc.sh build

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]
