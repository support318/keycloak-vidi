<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=false; section>
    <#if section = "header">
        <#if messageHeader??>
            ${messageHeader}
        <#else>
            ${message.summary}
        </#if>
    <#elseif section = "form">
        <div class="info-message">
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

        <#if skipLink??>
        <#else>
            <#if pageRedirectUri?has_content>
                <div style="text-align: center; margin-top: 30px;">
                    <a href="${pageRedirectUri}" class="link-btn">Continue</a>
                </div>
            <#elseif actionUri?has_content>
                <div style="text-align: center; margin-top: 30px;">
                    <a href="${actionUri}" class="link-btn">Continue</a>
                </div>
            <#elseif (client.baseUrl)?has_content>
                <div style="text-align: center; margin-top: 30px;">
                    <a href="${client.baseUrl}" class="link-btn">Continue</a>
                </div>
            <#else>
                <div style="text-align: center; margin-top: 30px;">
                    <a href="${url.loginUrl}" class="link-btn">Continue to Login</a>
                </div>
            </#if>
        </#if>
    </#if>
</@layout.registrationLayout>
