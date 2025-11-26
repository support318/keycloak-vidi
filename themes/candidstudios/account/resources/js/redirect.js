// Redirect from Keycloak account pages to the dashboard
(function() {
    // If we are on admin.candidstudios.net, redirect to dashboard
    if (window.location.hostname === "admin.candidstudios.net") {
        window.location.replace("https://login.candidstudios.net");
    }
})();
