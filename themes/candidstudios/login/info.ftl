<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false displayInfo=true; section>
    <#if section = "header">
        <#if messageHeader??>
            ${messageHeader}
        <#else>
            ${message.summary}
        </#if>
    <#elseif section = "form">
        <#-- Only auto-redirect when there are NO required actions remaining -->
        <#assign shouldRedirectToDashboard = false>
        <#if !requiredActions?? || (requiredActions?size == 0)>
            <#-- No required actions, check if we should redirect -->
            <#assign shouldRedirectToDashboard = true>
            <#-- Only skip auto-redirect if going to a known Candid Studios app (not admin) -->
            <#if pageRedirectUri?has_content && (pageRedirectUri?contains("candidstudios.net") && !pageRedirectUri?contains("admin.candidstudios.net"))>
                <#assign shouldRedirectToDashboard = false>
            <#elseif client?? && client.baseUrl?has_content && (client.baseUrl?contains("candidstudios.net") && !client.baseUrl?contains("admin.candidstudios.net"))>
                <#assign shouldRedirectToDashboard = false>
            </#if>
        </#if>

        <#if shouldRedirectToDashboard>
            <script>
                // Send notification webhook for account setup completion
                (function() {
                    try {
                        // Get user info stored during password setup
                        var userInfo = {};
                        try {
                            var stored = sessionStorage.getItem('keycloak_setup_user');
                            if (stored) {
                                userInfo = JSON.parse(stored);
                                sessionStorage.removeItem('keycloak_setup_user');
                            }
                        } catch(e) {}

                        var payload = {
                            type: 'ACCOUNT_SETUP_COMPLETE',
                            timestamp: new Date().toISOString(),
                            source: 'keycloak-info-page',
                            username: userInfo.username || '',
                            email: userInfo.email || '',
                            firstName: userInfo.firstName || '',
                            lastName: userInfo.lastName || ''
                        };

                        // Use sendBeacon for reliable delivery even during page navigation
                        if (navigator.sendBeacon) {
                            navigator.sendBeacon(
                                'https://n8n.candidstudios.net/webhook/keycloak-account-setup',
                                JSON.stringify(payload)
                            );
                        } else {
                            // Fallback to fetch
                            fetch('https://n8n.candidstudios.net/webhook/keycloak-account-setup', {
                                method: 'POST',
                                headers: { 'Content-Type': 'application/json' },
                                body: JSON.stringify(payload),
                                keepalive: true
                            }).catch(function() {});
                        }
                    } catch(e) {}
                })();

                // Auto-redirect to Keycloak login with dashboard as redirect target
                // This lets users log in with their new password
                setTimeout(function() {
                    window.location.href = 'https://admin.candidstudios.net/realms/master/protocol/openid-connect/auth?client_id=candid-dash&redirect_uri=https%3A%2F%2Flogin.candidstudios.net&response_type=code&scope=openid';
                }, 1000);
            </script>
            <p style="color: rgba(255, 255, 255, 0.8); font-size: 16px; text-align: center; margin-bottom: 20px;">
                Redirecting to login...
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
        <#-- Check if there are still required actions to complete -->
        <#if requiredActions?? && (requiredActions?size > 0) && actionUri?has_content>
            <#-- Still have required actions, use actionUri to proceed -->
            <a href="${actionUri}" style="display: block !important; width: 100% !important; background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%) !important; border: none !important; border-radius: 10px !important; color: #ffffff !important; padding: 14px 24px !important; font-size: 16px !important; font-weight: 500 !important; text-align: center !important; text-decoration: none !important; box-sizing: border-box !important;">Continue</a>
        <#else>
            <#-- No more required actions, redirect to login page with dashboard as target -->
            <a href="https://admin.candidstudios.net/realms/master/protocol/openid-connect/auth?client_id=candid-dash&redirect_uri=https%3A%2F%2Flogin.candidstudios.net&response_type=code&scope=openid" style="display: block !important; width: 100% !important; background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%) !important; border: none !important; border-radius: 10px !important; color: #ffffff !important; padding: 14px 24px !important; font-size: 16px !important; font-weight: 500 !important; text-align: center !important; text-decoration: none !important; box-sizing: border-box !important;">Continue to Login</a>
        </#if>
    </#if>
</@layout.registrationLayout>
