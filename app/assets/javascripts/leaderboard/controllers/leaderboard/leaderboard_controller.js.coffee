LeaderboardApp.controller 'leaderboardCtrl', ($scope, $rootScope, User, Departament, Input, $interval, $timeout) ->
  $scope.users = User.query({organization_id: $scope.organization.id});
  $scope.selectedPeriod = 'today'
  $scope.inputs = []
  $scope.leader = null
  $scope.allTeams = {id: 'all_teams', period: ['daily', 'weekly', 'monthly', 'quarterly', 'yearly'], name: 'Total Team'}
  $scope.channel = null
  $scope.rollingLeaderboardSet = false
  $scope.newInput = {}
  $scope.showNewInput = false
  $scope.showTotal = false

  $scope.labels = ['Target', 'Difference'];
  $scope.data = [];
  dispatcher = new WebSocketRails('demo.rankingdesk.com/websocket');


  Departament.query({organization_id: $scope.organization.id}, (teams)->
    $scope.teams = angular.forEach(teams, (team) ->
      team.selected_period = team.period[0]
    )

    periods = _.pluck($scope.teams, 'period');

    i = 0
    show_totals = []
    while i < periods.length
      if periods[i+1]
        show_totals.push(periods[i] == periods[i+1])
      ++i
    $scope.showTotal =  _.reduce(show_totals, (show_total) ->
      return show_total;)

    $scope.selectTeam(teams[0])
  );

  setWebsocket = ->
    if $scope.channel == null
      console.log("SET CHANNEL");
      $scope.channel = dispatcher.subscribe('organization-' + $scope.organization.id);
      $scope.channel.bind('input_created', (data) ->
        console.log("GET DATA:", data);
        $scope.newInput = data
        $scope.showNewInput = true
        console.log($scope);
        $timeout(->
          $scope.newInput = {}
          $scope.showNewInput = false
        , 10000)
      );

  $scope.selectTeam = (team) ->
    $scope.selectedTeam = team
    $scope.selectedPeriod = switch team.selected_period
      when 'daily' then 'today'
      when 'weekly' then 'week'
      when 'monthly' then 'month'
      when 'quarterly' then 'quarter'
      when 'yearly' then 'year'
    $scope.getInputs()

  $scope.nextTeam = ->
    nextTeam = $scope.teams.indexOf($scope.selectedTeam) + 1
    nextTeam = 0 if nextTeam >= $scope.teams.length
    team = $scope.teams[nextTeam]
    if nextTeam == 0
      nextPeriod = team.period.indexOf(team.selected_period ) + 1
      nextPeriod = 0 if nextPeriod >= team.period.length
      team.selected_period = team.period[nextPeriod]
    $scope.selectTeam(team)

  $scope.selectPeriod = (period) ->
    $scope.selectedPeriod = period
    $scope.getInputs()

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
    if $scope.organization.rolling && $scope.rollingLeaderboardSet == false
      $scope.rollingLeaderboardSet = true
      $interval( ->
        $scope.nextTeam();
      , ($scope.organization.rolling_time * 1000))


  # $scope.$watch('selectedTeam', $scope.getInputs)
  # $scope.$watch('selectedPeriod', $scope.getInputs)
  $scope.$watch('organization', $scope.rollingLeaderboard)
  $scope.$watch('organization', setWebsocket)
