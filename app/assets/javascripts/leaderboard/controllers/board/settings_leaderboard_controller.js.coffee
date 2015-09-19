LeaderboardApp.controller 'settingsBoardCtrl', ($scope, Organization, $timeout, $rootScope) ->
  $scope.erroOnUpdate = false;
  $scope.partialUrl = "leaderboard/templates/board/settings.html";
  $scope.boardSettingsActive = true;
  $scope.msgError = ''
  $scope.updateSuccessfully = false;

  Organization.query({id: $scope.organization.id}, (data) ->
    $scope.organization = data
  )

  $scope.submitSettings = ->
    $scope.erroOnUpdate = false;
    $scope.organization.$update (data) ->
      $rootScope.organization = data
      $scope.updateSuccessfully = true;
      $timeout( ->
        $scope.updateSuccessfully= false;
      , 3000)
    , (error) ->
      $scope.erroOnUpdate = true;
      $scope.msgError = error.data[0]
      $timeout( ->
        $scope.erroOnUpdate = false
      , 3000)