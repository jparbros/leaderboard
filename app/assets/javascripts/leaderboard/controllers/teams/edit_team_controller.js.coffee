LeaderboardApp.controller 'editTeamCtrl', ($scope, $modalInstance, Departament, departament) ->
  $scope.erroOnUpdate = false;
  $scope.departament = departament;
  $scope.previous_attributes = angular.copy(departament)
  $scope.msgError = ''

  $scope.periods = [ {id: 'daily', label: 'Daily'},
    {id: 'weekly', label: 'Weekly'},
    {id: 'monthly', label: 'Monthly'},
    {id: 'quartly', label: 'Quartly'},
    {id: 'yearly', label: 'Yearly'}
  ]

  $scope.multiselectSettings = {
      smartButtonMaxItems: 5,
      externalIdProp: 'id'
  }

  $scope.ok = ->
    $modalInstance.close($scope.previous_attributes);

  $scope.cancel = ->
    $modalInstance.close($scope.previous_attributes)

  $scope.open = ($event) ->
    $event.preventDefault();
    $event.stopPropagation();

    $scope.opened = true;

  $scope.submitDepartament = (departament) ->
    departament.period = _.uniq(_.flatten(_.map(departament.period, (period) ->
      _.values(period)
    )))

    departament.$update {organization_id: $scope.organization.id}, (departament)->
      $modalInstance.close(departament)
    , (error) ->
      $scope.erroOnUpdate = true
      $scope.msgError = error.data[0]
