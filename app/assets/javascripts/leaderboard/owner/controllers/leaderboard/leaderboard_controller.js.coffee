ownerApp.controller 'leaderboardCtrl', ($scope, $rootScope, User, Departament, Input) ->
  $scope.users = User.query({organization_id: $scope.user.organization_id});
  $scope.selectedPeriod = 'today'
  $scope.inputs = []
  Departament.query({organization_id: $scope.user.organization_id}, (teams)->
    $scope.teams = teams
    $scope.selectedTeam = teams[0]
  );

  $scope.labels = ['2006', '2007', '2008', '2009', '2010', '2011', '2012'];
    $scope.series = ['Series A', 'Series B'];

    $scope.data = [
      [65, 59, 80, 81, 56, 55, 40],
      [28, 48, 40, 19, 86, 27, 90]
    ];

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
    ) if $scope.user.organization_id && $scope.selectedTeam && $scope.selectedPeriod

  $scope.$watch('selectedTeam', $scope.getInputs)
  $scope.$watch('selectedPeriod', $scope.getInputs)
