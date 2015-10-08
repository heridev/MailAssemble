AutoresponderApp
  .directive('undoNotification', [ '$timeout', function($timeout) {
    var timeoutId;

    var decorateLabelType = function(type) {
      var object_title;

      switch (type) {
        case "Subscriber":
          object_title = 'subscriber';
        break;
        case "EmailList":
          object_title = "email list";
        break;
        default:
          object_title = "";
      }

      return object_title;
    }

    return {
      restrict: 'A',
      link: function( $scope, elem, attrs) {

        $scope.$on('version:send_notification', function(evt, next, current) {
          // let's show the element
          $scope.undo_action = true;
          $scope.message_notification = decorateLabelType($scope.currentVersion.item_type);

          // we are canceling the previous timer
          // if a new one is created
          // in order to avoid closing the notification
          // right after deleting an element
          $timeout.cancel(timeoutId);

          var _this = this;

          timeoutId = $timeout(function() {
            $scope.undo_action = false;
          }, 10000);
          });
      }
    };
  }])
