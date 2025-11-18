#!/bin/bash
echo "Waiting 30 seconds for deployment..."
sleep 30

echo "Getting access token..."
TOKEN=$(curl -s -X POST "https://login.candidstudios.net/realms/master/protocol/openid-connect/token" \
  -H "Content-Type: application/x-www-form-urlencoded" \
  -d "username=vidiman" \
  -d "password=2468VidiSmart." \
  -d "grant_type=password" \
  -d "client_id=admin-cli" | grep -o '"access_token":"[^"]*' | cut -d'"' -f4)

echo "Creating admin user (support@candidstudios.net)..."
curl -X POST "https://login.candidstudios.net/admin/realms/cc/users" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"username":"admin","email":"support@candidstudios.net","emailVerified":true,"enabled":true,"credentials":[{"type":"password","value":"Snoboard19","temporary":false}]}'

echo ""
echo "Creating photographer user (ryanmayiras@gmail.com)..."
curl -X POST "https://login.candidstudios.net/admin/realms/cc/users" \
  -H "Authorization: Bearer $TOKEN" \
  -H "Content-Type: application/json" \
  -d '{"username":"photographer","email":"ryanmayiras@gmail.com","emailVerified":true,"enabled":true,"credentials":[{"type":"password","value":"Snoboard19","temporary":false}]}'

echo ""
echo "Done! Users created with password: Snoboard19"
