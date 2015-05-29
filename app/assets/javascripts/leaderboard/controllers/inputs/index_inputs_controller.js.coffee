LeaderboardApp.controller 'indexInputsCtrl', ($scope, $location, $resource, $modal, Input) ->
  $scope.partialUrl = "leaderboard/templates/inputs/main.html";
  $scope.inputsActive = true;

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

  $scope.getPage = (page) ->
    Input.paginate({organization_id: $scope.organization.id, page: page }, (inputs) ->
      $scope.inputs = inputs.entries
      $scope.willPaginateCollection.currentPage = inputs.current_page
      $scope.willPaginateCollection.perPage = inputs.per_page
      $scope.willPaginateCollection.totalEntries = inputs.total_entries
      $scope.willPaginateCollection.totalPages = inputs.total_pages
    );

  $scope.getPage(1);

  $scope.openNewInput = ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/inputs/new.html',
      controller: 'newInputCtrl',
      size: 'lg'

    modalInstance.result.then (input) ->
      $scope.inputs.push(input)

  $scope.openEditInput =  (input) ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/records/edit.html',
      controller: 'editRecordCtrl',
      size: 'lg',
      resolve:
        input: ->
          input

    modalInstance.result

  $scope.openDialogDeleteInput = (input) ->
    modalInstance = $modal.open
      templateUrl: 'leaderboard/templates/inputs/delete.html',
      controller: 'deleteInputCtrl',
      size: 'lg',
      resolve:
        input: ->
          input

    modalInstance.result.then (input) ->
      index = $scope.inputs.indexOf(input)
      $scope.inputs.splice(index, 1)

