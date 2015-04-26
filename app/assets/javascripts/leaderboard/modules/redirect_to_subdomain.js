LeaderboardApp.factory('RedirectTo', ['$location', function ($location) {
  subdomain = function  (subdomain) {
    console.log("Redirect to:" + window.location.protocol + '//' + subdomain + '.' + host())
    window.location.href = window.location.protocol + '//' + subdomain + '.' + host()
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
    validate_token: validate_token
  };
}

]);