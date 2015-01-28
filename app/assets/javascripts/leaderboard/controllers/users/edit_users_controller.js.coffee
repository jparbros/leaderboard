app.controller 'editUsersCtrl', ($scope, $location) ->
  $scope.erroOnupdate = false;
  $scope.updateSuccessfully = false;
  $scope.partialUrl = "leaderboard/templates/users/edit.html";

  $scope.$on 'auth:account-update-success', (ev, user) ->
    $scope.updateSuccessfully = true;

  $scope.$on 'auth:account-update-error', (ev, reason) ->
    $scope.erroOnupdate = true;

