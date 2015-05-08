LeaderboardApp.controller 'passwordResetCtrl', ($scope, $modalInstance, $auth) ->
  $scope.erroOnUpdate = false
  $scope.successOnUpdate = false

  $scope.ok = ->
    $modalInstance.close();

  $scope.cancel = ->
    $modalInstance.dismiss('cancel');

  $scope.submitResetPassword = (resetPasswordForm) ->
    $auth.requestPasswordReset(resetPasswordForm).then( (resp) ->
      $scope.successOnUpdate = true
      resetPasswordForm.email = ''
    ).catch( (resp) ->
      $scope.erroOnUpdate = true
      resetPasswordForm.email = ''
    )