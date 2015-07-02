LeaderboardApp.controller 'newRecordCtrl', ($scope, $modalInstance, Input) ->
  $scope.erroOnCreate = false;
  $scope.inputForm = {}
  $scope.msgError = ''

  $scope.today = ->
    $scope.inputForm.date = new Date().toISOString().slice(0, 10)

  $scope.today()

  $scope.ok = ->
    $modalInstance.close();

  $scope.cancel = ->
    $modalInstance.dismiss('cancel');

  $scope.open = ($event) ->
    $event.preventDefault();
    $event.stopPropagation();

    $scope.opened = true;

  $scope.submitInput = (inputForm) ->
    input = new Input(inputForm)
    input.$save {user_id: $scope.user.id, organization_id: $scope.organization.id}, (input)->
      $modalInstance.close(input)
    , (error) ->
      $scope.erroOnCreate = true
      $scope.msgError = error.data[0]