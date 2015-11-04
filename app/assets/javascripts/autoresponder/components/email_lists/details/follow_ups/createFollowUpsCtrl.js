AutoresponderApp
  .controller('createFollowUpsCtrl', [
    '$scope',
    'Render',
    'findCurrentEmailListInParent',
    'FollowUpService',
    function (
      $scope,
      Render,
      findCurrentEmailListInParent,
      FollowUpService
    ) {

      $scope.follow_up = {
        send_windows_attributes: []
      }

      $scope.createFollowUp = function() {
        var _data;
        _data = {};

        _data.follow_up = $scope.follow_up;
        _.extend(_data, { email_uuid: findCurrentEmailListInParent.secure_key });

        FollowUpService.create(_data).then(function(follow_up) {
          // We are using email_list_count when adding a new follow up
          // in order to show/hide interval
          $scope.email_list.follow_ups_count +=1;

          Render.showGrowlNotification('success', 'The follow up was created successfully');
          return $scope.$state.go('^.edit', { followUpId: follow_up.id });
        }, function(errorResponse) {
          return Render.showGrowlNotification('warning', 'An error occurred while creating the follow up');
        });
      }
    }
  ])

