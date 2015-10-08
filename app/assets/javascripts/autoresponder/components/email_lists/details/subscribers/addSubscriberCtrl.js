AutoresponderApp
  .controller('addSubscriberCtrl', [
    '$scope',
    'findCurrentEmailListInParent',
    '$location',
    'Render',
    'SubscriberService',
    function (
      $scope,
      findCurrentEmailListInParent,
      $location,
      Render,
      SubscriberService
    ) {

      $scope.subscriber = {};

      $scope.addSubscriber = function() {
        var _data;
        _data = {};

        _data.subscriber = $scope.subscriber;
        _.extend(_data, { email_uuid: findCurrentEmailListInParent.secure_key });

        SubscriberService.create(_data).then(function(list) {
          Render.showGrowlNotification('success', 'The subscriber was created successfully');
          return $scope.$state.go('^.list');
        }, function(errorResponse) {
          return Render.showGrowlNotification('warning', 'An error occurred while creating the subscriber');
        });
      };
    }
  ])

