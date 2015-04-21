LeaderboardApp.controller 'settingsBoardCtrl', ($scope, Organization) ->
  $scope.erroOnUpdate = false;
  $scope.partialUrl = "leaderboard/templates/board/settings.html";
  $scope.boardSettingsActive = true;


  Organization.query({id: $scope.user.organization_id}, (data) ->
    $scope.organization = data
  )

  $scope.submitSettings = ->
    $scope.erroOnUpdate = false;
    $scope.organization.$update (data) ->
      data
    , (error) ->
      $scope.erroOnUpdate = true;