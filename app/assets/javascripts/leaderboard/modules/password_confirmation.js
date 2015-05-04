LeaderboardApp.directive('password-confirmation', function() {
  return {
    require: 'ngModel',
    restrict: 'A',
    link: function(scope, elm, attrs) {
      console.log(ctrl)
      ctrl.$validators.passwordConfirmation = function(modelValue, viewValue) {
        console.log(scope)

        return false;
      };
    }
  };
});

var compareTo = function() {
    return {
        require: "ngModel",
        restrict: 'A',
        scope: {
            otherModelValue: "=compareTo"
        },
        link: function(scope, element, attributes, ngModel) {

            ngModel.$validators.compareTo = function(modelValue) {
                return modelValue == scope.otherModelValue;
            };

            scope.$watch("otherModelValue", function() {
                ngModel.$validate();
            });
        }
    };
};

LeaderboardApp.directive("compareTo", compareTo);