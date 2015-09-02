LeaderboardApp.controller 'newBuyCtrl', ($scope, $http, $routeParams, Subscription, $location, $rootScope, Organization) ->
  $scope.partialUrl = "leaderboard/templates/buy/new.html";
  $scope.erroOnCreate = false
  $scope.subscription_kind = null
  $scope.stripeHandler = StripeCheckout.configure({
    key: 'pk_test_mR4Q3PLJ3OAQfHWOigpAeFxO',
    locale: 'auto',
    currency: 'EUR',
    token: (token) ->
      $scope.stripeResponse(token)
  })

  $http.get('/api/locations/countries').success (data) ->
    $scope.countries = data

  $scope.getRegions = (scope) ->
    $http.get('/api/locations/countries/' + scope.addressCountry.alpha_2_code).success (data) ->
      $scope.regions = data

  $scope.submitForm = (status, response) ->
    subscription = new Subscription({subscription: $scope.buyForm})
    subscription.$save({organization_id: $scope.organization.id})

  $scope.selectSubscriptionKind = (subscriptionKind) ->
    $scope.subscription_kind = subscriptionKind
    if subscriptionKind == 'monthly'
      description = 'Monthly Subscription'
      amount = 9900

    if subscriptionKind == 'yearly'
      description = 'Yearly Subscription'
      amount = 106800

    $scope.stripeHandler.open({
      name: 'RankingDesk',
      description: description,
      amount: amount
    });

  $scope.stripeResponse = (response) ->
    if(response.error)
      $scope.erroOnCreate = true
    else
      subscription = new Subscription({subscription: {
        subscription_kind: $scope.subscription_kind,
        card_number: response.card.last4,
        card_type: response.card.brand,
        token: response.id
      }})
      subscription.$save({organization_id: $scope.organization.id}, (data) ->
        Organization.get({id: $rootScope.user.organization_id }, (organization) ->
          $rootScope.organization = organization
          $location.path('/billing')
        )
      )