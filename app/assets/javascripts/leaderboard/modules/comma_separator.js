LeaderboardApp.filter('comma_separator', function() {
  return function(input, scope) {
    if (input!=null || input!=undefined) {
      input = input.replace(',', ' ').replace('.', ',');
      return input;
    }
  }
});