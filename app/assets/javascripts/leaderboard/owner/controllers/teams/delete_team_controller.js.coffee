ownerApp.controller 'deleteTeamCtrl', ($scope, $modalInstance, Departament, departament) ->
  $scope.erroOnDelete = false;
  $scope.departament = departament;

  $scope.ok = ->
    $modalInstance.close();

  $scope.cancel = ->
    $modalInstance.dismiss('cancel');

  $scope.open = ($event) ->
    $event.preventDefault();
    $event.stopPropagation();

    $scope.opened = true;

  $scope.deleteTeam = ->
    $scope.departament.$delete {organization_id: $scope.organization.id}, ->
      $modalInstance.close($scope.departament)
    , (error) ->
      $scope.erroOnDelete = true
