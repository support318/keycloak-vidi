# Candid Studios - Keycloak Email Templates

All email templates use a consistent design with:
- Candid Studios logo header (dark background)
- "PHOTOGRAPHY & VIDEOGRAPHY" tagline
- Blue gradient CTA buttons
- Footer with website link and mailto:support@candidstudios.net

---

## 1. Welcome / Account Setup Email (`execute-actions.ftl`)

**Triggered when:** Admin creates a user and sends "Credential Reset" → "Update Password"

### Role-Based Messaging:

| Role | Subject/Header | Message |
|------|----------------|---------|
| **photographer** | "Welcome to the Candid Studios Team!" | You've been added as a **Photographer** on the Candid Studios team. Once you set up your account, you'll be able to access your assignments, schedules, and project details. |
| **photographer-videographer** | "Welcome to the Candid Studios Team!" | You've been added as a **Photographer & Videographer** on the Candid Studios team. Once you set up your account, you'll be able to access your assignments, schedules, and project details. |
| **photo-editor** | "Welcome to the Candid Studios Team!" | You've been added as a **Photo Editor** on the Candid Studios team. Once you set up your account, you'll be able to access projects ready for editing and upload your completed work. |
| **video-editor** | "Welcome to the Candid Studios Team!" | You've been added as a **Video Editor** on the Candid Studios team. Once you set up your account, you'll be able to access video projects and upload your completed edits. |
| **photo-video-editor** | "Welcome to the Candid Studios Team!" | You've been added as a **Photo & Video Editor** on the Candid Studios team. Once you set up your account, you'll be able to access all editing projects. |
| **client** | "Welcome to Candid Studios!" | Your client portal account has been created. Once you set up your account, you'll be able to view your galleries, download photos, and manage your projects. |
| **vendor** | "Welcome to Candid Studios!" | Your vendor partner account has been created. Once you set up your account, you'll be able to access shared projects and collaborate with our team. |
| **affiliate** | "Welcome to the Candid Studios Referral Program!" | Your affiliate account has been created. Once you set up your account, you'll be able to access your referral dashboard, track your earnings, and manage your payouts. |
| **admin** | "Welcome to Candid Studios Admin!" | Your administrator account has been created. Once you set up your account, you'll have full access to manage users, projects, and system settings. |
| **(no role/default)** | "Welcome to Candid Studios!" | Your Candid Studios account has been created. |

### Email Content:
```
Hi {firstName},

{Role-specific message} To get started, please click the button below to set up your password.

[Set Up My Account] (button)

This link will expire in {X} minutes/hours.

If you didn't request this account or have any questions, please contact us at support@candidstudios.net.
```

---

## 2. Email Verification (`email-verification.ftl`)

**Triggered when:** User needs to verify their email address

### Email Content:
```
Verify Your Email Address

Welcome to Candid Studios!

To complete your account setup, please verify your email address by clicking the button below:

[Verify Email Address] (button)

This link will expire in {X} minutes/hours.

If you didn't create an account with Candid Studios, you can safely ignore this email.
```

---

## 3. Password Reset (`password-reset.ftl`)

**Triggered when:** User clicks "Forgot Password" on login page

### Email Content:
```
Reset Your Password

Hello,

We received a request to reset your password for your Candid Studios account.
Click the button below to create a new password:

[Reset Password] (button)

This link will expire in {X} minutes/hours.

If you didn't request a password reset, you can safely ignore this email.
```

---

## Email Footer (all emails)

```
─────────────────────────────────────

Candid Studios
Professional Photography & Videography Services

Visit Our Website | Contact Support (mailto:support@candidstudios.net)

© 2025 Candid Studios. All rights reserved.
You're receiving this email because you have an account with Candid Studios.

─────────────────────────────────────

Please do not reply to this email. For support, email us at support@candidstudios.net.
```

---

## File Locations

All templates are located in:
```
/services/keycloak/themes/candidstudios/email/html/
├── template.ftl          # Base template with header/footer
├── execute-actions.ftl   # Welcome/account setup email
├── email-verification.ftl # Email verification
└── password-reset.ftl    # Password reset
```

---

## How to Send Emails

### Welcome Email (New User Setup):
1. Create user in Keycloak Admin
2. Assign appropriate role (Role mapping tab)
3. Go to Credentials tab → Credential Reset
4. Select "Update Password"
5. Click "Send email"

### Email Verification:
1. Enable in Realm settings → Login → "Verify email" = ON
2. Create user with "Email verified" = OFF
3. User will be prompted to verify on first login

### Password Reset:
1. User clicks "Forgot Password?" on login page
2. Enters their email
3. Receives password reset email automatically
