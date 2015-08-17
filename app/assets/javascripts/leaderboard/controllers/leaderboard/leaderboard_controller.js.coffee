LeaderboardApp.controller 'leaderboardCtrl', ($scope, $rootScope, User, Departament, Input, $timeout) ->
  $scope.users = User.query({organization_id: $scope.organization.id});
  $scope.selectedPeriod = 'today'
  $scope.inputs = []
  $scope.leader = null
  $scope.allTeams = {id: 'all_teams', period: ['daily', 'weekly', 'monthly', 'quarterly', 'yearly'], name: 'Total Team'}

  $scope.labels = ['Target', 'Difference'];
  $scope.data = [];

  $scope.selectTeam = (team) ->
    $scope.selectedTeam = team
    $scope.selectedPeriod = switch team.period[0]
      when 'daily' then 'today'
      when 'weekly' then 'week'
      when 'monthly' then 'month'
      when 'quarterly' then 'quarter'
      when 'yearly' then 'year'

  $scope.nextTeam = ->
    nextTeam = $scope.teams.indexOf($scope.selectedTeam) + 1
    if nextTeam >= $scope.teams.length
      nextTeam = 0
    team = $scope.teams[nextTeam]
    $scope.selectTeam(team)

  Departament.query({organization_id: $scope.organization.id}, (teams)->
    $scope.teams = teams
    $scope.selectTeam(teams[0])
  );

  $scope.selectPeriod = (period) ->
    $scope.selectedPeriod = period

  $scope.showPeriod = (period) ->
    if $scope.selectedTeam
      _.contains($scope.selectedTeam.period, period)

  $scope.ulClass = ->
    "periods-#{$scope.selectedTeam.period.length}" if $scope.selectedTeam

  $scope.getInputs = ->
    Input.query({organization_id: $scope.organization.id, departament_id: $scope.selectedTeam.id, period: $scope.selectedPeriod, group_by_user: true}, (inputs) ->

      $scope.inputs = $scope.calculateInputs(inputs)
      $scope.leader = _.max($scope.inputs, (input) ->
        return input.fullfilment
      )
      $scope.data = [$scope.leader.realized, $scope.leader.difference]
    ) if $scope.organization.id && $scope.selectedTeam && $scope.selectedPeriod

  $scope.calculateInputs = (inputs) ->
    angular.forEach(inputs, (input) ->
      input.currentTarget = switch $scope.selectedPeriod
        when 'today' then parseInt(input.target.daily)
        when 'week' then parseInt(input.target.weekly)
        when 'month' then parseInt(input.target.monthly)
        when 'quarter' then parseInt(input.target.quarterly)
        when 'year' then parseInt(input.target.yearly)
      input.difference = input.currentTarget - input.realized
      input.fullfilment = (input.realized*100) / input.currentTarget
    )

  $scope.rollingLeaderboard = ->
    if $scope.organization.rolling
      $timeout( ->
        $scope.getInputs();
        $scope.nextTeam();
        $scope.rollingLeaderboard()
      , ($scope.organization.rolling_time * 1000))


  $scope.$watch('selectedTeam', $scope.getInputs)
  $scope.$watch('selectedPeriod', $scope.getInputs)
  $scope.$watch('organization', $scope.rollingLeaderboard)
