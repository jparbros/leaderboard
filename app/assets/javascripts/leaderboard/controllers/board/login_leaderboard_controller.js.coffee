LeaderboardApp.controller 'loginBoardCtrl', ($scope, GuestUser) ->
  $scope.erroOnUpdate = false;
  $scope.erroMessage = '';
  $scope.partialUrl = "leaderboard/templates/board/login.html";
  $scope.boardLoginActive = true;

  GuestUser.query({organization_id: $scope.user.organization_id}, (data) ->
    $scope.guestUser = data
  )

  $scope.submitBoardLogin = ->
    $scope.erroOnUpdate = false
    $scope.erroMessage = ''

    if $scope.guestUser.id
      $scope.guestUser.$update({organization_id: $scope.user.organization_id}, (data) ->
        data
      , (error) ->
        $scope.erroMessage = error.data[0]
        $scope.erroOnUpdate = true
      )
    else
      $scope.guestUser.$save({organization_id: $scope.user.organization_id}, (data) ->
        data
      , (error) ->
        $scope.erroMessage = error.data[0]
        $scope.erroOnUpdate = true
      )
