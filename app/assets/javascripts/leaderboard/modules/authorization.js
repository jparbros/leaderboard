LeaderboardApp.factory('Authorization', ['$auth', '$timeout', function ($auth, $timeout) {
  authorize = function  (requiredPermissions) {
    $timeout( function() {
      hasPermission = requiredPermissions.indexOf($auth.user.role) > -1
      console.log(hasPermission)
      return hasPermission;
    }, 300)
  }

  return {
    authorize: authorize
  };
}

]);