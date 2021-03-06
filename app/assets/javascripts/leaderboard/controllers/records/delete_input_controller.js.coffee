LeaderboardApp.controller 'deleteRecordCtrl', ($scope, $modalInstance, Input, input) ->
  $scope.erroOnDelete = false;
  $scope.input = input;
  $scope.msgError = ''

  $scope.ok = ->
    $modalInstance.close();

  $scope.cancel = ->
    $modalInstance.dismiss('cancel');

  $scope.open = ($event) ->
    $event.preventDefault();
    $event.stopPropagation();

    $scope.opened = true;

  $scope.deleteInput = ->
    $scope.input.$delete {user_id: $scope.user.id, organization_id: $scope.user.organization_id}, ->
      $modalInstance.close($scope.input)
    , (error) ->
      $scope.msgError = error.data[0]
      $scope.erroOnDelete = true
