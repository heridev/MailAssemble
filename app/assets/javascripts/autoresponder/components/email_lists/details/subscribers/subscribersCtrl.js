AutoresponderApp
  .controller('subscribersCtrl', [
    '$scope',
    'findCurrentEmailListInParent',
    '$location',
    'SubscriberService',
    function (
      $scope,
      findCurrentEmailListInParent,
      $location,
      SubscriberService
    ) {

      var initialSetup = function(){
        $scope.page_number = $scope.$stateParams.pageNumber || 1;
        $scope.subscribers = [];
        $scope.loading_subscribers = false;

        // we are initializing this value as false
        $scope.inifiteScrollStatus = true;
      }

      initialSetup();

      var loadEmailListSubscribers = function() {
        if($scope.loading_subscribers) { return };
        $scope.loading_subscribers = true;

        var _data = {
          email_uuid: findCurrentEmailListInParent.secure_key,
          page_count: $scope.page_number
        }

        return SubscriberService.findAll(_data).then(function(successResponse) {
          $scope.loading_subscribers = false
          $scope.subscribers = $scope.subscribers.concat(successResponse.subscribers);
          $scope.subscribers_count = successResponse.tot_subscribers;
          $scope.page_number = successResponse.page_count + 1;
          $scope.tot_pages = successResponse.tot_pages;
          $scope.inifiteScrollStatus = false;
        });
      };

      $scope.loadMoreSubscribers = function() {
        if(showLoadMore()) {
          loadEmailListSubscribers();
        }
      };

      var showLoadMore = function() {
        return ($scope.page_number <= $scope.tot_pages);
      }

      loadEmailListSubscribers();

      $scope.goToSubscriberDetails = function(subscriberId) {
        $scope.$state.go('^.show.details', { subscriberId: subscriberId })
      }
    }
  ])

