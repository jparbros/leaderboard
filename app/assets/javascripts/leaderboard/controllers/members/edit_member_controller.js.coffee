LeaderboardApp.controller 'editMemberCtrl', ($scope, $rootScope, $location, User, Departament, $routeParams, $filter) ->
  $scope.partialUrl = "leaderboard/templates/members/new.html";
  $scope.usersActive = true;
  $scope.erroOnCreate = false
  $scope.selectedTeam = null

  User.get({id: $routeParams.id, organization_id: $scope.user.organization_id}, (user) ->
    $scope.userForm = user

    Departament.query({organization_id: $scope.user.organization_id}, (teams) ->
      $scope.teams = teams

      $scope.$watch('userForm.departament_id', (old_value, new_value) ->
        $scope.selectedTeam = $filter('filter')($scope.teams, (team) ->
          team.id == $scope.userForm.departament_id
        )[0] if $scope.userForm.departament_id
      )
    )
  )




  $scope.submitUser = (userForm) ->
    userObject = new User(userForm)
    userObject.$update {organization_id: $scope.$scope.user.organization_id}, (userData)->
      $location.path('/users')
    , (error) ->
      $scope.erroOnCreate = true
