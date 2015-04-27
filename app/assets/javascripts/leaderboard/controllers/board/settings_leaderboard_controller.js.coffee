LeaderboardApp.controller 'settingsBoardCtrl', ($scope, Organization) ->
  $scope.erroOnUpdate = false;
  $scope.partialUrl = "leaderboard/templates/board/settings.html";
  $scope.boardSettingsActive = true;
  $scope.msgError = ''

  Organization.query({id: $scope.organization.id}, (data) ->
    $scope.organization = data
  )

  $scope.submitSettings = ->
    $scope.erroOnUpdate = false;
    $scope.organization.$update (data) ->
      data
    , (error) ->
      $scope.erroOnUpdate = true;
      $scope.msgError = error.data[0]