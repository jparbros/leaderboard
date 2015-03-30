LeaderboardApp.controller 'leaderboardCtrl', ($scope, $rootScope, User, Departament, Input) ->
  $scope.users = User.query({organization_id: $scope.user.organization_id});
  $scope.selectedPeriod = 'today'
  $scope.inputs = []
  $scope.leader = null
  Departament.query({organization_id: $scope.user.organization_id}, (teams)->
    $scope.teams = teams
    $scope.selectedTeam = teams[0]
  );


  $scope.selectTeam = (team) ->
    $scope.selectedTeam = team

  $scope.selectPeriod = (period) ->
    $scope.selectedPeriod = period

  $scope.getInputs = (newValue, oldValue) ->
    Input.query({organization_id: $scope.user.organization_id, departament_id: $scope.selectedTeam.id, period: $scope.selectedPeriod, group_by_user: true}, (inputs) ->
      angular.forEach(inputs, (input) ->
        input.currentTarget = switch $scope.selectedPeriod
          when 'today' then parseInt(input.target.daily)
          when 'week' then parseInt(input.target.weekly)
          when 'month' then parseInt(input.target.monthly)
          when 'quarter' then parseInt(input.target.quartly)
          when 'year' then parseInt(input.target.yearly)
        input.difference = input.currentTarget - input.realized
        input.fullfilment = (input.realized*100) / input.currentTarget
      )
      $scope.inputs = inputs
      $scope.leader = _.max($scope.inputs, (input) ->
        return input.fullfilment
      )
      console.log($scope.leader)
    ) if $scope.user.organization_id && $scope.selectedTeam && $scope.selectedPeriod

  $scope.$watch('selectedTeam', $scope.getInputs)
  $scope.$watch('selectedPeriod', $scope.getInputs)
