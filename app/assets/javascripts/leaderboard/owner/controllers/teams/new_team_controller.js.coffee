ownerApp.controller 'newTeamCtrl', ($scope, $modalInstance, Departament) ->
  $scope.erroOnCreate = false;
  $scope.inputForm = {}

  $scope.periodOptions = [
    {id: 'daily', label: 'Daily'},
    {id: 'monthly', label: 'Monthly'}
  ]

  $scope.ok = ->
    $modalInstance.close();

  $scope.cancel = ->
    $modalInstance.dismiss('cancel');

  $scope.open = ($event) ->
    $event.preventDefault();
    $event.stopPropagation();

    $scope.opened = true;

  $scope.submitDepartament = (inputDepartament) ->
    departament = new Departament(inputDepartament)
    departament.$save {organization_id: $scope.organization.id}, (departament)->
      $modalInstance.close(departament)
    , (error) ->
      $scope.erroOnCreate = true
