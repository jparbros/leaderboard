LeaderboardApp.controller 'editInputCtrl', ($scope, $modalInstance, Input, input) ->
  $scope.erroOnUpdate = false;
  $scope.inputForm = input;
  $scope.previous_attributes = angular.copy(input)

  $scope.ok = ->
    $modalInstance.close();

  $scope.cancel = ->
    $modalInstance.dismiss('cancel');
    angular.extend($scope.inputForm, $scope.previous_attributes);

  $scope.open = ($event) ->
    $event.preventDefault();
    $event.stopPropagation();

    $scope.opened = true;

  $scope.submitInput = (inputForm) ->
    input = new Input(inputForm)
    input.$update {user_id: input.user.id, organization_id: $scope.user.organization_id}, (input)->
      $modalInstance.close(input)
    , (error) ->
      $scope.erroOnUpdate = true
