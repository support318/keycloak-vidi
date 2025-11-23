<#import "template.ftl" as layout>
<#-- Determine user role for personalized messaging -->
<#assign userRole = "member">
<#assign roleMessage = "Your Candid Studios account has been created.">
<#assign roleWelcome = "Welcome to Candid Studios!">

<#if user.realmRoleMappings??>
  <#list user.realmRoleMappings as role>
    <#if role.name == "photographer">
      <#assign userRole = "photographer">
      <#assign roleWelcome = "Welcome to the Candid Studios Team!">
      <#assign roleMessage = "You've been added as a <strong>Photographer</strong> on the Candid Studios team. Once you set up your account, you'll be able to access your assignments, schedules, and project details.">
    <#elseif role.name == "photographer-videographer">
      <#assign userRole = "photographer-videographer">
      <#assign roleWelcome = "Welcome to the Candid Studios Team!">
      <#assign roleMessage = "You've been added as a <strong>Photographer & Videographer</strong> on the Candid Studios team. Once you set up your account, you'll be able to access your assignments, schedules, and project details.">
    <#elseif role.name == "photo-editor">
      <#assign userRole = "photo-editor">
      <#assign roleWelcome = "Welcome to the Candid Studios Team!">
      <#assign roleMessage = "You've been added as a <strong>Photo Editor</strong> on the Candid Studios team. Once you set up your account, you'll be able to access projects ready for editing and upload your completed work.">
    <#elseif role.name == "video-editor">
      <#assign userRole = "video-editor">
      <#assign roleWelcome = "Welcome to the Candid Studios Team!">
      <#assign roleMessage = "You've been added as a <strong>Video Editor</strong> on the Candid Studios team. Once you set up your account, you'll be able to access video projects and upload your completed edits.">
    <#elseif role.name == "photo-video-editor">
      <#assign userRole = "photo-video-editor">
      <#assign roleWelcome = "Welcome to the Candid Studios Team!">
      <#assign roleMessage = "You've been added as a <strong>Photo & Video Editor</strong> on the Candid Studios team. Once you set up your account, you'll be able to access all editing projects.">
    <#elseif role.name == "client">
      <#assign userRole = "client">
      <#assign roleWelcome = "Welcome to Candid Studios!">
      <#assign roleMessage = "Your client portal account has been created. Once you set up your account, you'll be able to view your galleries, download photos, and manage your projects.">
    <#elseif role.name == "vendor">
      <#assign userRole = "vendor">
      <#assign roleWelcome = "Welcome to Candid Studios!">
      <#assign roleMessage = "Your vendor partner account has been created. Once you set up your account, you'll be able to access shared projects and collaborate with our team.">
    <#elseif role.name == "affiliate">
      <#assign userRole = "affiliate">
      <#assign roleWelcome = "Welcome to the Candid Studios Referral Program!">
      <#assign roleMessage = "Your affiliate account has been created. Once you set up your account, you'll be able to access your referral dashboard, track your earnings, and manage your payouts.">
    <#elseif role.name == "admin">
      <#assign userRole = "admin">
      <#assign roleWelcome = "Welcome to Candid Studios Admin!">
      <#assign roleMessage = "Your administrator account has been created. Once you set up your account, you'll have full access to manage users, projects, and system settings.">
    </#if>
  </#list>
</#if>

<@layout.emailLayout>
  <h2 style="color: #333333; font-size: 24px; margin-bottom: 20px;">${roleWelcome}</h2>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    Hi<#if user.firstName?has_content> ${user.firstName}</#if>,
  </p>

  <p style="color: #555555; font-size: 16px; line-height: 1.6; margin-bottom: 20px;">
    ${roleMessage?no_esc} To get started, please click the button below to set up your password.
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
