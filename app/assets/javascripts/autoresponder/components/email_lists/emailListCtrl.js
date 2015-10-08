AutoresponderApp
  .controller('emailListCtrl', [
    '$scope',
    'ngDialog',
    'Render',
    'EmailListService',
    function (
      $scope,
      ngDialog,
      Render,
      EmailListService
    ) {

      var loadEmailLists = function() {
        return EmailListService.findAll().then(function(email_list) {
          $scope.email_list = email_list;
        });
      };

      loadEmailLists();

      $scope.openModal = function(current_list) {
        $scope.current_list = current_list;
        ngDialog.open({
          template: 'autoresponder/components/email_lists/warningDestroy.html',
          className: 'ngdialog-theme-default',
          scope: $scope
        });
      };

      $scope.destroyEmailList = function(emailListId) {
        EmailListService.destroy(emailListId).then(function(removed_list) {
          Render.showGrowlNotification('success', 'The email list was deleted sucessfully');
          ngDialog.closeAll()
          return $scope.$state.go('email_list.list', {}, { reload: true });
        }, function(errorResponse) {
          return Render.showGrowlNotification('warning', 'An error occurred while deleting the email list');
        });
      }

    }
  ])

  .controller('emailListAddCtrl', [
    '$scope',
    'EmailListService',
    'Render',
    '$state',
    function (
      $scope,
      EmailListService,
      Render,
      $state
    ) {

      $scope.email_list = {};

      $scope.createEmailList = function() {
        var _data;
        _data = {};

        _data.email_list = $scope.email_list;

        EmailListService.create(_data).then(function(list) {
          Render.showGrowlNotification('success', 'The email list was created successfully');
          return $state.go('email_list.details.form', { emailListId: list.id } );
        }, function(errorResponse) {
          return Render.showGrowlNotification('warning', 'An error occurred while creating the email list');
        });
      };
    }
  ])

  .controller('emailListDetailsCtrl', [
    '$scope',
    '$location',
    'findCurrentEmailListInParent',
    'EmailListService',
    'Render',
    function (
      $scope,
      $location,
      findCurrentEmailListInParent,
      EmailListService,
      Render
    ) {

      $scope.email_list = findCurrentEmailListInParent;

      $scope.updateEmailList = function() {
        var _data;
        _data = {};

        _data.email_list = $scope.email_list;

        EmailListService.update(_data, $scope.email_list.id).then(function(email_list) {
          Render.showGrowlNotification('success', 'The email list was updated successfully');
          return $scope.email_list = email_list;
        }, function(errorResponse) {
          return Render.showGrowlNotification('warning', 'An error occurred while creating the email list');
        });
      };
    }
  ])
