<#import "template.ftl" as layout>
<@layout.registrationLayout displayMessage=!messagesPerField.existsError('password','password-confirm'); section>
    <#if section = "header">
        Create Your Password
    <#elseif section = "form">
        <style>
            .password-toggle-btn {
                position: absolute !important;
                right: 12px !important;
                top: 50% !important;
                transform: translateY(-50%) !important;
                background: none !important;
                background-image: none !important;
                border: none !important;
                cursor: pointer !important;
                padding: 4px !important;
                margin: 0 !important;
                width: auto !important;
                height: auto !important;
                display: flex !important;
                align-items: center !important;
                justify-content: center !important;
                box-shadow: none !important;
                z-index: 10;
            }
            .password-toggle-btn:hover {
                background: none !important;
                box-shadow: none !important;
                transform: translateY(-50%) !important;
            }
            .password-toggle-btn svg {
                width: 20px;
                height: 20px;
                color: rgba(255, 255, 255, 0.5);
                transition: color 0.2s;
            }
            .password-toggle-btn:hover svg {
                color: rgba(255, 255, 255, 0.8);
            }
            .input-wrapper {
                position: relative;
            }
            .input-wrapper input[type="password"],
            .input-wrapper input[type="text"] {
                padding-right: 44px !important;
            }
        </style>
        <form id="kc-passwd-update-form" action="${url.loginAction}" method="post">
            <div class="form-group">
                <label for="password-new">New Password</label>
                <div class="input-wrapper">
                    <svg class="input-icon icon-lock" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                        <rect x="3" y="11" width="18" height="11" rx="2" ry="2"></rect>
                        <path d="M7 11V7a5 5 0 0 1 10 0v4"></path>
                    </svg>
                    <input type="password" id="password-new" name="password-new" autofocus autocomplete="new-password" placeholder="Enter new password" />
                    <button type="button" class="password-toggle-btn" onclick="togglePassword('password-new', this)" aria-label="Show password">
                        <svg class="eye-open" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                            <circle cx="12" cy="12" r="3"></circle>
                        </svg>
                        <svg class="eye-closed" style="display:none" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
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
                    <button type="button" class="password-toggle-btn" onclick="togglePassword('password-confirm', this)" aria-label="Show password">
                        <svg class="eye-open" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
                            <path d="M1 12s4-8 11-8 11 8 11 8-4 8-11 8-11-8-11-8z"></path>
                            <circle cx="12" cy="12" r="3"></circle>
                        </svg>
                        <svg class="eye-closed" style="display:none" viewBox="0 0 24 24" fill="none" stroke="currentColor" stroke-width="2" stroke-linecap="round" stroke-linejoin="round">
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
            function togglePassword(inputId, button) {
                const input = document.getElementById(inputId);
                const eyeOpen = button.querySelector('.eye-open');
                const eyeClosed = button.querySelector('.eye-closed');

                if (input.type === 'password') {
                    input.type = 'text';
                    eyeOpen.style.display = 'none';
                    eyeClosed.style.display = 'block';
                    button.setAttribute('aria-label', 'Hide password');
                } else {
                    input.type = 'password';
                    eyeOpen.style.display = 'block';
                    eyeClosed.style.display = 'none';
                    button.setAttribute('aria-label', 'Show password');
                }
            }
        </script>
    </#if>
</@layout.registrationLayout>
