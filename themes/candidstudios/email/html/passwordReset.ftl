<#import "template.ftl" as layout>
<@layout.emailLayout>
  <h2 style="color: #333333; font-size: 24px; margin-bottom: 20px;">Reset Your Password</h2>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    Hello,
  </p>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    We received a request to reset your password for your Candid Studios account.
    Click the button below to create a new password:
  </p>

  <div style="text-align: center; margin: 30px 0;">
    <a href="${link}" style="background-color: #4a90e2; color: #ffffff; padding: 14px 32px; text-decoration: none; border-radius: 6px; font-size: 16px; font-weight: 600; display: inline-block;">
      Reset Password
    </a>
  </div>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    This link will expire in ${linkExpirationFormatter(linkExpiration)}.
  </p>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    If you didn't request a password reset, you can safely ignore this email.
  </p>

  <p style="color: #555555; font-size: 14px; line-height: 1.6; margin-top: 30px; padding-top: 20px; border-top: 1px solid #e0e0e0;">
    Or copy and paste this URL into your browser:<br>
    <a href="${link}" style="color: #4a90e2; word-break: break-all;">${link}</a>
  </p>
</@layout.emailLayout>
