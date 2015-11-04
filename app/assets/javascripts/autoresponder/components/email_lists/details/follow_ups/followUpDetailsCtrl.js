AutoresponderApp
  .controller('followUpDetailsCtrl', [
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

      var loadEmailListFollowUp = function() {

        var data, followUpId;

        _data = {
          email_uuid: findCurrentEmailListInParent.secure_key
        };

        followUpId = $scope.$stateParams.followUpId;

        return FollowUpService.findOne(followUpId, _data).then(function(follow_up) {
          $scope.follow_up = follow_up.plain();
        });

      };

      loadEmailListFollowUp();

      $scope.updateFollowUp = function() {
        var _data;
        _data = {};

        _data.follow_up = $scope.follow_up;
        _.extend(_data, { email_uuid: findCurrentEmailListInParent.secure_key });

        FollowUpService.update(_data, $scope.follow_up.id).then(function(follow_up) {
          Render.showGrowlNotification('success', 'The follow up was updated successfully');
          return $scope.follow_up = follow_up;
        }, function(errorResponse) {
          return Render.showGrowlNotification('warning', 'An error occurred while updating the follow up');
        });
      }
    }
  ])

