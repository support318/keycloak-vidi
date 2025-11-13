FROM quay.io/keycloak/keycloak:26.0.7

# Copy custom theme
COPY themes/candidstudios /opt/keycloak/themes/candidstudios

# Set environment defaults
ENV KC_DB=postgres
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_HTTP_ENABLED=true
ENV KC_HOSTNAME_STRICT=false
ENV KC_HOSTNAME_STRICT_HTTPS=false
ENV KC_PROXY=edge

# Build optimized Keycloak
RUN /opt/keycloak/bin/kc.sh build

# Run Keycloak
ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]
