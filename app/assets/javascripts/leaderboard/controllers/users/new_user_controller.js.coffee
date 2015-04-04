LeaderboardApp.controller 'newUserCtrl', ($scope, $location, $timeout, Organization) ->
  $scope.erroOnLogin = false;
  $scope.registrationForm = {}
  $scope.availableDomain = null
  $scope.recommendedSubdoamin = ""

  $scope.hideSubdomainFeedback = ->
    return true if $scope.availableDomain == null
    $scope.availableDomain


  $scope.subdomainAvailability = ->
    subdomain = $scope.registrationForm.organization_attributes.subdomain
    Organization.availability({subdomain: subdomain}, (respond) ->
      $scope.availableDomain = respond.available
      $scope.recommendedSubdoamin = respond.recommendation unless respond.available
    )


