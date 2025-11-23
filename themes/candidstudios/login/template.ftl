<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html<#if realm.internationalizationEnabled> lang="${locale.currentLanguageTag}"</#if>>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
    <link rel="icon" href="${url.resourcesPath}/img/favicon.ico" />
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
        .footer-links {
            text-align: center;
            margin-top: 24px;
            color: rgba(255, 255, 255, 0.8);
            font-size: 14px;
            line-height: 1.5;
        }
        .footer-links a {
            color: #4a90e2;
            font-size: 14px;
            text-decoration: none;
        }
        .footer-links a:hover {
            color: #5ba3f5;
            text-decoration: underline;
        }
        /* Info text styling */
        #kc-info, #kc-info-wrapper {
            color: rgba(255, 255, 255, 0.8) !important;
            font-size: 14px;
            line-height: 1.6;
            text-align: center;
            margin-top: 20px;
        }
        #kc-info p {
            color: rgba(255, 255, 255, 0.8) !important;
            margin: 0;
        }
        /* SVG Icons */
        .icon-user, .icon-lock, .icon-eye, .icon-eye-off {
            width: 20px;
            height: 20px;
        }
        /* Hide default Keycloak elements */
        #kc-header, #kc-header-wrapper {
            display: none !important;
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
    </script>
</body>
</html>
</#macro>
