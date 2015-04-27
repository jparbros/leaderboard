LeaderboardApp.controller 'newUserCtrl', ($scope, $location, Organization, $auth, $cookies) ->
  $scope.erroOnLogin = false;
  $scope.registrationForm = {}
  $scope.availableDomain = null
  $scope.recommendedSubdoamin = ""

  $scope.submitRegistrationForm = (registrationForm) ->
    $cookies['subdomain'] = registrationForm.organization_attributes.subdomain
    registrationForm.role = 'admin'
    registrationForm.owner = true
    $auth.submitRegistration(registrationForm).catch((respond)->
      $scope.erroOnLogin = true
    )


  $scope.hideSubdomainFeedback = ->
    return true if $scope.availableDomain == null
    $scope.availableDomain


  $scope.subdomainAvailability = ->
    subdomain = $scope.registrationForm.organization_attributes.subdomain
    Organization.availability({subdomain: subdomain}, (respond) ->
      $scope.availableDomain = respond.available
      $scope.recommendedSubdoamin = respond.recommendation unless respond.available
    )


