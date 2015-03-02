app.controller 'indexTeamsCtrl', ($scope, $location, $modal, $rootScope, Departament) ->
  $scope.partialUrl = "leaderboard/templates/teams/index.html";
  $scope.departamentsActive = true;

  $scope.departaments = Departament.query({organization_id: $scope.user.id});

  $scope.openNewDepartament = ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/teams/new.html',
      controller: 'newTeamCtrl',
      size: 'lg'

    modalInstance.result.then (departament) ->
      $scope.departaments.push(departament)

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