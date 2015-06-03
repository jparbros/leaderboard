LeaderboardApp.controller 'newBuyCtrl', ($scope, $http, $routeParams, Subscription) ->
  $scope.partialUrl = "leaderboard/templates/buy/new.html";
  $scope.erroOnCreate = false
  $scope.buyForm = {
    subscription_kind: $routeParams.plan,
    credit_card_attributes: {},
    billing_address: {}
  }

  $http.get('/api/locations/countries').success (data) ->
    $scope.countries = data

  $scope.getRegions = ->
    country =  $scope.buyForm.billing_address.country
    $http.get('/api/locations/countries/' + country.alpha_2_code).success (data) ->
      $scope.regions = data

  $scope.submitForm = ->
    subscription = new Subscription({subscription: $scope.buyForm})
    subscription.$save({organization_id: $scope.organization.id})
    console.log(subscription)


  $scope.$watch('buyForm.credit_card_attributes.name', ->
    if $scope.buyForm.credit_card_attributes.name
      creditCardName = $scope.buyForm.credit_card_attributes.name.split(' ')
      $scope.buyForm.credit_card_attributes.first_name = creditCardName[0]
      $scope.buyForm.credit_card_attributes.last_name = creditCardName[creditCardName.length - 1]
  )

  $scope.$watch('buyForm.credit_card_attributes.expiry', ->
    if $scope.buyForm.credit_card_attributes.expiry
      creditCardExpiry = $scope.buyForm.credit_card_attributes.expiry.split('/')
      $scope.buyForm.credit_card_attributes.month = creditCardExpiry[0]
      $scope.buyForm.credit_card_attributes.year = creditCardExpiry[creditCardExpiry.length - 1]
  )