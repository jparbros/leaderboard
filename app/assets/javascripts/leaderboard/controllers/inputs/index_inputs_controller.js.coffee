LeaderboardApp.controller 'indexInputsCtrl', ($scope, $location, $resource, $modal, Input) ->
  $scope.partialUrl = "leaderboard/templates/inputs/main.html";
  $scope.inputsActive = true;
  $scope.currentPage = 1

  $scope.inputs = []

  $scope.willPaginateCollection = {
    currentPage: 0,
    perPage: 20,
    totalEntries: 1,
    totalPages: 1,
    offset: 0
  };

  $scope.willPaginateConfig = {
    previousLabel: '<< Prev',
    nextLabel: 'Next >>',
    outerWindow: 3
  };

  $scope.inputsOrder = {
    field: 'date',
    direction: 'desc'
  }

  $scope.getPage = (page) ->
    $scope.currentPage = page
    Input.paginate({organization_id: $scope.organization.id, page: page, order: $scope.inputsOrder.field, order_direction: $scope.inputsOrder.direction}, (inputs) ->
      $scope.inputs = inputs.entries
      $scope.willPaginateCollection.currentPage = inputs.current_page
      $scope.willPaginateCollection.perPage = inputs.per_page
      $scope.willPaginateCollection.totalEntries = inputs.total_entries
      $scope.willPaginateCollection.totalPages = inputs.total_pages
    );

  $scope.getOrderedPage = (field) ->
    if $scope.inputsOrder.field == field
      if $scope.inputsOrder.direction == 'ASC'
        $scope.inputsOrder.direction = 'DESC'
      else
        $scope.inputsOrder.direction = 'ASC'
    else
      $scope.inputsOrder.field = field
      $scope.inputsOrder.direction = 'DESC'

    $scope.getPage(1);

  $scope.getPage(1);

  $scope.openNewInput = ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/inputs/new.html',
      controller: 'newInputCtrl',

    modalInstance.result.then (input) ->
      $scope.inputs.push(input)

  $scope.openEditInput =  (input) ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/records/edit.html',
      controller: 'editRecordCtrl',
      resolve:
        input: ->
          input

    modalInstance.result

  $scope.openDialogDeleteInput = (input) ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/inputs/delete.html',
      controller: 'deleteInputCtrl',
      resolve:
        input: ->
          input

    modalInstance.result.then (input) ->
      $scope.getPage($scope.currentPage)