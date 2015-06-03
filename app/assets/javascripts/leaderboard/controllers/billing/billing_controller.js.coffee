LeaderboardApp.controller 'billingCtrl', ($scope, $http, $routeParams, Subscription) ->
  $scope.partialUrl = "leaderboard/templates/billing/index.html";
  $scope.subscription = null

  Subscription.query({organization_id: $scope.organization.id}, (data) ->
    $scope.subscription = data
  )
