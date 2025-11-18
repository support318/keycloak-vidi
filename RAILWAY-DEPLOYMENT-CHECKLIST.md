# Railway Deployment Checklist for Keycloak

## What We Just Updated
- ✅ Renamed theme from `cc` to `candidstudios`
- ✅ Added branded email templates (HTML + plain text)
- ✅ Fixed Dockerfile to copy correct theme folder

## Deploy to Railway

### Step 1: Trigger Deployment
Go to Railway dashboard and deploy the Keycloak service:
- **Project**: keycloak-vidi (or similar)
- **Service**: Keycloak
- **Branch**: main

### Step 2: Verify Environment Variables
Check that these are configured in Railway:

**Required:**
- `KEYCLOAK_ADMIN` = admin username (e.g., `support@candidstudios.net`)
- `KEYCLOAK_ADMIN_PASSWORD` = your admin password
- `KC_DB` = `postgres`
- `KC_DB_URL` = Railway PostgreSQL connection string
- `KC_HOSTNAME` = `login.candidstudios.net`
- `KC_PROXY` = `edge`

**Optional (if not configured via admin console):**
- Email configuration is typically done via Keycloak Admin Console, not env vars

### Step 3: Wait for Build to Complete
- Railway will build the Docker image with the new theme
- Watch the build logs for any errors
- Deployment typically takes 3-5 minutes

### Step 4: Verify Theme is Deployed
Once deployed, check:
```
https://login.candidstudios.net/realms/candidstudios/account
```
You should see the Candid Studios branded theme.

## After Deployment

### Enable the Theme in Realm
Run this command locally to activate the theme:
```bash
cd /mnt/c/code/candid-studios-platform
KEYCLOAK_CLIENT_SECRET=gatngbo2GHVTcicCz029YqdavRfVPXzK \
npx tsx scripts/configure-realm-theme.ts
```

This will set:
- Login theme: `candidstudios`
- Account theme: `candidstudios`
- Admin theme: `candidstudios`
- Email theme: `candidstudios`

### Verify Email Configuration
1. Go to Keycloak Admin Console: https://login.candidstudios.net/admin/candidstudios/console
2. Navigate to: **Realm Settings** → **Email** tab
3. Verify these settings:
   - **From**: `noreply@candidstudios.net` (or your verified email)
   - **From Display Name**: `Candid Studios`
   - **Host**: `smtp.resend.com`
   - **Port**: `587`
   - **Username**: `resend`
   - **Password**: Your Resend API key (re_xxxxx)
   - **Enable StartTLS**: ON
   - **Enable Authentication**: ON

4. Click **Test connection** to verify email works

## DNS Configuration (Cloudflare)

After email is configured, set up these DNS records for better deliverability:

### SPF Record
Type: `TXT`
Name: `@`
Value: `v=spf1 include:_spf.resend.com ~all`

### DKIM Records
Get these from Resend dashboard → Domain Settings → DNS Records
Type: `TXT`
Name: `resend._domainkey` (or as shown in Resend)
Value: (provided by Resend)

### DMARC Record
Type: `TXT`
Name: `_dmarc`
Value: `v=DMARC1; p=none; rua=mailto:dmarc@candidstudios.net`

## Testing Checklist

After deployment:
- [ ] Visit https://login.candidstudios.net
- [ ] Login page shows Candid Studios branding
- [ ] Go to https://dash.candidstudios.net
- [ ] Login redirects to Keycloak
- [ ] After login, dashboard shows apps based on role
- [ ] Test password reset email (sends and looks good)
- [ ] Test email verification (sends and looks good)
- [ ] Test all 10 role types

## Troubleshooting

### Theme not showing
- Clear browser cache
- Check Railway logs for theme copy errors
- Verify Dockerfile copied theme correctly

### Email not sending
- Check SMTP credentials in Admin Console
- Test connection in Email settings tab
- Check Resend dashboard for errors
- Verify domain is verified in Resend

### Domain verification
- Make sure DNS records are added in Cloudflare
- DNS propagation can take up to 48 hours (usually much faster)
