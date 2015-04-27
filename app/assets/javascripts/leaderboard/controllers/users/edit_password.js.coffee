LeaderboardApp.controller 'editPasswordCtrl', ($scope, $location, $upload) ->
  $scope.erroOnupdate = false;
  $scope.updateSuccessfully = false;
  $scope.partialUrl = "leaderboard/templates/users/edit.html";

