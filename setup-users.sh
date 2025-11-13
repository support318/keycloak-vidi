#!/bin/bash

# Keycloak setup script for creating users
# This script creates admin and photographer users in the candidstudios realm

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
  echo "Response: $RESPONSE"
  exit 1
fi

echo "Access token obtained successfully"

# Create admin user with support@candidstudios.net
echo "Creating admin user: support@candidstudios.net..."
curl -s -X POST "${KEYCLOAK_URL}/admin/realms/${REALM}/users" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "admin",
    "email": "support@candidstudios.net",
    "emailVerified": true,
    "enabled": true,
    "credentials": [{
      "type": "password",
      "value": "Snoboard19",
      "temporary": false
    }]
  }'

echo "Admin user created"

# Create photographer user with ryanmayiras@gmail.com
echo "Creating photographer user: ryanmayiras@gmail.com..."
curl -s -X POST "${KEYCLOAK_URL}/admin/realms/${REALM}/users" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{
    "username": "photographer",
    "email": "ryanmayiras@gmail.com",
    "emailVerified": true,
    "enabled": true,
    "credentials": [{
      "type": "password",
      "value": "Snoboard19",
      "temporary": false
    }]
  }'

echo "Photographer user created"
echo ""
echo "Users created successfully!"
echo "Admin: support@candidstudios.net / Snoboard19"
echo "Photographer: ryanmayiras@gmail.com / Snoboard19"
