LeaderboardApp.controller 'UserSessionsCtrl', ($scope, subdomain, $location, $timeout, $window) ->
  $scope.erroOnLogin = false;
  $scope.loginForm = {}
  $scope.subdomain = subdomain

  $scope.$on 'auth:login-success', (ev, user) ->
    if subdomain
      $location.path('/')
    else
      console.log(window.location.protocol + '//' + $scope.loginForm.subdomain + '.' + window.location.host)
      $window.location.href = window.location.protocol + '//' + $scope.loginForm.subdomain + '.' + window.location.host

  $scope.$on 'auth:login-error', (ev, reason) ->
    $scope.erroOnLogin = true;
    $scope.loginForm.email = ""
    $scope.loginForm.password = ""
    $timeout( ->
      $scope.erroOnLogin = false;
    , 3000)

