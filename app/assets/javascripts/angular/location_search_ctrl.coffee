@LocationSearchCtrl = ['$scope', '$http', 'Location', ($scope, $http, Location) ->

  $scope.init = (targetField, existingLocationId) ->
    $scope.targetField = targetField
    $scope.existingLocationId = existingLocationId
    $scope.searchTerms = ""
    $scope.searchingLocations = false

  $scope.search = () ->
    request = $http.get '/locations/search.json', params: { q: $scope.searchTerms }
    request.then(
      (success_result) ->
        $scope.results = success_result.data
    )

  $scope.onKeyUp = ($event) ->
    if $scope.searchTerms.length >= 3
      $scope.search()

  $scope.setLocationId = () ->
    angular.element($scope.targetField).val($scope.location.id)
    return true

  $scope.selectLocation = ($event, location) ->
    $event.preventDefault()
    $scope.location = location
    $scope.setLocationId()
    $scope.searchingLocations = false
    $scope.searchTerms = ""

  $scope.displaySearchForm = ($event) ->
    $event.preventDefault()
    $scope.searchingLocations = true

  $scope.cancelSearch = ($event) ->
    $event.preventDefault()
    $scope.searchingLocations = false
    $scope.existingLocationId = null
    angular.element($scope.targetField).val("")
    $scope.searchTerms = ""
    $scope.location = ""

]