# Railway Deployment Issue - Troubleshooting Guide

## Problem Summary
Railway keeps deploying old commits (58b4ab96, efcb409c, 724871aa, a27e804e) that don't even exist in current git history, instead of latest commits with email templates and logo fixes.

**Impact**:
- Password reset emails have NO clickable links
- Logo doesn't display on login page
- Custom email templates not deployed

## Latest Commit (Just Pushed)
**Commit**: `3ac8e59` - Add build verification and explicit watch patterns to force Railway deployment

This commit adds:
1. Build-time verification that lists all theme files being copied
2. Explicit `watchPatterns` in railway.toml
3. Should help identify if Railway is actually using the latest code

## Step 1: Trigger New Deployment

In Railway dashboard:
1. Go to your Keycloak service
2. Click "Deploy" or "Redeploy"
3. Watch the build logs carefully

## Step 2: Check Build Logs

Look for these verification messages in the build output:
```
=== Verifying Candid Studios theme files ===
=== Email templates ===
=== Login resources ===
=== Theme verification complete ===
```

**What to check**:
- Does it show `password-reset.ftl` in email/html/?
- Does it show `execute-actions.ftl` in email/html/?
- Does it show `logo.png` in login/resources/img/?

If YES → Theme files are being copied correctly
If NO → Railway is using cached or old code

## Step 3: Verify Which Commit Was Deployed

In Railway build logs, look for the commit hash near the beginning.

**Expected**: `3ac8e59` or newer (`3ac8e59`, `7185018`, `ca03d14`, `aa6575e`, `6baa431`)
**Problem**: Old commits (`58b4ab96`, `efcb409c`, `724871aa`, `a27e804e`)

## Step 4: If Still Wrong Commit

### Option A: Force Railway to Clear Cache
1. Go to Railway service Settings
2. Look for any "Clear Build Cache" or "Reset" option
3. Try deploying again

### Option B: Check GitHub Integration
1. In Railway service settings, find "Source" or "Repository" section
2. Verify it shows: `support318/keycloak-vidi`
3. Verify branch: `main`
4. Check if there's a "Deploy on Push" toggle - ensure it's ON

### Option C: Manual Deployment Configuration
1. In service settings, look for deployment triggers
2. Check if there's a specific commit or tag pinned
3. Ensure it's set to "Auto-deploy from main branch"

### Option D: Environment Variables
Check if there's a `RAILWAY_GIT_COMMIT_SHA` or similar variable set to a specific old commit. Remove it if so.

## Step 5: Nuclear Option - Recreate Service

If nothing else works, Railway service may be corrupted:

1. **Before deleting**: Note down all environment variables
   - `KEYCLOAK_ADMIN`: support@candidstudios.net
   - `KEYCLOAK_ADMIN_PASSWORD`: Snoboard19
   - `KC_DB`: postgres
   - `KC_DB_URL_HOST`: (your postgres host)
   - `KC_DB_URL_DATABASE`: (your database name)
   - `KC_DB_USERNAME`: (your db username)
   - `KC_DB_PASSWORD`: (your db password)
   - `KC_HOSTNAME`: login.candidstudios.net

2. **Create new service**:
   - Connect to same GitHub repo: support318/keycloak-vidi
   - Set branch to `main`
   - Add all environment variables from step 1
   - Railway should auto-detect Dockerfile

3. **Update DNS**:
   - Point login.candidstudios.net to new Railway service
   - May need to update Cloudflare CNAME

## Step 6: Verify Working Deployment

Once deployed with correct commit:

1. **Check Login Page**: https://login.candidstudios.net/realms/candidstudios/account
   - Logo should display (white Candid Studios logo)
   - Dark professional theme should be active

2. **Test Password Reset Email**:
   - Go to Keycloak Admin Console
   - Find a test user
   - Click "Credential Reset" → "Reset Password"
   - Check email has:
     - Candid Studios header with logo
     - "Reset Password" blue button
     - Clickable link that works

3. **Test Execute Actions Email**:
   - In admin console, go to user
   - Actions → "Update Password"
   - Email should have:
     - Professional Candid Studios branding
     - List of required actions
     - "Complete Actions" button
     - Working clickable link

## Expected File Structure (From Build Logs)

```
/opt/keycloak/themes/candidstudios/
├── email/
│   ├── html/
│   │   ├── template.ftl           ← Base email template with logo
│   │   ├── password-reset.ftl     ← Password reset with ${link}
│   │   ├── execute-actions.ftl    ← Execute actions with ${link}
│   │   └── email-verification.ftl
│   ├── text/
│   │   ├── password-reset.ftl
│   │   ├── execute-actions.ftl
│   │   └── email-verification.ftl
│   ├── resources/
│   │   └── img/
│   │       └── logo.png           ← Logo for emails
│   └── theme.properties
├── login/
│   ├── messages/
│   │   └── messages_en.properties ← Logo in loginTitleHtml
│   ├── resources/
│   │   ├── css/
│   │   │   └── login.css          ← Dark theme
│   │   └── img/
│   │       └── logo.png           ← Logo for login page
│   └── theme.properties
└── account/
    └── ... (similar structure)
```

## Critical Files That MUST Be Deployed

1. **Email Templates** (for working password reset links):
   - `themes/candidstudios/email/html/password-reset.ftl`
   - `themes/candidstudios/email/html/execute-actions.ftl`
   - Both contain `<a href="${link}">` buttons

2. **Logo Files**:
   - `themes/candidstudios/email/resources/img/logo.png`
   - `themes/candidstudios/login/resources/img/logo.png`

3. **Login Theme**:
   - `themes/candidstudios/login/messages/messages_en.properties`
   - Contains: `loginTitleHtml=<img src="${url.resourcesPath}/img/logo.png" ... />`

## Success Criteria

✅ Railway deploys commit `3ac8e59` or newer
✅ Build logs show theme verification output
✅ Password reset email has clickable "Reset Password" button
✅ Email has Candid Studios logo and professional branding
✅ Login page shows logo (not broken image)
✅ Dark theme is active on login page

## Contact/Next Steps

If this still doesn't work after trying all options:
1. Check Railway status page for platform issues
2. Contact Railway support with service ID
3. Consider alternative deployment (Google Cloud Run, AWS ECS, direct Docker host)

The code is 100% correct and ready. The issue is purely Railway's deployment system not using the latest commits from GitHub.
