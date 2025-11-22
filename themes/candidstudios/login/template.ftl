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
            background: linear-gradient(135deg, #0f0f1a 0%, #1a1a2e 50%, #16213e 100%) !important;
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
            margin-bottom: 30px;
        }
        .logo-wrapper img {
            max-width: 180px;
            height: auto;
        }
        .login-card {
            background: rgba(255, 255, 255, 0.08);
            backdrop-filter: blur(20px);
            -webkit-backdrop-filter: blur(20px);
            border-radius: 20px;
            border: 1px solid rgba(255, 255, 255, 0.15);
            box-shadow: 0 8px 32px rgba(0, 0, 0, 0.4);
            padding: 40px;
            width: 100%;
            max-width: 420px;
        }
        .login-card h1 {
            color: #ffffff;
            font-size: 24px;
            font-weight: 400;
            text-align: center;
            margin: 0 0 30px 0;
        }
        .login-card label {
            color: rgba(255, 255, 255, 0.9);
            font-size: 14px;
            font-weight: 500;
            display: block;
            margin-bottom: 8px;
        }
        .login-card input[type="text"],
        .login-card input[type="password"],
        .login-card input[type="email"] {
            width: 100%;
            background: rgba(255, 255, 255, 0.1);
            border: 1px solid rgba(255, 255, 255, 0.2);
            border-radius: 10px;
            color: #ffffff;
            padding: 14px 16px;
            font-size: 16px;
            margin-bottom: 20px;
            transition: all 0.3s ease;
        }
        .login-card input[type="text"]:focus,
        .login-card input[type="password"]:focus,
        .login-card input[type="email"]:focus {
            border-color: rgba(74, 144, 226, 0.6);
            background: rgba(255, 255, 255, 0.15);
            box-shadow: 0 0 20px rgba(74, 144, 226, 0.3);
            outline: none;
        }
        .login-card input[type="submit"],
        .login-card button[type="submit"] {
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
            margin-top: 10px;
        }
        .login-card input[type="submit"]:hover,
        .login-card button[type="submit"]:hover {
            background: linear-gradient(135deg, #5ba3f5 0%, #4a90e2 100%);
            box-shadow: 0 4px 20px rgba(74, 144, 226, 0.4);
            transform: translateY(-2px);
        }
        .login-card a {
            color: #4a90e2;
            text-decoration: none;
        }
        .login-card a:hover {
            color: #5ba3f5;
            text-decoration: underline;
        }
        .alert {
            padding: 12px 16px;
            border-radius: 10px;
            margin-bottom: 20px;
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
        .form-group {
            margin-bottom: 20px;
        }
        .checkbox-wrapper {
            display: flex;
            align-items: center;
            gap: 8px;
            margin-bottom: 20px;
        }
        .checkbox-wrapper label {
            color: rgba(255, 255, 255, 0.7);
            margin: 0;
            font-size: 14px;
        }
        .footer-links {
            text-align: center;
            margin-top: 20px;
            padding-top: 20px;
            border-top: 1px solid rgba(255, 255, 255, 0.1);
        }
        .footer-links a {
            color: rgba(255, 255, 255, 0.6);
            font-size: 14px;
        }
        /* Hide default Keycloak elements we don't need */
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

        <div class="login-card">
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
</body>
</html>
</#macro>
