ownerApp.controller 'indexInputsCtrl', ($scope, $location, $resource, $modal, Input) ->
  $scope.partialUrl = "leaderboard/owner/templates/inputs/main.html";
  $scope.inputsActive = true;

  $scope.inputs = Input.query({organization_id: $scope.user.organization_id});

  $scope.openNewInput = ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/owner/templates/inputs/new.html',
      controller: 'newInputCtrl',
      size: 'lg'

    modalInstance.result.then (input) ->
      $scope.inputs.push(input)

  $scope.openEditInput =  (input) ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/owner/templates/inputs/edit.html',
      controller: 'editInputCtrl',
      size: 'lg',
      resolve:
        input: ->
          input

    modalInstance.result

  $scope.openDialogDeleteInput = (input) ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/owner/templates/inputs/delete.html',
      controller: 'deleteInputCtrl',
      size: 'lg',
      resolve:
        input: ->
          input

    modalInstance.result.then (input) ->
      index = $scope.inputs.indexOf(input)
      $scope.inputs.splice(index, 1)