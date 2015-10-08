AutoresponderApp
  .controller('mainCtrl', [
    '$scope',
    'Render',
    'versionControlService',
    function (
      $scope,
      Render,
      versionControlService
    ) {

      // hiden div notification by default
      $scope.undo_action = false;

      $scope.$on('version:destroyed', function(evt, next, current) {
        // listening to events this events is called
        // within the subscribersCtrl in deleteSubscriber method
        // we save the value that we want to use
        // in the undoAction
        $scope.currentVersion = next;
        // we are listening to this event in the undoNotification directive
        // so we can show hide the elements
        $scope.$emit('version:send_notification');
      });

      $scope.undoAction = function() {
        versionControlService.undo($scope.currentVersion.id).then(function(version) {
          // After undoing the action let's hide the element
          $scope.undo_action = false;
          Render.showGrowlNotification('success', 'The undo action was perfomed successfully');
          var state = versionControlService.handleRedirectState($scope.currentVersion);
          $scope.$state.go(state, {}, { reload: true });
        }, function(errorResponse) {
          return Render.showGrowlNotification('warning', 'An error occurred while deleting the subscriber');
        });


      }
    }
  ])
