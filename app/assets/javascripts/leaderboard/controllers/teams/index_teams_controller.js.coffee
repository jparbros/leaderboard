LeaderboardApp.controller 'indexTeamsCtrl', ($scope, $location, $modal, $rootScope, Departament, $timeout) ->
  $scope.partialUrl = "leaderboard/templates/teams/index.html";
  $scope.departamentsActive = true;
  $scope.erroOnCreate = false;
  $scope.errorMsg = 'There was an error when trying to create the team.'

  $scope.departaments = Departament.query({organization_id: $scope.organization.id});

  $scope.periods = [ {id: 'daily', label: 'Daily'},
    {id: 'weekly', label: 'Weekly'},
    {id: 'monthly', label: 'Monthly'},
    {id: 'quarterly', label: 'Quarterly'},
    {id: 'yearly', label: 'Yearly'}
  ]

  $scope.departament =  new Departament({period: []})

  $scope.multiselectSettings = {
      smartButtonMaxItems: 5,
      externalIdProp: 'id'
  }

  $scope.submitDepartament = (departament) ->
    flatPeriods departament

    if departament.period.length > 0
      departament.$save {organization_id: $scope.organization.id}, (departament)->
        $scope.departaments.push(departament)
        $scope.departament =  new Departament({period: []})
      , (error) ->
        $scope.erroOnCreate = true
    else
      $scope.errorMsg = 'Please, select a period for the team.'
      $scope.erroOnCreate =  true
      $timeout( ->
        $scope.erroOnCreate =  false
        $scope.errorMsg = 'There was an error when trying to create the team.'
      , 3000)

  $scope.openEditDepartament = (departament) ->
    departament.period = _.map(departament.period, (period) ->
      {id: period, label: period }
    )
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/teams/edit.html',
      controller: 'editTeamCtrl',
      size: 'lg'
      resolve:
        departament: ->
          departament

    modalInstance.result.then (modal_departament) ->
      departament.$get({organization_id: $scope.organization.id})

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

  flatPeriods = (departament) ->
    departament.period = _.flatten(_.map(departament.period, (period) ->
      _.values(period)
    ))