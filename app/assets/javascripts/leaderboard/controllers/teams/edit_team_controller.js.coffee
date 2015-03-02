app.controller 'editTeamCtrl', ($scope, $modalInstance, Departament, departament) ->
  $scope.erroOnUpdate = false;
  $scope.departament = departament;
  $scope.previous_attributes = angular.copy(departament)

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
    input.$update {user_id: $scope.user.id}, (input)->
      $modalInstance.close(input)
    , (error) ->
      $scope.erroOnUpdate = true

  $scope.submitDepartament = (departament) ->
    departament = new Departament(departament)
    departament.$update {organization_id: $scope.organization.id}, (departament)->
      $modalInstance.close(departament)
    , (error) ->
      $scope.erroOnUpdate = true