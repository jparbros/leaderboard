LeaderboardApp.controller 'indexMembersCtrl', ($scope, $rootScope, User) ->
  $scope.partialUrl = "leaderboard/templates/members/index.html";
  $scope.usersActive = true;

  $scope.users = User.query({organization_id: $scope.user.organization_id});
