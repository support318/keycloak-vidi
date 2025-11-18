#!/bin/bash

KEYCLOAK_URL="https://login.candidstudios.net"
REALM="cc"
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

echo "Getting user ID for support@candidstudios.net..."
USER_RESPONSE=$(curl -s -X GET "${KEYCLOAK_URL}/admin/realms/${REALM}/users?email=support@candidstudios.net" \
  -H "Authorization: Bearer ${TOKEN}")
USER_ID=$(echo $USER_RESPONSE | grep -o '"id":"[^"]*' | head -1 | cut -d'"' -f4)

echo "User ID: $USER_ID"

echo "Resetting password to Snoboard19..."
curl -s -X PUT "${KEYCLOAK_URL}/admin/realms/${REALM}/users/${USER_ID}/reset-password" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{"type":"password","value":"Snoboard19","temporary":false}'

echo ""
echo "Done! Password reset for support@candidstudios.net"
echo "Email: support@candidstudios.net"
echo "Password: Snoboard19"
