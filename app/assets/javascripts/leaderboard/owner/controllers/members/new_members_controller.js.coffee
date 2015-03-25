ownerApp.controller 'newMemberCtrl', ($scope, $rootScope, $location, User, Departament, $filter) ->
  $scope.partialUrl = "leaderboard/templates/members/new.html";
  $scope.usersActive = true;
  $scope.erroOnCreate = false
  $scope.userForm = new User()
  $scope.selectedTeam = null

  Departament.query({organization_id: $scope.user.organization_id}, (teams) ->
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
    , (error) ->
      $scope.erroOnCreate = true