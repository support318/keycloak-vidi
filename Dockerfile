FROM quay.io/keycloak/keycloak:26.4.5

# Copy Candid Studios custom theme
COPY themes/candidstudios /opt/keycloak/themes/candidstudios

# Verify theme files are copied (helps debug Railway deployments)
RUN echo "=== BUILD TIMESTAMP: $(date) ===" && \
    echo "=== Verifying Candid Studios theme files ===" && \
    ls -R /opt/keycloak/themes/candidstudios && \
    echo "=== Email templates ===" && \
    ls -la /opt/keycloak/themes/candidstudios/email/html/ && \
    echo "=== Checking for password-reset.ftl ===" && \
    cat /opt/keycloak/themes/candidstudios/email/html/password-reset.ftl | grep -A2 "href=" && \
    echo "=== Login resources ===" && \
    ls -la /opt/keycloak/themes/candidstudios/login/resources/img/ && \
    echo "=== Theme verification complete ==="

ENV KC_DB=postgres
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_HTTP_ENABLED=true
ENV KC_HOSTNAME_STRICT=false
ENV KC_HOSTNAME_STRICT_HTTPS=false
ENV KC_PROXY=edge

RUN /opt/keycloak/bin/kc.sh build

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]
