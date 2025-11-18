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
echo "=================================="

# All role definitions with descriptions
declare -A ROLES
ROLES["vendor"]="Vendor who provides services"
ROLES["photographer"]="Photographer who captures photos"
ROLES["photographer-videographer"]="Photographer and videographer"
ROLES["referrer"]="Referrer in the referral program"
ROLES["affiliate"]="Affiliate partner"
ROLES["client"]="Client who receives services"
ROLES["photo-editor"]="Photo editor"
ROLES["video-editor"]="Video editor"
ROLES["photo-video-editor"]="Photo and video editor"
ROLES["admin"]="Administrator with full access"

# Create each role
for role in "${!ROLES[@]}"; do
  description="${ROLES[$role]}"
  echo "Creating role: $role"

  curl -s -X POST "${KEYCLOAK_URL}/admin/realms/${REALM}/roles" \
    -H "Authorization: Bearer ${TOKEN}" \
    -H "Content-Type: application/json" \
    -d "{\"name\":\"${role}\",\"description\":\"${description}\"}" \
    > /dev/null 2>&1

  # Check if role was created or already exists
  if [ $? -eq 0 ]; then
    echo "  ✓ Role '${role}' created or already exists"
  else
    echo "  ⚠ Warning: Could not create role '${role}' (may already exist)"
  fi
done

echo ""
echo "=================================="
echo "Role setup complete!"
echo ""
echo "Available roles in realm 'cc':"
echo "  - admin (full access to all admin apps)"
echo "  - referrer (access to referral portal)"
echo "  - affiliate (access to referral portal)"
echo "  - vendor (access to banking/settings)"
echo "  - photographer (access to banking/settings)"
echo "  - photographer-videographer (access to banking/settings)"
echo "  - client (access to banking/settings)"
echo "  - photo-editor (access to banking/settings)"
echo "  - video-editor (access to banking/settings)"
echo "  - photo-video-editor (access to banking/settings)"
echo ""
echo "Note: Assign these roles to users in the Keycloak admin console"
echo "URL: https://login.candidstudios.net/admin/master/console/#/cc/users"
