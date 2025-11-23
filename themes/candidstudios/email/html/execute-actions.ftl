<#import "template.ftl" as layout>
<@layout.emailLayout>
  <h2 style="color: #333333; font-size: 24px; margin-bottom: 20px;">Welcome to Candid Studios!</h2>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    Hi<#if user.firstName?has_content> ${user.firstName}</#if>,
  </p>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    Your Candid Studios account has been created. To get started, please click the button below to set up your password and complete your account setup.
  </p>

  <div style="text-align: center; margin: 30px 0;">
    <a href="${link}" style="background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%); color: #ffffff; padding: 16px 40px; text-decoration: none; border-radius: 8px; font-size: 16px; font-weight: 600; display: inline-block;">
      Set Up My Account
    </a>
  </div>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    This link will expire in ${linkExpiration} ${linkExpirationFormatter(linkExpiration)}.
  </p>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    If you didn't request this account or have any questions, please contact us at <a href="mailto:support@candidstudios.net" style="color: #4a90e2; text-decoration: none;">support@candidstudios.net</a>.
  </p>

  <p style="color: #888888; font-size: 14px; line-height: 1.6; margin-top: 30px; padding-top: 20px; border-top: 1px solid #e0e0e0;">
    Or copy and paste this URL into your browser:<br>
    <a href="${link}" style="color: #4a90e2; word-break: break-all; font-size: 13px;">${link}</a>
  </p>
</@layout.emailLayout>
