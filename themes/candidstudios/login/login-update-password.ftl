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
                    <button type="button" class="password-toggle" onclick="togglePasswordNew()" aria-label="Toggle password visibility">
                        <svg id="eye-icon-new" class="icon-eye" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                            <circle cx="12" cy="12" r="3"></circle>
                        </svg>
                        <svg id="eye-off-icon-new" class="icon-eye-off" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="display: none;">
                            <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
                            <line x1="1" y1="1" x2="23" y2="23"></line>
                        </svg>
                    </button>
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
                    <button type="button" class="password-toggle" onclick="togglePasswordConfirm()" aria-label="Toggle password visibility">
                        <svg id="eye-icon-confirm" class="icon-eye" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                            <circle cx="12" cy="12" r="3"></circle>
                        </svg>
                        <svg id="eye-off-icon-confirm" class="icon-eye-off" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round" style="display: none;">
                            <path d="M17.94 17.94A10.07 10.07 0 0 1 12 20c-7 0-11-8-11-8a18.45 18.45 0 0 1 5.06-5.94M9.9 4.24A9.12 9.12 0 0 1 12 4c7 0 11 8 11 8a18.5 18.5 0 0 1-2.16 3.19m-6.72-1.07a3 3 0 1 1-4.24-4.24"></path>
                            <line x1="1" y1="1" x2="23" y2="23"></line>
                        </svg>
                    </button>
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

        <script>
            // Store user info for webhook notification after setup completion
            (function() {
                try {
                    var userInfo = {
                        <#if user?? && user.username??>username: '${user.username?js_string}',</#if>
                        <#if user?? && user.email??>email: '${user.email?js_string}',</#if>
                        <#if user?? && user.firstName??>firstName: '${user.firstName?js_string}',</#if>
                        <#if user?? && user.lastName??>lastName: '${user.lastName?js_string}'</#if>
                    };
                    sessionStorage.setItem('keycloak_setup_user', JSON.stringify(userInfo));
                } catch(e) {}
            })();

            function togglePasswordNew() {
                const passwordInput = document.getElementById('password-new');
                const eyeIcon = document.getElementById('eye-icon-new');
                const eyeOffIcon = document.getElementById('eye-off-icon-new');

                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    eyeIcon.style.display = 'none';
                    eyeOffIcon.style.display = 'block';
                } else {
                    passwordInput.type = 'password';
                    eyeIcon.style.display = 'block';
                    eyeOffIcon.style.display = 'none';
                }
            }

            function togglePasswordConfirm() {
                const passwordInput = document.getElementById('password-confirm');
                const eyeIcon = document.getElementById('eye-icon-confirm');
                const eyeOffIcon = document.getElementById('eye-off-icon-confirm');

                if (passwordInput.type === 'password') {
                    passwordInput.type = 'text';
                    eyeIcon.style.display = 'none';
                    eyeOffIcon.style.display = 'block';
                } else {
                    passwordInput.type = 'password';
                    eyeIcon.style.display = 'block';
                    eyeOffIcon.style.display = 'none';
                }
            }

        </script>
    </#if>
</@layout.registrationLayout>
