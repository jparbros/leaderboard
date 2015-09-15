LeaderboardApp.controller 'indexMembersCtrl', ($scope, $rootScope, User, Departament, $timeout, $http) ->
  $scope.partialUrl = "leaderboard/templates/members/index.html";
  $scope.usersActive = true;
  $scope.departaments = [];
  $scope.erroOnSent = false;
  $scope.sentSuccessfully = false;

  Departament.query({organization_id: $scope.organization.id}, (departaments) ->
    angular.forEach(departaments, (departament) ->
      User.query({organization_id: $scope.organization.id, departament_id: departament.id}, (users) ->
        departament.users = users
        $scope.departaments.push(departament)
        $timeout(->
          $('[data-toggle="tooltip"]').tooltip();
        , 1000)
      );
    );
  );

  $scope.sendEmail = (user_id)->
    $http.get("/api/users/#{user_id}/resubmit_email").then((response) ->
      $scope.sentSuccessfully = true;
      $timeout(->
        $scope.sentSuccessfully = false;
      , 6000);
    , (response) ->
      $scope.erroOnSent = true;
      $timeout(->
        $scope.erroOnSent = false;
      , 6000);
    );