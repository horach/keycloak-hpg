# Fase de construcción
FROM quay.io/keycloak/keycloak:latest as builder

# Habilitar soporte de health y métricas
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true

# Configurar un proveedor de base de datos
ENV KC_DB=postgres

WORKDIR /opt/keycloak
# Construir Keycloak
RUN /opt/keycloak/bin/kc.sh build

# Fase final
FROM quay.io/keycloak/keycloak:latest
COPY --from=builder /opt/keycloak/ /opt/keycloak/

# Configuración de base de datos (reemplaza con los valores adecuados)
ENV KC_DB=postgres
#ENV KC_DB_URL=<DBURL>
#ENV KC_DB_USERNAME=<DBUSERNAME>
#ENV KC_DB_PASSWORD=<DBPASSWORD>
#ENV KC_HOSTNAME=localhost

# Deshabilitar HTTPS (solo para desarrollo)
ENV KC_HTTP_ENABLED=true

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start-dev"]
