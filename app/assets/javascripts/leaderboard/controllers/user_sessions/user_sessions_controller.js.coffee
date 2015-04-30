LeaderboardApp.controller 'UserSessionsCtrl', ($scope, subdomain, $location, $timeout, $window, RedirectTo, $cookies) ->
  $scope.erroOnLogin = false;
  $scope.loginForm = {}
  $scope.subdomain = subdomain

  $scope.$on 'auth:login-success', (ev, user) ->
    if subdomain
      $cookies['subdomain'] = $scope.subdomain
      $location.path('/')
    else
      $cookies['subdomain'] = $scope.loginForm.subdomain
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

