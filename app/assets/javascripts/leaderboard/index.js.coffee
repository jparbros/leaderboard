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
        controller: 'indexCtrl',
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
      .otherwise {redirectTo: '/'}

    $locationProvider.html5Mode(true)

    $authProvider.configure
      apiUrl: 'http://localhost:3000'

    $httpProvider.defaults.useXDomain = true;
    delete $httpProvider.defaults.headers.common["X-Requested-With"];
).run( ($rootScope, $location) ->

  $rootScope.$on '$routeChangeError', (ev) ->
    $location.path('/signin')

  $rootScope.$on 'auth:logout-success', (ev) ->
    $location.path('/signin')
)
