<#import "template.ftl" as layout>
<@layout.emailLayout>
  <h2 style="color: #333333; font-size: 24px; margin-bottom: 20px;">Welcome to Candid Studios!</h2>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    Hi<#if user?? && user.firstName??> ${user.firstName}<#else>there</#if>,
  </p>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    Your Candid Studios user profile has been created. To get started, please click the button below to set up your password.
  </p>

  <div style="text-align: center; margin: 30px 0;">
    <a href="${link}" style="background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%); color: #ffffff; padding: 16px 40px; text-decoration: none; border-radius: 8px; font-size: 16px; font-weight: 600; display: inline-block;">
      Set Up My Profile
    </a>
  </div>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    This link will expire in ${linkExpirationFormatter(linkExpiration)}.
  </p>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 0;">
    If you didn't request this or have any questions, please contact us at <a href="mailto:support@candidstudios.net" style="color: #4a90e2; text-decoration: none;">support@candidstudios.net</a>.
  </p>
</@layout.emailLayout>
