window.LeaderboardApp ||= angular.module('LeaderboardApp', [
  'templates',
  'ngResource',
  'ngAnimate',
  'ngRoute',
  'ngCookies',
  'ngResource',
  'ng-token-auth',
  'ng-rails-csrf',
  'ui.bootstrap',
  'chart.js',
  'angularjs-dropdown-multiselect'
  ]).config( ($routeProvider, $locationProvider, $authProvider, $httpProvider) ->
    $routeProvider
      .when '/rankingdesk', {
        templateUrl: 'leaderboard/templates/index.html',
        controller: 'indexInputsCtrl',
        resolve:
          auth: ($auth) ->
            $auth.validateUser()
      }
      .when '/rankingdesk/signup', {templateUrl: 'leaderboard/templates/users/new.html'}
      .when '/rankingdesk/signin', {
        templateUrl: 'leaderboard/templates/user_sessions/new.html',
        controller: 'UserSessionsCtrl'}
      .when '/rankingdesk/profile', {
        templateUrl: 'leaderboard/templates/index.html',
        controller: 'editUsersCtrl',
        resolve:
          auth: ($auth) ->
            $auth.validateUser()
      }
      .when '/rankingdesk/teams', {
        templateUrl: 'leaderboard/templates/index.html',
        controller: 'indexTeamsCtrl',
        resolve:
          auth: ($auth) ->
            $auth.validateUser()
      }
      .when '/rankingdesk/users', {
        templateUrl: 'leaderboard/templates/index.html',
        controller: 'indexMembersCtrl',
        resolve:
          auth: ($auth) ->
            $auth.validateUser()
      }
      .when '/rankingdesk/users/new', {
        templateUrl: 'leaderboard/templates/index.html',
        controller: 'newMemberCtrl',
        resolve:
          auth: ($auth) ->
            $auth.validateUser()
      }
      .when '/rankingdesk/users/:id/edit', {
        templateUrl: 'leaderboard/templates/index.html',
        controller: 'editMemberCtrl',
        resolve:
          auth: ($auth) ->
            $auth.validateUser()
      }
      .when '/rankingdesk/leaderboard', {
        templateUrl: 'leaderboard/templates/leaderboard/index.html',
        controller: 'leaderboardCtrl',
        resolve:
          auth: ($auth) ->
            $auth.validateUser()
      }
      .when '/rankingdesk/input', {
        templateUrl: 'leaderboard/templates/index.html',
        controller: 'indexInputsCtrl',
        resolve:
          auth: ($auth) ->
            $auth.validateUser()
      }
      .when '/rankingdesk/records', {
        templateUrl: 'leaderboard/templates/records/index.html',
        controller: 'indexRecordsCtrl',
        resolve:
          auth: ($auth) ->
            $auth.validateUser()
      }
      .when '/rankingdesk/boardlogin/settings', {
        templateUrl: 'leaderboard/templates/index.html',
        controller: 'settingsBoardloginCtrl',
        resolve:
          auth: ($auth) ->
            $auth.validateUser()
      }

      .otherwise {redirectTo: '/rankingdesk'}

    $locationProvider.html5Mode(true)

    $authProvider.configure
      apiUrl: 'http://localhost:3000/'

).run( ($rootScope, $location, Organization) ->

  $rootScope.$on '$routeChangeError', (ev) ->
    $location.path('/rankingdesk/signin')

  $rootScope.$on 'auth:user-loaded', (ev) ->
    Organization.get({id: $rootScope.user.organization_id }, (organization) ->
      $rootScope.organization = organization
    )

  $rootScope.$on 'auth:registration-email-success', (ev) ->
    $location.path('/rankingdesk/signin')

  $rootScope.$on 'auth:logout-success', (ev) ->
    $location.path('/rankingdesk/signin')
)
