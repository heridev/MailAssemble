AutoresponderApp
  .controller('followUpsCtrl', [
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

      var loadEmailListFollowUps = function() {

        var _data = {
          email_uuid: findCurrentEmailListInParent.secure_key,
        }

        return FollowUpService.findAll(_data).then(function(messages) {
          $scope.follow_up_messages = messages.plain();
        });
      };

      loadEmailListFollowUps();

      $scope.openModal = function(current_follow_up) {
        $scope.current_follow_up = current_follow_up;
        ngDialog.open({
          template: 'autoresponder/components/email_lists/details/follow_ups/warningDestroy.html',
          className: 'ngdialog-theme-default',
          scope: $scope
        });
      };

      $scope.destroyFollowUp = function(followUpId) {
        var data;
        _data = {};

        _data.follow_up = $scope.follow_up;
        _.extend(_data, { email_uuid: findCurrentEmailListInParent.secure_key });

        FollowUpService.destroy(followUpId, _data).then(function(removed_list) {
          Render.showGrowlNotification('success', 'The follow up was deleted sucessfully');
          ngDialog.closeAll()
          return $scope.$state.go('^.list', {}, { reload: true });
        }, function(errorResponse) {
          return Render.showGrowlNotification('warning', 'An error occurred while deleting the follow up');
        });
      }

      $scope.sortableRows = {
        // we are sending the new array with order
        stop: function(e, ui) {
          // we trigger the update only when the item has changed
          if(Utils.isDefined(ui.item.sortable.dropindex)){
            var newOrderElements,
            elementsIds;

            newOrderElements = ui.item.sortable.sourceModel;
            elementIds = _.pluck(newOrderElements, 'id');

            var _data = {};
            _data.element_ids = elementIds;
            _.extend(_data, { email_uuid: findCurrentEmailListInParent.secure_key });

            FollowUpService.sort(_data).then(function(rows) {
              Render.showGrowlNotification('success', 'The order was changed successfully');
            }, function(errorResponse) {
              return Render.showGrowlNotification('warning', 'An error occurred while deleting the follow up');
            });
          }

        },
      };
    }
  ])

