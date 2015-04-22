LeaderboardApp.controller 'indexTeamsCtrl', ($scope, $location, $modal, $rootScope, Departament) ->
  $scope.partialUrl = "leaderboard/templates/teams/index.html";
  $scope.departamentsActive = true;
  $scope.erroOnCreate = false;

  $scope.departaments = Departament.query({organization_id: $scope.user.organization_id});

  $scope.periods = [ {id: 'daily', label: 'Daily'},
    {id: 'weekly', label: 'Weekly'},
    {id: 'monthly', label: 'Monthly'},
    {id: 'quartly', label: 'Quartly'},
    {id: 'yearly', label: 'Yearly'}
  ]

  $scope.departament =  new Departament({period: []})

  $scope.multiselectSettings = {
      smartButtonMaxItems: 5,
      externalIdProp: 'id'
  }

  $scope.submitDepartament = (departament) ->
    departament.period = _.flatten(_.map(departament.period, (period) ->
      _.values(period)
    ))
    departament.$save {organization_id: $scope.$scope.user.organization_id}, (departament)->
      $scope.departaments.push(departament)
      $scope.departament =  new Departament({period: []})
    , (error) ->
      $scope.erroOnCreate = true

  $scope.openEditDepartament = (departament) ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/teams/edit.html',
      controller: 'editTeamCtrl',
      size: 'lg'
      resolve:
        departament: ->
          departament

  $scope.openDialogDeleteDepartament = (departament) ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/teams/delete.html',
      controller: 'deleteTeamCtrl',
      size: 'lg',
      resolve:
        departament: ->
          departament

    modalInstance.result.then (departament) ->
      index = $scope.departaments.indexOf(departament)
      $scope.departaments.splice(index, 1)