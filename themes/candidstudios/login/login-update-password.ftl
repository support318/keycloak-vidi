<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
    <#if section = "header">
        Create Your Password
    <#elseif section = "form">
        <form id="kc-passwd-update-form" action="${url.loginAction}" method="post">
            <div class="form-group">
                <label for="password-new">New Password</label>
                <div class="input-wrapper">
                    <svg class="input-icon icon-lock" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                        <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                    </svg>
                    <input type="password" id="password-new" name="password-new" autofocus autocomplete="new-password" placeholder="Enter new password" />
                </div>
            </div>

            <div class="form-group">
                <label for="password-confirm">Confirm Password</label>
                <div class="input-wrapper">
                    <svg class="input-icon icon-lock" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                        <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                    </svg>
                    <input type="password" id="password-confirm" name="password-confirm" autocomplete="new-password" placeholder="Confirm new password" />
                </div>
            </div>

            <#if messagesPerField.existsError('password')>
                <div class="alert alert-error" style="margin-bottom: 20px;">
                    ${kcSanitize(messagesPerField.get('password'))?no_esc}
                </div>
            </#if>

            <#if messagesPerField.existsError('password-confirm')>
                <div class="alert alert-error" style="margin-bottom: 20px;">
                    ${kcSanitize(messagesPerField.get('password-confirm'))?no_esc}
                </div>
            </#if>

            <div id="kc-form-buttons">
                <#if isAppInitiatedAction??>
                    <input class="submit-btn" type="submit" value="Save Password" />
                    <button class="submit-btn" type="submit" name="cancel-aia" value="true" style="background: rgba(255,255,255,0.1); margin-top: 10px;">Cancel</button>
                <#else>
                    <input class="submit-btn" type="submit" value="Set Password" />
                </#if>
            </div>
        </form>
    </#if>
</@layout.registrationLayout>
