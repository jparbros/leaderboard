LeaderboardApp.factory('hostname', ['$location', 'subdomain', function ($location, subdomain) {
    var host = $location.host().split('.');
    if (host.length < 3 || host[0] == 'www' || host[0] == 'www')
        return null;
    else
        return host[0];
}]);