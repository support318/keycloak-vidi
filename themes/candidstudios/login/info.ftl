<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false displayInfo=true; section>
    <#if section = "header">
        <#if messageHeader??>
            ${messageHeader}
        <#else>
            ${message.summary}
        </#if>
    <#elseif section = "form">
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
        <#-- Always show a button - use redirect URIs if available, otherwise login -->
        <#if pageRedirectUri?has_content>
            <a href="${pageRedirectUri}" style="display: block !important; width: 100% !important; background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%) !important; border: none !important; border-radius: 10px !important; color: #ffffff !important; padding: 14px 24px !important; font-size: 16px !important; font-weight: 500 !important; text-align: center !important; text-decoration: none !important; box-sizing: border-box !important;">Continue</a>
        <#elseif actionUri?has_content>
            <a href="${actionUri}" style="display: block !important; width: 100% !important; background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%) !important; border: none !important; border-radius: 10px !important; color: #ffffff !important; padding: 14px 24px !important; font-size: 16px !important; font-weight: 500 !important; text-align: center !important; text-decoration: none !important; box-sizing: border-box !important;">Continue</a>
        <#elseif client?? && client.baseUrl?has_content>
            <a href="${client.baseUrl}" style="display: block !important; width: 100% !important; background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%) !important; border: none !important; border-radius: 10px !important; color: #ffffff !important; padding: 14px 24px !important; font-size: 16px !important; font-weight: 500 !important; text-align: center !important; text-decoration: none !important; box-sizing: border-box !important;">Continue</a>
        <#else>
            <a href="https://login.candidstudios.net" style="display: block !important; width: 100% !important; background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%) !important; border: none !important; border-radius: 10px !important; color: #ffffff !important; padding: 14px 24px !important; font-size: 16px !important; font-weight: 500 !important; text-align: center !important; text-decoration: none !important; box-sizing: border-box !important;">Continue to Dashboard</a>
        </#if>
    </#if>
</@layout.registrationLayout>
