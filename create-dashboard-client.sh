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

echo "Creating dashboard client in cc realm..."
curl -s -X POST "${KEYCLOAK_URL}/admin/realms/${REALM}/clients" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "clientId": "candid-dashboard",
    "name": "Candid Studios Dashboard",
    "description": "Main dashboard application for Candid Studios",
    "enabled": true,
    "publicClient": true,
    "standardFlowEnabled": true,
    "implicitFlowEnabled": false,
    "directAccessGrantsEnabled": false,
    "protocol": "openid-connect",
    "redirectUris": [
      "https://dash.candidstudios.net/*",
      "http://localhost:3000/*"
    ],
    "webOrigins": [
      "https://dash.candidstudios.net",
      "http://localhost:3000"
    ],
    "attributes": {
      "pkce.code.challenge.method": "S256"
    }
  }'

echo ""
echo "Done! Dashboard client created"
echo ""
echo "Client ID: candid-dashboard"
echo "Redirect URIs:"
echo "  - https://dash.candidstudios.net/*"
echo "  - http://localhost:3000/* (for local development)"
echo ""
echo "Login URL: https://login.candidstudios.net/realms/cc/protocol/openid-connect/auth?client_id=candid-dashboard&redirect_uri=https://dash.candidstudios.net/&response_type=code&scope=openid"
