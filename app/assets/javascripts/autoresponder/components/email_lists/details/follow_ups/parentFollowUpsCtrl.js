AutoresponderApp
  .controller('parentFollowUpsCtrl', [
    '$scope',
    'Render',
    'Utils',
    'findCurrentEmailListInParent',
    'ngDialog',
    'FollowUpService',
    function (
      $scope,
      Render,
      Utils,
      findCurrentEmailListInParent,
      ngDialog,
      FollowUpService
    ) {

      $scope.validDaySelected = function(send_window) {
        var anySelectedDay = send_window.monday || send_window.tuesday || send_window.wednesday || send_window.thursday || send_window.friday || send_window.saturday || send_window.sunday
        return !anySelectedDay;
      }

      $scope.addSendWindowTo = function(follow_up) {
        follow_up.send_windows_attributes.push({
          sunday: false,
          monday: false,
          tuesday: false,
          wednesday: false,
          thursday: false,
          friday: false,
          saturday: false,
          isNotPersisted: true,
        })
      };

      $scope.removeSendWindowFrom = function(followUp, index, sendWindow) {
        followUp.send_windows_attributes.splice(index, 1);

        if(!sendWindow.isNotPersisted) {
          destroyFromDb(sendWindow);
        }
      };

      var destroyFromDb = function(sendWindow) {
        var data,
            followUpId,
            removeElements,
            sendWindowId;

        followUpId = $scope.$stateParams.followUpId;

        _data = {
          email_uuid: findCurrentEmailListInParent.secure_key,
          send_window_id: sendWindow.id
        };

        FollowUpService.destroySendWindow(followUpId, _data).then(function(successResponse) {
          return Render.showGrowlNotification('success', successResponse.status);
        }, function(errorResponse) {
          return Render.showGrowlNotification('warning', 'An error occurred while removing the send window');
        });
      };

      $scope.availableHours = [
        '00:00',
        '4:00',
        '8:00',
        '12:00',
        '16:00',
        '20:00',
        '24:00',
      ]
    }
  ])

