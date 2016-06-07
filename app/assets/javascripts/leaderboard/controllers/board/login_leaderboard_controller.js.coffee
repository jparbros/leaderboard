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

    if $scope.guestUser.password || $scope.guestUser.password_confirmation
      unless $scope.guestUser.password && $scope.guestUser.password_confirmation
        $scope.erroMessage = 'You must fill out the fields labeled "password" and "password confirmation".'
        $scope.erroOnUpdate = true
        $timeout( ->
          $scope.erroOnUpdate = false
        , 6000)

    unless $scope.erroOnUpdate
      if $scope.guestUser.id
        $scope.guestUser.$update({organization_id: $scope.organization.id}, (data) ->
          $scope.updateSuccessfully= true
          $timeout( ->
            $scope.updateSuccessfully= false;
          , 6000)
        , (error) ->

          if error.data[0] > 1
            $scope.erroMessage = error.data[0]
          else
            $scope.erroMessage = 'The username already is taken.'

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

          if error.data[0] > 1
            $scope.erroMessage = error.data[0]
          else
            $scope.erroMessage = 'The username already is taken.'

          $scope.erroOnUpdate = true
          $timeout( ->
            $scope.erroOnUpdate = false
          , 6000)
        )