<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false displayInfo=true; section>
    <#if section = "header">
        <#if messageHeader??>
            ${messageHeader}
        <#else>
            ${message.summary}
        </#if>
    <#elseif section = "form">
        <#-- Always auto-redirect to dashboard - never leave users on Keycloak -->
        <#assign shouldRedirectToDashboard = true>
        <#-- Only skip auto-redirect if going to a known Candid Studios app -->
        <#if pageRedirectUri?has_content && (pageRedirectUri?contains("candidstudios.net") && !pageRedirectUri?contains("admin.candidstudios.net"))>
            <#assign shouldRedirectToDashboard = false>
        <#elseif client?? && client.baseUrl?has_content && (client.baseUrl?contains("candidstudios.net") && !client.baseUrl?contains("admin.candidstudios.net"))>
            <#assign shouldRedirectToDashboard = false>
        </#if>

        <#if shouldRedirectToDashboard>
            <script>
                // Auto-redirect to dashboard after 1 second
                setTimeout(function() {
                    window.location.href = 'https://login.candidstudios.net';
                }, 1000);
            </script>
            <p style="color: rgba(255, 255, 255, 0.8); font-size: 16px; text-align: center; margin-bottom: 20px;">
                Redirecting to dashboard...
            </p>
        </#if>
        <div class="info-content">
            <#if requiredActions??>
                <p style="color: rgba(255, 255, 255, 0.8); font-size: 16px; margin-bottom: 20px;">
                    Please complete the following to set up your user profile:
                </p>
                <ul style="color: rgba(255, 255, 255, 0.9); margin-bottom: 30px; padding-left: 20px;">
                    <#list requiredActions as reqActionItem>
                        <li style="margin-bottom: 8px;">
                            <#if reqActionItem == "UPDATE_PASSWORD">
                                Create your password
                            <#elseif reqActionItem == "UPDATE_PROFILE">
                                Update your profile
                            <#elseif reqActionItem == "VERIFY_EMAIL">
                                Verify your email
                            <#elseif reqActionItem == "CONFIGURE_TOTP">
                                Set up two-factor authentication
                            <#else>
                                ${msg("requiredAction.${reqActionItem}")}
                            </#if>
                        </li>
                    </#list>
                </ul>
            <#else>
                <p style="color: rgba(255, 255, 255, 0.8); font-size: 16px; margin-bottom: 20px;">
                    ${message.summary}
                </p>
            </#if>
        </div>
    <#elseif section = "info">
        <#-- Determine the best redirect URL - always prefer dashboard over admin -->
        <#assign buttonUrl = "https://login.candidstudios.net">
        <#if pageRedirectUri?has_content && pageRedirectUri?contains("candidstudios.net") && !pageRedirectUri?contains("admin.candidstudios.net")>
            <#assign buttonUrl = pageRedirectUri>
        <#elseif client?? && client.baseUrl?has_content && client.baseUrl?contains("candidstudios.net") && !client.baseUrl?contains("admin.candidstudios.net")>
            <#assign buttonUrl = client.baseUrl>
        </#if>
        <a href="${buttonUrl}" style="display: block !important; width: 100% !important; background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%) !important; border: none !important; border-radius: 10px !important; color: #ffffff !important; padding: 14px 24px !important; font-size: 16px !important; font-weight: 500 !important; text-align: center !important; text-decoration: none !important; box-sizing: border-box !important;">Continue to Dashboard</a>
    </#if>
</@layout.registrationLayout>
