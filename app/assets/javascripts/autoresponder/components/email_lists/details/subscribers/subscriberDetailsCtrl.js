AutoresponderApp
  .controller('subscriberDetailsCtrl', [
    '$scope',
    'Render',
    '$q',
    '$http',
    'findCurrentEmailListInParent',
    '$location',
    'SubscriberService',
    function (
      $scope,
      Render,
      $q,
      $http,
      findCurrentEmailListInParent,
      $location,
      SubscriberService
    ) {

      var data, subscriberId;

      _data = {
        email_uuid: findCurrentEmailListInParent.secure_key
      };

      subscriberId = $scope.$stateParams.subscriberId;

      var loadSubscriber = function() {
        return SubscriberService.findOne(subscriberId, _data).then(function(subscriber) {
          $scope.subscriber = subscriber;
        });
      };

      loadSubscriber();

      $scope.updateSubscriber = function() {
        var _data;
        _data = {};

        _data.subscriber = $scope.subscriber.plain();

        _.extend(_data, {email_uuid: findCurrentEmailListInParent.secure_key});

        SubscriberService.update(_data, $scope.subscriber.id).then(function(subscriber) {
          Render.showGrowlNotification('success', 'The subscriber was updated successfully');
          return $scope.subscriber = subscriber;
        }, function(errorResponse) {
          return Render.showGrowlNotification('warning', 'An error occurred while updating the subscriber');
        });

      };

      $scope.deleteSubscriber = function() {
        var _data;
        _data = {};

        _data = {
          email_uuid: findCurrentEmailListInParent.secure_key,
          id: $scope.subscriber.id,
        }

        SubscriberService.destroy($scope.subscriber.id, _data).then(function(version) {
          // using emit to comunicate events
          // from children to parents
          // if you want to use from parents to children
          // use broadcast instead
          $scope.$emit('version:destroyed', version.plain());
          Render.showGrowlNotification('success', 'The subscriber was deleted sucessfully');
          $scope.$state.go('email_list.details.subscribers.list');
        }, function(errorResponse) {
          return Render.showGrowlNotification('warning', 'An error occurred while deleting the subscriber');
        });

      };

      $scope.validateEmail = function(data) {
        var _data = {};

        _data = {
          email_uuid: findCurrentEmailListInParent.secure_key,
          id: $scope.subscriber.id,
          email: data
        }

        var d = $q.defer();

        SubscriberService.validateEmailSubscriberUpdate(_data).then(function(successResponse) {
          d.resolve()
        }, function(errorResponse) {
          d.reject(errorResponse.data.error);
        });

        return d.promise;
      }
    }
  ])

