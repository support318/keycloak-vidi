<#import "template.ftl" as layout>
<@layout.emailLayout>
  <h2 style="color: #333333; font-size: 24px; margin-bottom: 20px;">Action Required for Your Account</h2>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    Hello,
  </p>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    Your administrator has requested that you perform the following action(s) on your Candid Studios account:
  </p>

  <div style="background-color: #f9f9f9; border-left: 4px solid #4a90e2; padding: 15px; margin: 20px 0;">
    <ul style="margin: 0; padding-left: 20px; color: #333333;">
      <#list requiredActions as action>
        <li style="margin: 5px 0;">${action}</li>
      </#list>
    </ul>
  </div>

  <div style="text-align: center; margin: 30px 0;">
    <a href="${link}" style="background-color: #4a90e2; color: #ffffff; padding: 14px 32px; text-decoration: none; border-radius: 6px; font-size: 16px; font-weight: 600; display: inline-block;">
      Complete Actions
    </a>
  </div>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    This link will expire in ${linkExpiration} ${linkExpirationFormatter(linkExpiration)}.
  </p>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    If you have any questions, please contact your administrator or our support team.
  </p>

  <p style="color: #555555; font-size: 14px; line-height: 1.6; margin-top: 30px; padding-top: 20px; border-top: 1px solid #e0e0e0;">
    Or copy and paste this URL into your browser:<br>
    <a href="${link}" style="color: #4a90e2; word-break: break-all;">${link}</a>
  </p>
</@layout.emailLayout>
