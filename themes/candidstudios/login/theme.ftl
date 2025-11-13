<#macro registrationLayout bodyClass="" displayInfo=false displayMessage=true displayRequiredFields=false>
<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta http-equiv="Content-Type" content="text/html; charset=UTF-8" />
    <meta name="robots" content="noindex, nofollow">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <title>${msg("loginTitle",(realm.displayName!''))}</title>
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
</head>
<body class="${bodyClass}">
    <div class="login-pf-page">
        <div id="kc-header" class="login-pf-page-header">
            <div style="text-align: center; padding: 40px 0 20px;">
                <img src="${url.resourcesPath}/img/logo.png" alt="Candid Studios" style="max-width: 200px; height: auto;" />
            </div>
        </div>
        <div id="kc-content">
            <div id="kc-content-wrapper">
                <#nested "header">
                <div id="kc-form">
                    <div id="kc-form-wrapper">
                        <#nested "form">
                    </div>
                </div>
                <#nested "info">
            </div>
        </div>
    </div>
</body>
</html>
</#macro>
