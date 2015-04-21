LeaderboardApp.controller 'newBuyCtrl', ($scope, $http) ->
  $scope.partialUrl = "leaderboard/templates/buy/new.html";
  $scope.erroOnCreate = false
  $scope.buyForm = {
    credit_card: {},
    billing_address: {}
  }

  $http.get('/api/locations/countries').success (data) ->
    $scope.countries = data

  $scope.submitForm = ->
    console.log("SUBMIT FORM")
