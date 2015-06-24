LeaderboardApp.controller 'forgotSubdomainCtrl', ($scope, $modalInstance, $http, $timeout) ->
  $scope.erroOnUpdate = false
  $scope.forgottenSubdomain = false
  $scope.email = ''

  $scope.ok = ->
    $modalInstance.close();

  $scope.cancel = ->
    $modalInstance.dismiss('cancel');

  $scope.submitForgotSubdomain = (forgotSubdomainForm) ->
    $scope.erroOnUpdate = false
    $scope.email = forgotSubdomainForm.email

    $http.get('/api/subdomains/forgot', {params: {email: forgotSubdomainForm.email} }).
      success( (data) ->
        $scope.forgottenSubdomain = data.subdomain
      ).
      error( (data) ->
        $scope.erroOnUpdate = true
        forgotSubdomainForm.email = ''
        $timeout( ->
          $scope.erroOnUpdate = false
        , 3000)
      );