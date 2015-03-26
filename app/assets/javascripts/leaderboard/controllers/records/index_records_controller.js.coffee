LeaderboardApp.controller 'indexRecordsCtrl', ($scope, $rootScope, User, Input) ->
  $scope.currentUser = $rootScope.user
  $scope.inputs = []
  $scope.periodDetails = null

  $scope.periods =
    'daily': 'today'
    'weekly': 'week'
    'monthly': 'month'
    'quartly': 'quarter'
    'yearly': 'year'

  $scope.selectPeriod = (period) ->
    console.log(period)
    Input.query({organization_id: $scope.currentUser.organization_id, period: $scope.periods[period], user_id: $scope.currentUser.id}, (inputs) ->
      $scope.inputs = inputs
    )

    Input.query({organization_id: $scope.currentUser.organization_id, period: $scope.periods[period], user_id: $scope.currentUser.id, group_by_user: true}, (inputs) ->
      input = inputs[0]
      if input
        input.difference = input.currentTarget - input.realized
        input.currentTarget = $scope.currentUser.target[period]
        console.log input.currentTarget
        input.fullfilment = (input.realized*100) / input.currentTarget
        $scope.periodDetails = input
    )