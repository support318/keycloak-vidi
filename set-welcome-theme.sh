#!/bin/bash

KEYCLOAK_URL="https://login.candidstudios.net"
ADMIN_USER="vidiman"
ADMIN_PASSWORD="2468VidiSmart."

echo "Getting admin access token..."
RESPONSE=$(curl -s -X POST "${KEYCLOAK_URL}/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=${ADMIN_USER}" \
  -d "password=${ADMIN_PASSWORD}" \
  -d "grant_type=password" \
  -d "client_id=admin-cli")

TOKEN=$(echo $RESPONSE | grep -o '"access_token":"[^"]*' | cut -d'"' -f4)

if [ -z "$TOKEN" ]; then
  echo "ERROR: Failed to get access token"
  exit 1
fi

echo "Setting welcome theme to 'cc' for master realm..."
curl -s -X PUT "${KEYCLOAK_URL}/admin/realms/master" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{"welcomeTheme":"cc"}'

echo ""
echo "Done! Welcome theme set to 'cc'"
echo "Now login.candidstudios.net will redirect to /realms/cc/account/"
