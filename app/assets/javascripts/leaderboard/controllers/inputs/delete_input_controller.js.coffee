LeaderboardApp.controller 'deleteInputCtrl', ($scope, $modalInstance, Input, input) ->
  $scope.erroOnDelete = false;
  $scope.input = new Input(input);
  $scope.msgError = ''

  $scope.ok = ->
    $modalInstance.close();

  $scope.cancel = ->
    $modalInstance.dismiss('cancel');

  $scope.open = ($event) ->
    console.log($scope.input)
    $event.preventDefault();
    $event.stopPropagation();

    $scope.opened = true;

  $scope.deleteInput = ->
    $scope.input.$delete {user_id: $scope.input.user.id, organization_id: $scope.user.organization_id}, ->
      $modalInstance.close($scope.input)
    , (error) ->
      $scope.erroOnDelete = true
      $scope.msgError = error.data[0]
