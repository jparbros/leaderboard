LeaderboardApp.controller 'editInputCtrl', ($scope, $modalInstance, Input, input) ->
  $scope.erroOnUpdate = false;
  $scope.inputForm = input;
  $scope.previous_attributes = angular.copy(input)
  $scope.msgError = ''

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
    editedInput = new Input(inputForm)
    editedInput.$update {user_id: input.user_id, organization_id: $scope.organization.id}, (input)->
      console.log(input);
      $modalInstance.close(input)
    , (error) ->
      $scope.erroOnUpdate = true
      $scope.msgError = error.data[0]
