# Deploy Keycloak with Custom Theme

## From WSL Terminal (Ubuntu)

Railway CLI is installed in WSL, so you need to run from there:

### Step 1: Open WSL
- Open Windows Terminal
- Select "Ubuntu" or "WSL"
- OR in PowerShell, type: `wsl`

### Step 2: Navigate to directory
```bash
cd /mnt/c/code/candid-studios-platform/services/keycloak
```

### Step 3: Link to Railway
```bash
railway link
```

When prompted, select:
1. Workspace: **Candid Projects** (or candid-cloud)
2. Project: **production**
3. Environment: **production**
4. Service: **keycloak**

### Step 4: Deploy
```bash
railway up
```

This will:
- Upload your Dockerfile and theme files
- Build the Docker image with Candid Studios logo
- Deploy to https://login.candidstudios.net

### Step 5: Verify (after 2-5 minutes)
Visit: https://login.candidstudios.net/realms/cc/account

You should see your Candid Studios logo! 🎉

---

## Alternative: Use Railway Dashboard

If the CLI doesn't work:

1. Go to https://railway.app
2. Find: candid-cloud → production → keycloak service
3. Go to Settings → Deploy Trigger
4. Click "Deploy Now" or "Redeploy"

But you'll need to connect the service to a GitHub repo first, or the theme files won't be included.

---

## Files Ready for Deployment

✅ Dockerfile updated with theme copy
✅ Theme files in: `themes/candidstudios/`
✅ Logo: Candid Studios white script (650x400px)
✅ Realm configured to use `candidstudios` theme
✅ Custom dark theme CSS

Ready to deploy!
