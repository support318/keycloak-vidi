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

echo "Creating roles in cc realm..."

# Create admin role
echo "Creating 'admin' role..."
curl -s -X POST "${KEYCLOAK_URL}/admin/realms/${REALM}/roles" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{"name":"admin","description":"Administrator with full access"}'

# Create photographer role
echo "Creating 'photographer' role..."
curl -s -X POST "${KEYCLOAK_URL}/admin/realms/${REALM}/roles" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{"name":"photographer","description":"Photographer who can upload and manage photos"}'

# Create client role
echo "Creating 'client' role..."
curl -s -X POST "${KEYCLOAK_URL}/admin/realms/${REALM}/roles" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d '{"name":"client","description":"Client who can view their photos"}'

echo ""
echo "Getting user IDs..."

# Get support@candidstudios.net user ID
ADMIN_USER_RESPONSE=$(curl -s -X GET "${KEYCLOAK_URL}/admin/realms/${REALM}/users?email=support@candidstudios.net" \
  -H "Authorization: Bearer ${TOKEN}")
ADMIN_USER_ID=$(echo $ADMIN_USER_RESPONSE | grep -o '"id":"[^"]*' | head -1 | cut -d'"' -f4)

# Get ryanmayiras@gmail.com user ID
PHOTOG_USER_RESPONSE=$(curl -s -X GET "${KEYCLOAK_URL}/admin/realms/${REALM}/users?email=ryanmayiras@gmail.com" \
  -H "Authorization: Bearer ${TOKEN}")
PHOTOG_USER_ID=$(echo $PHOTOG_USER_RESPONSE | grep -o '"id":"[^"]*' | head -1 | cut -d'"' -f4)

echo "Admin user ID: $ADMIN_USER_ID"
echo "Photographer user ID: $PHOTOG_USER_ID"

# Get role IDs
ADMIN_ROLE_RESPONSE=$(curl -s -X GET "${KEYCLOAK_URL}/admin/realms/${REALM}/roles/admin" \
  -H "Authorization: Bearer ${TOKEN}")
ADMIN_ROLE_ID=$(echo $ADMIN_ROLE_RESPONSE | grep -o '"id":"[^"]*' | head -1 | cut -d'"' -f4)

PHOTOG_ROLE_RESPONSE=$(curl -s -X GET "${KEYCLOAK_URL}/admin/realms/${REALM}/roles/photographer" \
  -H "Authorization: Bearer ${TOKEN}")
PHOTOG_ROLE_ID=$(echo $PHOTOG_ROLE_RESPONSE | grep -o '"id":"[^"]*' | head -1 | cut -d'"' -f4)

echo ""
echo "Assigning admin role to support@candidstudios.net..."
curl -s -X POST "${KEYCLOAK_URL}/admin/realms/${REALM}/users/${ADMIN_USER_ID}/role-mappings/realm" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d "[{\"id\":\"${ADMIN_ROLE_ID}\",\"name\":\"admin\"}]"

echo "Assigning photographer role to ryanmayiras@gmail.com..."
curl -s -X POST "${KEYCLOAK_URL}/admin/realms/${REALM}/users/${PHOTOG_USER_ID}/role-mappings/realm" \
  -H "Authorization: Bearer ${TOKEN}" \
  -H "Content-Type: application/json" \
  -d "[{\"id\":\"${PHOTOG_ROLE_ID}\",\"name\":\"photographer\"}]"

echo ""
echo "Done! Roles created and assigned:"
echo "- support@candidstudios.net → admin role"
echo "- ryanmayiras@gmail.com → photographer role"
