<#import "template.ftl" as layout>
<@layout.emailLayout>
  <h2 style="color: #333333; font-size: 24px; margin-bottom: 20px;">Verify Your Email Address</h2>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    Welcome to Candid Studios!
  </p>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    To complete your profile setup, please verify your email address by clicking the button below:
  </p>

  <div style="text-align: center; margin: 30px 0;">
    <a href="${link}" style="background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%); color: #ffffff; padding: 14px 32px; text-decoration: none; border-radius: 8px; font-size: 16px; font-weight: 600; display: inline-block;">
      Verify Email Address
    </a>
  </div>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    This link will expire in ${linkExpirationFormatter(linkExpiration)}.
  </p>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 0;">
    If you didn't create a profile with Candid Studios, you can safely ignore this email.
  </p>
</@layout.emailLayout>
