LeaderboardApp.controller 'newMemberCtrl', ($scope, $rootScope, $location, User, Departament, $filter, $timeout, $window) ->
  $scope.partialUrl = "leaderboard/templates/members/new.html";
  $scope.usersActive = true;
  $scope.erroOnCreate = false
  $scope.userForm = new User({active: true})
  $scope.selectedTeam = null
  $scope.msgError = ''
  $scope.showTooltip = true;

  Departament.query({organization_id: $scope.organization.id}, (teams) ->
    $scope.teams = teams

    $scope.$watch('userForm.departament_id', (old_value, new_value) ->
      $scope.selectedTeam = $filter('filter')($scope.teams, (team) ->
        team.id == $scope.userForm.departament_id
      )[0] if $scope.userForm.departament_id
    )
  );

  $scope.submitUser = (userForm) ->
    userObject = new User(userForm)
    userObject.$save {organization_id: $scope.organization.id}, (userData)->
      $location.path('/users')
    , (respond) ->
      $scope.erroOnCreate = true
      error_key = Object.keys(respond.data)[0];
      $scope.msgError = respond.data[error_key][0]
      $('.main').scrollTop(-300);
      $timeout( ->
        $scope.erroOnCreate = false
      , 5000)
