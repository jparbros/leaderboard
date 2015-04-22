LeaderboardApp.controller 'newInputCtrl', ($scope, $modalInstance, Input) ->
  $scope.erroOnCreate = false;
  $scope.inputForm = {}

  $scope.ok = ->
    $modalInstance.close();

  $scope.cancel = ->
    $modalInstance.dismiss('cancel');

  $scope.open = ($event) ->
    $event.preventDefault();
    $event.stopPropagation();

    $scope.opened = true;

  $scope.submitInput = (inputForm) ->
    input = new Input(inputForm)
    input.$save {user_id: $scope.user.id, organization_id: $scope.organization.id}, (input)->
      $modalInstance.close(input)
    , (error) ->
      $scope.erroOnCreate = true