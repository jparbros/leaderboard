window.app ||= angular.module('LeaderboardApp', [
  'templates',
  'ngResource',
  'ngAnimate',
  'ngRoute',
  'ngCookies',
  'ngResource',
  'ng-token-auth',
  'ng-rails-csrf',
  'ui.bootstrap'
  ]).config( ($routeProvider, $locationProvider, $authProvider, $httpProvider) ->
    $routeProvider
      .when '/', {
        templateUrl: 'leaderboard/templates/index.html',
        controller: 'indexInputsCtrl',
        resolve:
          auth: ($auth) ->
            $auth.validateUser()
      }
      .when '/signup', {templateUrl: 'leaderboard/templates/users/new.html'}
      .when '/signin', {
        templateUrl: 'leaderboard/templates/user_sessions/new.html',
        controller: 'UserSessionsCtrl'}
      .when '/profile', {
        templateUrl: 'leaderboard/templates/index.html',
        controller: 'editUsersCtrl'}
      .when '/teams', {
        templateUrl: 'leaderboard/templates/index.html',
        controller: 'indexTeamsCtrl'
      }
      .when '/users', {
        templateUrl: 'leaderboard/templates/index.html',
        controller: 'indexTeamsCtrl'
      }
      .otherwise {redirectTo: '/'}

    $locationProvider.html5Mode(true)

    $authProvider.configure
      apiUrl: 'http://localhost:3000'

).run( ($rootScope, $location, Organization) ->

  $rootScope.$on '$routeChangeError', (ev) ->
    $location.path('/signin')

  $rootScope.$on 'auth:user-loaded', (ev) ->
    organization = Organization.get({id: $rootScope.user.organization_id })
    $rootScope.organization = organization

  $rootScope.$on 'auth:logout-success', (ev) ->
    $location.path('/signin')
)
