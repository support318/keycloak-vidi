# Keycloak Custom Branding - Deployment Instructions

## Status

All theme files are ready and the Keycloak realm is configured to use the `candidstudios` theme. However, Railway CLI deployment keeps failing due to file encoding issues.

## What's Ready

✅ Custom theme created in `themes/candidstudios/`
✅ Candid Studios logo (white script)
✅ Custom dark theme CSS
✅ Dockerfile configured to copy theme files
✅ Realm `cc` configured to use candidstudios theme

## The Problem

The `railway up` command keeps corrupting the Dockerfile during upload, causing build failures.

## Solution: Deploy via Railway Dashboard + GitHub

### Step 1: Create/Use GitHub Repository

You need to push this code to GitHub so Railway can pull from there instead of uploading directly.

Do you have a GitHub account and repository for this project?

### Step 2: Push Code to GitHub

If you have a GitHub repo:

```bash
cd /mnt/c/code/candid-studios-platform
git init  # if not already a git repo
git add services/keycloak/
git commit -m "Add Keycloak custom branding"
git remote add origin https://github.com/YOUR-USERNAME/YOUR-REPO.git
git push -u origin main
```

### Step 3: Connect Railway to GitHub

1. Go to https://railway.app
2. Navigate to: candid-cloud → production → keycloak
3. Click on "Settings"
4. Under "Source", click "Connect to GitHub Repository"
5. Select your repository
6. Set root directory to: `/services/keycloak` (if using monorepo)
7. Railway will automatically detect the Dockerfile and deploy

## Alternative: Manual Deployment

If you can't use GitHub, you can manually update the Dockerfile in Railway:

1. Go to Railway dashboard
2. Find your Keycloak service
3. Go to "Variables" or "Settings"
4. Look for an option to edit the Dockerfile directly
5. Copy/paste the clean Dockerfile content

## The Dockerfile

```dockerfile
FROM quay.io/keycloak/keycloak:26.0.7

COPY themes/candidstudios /opt/keycloak/themes/candidstudios

ENV KC_DB=postgres
ENV KC_HEALTH_ENABLED=true
ENV KC_METRICS_ENABLED=true
ENV KC_HTTP_ENABLED=true
ENV KC_HOSTNAME_STRICT=false
ENV KC_HOSTNAME_STRICT_HTTPS=false
ENV KC_PROXY=edge

RUN /opt/keycloak/bin/kc.sh build

ENTRYPOINT ["/opt/keycloak/bin/kc.sh", "start", "--optimized"]
```

## After Successful Deployment

Visit: https://login.candidstudios.net/realms/cc/account

You should see the Candid Studios logo instead of the Keycloak logo!

## Files Location

- Theme files: `/mnt/c/code/candid-studios-platform/services/keycloak/themes/candidstudios/`
- Dockerfile: `/mnt/c/code/candid-studios-platform/services/keycloak/Dockerfile`
- Logo: 650x400px white PNG (in all theme subdirectories)

## Need Help?

The Railway CLI `railway up` command has file encoding issues. Using GitHub integration is the most reliable deployment method for Railway.
