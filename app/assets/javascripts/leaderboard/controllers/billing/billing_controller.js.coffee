LeaderboardApp.controller 'billingCtrl', ($scope, $http, $routeParams, $rootScope, Subscription) ->
  $scope.partialUrl = "leaderboard/templates/billing/index.html";
  $scope.subscription = null
  $scope.organization = $rootScope.organization
  $scope.payment = $routeParams.payment;

  Subscription.query({organization_id: $scope.organization.id}, (data) ->
    $scope.subscription = data
  )
