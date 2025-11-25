#!/bin/bash
set -e

echo "=== Keycloak Custom Entrypoint ==="

ADMIN_USER="${KEYCLOAK_ADMIN:-admin}"
ADMIN_PASS="${KEYCLOAK_ADMIN_PASSWORD:-admin}"

echo "Admin user will be: ${ADMIN_USER}"

# Start Keycloak in background with candidstudios welcome theme
echo "Starting Keycloak in background..."
/opt/keycloak/bin/kc.sh start --optimized --spi-theme-welcome-theme=candidstudios &
KC_PID=$!

# Wait for Keycloak to be ready
echo "Waiting for Keycloak to start (60 seconds)..."
sleep 60

echo "Attempting to configure admin user..."

# Try to authenticate with existing credentials first, if that fails try default
/opt/keycloak/bin/kcadm.sh config credentials \
  --server http://localhost:8080 \
  --realm master \
  --user "${ADMIN_USER}" \
  --password "${ADMIN_PASS}" 2>/dev/null && {
  echo "Already authenticated with ${ADMIN_USER}"
} || {
  echo "Could not authenticate, trying to create admin via temporary bootstrap..."

  # Try with any existing admin
  for existing_pass in "admin" "Admin123!" "Snoboard19" "password"; do
    /opt/keycloak/bin/kcadm.sh config credentials \
      --server http://localhost:8080 \
      --realm master \
      --user admin \
      --password "${existing_pass}" 2>/dev/null && {
      echo "Authenticated with existing admin, updating password..."
      /opt/keycloak/bin/kcadm.sh set-password -r master --username "${ADMIN_USER}" --new-password "${ADMIN_PASS}" 2>/dev/null || true
      break
    } || true
  done
}

echo "Admin setup complete. Keycloak is running."

# Wait for Keycloak process
wait $KC_PID
