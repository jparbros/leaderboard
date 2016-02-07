LeaderboardApp.controller 'newBuyCtrl', ($scope, $http, $routeParams, Subscription, $location, $rootScope, Organization, $timeout) ->
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

  $rootScope.organization.address_attributes = {}

  $http.get('/api/locations/countries').success (data) ->
    $scope.countries = data

  $scope.submitForm = (status, response) ->
    subscription = new Subscription({subscription: $scope.buyForm})
    subscription.$save({organization_id: $scope.organization.id})

  $scope.selectSubscriptionKind = (subscriptionKind) ->
    $scope.subscription_kind = subscriptionKind

  $scope.submitForm = ->
    if $scope.subscription_kind == 'monthly'
      description = 'Monthly Subscription'
      amount = 9900

    if $scope.subscription_kind == 'yearly'
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
      $('#modal-processing').modal();
      subscription = new Subscription({subscription: {
        subscription_kind: $scope.subscription_kind,
        card_number: response.card.last4,
        card_type: response.card.brand,
        token: response.id
      }})

      subscription.$save({organization_id: $scope.organization.id}, (data) ->
        $rootScope.organization.$update({id: $rootScope.user.organization_id }, (organization) ->
          $('#modal-processing').modal('hide');
          $rootScope.organization = organization;
          $timeout( ->
            $location.url('/billing?payment=true')
          , 500);

        )
      )