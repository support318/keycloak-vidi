#!/bin/bash
set -e

echo "=== Keycloak Custom Entrypoint ==="
echo "Starting Keycloak with bootstrap admin..."

# Use Keycloak's built-in bootstrap admin feature
export KC_BOOTSTRAP_ADMIN_USERNAME="${KEYCLOAK_ADMIN:-admin}"
export KC_BOOTSTRAP_ADMIN_PASSWORD="${KEYCLOAK_ADMIN_PASSWORD:-admin}"

echo "Bootstrap admin username: ${KC_BOOTSTRAP_ADMIN_USERNAME}"
echo "Starting Keycloak..."

# Start Keycloak with the bootstrap admin variables
exec /opt/keycloak/bin/kc.sh start --optimized
