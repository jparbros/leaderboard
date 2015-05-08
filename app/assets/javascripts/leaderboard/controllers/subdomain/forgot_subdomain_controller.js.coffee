LeaderboardApp.controller 'forgotSubdomainCtrl', ($scope, $modalInstance, $http) ->
  $scope.erroOnUpdate = false
  $scope.forgottenSubdomain = false

  $scope.ok = ->
    $modalInstance.close();

  $scope.cancel = ->
    $modalInstance.dismiss('cancel');

  $scope.submitForgotSubdomain = (forgotSubdomainForm) ->
    $scope.erroOnUpdate = false

    $http.get('/api/subdomains/forgot', {params: {email: forgotSubdomainForm.email} }).
      success( (data) ->
        console.log(data)
        $scope.forgottenSubdomain = data.subdomain
      ).
      error( (data) ->
        $scope.erroOnUpdate = true
        forgotSubdomainForm.email = ''
      );