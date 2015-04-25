LeaderboardApp.factory('RedirectTo', ['$location', function ($location) {
  subdomain = function  (subdomain) {
    console.log("Redirect to:" + window.location.protocol + '//' + subdomain + '.' + host())
    window.location.href = window.location.protocol + '//' + subdomain + '.' + host()
  }

  host = function () {
    var hostname = window.location.host.split('.');
    if (hostname.length >= 3) {
      hostname.shift();
    }
    return hostname.join('.');
  }

  return {
    subdomain: subdomain
  };
}

]);