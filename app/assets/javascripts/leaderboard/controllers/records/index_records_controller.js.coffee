LeaderboardApp.controller 'indexRecordsCtrl', ($scope, $rootScope, User, Input, $modal) ->
  $scope.currentUser = $rootScope.user
  $scope.inputs = []
  $scope.periodDetails = null
  $scope.selectedPeriod = ''

  $scope.periods =
    'daily': 'today'
    'weekly': 'week'
    'monthly': 'month'
    'quarterly': 'quarter'
    'yearly': 'year'

  $scope.selectPeriod = (period) ->
    $scope.selectedPeriod = period
    Input.query({organization_id: $scope.currentUser.organization_id, period: $scope.periods[period], user_id: $scope.currentUser.id}, (inputs) ->
      $scope.inputs = inputs
    )

    Input.query({organization_id: $scope.currentUser.organization_id, period: $scope.periods[period], user_id: $scope.currentUser.id, group_by_user: true}, (inputs) ->
      input = inputs[0]
      if input
        input.difference = input.currentTarget - input.realized
        input.currentTarget = $scope.currentUser.target[period]
        input.fullfilment = (input.realized*100) / input.currentTarget
        $scope.periodDetails = input
      else
        $scope.periodDetails = {}
        $scope.periodDetails.difference = 0
        $scope.periodDetails.currentTarget = $scope.currentUser.target[period]
        $scope.fullfilment = (0*100) / $scope.periodDetails.currentTarget
    )

  firstPeriod = Object.keys($scope.currentUser.target)[0];
  $scope.selectPeriod(firstPeriod)

  $scope.openNewRecord = ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/records/new.html',
      controller: 'newRecordCtrl'

    modalInstance.result.then (input) ->
      $scope.inputs.push(input)
      $scope.selectPeriod($scope.selectedPeriod)

  $scope.openEditInput =  (input) ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/records/edit.html',
      controller: 'editRecordCtrl',
      resolve:
        input: ->
          input

    modalInstance.result.then (input) ->
      $scope.selectPeriod($scope.selectedPeriod)

  $scope.openDialogDeleteInput = (input) ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/records/delete.html',
      controller: 'deleteRecordCtrl',
      resolve:
        input: ->
          input

    modalInstance.result.then (input) ->
      index = $scope.inputs.indexOf(input)
      $scope.inputs.splice(index, 1)