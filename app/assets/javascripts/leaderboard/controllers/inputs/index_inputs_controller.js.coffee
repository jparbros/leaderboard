LeaderboardApp.controller 'indexInputsCtrl', ($scope, $location, $resource, $modal, Input) ->
  $scope.partialUrl = "leaderboard/templates/inputs/main.html";
  $scope.inputsActive = true;

  $scope.inputs = Input.query({organization_id: $scope.organization.id});

  $scope.openNewInput = ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/inputs/new.html',
      controller: 'newInputCtrl',
      size: 'lg'

    modalInstance.result.then (input) ->
      $scope.inputs.push(input)

  $scope.openEditInput =  (input) ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/records/edit.html',
      controller: 'editRecordCtrl',
      size: 'lg',
      resolve:
        input: ->
          input

    modalInstance.result

  $scope.openDialogDeleteInput = (input) ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/inputs/delete.html',
      controller: 'deleteInputCtrl',
      size: 'lg',
      resolve:
        input: ->
          input

    modalInstance.result.then (input) ->
      index = $scope.inputs.indexOf(input)
      $scope.inputs.splice(index, 1)