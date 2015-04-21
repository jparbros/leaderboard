LeaderboardApp.controller 'buyModalCtrl', ($scope, $location, $modalInstance, $resource) ->
  $scope.buyForm = {};
  $scope.erroOnUpdate = false;

  $scope.ok = ->
    $modalInstance.close();

  $scope.cancel = ->
    $modalInstance.dismiss('cancel');

  $scope.open = ($event) ->
    $event.preventDefault();
    $event.stopPropagation();

    $scope.opened = true;

  $scope.buyPlan = (plan) ->
    $modalInstance.close();
    $location.path("/buy/new/#{plan}")
