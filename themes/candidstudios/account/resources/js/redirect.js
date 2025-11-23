// Redirect users from Keycloak account page to the dashboard
(function() {
  // Only redirect if we're on the account page (not admin)
  if (window.location.pathname.includes('/realms/') &&
      window.location.pathname.includes('/account') &&
      !window.location.pathname.includes('/admin')) {
    window.location.href = 'https://dash.candidstudios.net';
  }
})();
