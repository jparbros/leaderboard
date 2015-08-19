LeaderboardApp.controller 'loginBoardCtrl', ($scope, GuestUser, $timeout) ->
  $scope.erroOnUpdate = false;
  $scope.erroMessage = '';
  $scope.partialUrl = "leaderboard/templates/board/login.html";
  $scope.boardLoginActive = true;
  $scope.updateSuccessfully = false;

  GuestUser.query({organization_id: $scope.organization.id}, (data) ->
    $scope.guestUser = data
  )

  $scope.submitBoardLogin = ->
    $scope.erroOnUpdate = false
    $scope.erroMessage = ''

    if $scope.guestUser.id
      $scope.guestUser.$update({organization_id: $scope.organization.id}, (data) ->
        $scope.updateSuccessfully= true
        $timeout( ->
          $scope.updateSuccessfully= false;
        , 6000)
      , (error) ->
        $scope.erroMessage = error.data[0]
        $scope.erroOnUpdate = true
        $timeout( ->
          $scope.erroOnUpdate = false
        , 6000)
      )
    else
      $scope.guestUser.$save({organization_id: $scope.organization.id}, (data) ->
        $scope.updateSuccessfully= true
        $timeout( ->
          $scope.updateSuccessfully= false;
        , 6000)
      , (error) ->
        $scope.erroMessage = error.data[0]
        $scope.erroOnUpdate = true
        $timeout( ->
          $scope.erroOnUpdate = false
        , 6000)
      )

    if($scope.erroMessage.length < 10)
      $scope.erroMessage = 'There was an error trying to update your boardlogin details.'
