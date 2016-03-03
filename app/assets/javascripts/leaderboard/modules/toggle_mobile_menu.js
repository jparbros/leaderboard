LeaderboardApp.directive('toggleMobileMenu', function() {
  return {
    restrict: 'A',
    link: function(scope, elem, attrs) {
      elem.bind('click', function() {
         $('.main-row').toggleClass('toggled');
      });
    }
  };
});