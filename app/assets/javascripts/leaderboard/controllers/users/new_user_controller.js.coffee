LeaderboardApp.controller 'newUserCtrl', ($scope, $location, Organization, $auth, $cookies) ->
  $scope.erroOnLogin = false;
  $scope.registrationForm = {}
  $scope.availableDomain = null
  $scope.recommendedSubdoamin = ""
  $scope.msgError = ''

  $scope.submitRegistrationForm = (registrationForm) ->
    $cookies['subdomain'] = registrationForm.organization_attributes.subdomain
    registrationForm.role = 'admin'
    registrationForm.owner = true
    $auth.submitRegistration(registrationForm).catch((respond)->
      $scope.erroOnLogin = true
      $scope.msgError = respond.data[0]
    )


  $scope.hideSubdomainFeedback = ->
    return true if $scope.availableDomain == null
    $scope.availableDomain


  $scope.subdomainAvailability = ->
    if $scope.registrationForm.organization_attributes
      subdomain = $scope.registrationForm.organization_attributes.subdomain
      Organization.availability({subdomain_to_check: subdomain}, (respond) ->
        $scope.availableDomain = respond.available
        $scope.recommendedSubdoamin = respond.recommendation unless respond.available
      )

  $scope.organizationToSubdomain = ->
    subdomain = $scope.registrationForm.organization_attributes.name.parameterize()
    Organization.availability({subdomain_to_check: subdomain}, (respond) ->
      $scope.availableDomain = true
      if respond.available
        $scope.registrationForm.organization_attributes.subdomain = subdomain
      else
        $scope.registrationForm.organization_attributes.subdomain = respond.recommendation
   )

