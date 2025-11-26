FROM quay.io/keycloak/keycloak:26.4.5

# Cache buster - change this value to force rebuild
ARG CACHE_BUST=2025-11-26-v21-minimal-admin-intercept

# Copy Candid Studios custom theme
COPY themes/candidstudios /opt/keycloak/themes/candidstudios

# Verify theme files are copied (helps debug Railway deployments)
RUN echo "=== BUILD TIMESTAMP: $(date) ===" && \
    echo "=== CACHE_BUST: ${CACHE_BUST} ===" && \
    echo "=== Verifying Candid Studios theme files ===" && \
    ls -R /opt/keycloak/themes/candidstudios && \
    echo "=== Email templates ===" && \
    ls -la /opt/keycloak/themes/candidstudios/email/html/ && \
    echo "=== Login resources ===" && \
    ls -la /opt/keycloak/themes/candidstudios/login/resources/img/ && \
    echo "=== Template.ftl content check (looking for legal-footer) ===" && \
    grep -c "legal-footer" /opt/keycloak/themes/candidstudios/login/template.ftl && \
    grep -c "social-providers" /opt/keycloak/themes/candidstudios/login/login.ftl && \
    echo "=== Theme verification complete ==="

ENV KC_DB=postgres
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_HTTP_ENABLED=true
ENV KC_HOSTNAME_STRICT=false
ENV KC_HOSTNAME_STRICT_HTTPS=false
ENV KC_PROXY=edge

RUN /opt/keycloak/bin/kc.sh build

# Copy custom entrypoint script to reset admin password on startup (with execute permissions)
COPY --chmod=755 entrypoint.sh /opt/keycloak/entrypoint.sh

ENTRYPOINT ["/opt/keycloak/entrypoint.sh"]
