LeaderboardApp.controller 'newUserCtrl', ($scope, $location, Organization, $auth, ipCookie) ->
  $scope.erroOnLogin = false;
  $scope.registrationForm = {}
  $scope.availableDomain = null
  $scope.recommendedSubdoamin = ""
  $scope.msgError = ''

  $scope.submitRegistrationForm = (registrationForm) ->
    ipCookie('subdomain', registrationForm.organization_attributes.subdomain, { path: '/', domain: 'rankingdesk.com' })
    registrationForm.role = 'admin'
    registrationForm.owner = true
    registrationForm.active = true
    $auth.submitRegistration(registrationForm).catch((respond)->
      ipCookie.remove('subdomain')
      $scope.erroOnLogin = true
      error_key = Object.keys(respond.data['errors'])[0];
      $scope.msgError = respond.data['errors'][error_key][0]
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

