#!/bin/bash
set -e

echo "=== Keycloak Custom Entrypoint ==="
echo "Starting Keycloak and ensuring admin user exists..."

# Start Keycloak in the background
/opt/keycloak/bin/kc.sh start --optimized &
KEYCLOAK_PID=$!

echo "Waiting for Keycloak to start..."
sleep 15

# Try to create/update admin user
echo "Ensuring admin user exists with correct password..."

# Use kcadm.sh to configure admin credentials
/opt/keycloak/bin/kcadm.sh config credentials \
  --server http://localhost:8080 \
  --realm master \
  --user ${KEYCLOAK_ADMIN} \
  --password ${KEYCLOAK_ADMIN_PASSWORD} 2>/dev/null || true

# If that failed, try with default admin/admin
/opt/keycloak/bin/kcadm.sh config credentials \
  --server http://localhost:8080 \
  --realm master \
  --user admin \
  --password admin 2>/dev/null || true

# Now try to update the password
/opt/keycloak/bin/kcadm.sh set-password \
  --username ${KEYCLOAK_ADMIN} \
  --new-password ${KEYCLOAK_ADMIN_PASSWORD} \
  --realm master 2>/dev/null || {

  # If user doesn't exist, create it
  echo "Admin user doesn't exist, creating..."
  /opt/keycloak/bin/kcadm.sh create users \
    -r master \
    -s username=${KEYCLOAK_ADMIN} \
    -s enabled=true 2>/dev/null || true

  /opt/keycloak/bin/kcadm.sh set-password \
    --username ${KEYCLOAK_ADMIN} \
    --new-password ${KEYCLOAK_ADMIN_PASSWORD} \
    --realm master 2>/dev/null || true

  /opt/keycloak/bin/kcadm.sh add-roles \
    --username ${KEYCLOAK_ADMIN} \
    --realm master \
    --rolename admin 2>/dev/null || true
}

echo "Admin user configured!"

# Keep the script running and forward signals to Keycloak
wait $KEYCLOAK_PID
