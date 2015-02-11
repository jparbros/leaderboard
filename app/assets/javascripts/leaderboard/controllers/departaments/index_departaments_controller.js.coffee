app.controller 'indexDepartamentsCtrl', ($scope, $location, $modal, $rootScope, Departament) ->
  $scope.partialUrl = "leaderboard/templates/departaments/index.html";
  $scope.departamentsActive = true;

  $scope.departaments = Departament.query({organization_id: $scope.user.id});

  $scope.openNewDepartament = ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/departaments/new.html',
      controller: 'newDepartamentCtrl',
      size: 'lg'

    modalInstance.result.then (departament) ->
      $scope.departaments.push(departament)

