<#macro emailLayout>
<!DOCTYPE html>
<html lang="en">
<head>
    <meta charset="UTF-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>Candid Studios</title>
</head>
<body style="margin: 0; padding: 0; font-family: -apple-system, BlinkMacSystemFont, 'Segoe UI', Roboto, 'Helvetica Neue', Arial, sans-serif; background-color: #f5f5f5;">
    <table role="presentation" style="width: 100%; border-collapse: collapse; background-color: #f5f5f5;">
        <tr>
            <td style="padding: 40px 20px;">
                <!-- Main Container -->
                <table role="presentation" style="max-width: 600px; margin: 0 auto; background-color: #ffffff; border-radius: 8px; box-shadow: 0 2px 8px rgba(0,0,0,0.1); border-collapse: collapse;">
                    <!-- Header with Logo -->
                    <tr>
                        <td style="padding: 40px 40px 30px 40px; text-align: center; background: linear-gradient(135deg, #1a1a1a 0%, #2d2d2d 100%); border-radius: 8px 8px 0 0;">
                            <img src="https://cdn.candidstudios.net/wp-media-folder-candid-studios/Candid.wht2_.png" alt="Candid Studios" style="max-width: 150px; height: auto; margin: 0 auto 15px auto; display: block;" />
                            <div style="font-size: 14px; color: #cccccc; margin-top: 10px; letter-spacing: 2px;">
                                PHOTOGRAPHY & VIDEOGRAPHY
                            </div>
                        </td>
                    </tr>

                    <!-- Content -->
                    <tr>
                        <td style="padding: 40px;">
                            <#nested>
                        </td>
                    </tr>

                    <!-- Footer -->
                    <tr>
                        <td style="padding: 30px 40px; background-color: #f9f9f9; border-radius: 0 0 8px 8px; border-top: 1px solid #e0e0e0;">
                            <p style="color: #888888; font-size: 14px; line-height: 1.6; margin: 0 0 10px 0; text-align: center;">
                                <strong style="color: #333333;">Candid Studios</strong><br>
                                Professional Photography & Videography Services
                            </p>
                            <p style="color: #888888; font-size: 13px; line-height: 1.6; margin: 10px 0 0 0; text-align: center;">
                                <a href="https://www.candidstudios.net" style="color: #4a90e2; text-decoration: none;">Visit Our Website</a> |
                                <a href="https://www.candidstudios.net/contact" style="color: #4a90e2; text-decoration: none;">Contact Support</a>
                            </p>
                            <p style="color: #aaaaaa; font-size: 12px; line-height: 1.5; margin: 15px 0 0 0; text-align: center;">
                                © ${.now?string('yyyy')} Candid Studios. All rights reserved.<br>
                                You're receiving this email because you have an account with Candid Studios.
                            </p>
                        </td>
                    </tr>
                </table>

                <!-- Footer Note -->
                <table role="presentation" style="max-width: 600px; margin: 20px auto 0 auto;">
                    <tr>
                        <td style="text-align: center; color: #999999; font-size: 12px; line-height: 1.5;">
                            Please do not reply to this email. For support, visit our <a href="https://www.candidstudios.net/contact" style="color: #4a90e2; text-decoration: none;">Contact Page</a>.
                        </td>
                    </tr>
                </table>
            </td>
        </tr>
    </table>
</body>
</html>
</#macro>
