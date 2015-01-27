app.controller 'indexCtrl', ($scope, $location, $resource, $modal, Input) ->
  $scope.partialUrl = "leaderboard/templates/main.html";

  $scope.inputs = Input.query({user_id: $scope.user.id});

  $scope.openNewInput = ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/inputs/new.html',
      controller: 'newInputCtrl',
      size: 'lg'

    modalInstance.result.then (input) ->
      $scope.inputs.push(input)

  $scope.openEditInput =  (input) ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/inputs/edit.html',
      controller: 'editInputCtrl',
      size: 'lg',
      resolve:
        input: ->
          input

    modalInstance.result