LeaderboardApp.controller 'UserSessionsCtrl', ($scope, subdomain, $location, $timeout, $window, RedirectTo, ipCookie, $modal) ->
  $scope.erroOnLogin = false;
  $scope.loginForm = {}
  $scope.subdomain = subdomain
  $scope.loginForm.subdomain = $scope.subdomain

  $scope.$on 'auth:login-success', (ev, user) ->
    if subdomain
      ipCookie('subdomain', $scope.subdomain, { path: '/', domain: 'rankingdesk.com' })
      $location.path('/')
    else
      ipCookie('subdomain', $scope.loginForm.subdomain, { path: '/', domain: 'rankingdesk.com' })
      $timeout(->
        RedirectTo.subdomain($scope.loginForm.subdomain)
      , 500)

  $scope.$on 'auth:login-error', (ev, reason) ->
    $scope.erroOnLogin = true;
    $scope.loginForm.email = ""
    $scope.loginForm.password = ""
    $timeout( ->
      $scope.erroOnLogin = false;
    , 6000)

  $scope.openForgotPassword = ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/password/reset.html',
      controller: 'passwordResetCtrl',

    modalInstance.result.then (input) ->
      $scope.inputs.push(input)

  $scope.changeSubdomain = ->
    ipCookie.remove('subdomain', { path: '/', domain: 'rankingdesk.com' })
    RedirectTo.sign_in('demo')

  $scope.openForgotSubdomain = ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/subdomain/forgot.html',
      controller: 'forgotSubdomainCtrl',

    modalInstance.result.then (input) ->
      $scope.inputs.push(input)
