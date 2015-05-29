LeaderboardApp.controller 'indexMembersCtrl', ($scope, $rootScope, User, Departament) ->
  $scope.partialUrl = "leaderboard/templates/members/index.html";
  $scope.usersActive = true;
  $scope.departaments = []

  Departament.query({organization_id: $scope.organization.id}, (departaments) ->
    angular.forEach(departaments, (departament) ->
      console.log(departament)
      User.query({organization_id: $scope.organization.id, departament_id: departament.id}, (users) ->
        departament.users = users
        $scope.departaments.push(departament)
      );
    );
  );