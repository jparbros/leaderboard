app.controller 'UserSessionsCtrl', ($scope, $location, $timeout) ->
  $scope.erroOnLogin = false;
  $scope.loginForm = {}

  $scope.$on 'auth:login-success', (ev, user) ->
    $location.path('/leaderboard')

  $scope.$on 'auth:login-error', (ev, reason) ->
    $scope.erroOnLogin = true;
    $scope.loginForm.email = ""
    $scope.loginForm.password = ""
    $timeout( ->
      $scope.erroOnLogin = false;
    , 3000)
