ownerApp.controller 'indexMembersCtrl', ($scope, $rootScope, User) ->
  $scope.partialUrl = "leaderboard/owner/templates/members/index.html";
  $scope.usersActive = true;

  $scope.users = User.query({organization_id: $scope.user.id});
