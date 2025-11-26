<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html<#if realm.internationalizationEnabled> lang="${locale.currentLanguageTag}"</#if>>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <script>
        // Intercept security-admin-console redirects only
        // This catches users who completed password setup from admin console emails
        (function() {
            var search = window.location.search;

            // ONLY intercept if this is explicitly the security-admin-console client
            // This happens when password setup emails are sent from Keycloak admin UI
            if (search.indexOf('client_id=security-admin-console') !== -1) {
                // Redirect to dashboard login instead of admin console
                window.location.replace('https://admin.candidstudios.net/realms/master/protocol/openid-connect/auth?client_id=candid-dash&redirect_uri=https%3A%2F%2Flogin.candidstudios.net&response_type=code&scope=openid');
            }
        })();
    </script>
    <link rel="icon" type="image/png" href="${url.resourcesPath}/img/favicon.png" />
    <#if properties.stylesCommon?has_content>
        <#list properties.stylesCommon?split(' ') as style>
            <link href="${url.resourcesCommonPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <#if properties.styles?has_content>
        <#list properties.styles?split(' ') as style>
            <link href="${url.resourcesPath}/${style}" rel="stylesheet" />
        </#list>
    </#if>
    <style>
        * {
            box-sizing: border-box;
        }
        body {
            background: linear-gradient(135deg, #0f0f1a 0%, #1a1a2e 50%, #16213e 100%);
            min-height: 100vh;
            margin: 0;
            padding: 0;
            font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, sans-serif;
        }
        .login-container {
            display: flex;
            flex-direction: column;
            align-items: center;
            justify-content: center;
            min-height: 100vh;
            padding: 20px;
        }
        .logo-wrapper {
            text-align: center;
            margin-bottom: 40px;
        }
        .logo-wrapper img {
            max-width: 180px;
            height: auto;
        }
        .login-form-wrapper {
            width: 100%;
            max-width: 420px;
            background: rgba(255, 255, 255, 0.05);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border: 1px solid rgba(255, 255, 255, 0.1);
            border-radius: 20px;
            padding: 40px;
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.3);
        }
        .login-form-wrapper h1 {
            color: #ffffff;
            font-size: 24px;
            font-weight: 400;
            text-align: center;
            margin: 0 0 30px 0;
        }
        /* Make all text in the form wrapper readable */
        .login-form-wrapper p,
        .login-form-wrapper span,
        .login-form-wrapper div,
        .login-form-wrapper li,
        .login-form-wrapper td,
        .login-form-wrapper .instruction,
        .login-form-wrapper .kc-feedback-text,
        #kc-info-message,
        #kc-info-message p,
        .kc-social-section p {
            color: rgba(255, 255, 255, 0.9) !important;
        }
        /* Links should be blue */
        .login-form-wrapper a:not(.submit-btn):not(.social-link):not(.btn-primary) {
            color: #4a90e2 !important;
        }
        .login-form-wrapper a:not(.submit-btn):not(.social-link):not(.btn-primary):hover {
            color: #5ba3f5 !important;
            text-decoration: underline;
        }
        .form-group {
            margin-bottom: 20px;
        }
        .form-group label {
            color: rgba(255, 255, 255, 0.9);
            font-size: 14px;
            font-weight: 500;
            display: block;
            margin-bottom: 8px;
        }
        .input-wrapper {
            position: relative;
            display: flex;
            align-items: center;
        }
        .input-icon {
            position: absolute;
            left: 16px;
            color: rgba(255, 255, 255, 0.5);
            pointer-events: none;
        }
        .input-wrapper input {
            width: 100%;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            color: #ffffff;
            padding: 14px 50px 14px 52px;
            font-size: 16px;
            transition: all 0.3s ease;
        }
        .input-wrapper input:focus {
            border-color: rgba(74, 144, 226, 0.6);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 0 20px rgba(74, 144, 226, 0.3);
            outline: none;
        }
        .input-wrapper input::placeholder {
            color: rgba(255, 255, 255, 0.4);
        }
        .password-toggle {
            position: absolute;
            right: 16px;
            background: none;
            border: none;
            color: rgba(255, 255, 255, 0.5);
            cursor: pointer;
            padding: 0;
            display: flex;
            align-items: center;
            justify-content: center;
        }
        .password-toggle:hover {
            color: rgba(255, 255, 255, 0.8);
        }
        .options-row {
            display: flex;
            justify-content: space-between;
            align-items: center;
            margin-bottom: 24px;
        }
        .remember-me {
            display: flex;
            align-items: center;
            gap: 8px;
        }
        .remember-me input[type="checkbox"] {
            width: 18px;
            height: 18px;
            margin: 0;
            cursor: pointer;
            accent-color: #4a90e2;
        }
        .remember-me label {
            color: rgba(255, 255, 255, 0.7);
            font-size: 14px;
            cursor: pointer;
            margin: 0;
        }
        .forgot-password {
            color: #4a90e2;
            font-size: 14px;
            text-decoration: none;
            transition: color 0.3s ease;
        }
        .forgot-password:hover {
            color: #5ba3f5;
            text-decoration: underline;
        }
        .submit-btn {
            width: 100%;
            background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%);
            border: none;
            border-radius: 10px;
            color: #ffffff;
            padding: 14px 24px;
            font-size: 16px;
            font-weight: 500;
            cursor: pointer;
            transition: all 0.3s ease;
        }
        .submit-btn:hover {
            background: linear-gradient(135deg, #5ba3f5 0%, #4a90e2 100%);
            box-shadow: 0 4px 20px rgba(74, 144, 226, 0.4);
            transform: translateY(-2px);
        }
        /* ALL submit buttons must have white text - be specific to avoid input fields */
        input[type="submit"],
        button[type="submit"],
        .pf-c-button.pf-m-primary,
        #kc-form-buttons input[type="submit"],
        #kc-login,
        .btn-primary {
            background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%) !important;
            border: none !important;
            border-radius: 10px !important;
            color: #ffffff !important;
            padding: 14px 24px !important;
            font-size: 16px !important;
            font-weight: 500 !important;
            cursor: pointer !important;
            width: 100% !important;
            margin-top: 10px !important;
        }
        input[type="submit"]:hover,
        button[type="submit"]:hover,
        .pf-c-button.pf-m-primary:hover,
        #kc-login:hover,
        .btn-primary:hover {
            background: linear-gradient(135deg, #5ba3f5 0%, #4a90e2 100%) !important;
            box-shadow: 0 4px 20px rgba(74, 144, 226, 0.4) !important;
            color: #ffffff !important;
        }
        /* Ensure password toggle button doesn't get styled as submit */
        .password-toggle, button.pf-c-button:not([type="submit"]) {
            background: none !important;
            border: none !important;
            padding: 0 !important;
            width: auto !important;
            margin: 0 !important;
        }
        /* Link styled as button */
        a.btn-primary, a.link-btn {
            display: block !important;
            width: 100% !important;
            background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%) !important;
            border: none !important;
            border-radius: 10px !important;
            color: #ffffff !important;
            padding: 14px 24px !important;
            font-size: 16px !important;
            font-weight: 500 !important;
            cursor: pointer !important;
            transition: all 0.3s ease !important;
            text-align: center !important;
            text-decoration: none !important;
        }
        a.btn-primary:hover, a.link-btn:hover {
            background: linear-gradient(135deg, #5ba3f5 0%, #4a90e2 100%) !important;
            box-shadow: 0 4px 20px rgba(74, 144, 226, 0.4) !important;
            transform: translateY(-2px) !important;
            color: #ffffff !important;
        }
        .alert {
            padding: 12px 16px;
            border-radius: 10px;
            margin-bottom: 20px;
            font-size: 14px;
        }
        .alert-error {
            background: rgba(255, 107, 107, 0.15);
            border: 1px solid rgba(255, 107, 107, 0.3);
            color: #ff6b6b;
        }
        .alert-success {
            background: rgba(107, 255, 139, 0.15);
            border: 1px solid rgba(107, 255, 139, 0.3);
            color: #6bff8b;
        }
        .alert-warning {
            background: rgba(255, 193, 7, 0.15);
            border: 1px solid rgba(255, 193, 7, 0.3);
            color: #ffc107;
        }
        .alert-info {
            background: rgba(74, 144, 226, 0.15);
            border: 1px solid rgba(74, 144, 226, 0.3);
            color: #4a90e2;
        }
        /* Footer links styled as buttons */
        .footer-links {
            text-align: center;
            margin-top: 24px;
        }
        .footer-links a {
            display: block !important;
            width: 100% !important;
            background: linear-gradient(135deg, #4a90e2 0%, #357abd 100%) !important;
            border: none !important;
            border-radius: 10px !important;
            color: #ffffff !important;
            padding: 14px 24px !important;
            font-size: 16px !important;
            font-weight: 500 !important;
            text-align: center !important;
            text-decoration: none !important;
            box-sizing: border-box !important;
        }
        .footer-links a:hover {
            background: linear-gradient(135deg, #5ba3f5 0%, #4a90e2 100%) !important;
            box-shadow: 0 4px 20px rgba(74, 144, 226, 0.4) !important;
            transform: translateY(-2px) !important;
            color: #ffffff !important;
        }
        /* SVG Icons */
        .icon-user, .icon-lock, .icon-eye, .icon-eye-off {
            width: 20px;
            height: 20px;
        }
        /* Hide default Keycloak elements and inner panels */
        #kc-header, #kc-header-wrapper {
            display: none !important;
        }
        #kc-form, #kc-form-wrapper, #kc-form-login, #kc-reset-password-form,
        .kc-form-card, .card-pf, #kc-content, #kc-content-wrapper,
        .login-form-wrapper > div, .login-form-wrapper form,
        .login-form-wrapper > div > div {
            background: transparent !important;
            background-color: transparent !important;
            border: none !important;
            box-shadow: none !important;
            padding: 0 !important;
            margin: 0 !important;
            border-radius: 0 !important;
        }
        /* Nuclear option - remove all inner backgrounds */
        .login-form-wrapper * {
            background-image: none !important;
        }
        .login-form-wrapper div:not(.input-wrapper):not(.form-group):not(.options-row):not(.remember-me):not(.footer-links):not(.alert) {
            background: transparent !important;
            border: none !important;
            box-shadow: none !important;
        }
        /* Override any default input styles */
        input[type="text"], input[type="password"], input[type="email"] {
            padding-left: 52px !important;
            background: rgba(255, 255, 255, 0.1) !important;
        }
        /* Fix browser autofill white background */
        input:-webkit-autofill,
        input:-webkit-autofill:hover,
        input:-webkit-autofill:focus,
        input:-webkit-autofill:active {
            -webkit-box-shadow: 0 0 0 50px rgba(30, 30, 50, 1) inset !important;
            -webkit-text-fill-color: #ffffff !important;
            background-color: rgba(255, 255, 255, 0.1) !important;
            caret-color: #ffffff !important;
        }
        /* Social Providers */
        #kc-social-providers {
            margin-top: 20px;
        }
        .social-divider {
            display: flex;
            align-items: center;
            margin: 20px 0;
        }
        .social-divider::before,
        .social-divider::after {
            content: '';
            flex: 1;
            border-bottom: 1px solid rgba(255, 255, 255, 0.1);
        }
        .social-divider span {
            color: rgba(255, 255, 255, 0.4);
            font-size: 14px;
            padding: 0 16px;
        }
        #kc-social-providers ul {
            list-style: none;
            padding: 0;
            margin: 0;
        }
        #kc-social-providers li {
            margin-bottom: 10px;
        }
        .social-link {
            display: flex;
            align-items: center;
            justify-content: center;
            gap: 12px;
            width: 100%;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            color: #ffffff;
            padding: 14px 24px;
            font-size: 16px;
            font-weight: 500;
            text-decoration: none;
            transition: all 0.3s ease;
        }
        .social-link:hover {
            background: rgba(255, 255, 255, 0.15);
            border-color: rgba(255, 255, 255, 0.3);
            transform: translateY(-2px);
        }
        .social-icon {
            flex-shrink: 0;
        }
        /* Legal Footer - Fixed at bottom */
        .legal-footer {
            position: fixed;
            bottom: 0;
            left: 0;
            right: 0;
            display: flex;
            flex-wrap: wrap;
            justify-content: center;
            align-items: center;
            gap: 8px;
            padding: 16px 20px;
            background: transparent;
        }
        .legal-footer a {
            color: rgba(255, 255, 255, 0.5) !important;
            font-size: 13px;
            text-decoration: none !important;
            transition: color 0.3s ease;
            background: none !important;
            padding: 0 !important;
            display: inline !important;
            width: auto !important;
        }
        .legal-footer a:hover {
            color: #4a90e2 !important;
        }
        .footer-divider {
            color: rgba(255, 255, 255, 0.2);
            font-size: 12px;
        }
        /* Add padding to body to account for fixed footer */
        .login-container {
            padding-bottom: 60px;
        }
    </style>
</head>
<body>
    <div class="login-container">
        <div class="logo-wrapper">
            <img src="https://cdn.candidstudios.net/wp-media-folder-candid-studios/Candid.wht2_.png" alt="Candid Studios" />
        </div>

        <div class="login-form-wrapper">
            <h1><#nested "header"></h1>

            <#if displayMessage && message?has_content && (message.type != 'warning' || !isAppInitiatedAction??)>
                <div class="alert alert-${message.type}">
                    ${kcSanitize(message.summary)?no_esc}
                </div>
            </#if>

            <#nested "form">

            <#if displayInfo>
                <div class="footer-links">
                    <#nested "info">
                </div>
            </#if>
        </div>
    </div>

    <!-- Legal Footer -->
    <div class="legal-footer">
        <a href="https://earn.candidstudios.net/terms" target="_blank">Terms & Conditions</a>
        <span class="footer-divider">•</span>
        <a href="https://earn.candidstudios.net/privacy" target="_blank">Privacy Policy</a>
        <span class="footer-divider">•</span>
        <a href="mailto:support@candidstudios.net">Support</a>
    </div>

    <script>
        function togglePassword() {
            const passwordInput = document.getElementById('password');
            const eyeIcon = document.getElementById('eye-icon');
            const eyeOffIcon = document.getElementById('eye-off-icon');

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

        // Global redirect check - redirect from admin.candidstudios.net to dashboard after completing auth
        (function() {
            const currentPath = window.location.pathname;
            const currentSearch = window.location.search;

            // If we're on admin.candidstudios.net, check if this is an active login flow or completed
            if (window.location.hostname === 'admin.candidstudios.net') {
                // These paths are ACTIVE login flows - do NOT redirect
                const activeFlowPaths = [
                    '/login-actions/authenticate',
                    '/login-actions/required-action',
                    '/login-actions/first-broker-login',
                    '/protocol/openid-connect/auth',
                    '/protocol/openid-connect/login-status-iframe',
                    '/broker/'
                ];

                // Check if this is an active login flow
                const isActiveFlow = activeFlowPaths.some(path => currentPath.includes(path));

                // Also check if there's an action token (means we're in a flow)
                const hasActionToken = currentSearch.includes('key=') ||
                                       currentSearch.includes('execution=') ||
                                       currentSearch.includes('session_code=');

                // If NOT an active flow and NOT on admin console, redirect to dashboard
                if (!isActiveFlow && !hasActionToken && !currentPath.startsWith('/admin')) {
                    window.location.replace('https://login.candidstudios.net');
                }
            }
        })();
    </script>
</body>
</html>
</#macro>
