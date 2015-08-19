LeaderboardApp.controller 'editUsersCtrl', ($scope, $rootScope, $location, $upload, $timeout, Organization) ->
  $scope.erroOnupdate = false;
  $scope.erroOnPassword = false;
  $scope.erroOnOrganization = false;
  $scope.updateSuccessfully = false;
  $scope.passwordSuccessfully = false;
  $scope.organizationSuccessfully = false;
  $scope.partialUrl = "leaderboard/templates/users/edit.html";
  $scope.msgError = ''
  $scope.passwordMsgError = ''
  $scope.organizationMsgError = ''

  $scope.updateAccountForm = $scope.user
  $scope.organizationForm = {
    id: $rootScope.organization.id,
    name: $rootScope.organization.name,
    vat: $rootScope.organization.vat
  }

  $scope.$on 'auth:account-update-success', (ev, user) ->
    $scope.updateSuccessfully = true;
    $timeout( ->
      $scope.updateSuccessfully = false
    , 6000)

  $scope.$on 'auth:account-update-error', (ev, error) ->
    $scope.erroOnupdate = true;
    keyError = Object.keys(error.errors)[0]
    $scope.msgError = keyError + " " + error.errors[keyError]
    $timeout( ->
      $scope.erroOnupdate = false
    , 6000)

  $scope.$on 'auth:password-change-success', (ev, user) ->
    $scope.passwordSuccessfully = true;
    $timeout( ->
      $scope.passwordSuccessfully = false
    , 6000)

  $scope.$on 'auth:password-change-error', (ev, error) ->
    $scope.erroOnPassword = true;
    $scope.passwordMsgError = error.errors[0]
    $timeout( ->
      $scope.erroOnPassword = false
    , 6000)

  # $scope.$watch 'files', ->
  #   $scope.upload($scope.files);

  $scope.updateOrganization = ->
    $scope.organization = new Organization($scope.organizationForm);
    $scope.organization.$update  ->
      $scope.organizationSuccessfully = true;
      $timeout( ->
        $scope.organizationSuccessfully= false;
      , 6000)
    , (error) ->
      $scope.erroOnOrganization = true;
      $scope.organizationMsgError = error.data[0]
      $timeout( ->
        $scope.erroOnOrganization = false
      , 6000)


  $scope.upload = (file) ->
    if file && file.length
      $upload.upload({
        url: "/api/users/#{$scope.user.id}/upload",
        file: file[0]
      }).success((data, status, headers, config) ->
        $scope.user = data
      )
