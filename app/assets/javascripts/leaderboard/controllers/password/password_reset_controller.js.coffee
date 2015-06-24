LeaderboardApp.controller 'passwordResetCtrl', ($scope, $modalInstance, $auth, $timeout) ->
  $scope.erroOnUpdate = false
  $scope.successOnUpdate = false
  $scope.errorMessage = ''

  $scope.ok = ->
    $modalInstance.close();

  $scope.cancel = ->
    $modalInstance.dismiss('cancel');

  $scope.submitResetPassword = (resetPasswordForm) ->
    $auth.requestPasswordReset(resetPasswordForm).then( (resp) ->
      $scope.successOnUpdate = true
      resetPasswordForm.email = ''
      $timeout( ->
        $scope.successOnUpdate = false
      , 3000)
    ).catch( (resp) ->
      $scope.erroOnUpdate = true
      resetPasswordForm.email = ''
      $scope.errorMessage = resp['data']['errors'][0]

      $timeout( ->
        $scope.erroOnUpdate = false
        $scope.errorMessage = ''
      , 3000)
    )