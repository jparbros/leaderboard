app.controller 'UserSessionsCtrl', ($scope, $location) ->
  $scope.erroOnLogin = false;

  $scope.$on 'auth:login-success', (ev, user) ->
    $location.path('/leaderboard')

  $scope.$on 'auth:login-error', (ev, reason) ->
    $scope.erroOnLogin = true;
