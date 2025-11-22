<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('username','password') displayInfo=realm.password && realm.registrationAllowed && !registrationDisabled??; section>
    <#if section = "header">
        ${msg("loginAccountTitle")}
    <#elseif section = "form">
        <div id="kc-form">
            <div id="kc-form-wrapper">
                <#if realm.password>
                    <form id="kc-form-login" onsubmit="login.disabled = true; return true;" action="${url.loginAction}" method="post">
                        <div class="form-group">
                            <label for="username">${msg("usernameOrEmail")}</label>
                            <input tabindex="1" id="username" name="username" value="${(login.username!'')}" type="text" autofocus autocomplete="off" />
                        </div>

                        <div class="form-group">
                            <label for="password">${msg("password")}</label>
                            <input tabindex="2" id="password" name="password" type="password" autocomplete="off" />
                        </div>

                        <div class="form-group" style="display: flex; justify-content: space-between; align-items: center;">
                            <#if realm.rememberMe && !usernameEditDisabled??>
                                <div style="display: flex; align-items: center; gap: 8px;">
                                    <input tabindex="3" id="rememberMe" name="rememberMe" type="checkbox" style="margin: 0; width: 16px; height: 16px;" <#if login.rememberMe??>checked</#if>>
                                    <label for="rememberMe" style="cursor: pointer; margin: 0; color: rgba(255,255,255,0.7); font-size: 14px;">${msg("rememberMe")}</label>
                                </div>
                            <#else>
                                <div></div>
                            </#if>
                            <#if realm.resetPasswordAllowed>
                                <a tabindex="5" href="${url.loginResetCredentialsUrl}" style="font-size: 14px; color: #4a90e2;">${msg("doForgotPassword")}</a>
                            </#if>
                        </div>

                        <div id="kc-form-buttons">
                            <input type="hidden" id="id-hidden-input" name="credentialId" <#if auth.selectedCredential?has_content>value="${auth.selectedCredential}"</#if>/>
                            <input tabindex="4" name="login" id="kc-login" type="submit" value="${msg("doLogIn")}"/>
                        </div>
                    </form>
                </#if>
            </div>
        </div>
    <#elseif section = "info">
        <#if realm.password && realm.registrationAllowed && !registrationDisabled??>
            <span>${msg("noAccount")} <a tabindex="6" href="${url.registrationUrl}">${msg("doRegister")}</a></span>
        </#if>
    </#if>
</@layout.registrationLayout>
