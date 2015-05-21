LeaderboardApp.directive('fullNameValidation', function() {
  return {
    require: '^ngModel',
    restrict: 'A',
    link: function(scope, elm, attrs, ngModel) {
      ngModel.$validators.fullName = function(modelValue) {
        if(modelValue != undefined) {
          return modelValue.split(' ').length > 1
        } else {
          return false
        }
      };
    }
  };
});
