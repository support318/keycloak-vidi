<#import "template.ftl" as layout>
<@layout.emailLayout>
  <h2 style="color: #333333; font-size: 24px; margin-bottom: 20px;">Reset Your Password</h2>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    Hello,
  </p>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    We received a request to reset the password for your Candid Studios user profile.
    Click the button below to create a new password:
  </p>

  <div style="text-align: center; margin: 30px 0;">
    <a href="${link}" style="background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%); color: #ffffff; padding: 14px 32px; text-decoration: none; border-radius: 8px; font-size: 16px; font-weight: 600; display: inline-block;">
      Reset Password
    </a>
  </div>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    This link will expire in ${linkExpirationFormatter(linkExpiration)}.
  </p>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 0;">
    If you didn't request a password reset, you can safely ignore this email.
  </p>
</@layout.emailLayout>
