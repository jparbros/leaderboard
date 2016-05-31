LeaderboardApp.factory('RedirectTo', ['$location', function ($location) {
  subdomain = function  (subdomain) {
    window.location.href = window.location.protocol + '//' + subdomain + '.' + host()
  }

  signIn = function (subdomain) {
    console.log('RedirectTo signIn => ', subdomain)
    window.location.href = window.location.protocol + '//' + subdomain + '.' + host() + '/signin'
  }

  validate_token = function (subdomain, uid, auth_token) {
    window.location.href = window.location.protocol + '//' + subdomain + '.' + host() + "/validate_token?uid=" + uid + "&auth_token=" + auth_token
  }

  host = function () {
    var hostname = window.location.host.split('.');
    if (hostname.length >= 3) {
      hostname.shift();
    }
    return hostname.join('.');
  }

  return {
    subdomain: subdomain,
    validate_token: validate_token,
    sign_in: signIn
  };
}

]);