LeaderboardApp.controller 'UserSessionsCtrl', ($scope, subdomain, $location, $timeout, $window, RedirectTo) ->
  $scope.erroOnLogin = false;
  $scope.loginForm = {}
  $scope.subdomain = subdomain

  $scope.$on 'auth:login-success', (ev, user) ->
    if subdomain
      $location.path('/')
    else
      $timeout(->
        RedirectTo.subdomain($scope.loginForm.subdomain)
      , 500)

  $scope.$on 'auth:login-error', (ev, reason) ->
    $scope.erroOnLogin = true;
    $scope.loginForm.email = ""
    $scope.loginForm.password = ""
    $timeout( ->
      $scope.erroOnLogin = false;
    , 3000)

