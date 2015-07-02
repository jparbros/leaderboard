LeaderboardApp.controller 'editUsersCtrl', ($scope, $location, $upload, $timeout) ->
  $scope.erroOnupdate = false;
  $scope.erroOnPassword = false;
  $scope.updateSuccessfully = false;
  $scope.passwordSuccessfully = false;
  $scope.partialUrl = "leaderboard/templates/users/edit.html";
  $scope.msgError = ''
  $scope.passwordMsgError = ''

  $scope.$on 'auth:account-update-success', (ev, user) ->
    $scope.updateSuccessfully = true;

  $scope.$on 'auth:account-update-error', (ev, error) ->
    $scope.erroOnupdate = true;
    $scope.msgError = error.data[0]

  $scope.$on 'auth:password-change-success', (ev, user) ->
    $scope.passwordSuccessfully = true;
    $timeout( ->
      $scope.passwordSuccessfully = false
    , 3000)

  $scope.$on 'auth:password-change-error', (ev, error) ->
    $scope.erroOnPassword = true;
    console.log(error.errors[0])
    $scope.passwordMsgError = error.errors[0]
    $timeout( ->
      $scope.erroOnPassword = false
    , 3000)

  # $scope.$watch 'files', ->
  #   $scope.upload($scope.files);

  $scope.upload = (file) ->
    if file && file.length
      $upload.upload({
        url: "/api/users/#{$scope.user.id}/upload",
        file: file[0]
      }).success((data, status, headers, config) ->
        $scope.user = data
      )
