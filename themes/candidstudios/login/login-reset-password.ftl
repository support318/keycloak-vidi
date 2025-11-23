<#import "template.ftl" as layout>
<@layout.registrationLayout displayInfo=true displayMessage=!messagesPerField.existsError('username'); section>
    <#if section = "header">
        ${msg("emailForgotTitle")}
    <#elseif section = "form">
        <form id="kc-reset-password-form" action="${url.loginAction}" method="post">
            <div class="form-group">
                <label for="username">${msg("usernameOrEmail")}</label>
                <div class="input-wrapper">
                    <svg class="input-icon icon-user" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <path d="M20 21v-2a4 4 0 0 0-4-4H8a4 4 0 0 0-4 4v2"></path>
                        <circle cx="12" cy="7" r="4"></circle>
                    </svg>
                    <input type="text" id="username" name="username" autofocus value="${(auth.attemptedUsername!'')}" placeholder="Enter your email" />
                </div>
            </div>

            <div class="form-group" style="margin-bottom: 20px;">
                <a href="${url.loginUrl}" class="forgot-password">← Back to Login</a>
            </div>

            <div id="kc-form-buttons">
                <input class="submit-btn" type="submit" value="${msg("doSubmit")}" />
            </div>
        </form>
    <#elseif section = "info">
        <p>${msg("emailInstruction")}</p>
    </#if>
</@layout.registrationLayout>
