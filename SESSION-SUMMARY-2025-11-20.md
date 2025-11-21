# Keycloak SSO Session Summary - November 20, 2025

## Current State: Keycloak Crashing on Startup

**Last Error**: "Application failed to respond" - Keycloak cannot connect to the new PostgreSQL database.

**Likely Issue**: The database hostname `postgres.railway.internal` is incorrect. Need to find the actual hostname of the new Postgres service.

---

## What We've Done This Session

### 1. Railway Deployment Issues (Resolved)
- Railway was deploying old commits that didn't exist in git history
- Fixed by recreating the Keycloak service from scratch
- Verified build logs show correct theme files deployed

### 2. Custom Domain Issues (Partially Resolved)
- `login.candidstudios.net` wasn't routing correctly
- Temporarily using Railway domain: `keycloak-vidi-production.up.railway.app`
- Cloudflare DNS set to CNAME pointing to Railway domain
- KC_HOSTNAME set to Railway domain for now

### 3. Admin Login Issues (Current Problem)
- `KEYCLOAK_ADMIN` and `KEYCLOAK_ADMIN_PASSWORD` env vars only work on FIRST startup with empty database
- Original database had existing data, so admin user wasn't created
- Tried custom entrypoint script to reset password - didn't run (Railway might override ENTRYPOINT)
- Tried changing schema to `keycloak_fresh` - schema didn't exist, Keycloak crashed
- Created a NEW PostgreSQL database in Railway for fresh start
- Updated Keycloak variables to point to new database
- **CURRENT CRASH**: Keycloak can't connect to new database - hostname might be wrong

---

## Current Railway Configuration

### keycloak-vidi Service Variables (as of last update):
```
KC_DB=postgres
KC_DB_URL=jdbc:postgresql://postgres.railway.internal:5432/railway  <-- MIGHT BE WRONG HOSTNAME
KC_DB_USERNAME=postgres
KC_DB_PASSWORD=WrhscjQnfJTZDxzLmgOMuybocgzOhNPR
KC_HEALTH_ENABLED=true
KC_HOSTNAME=keycloak-vidi-production.up.railway.app
KC_HOSTNAME_STRICT=false
KC_HTTP_ENABLED=true
KC_LOG_LEVEL=info
KC_METRICS_ENABLED=true
KC_PROXY=edge
KC_PROXY_HEADERS=xforwarded
KEYCLOAK_ADMIN=support@candidstudios.net
KEYCLOAK_ADMIN_PASSWORD=Snoboard19
```

### New PostgreSQL Database Variables:
```
POSTGRES_USER=postgres
POSTGRES_PASSWORD=WrhscjQnfJTZDxzLmgOMuybocgzOhNPR
POSTGRES_DB=railway
PGPORT=5432
```

**NOTE**: Need to find the actual internal hostname for the new Postgres service. The service name in Railway determines the hostname (e.g., if named "Postgres", hostname is `postgres.railway.internal`).

---

## Files Modified This Session

### /mnt/c/code/candid-studios-platform/services/keycloak/Dockerfile
- Added build verification that outputs theme files during build
- Added custom entrypoint script (but Railway might not be using it)
- Current entrypoint: `/opt/keycloak/entrypoint.sh`

### /mnt/c/code/candid-studios-platform/services/keycloak/entrypoint.sh
- Created to auto-reset admin password on startup
- Script runs Keycloak in background, waits, then uses kcadm.sh to set admin password
- **NOT WORKING** - Railway appears to override the ENTRYPOINT

### /mnt/c/code/candid-studios-platform/services/keycloak/railway.toml
```toml
[build]
builder = "DOCKERFILE"
dockerfilePath = "Dockerfile"
watchPatterns = ["themes/**", "Dockerfile", "railway.toml"]

[deploy]
startCommand = "/opt/keycloak/bin/kc.sh start --optimized"
restartPolicyType = "ON_FAILURE"
restartPolicyMaxRetries = 10
```

**NOTE**: The `startCommand` in railway.toml might be overriding the Dockerfile ENTRYPOINT!

---

## Theme Files Status (Verified Deployed)

All theme files are correctly deployed in `/opt/keycloak/themes/candidstudios/`:

### Email Templates (with working ${link} variables):
- `email/html/password-reset.ftl` - Has `<a href="${link}">Reset Password</a>` button
- `email/html/execute-actions.ftl` - Has `<a href="${link}">Complete Actions</a>` button
- `email/html/email-verification.ftl` - Has verification link
- `email/html/template.ftl` - Base template with Candid Studios branding

### Login Theme:
- `login/resources/css/login.css` - Dark theme styling
- `login/resources/img/logo.png` - Candid Studios logo (233KB)
- `login/messages/messages_en.properties` - Contains loginTitleHtml with logo

### Logo Files:
- `login/resources/img/logo.png`
- `email/resources/img/logo.png`
- `account/resources/img/logo.png`
- `admin/resources/img/logo.png`

---

## Next Steps to Fix

### Immediate Fix Needed:
1. Find the actual hostname for the new PostgreSQL database in Railway
   - Go to new Postgres service → Settings → look for "Private Domain" or service name
   - Or check the deployment logs for connection error showing what hostname was tried

2. Update `KC_DB_URL` with correct hostname:
   - If service named "Postgres": `jdbc:postgresql://postgres.railway.internal:5432/railway`
   - If service named "PostgreSQL": `jdbc:postgresql://postgresql.railway.internal:5432/railway`
   - If different name: `jdbc:postgresql://[servicename].railway.internal:5432/railway`

3. Redeploy and test login with:
   - Username: `support@candidstudios.net`
   - Password: `Snoboard19`

### After Login Works:
1. Go to Keycloak Admin Console → Realm Settings → Themes tab
2. Set Email theme to `candidstudios`
3. Set Login theme to `candidstudios`
4. Save

### Test Email Templates:
1. Create a test user or use existing
2. Send password reset email
3. Verify email has:
   - Candid Studios logo
   - Blue "Reset Password" button
   - Working clickable link

### Fix Custom Domain (Later):
1. Update KC_HOSTNAME back to `login.candidstudios.net`
2. Configure Railway custom domain properly
3. Update Cloudflare DNS if needed

---

## Railway Project Structure

```
CandidCloud (Railway Project)
├── keycloak-vidi (login.candidstudios.net) - CRASHING
├── Postgres (NEW - for Keycloak) - 9 minutes ago
├── Candid.Cloud.PostgreSQL (OLD - has other app data)
├── candid-dash (dash.candidstudios.net)
├── nextcloud-vidi (vidiblast.net)
├── pimcore
├── opencloud-rolling
├── redis (sleeping)
└── candid.cloud.drive (failed)
```

---

## GitHub Repository

- **Repo**: https://github.com/support318/keycloak-vidi
- **Branch**: main
- **Latest Commit**: `ed1a343` - Fix entrypoint.sh permissions issue

---

## Key Credentials (for reference)

### Keycloak Admin (once working):
- URL: https://keycloak-vidi-production.up.railway.app/admin/candidstudios/console
- Username: support@candidstudios.net
- Password: Snoboard19

### New PostgreSQL Database:
- User: postgres
- Password: WrhscjQnfJTZDxzLmgOMuybocgzOhNPR
- Database: railway
- Port: 5432
- Host: **NEEDS TO BE DETERMINED**

---

## User Goals (from original request)

1. Single sign-on portal at dash.candidstudios.net
2. Auto-redirect users with single app access directly to that app
3. Professional branded emails that don't go to spam
4. Password reset emails must have working clickable links
5. Login page must show Candid Studios logo
6. Support for photographers, videographers, editors, vendors, clients, referrers

---

## Resume Instructions

When continuing this session:

1. Find the correct PostgreSQL hostname in Railway
2. Update KC_DB_URL in keycloak-vidi variables
3. Redeploy Keycloak
4. Test login with support@candidstudios.net / Snoboard19
5. Configure email/login themes in Keycloak admin
6. Test password reset email functionality
7. Fix custom domain (login.candidstudios.net)
