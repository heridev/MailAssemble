AutoresponderApp
  .controller('emailListCtrl', [
    '$scope',
    'EmailListService',
    function (
      $scope,
      EmailListService
    ) {

      var loadEmailLists = function() {
        return EmailListService.findAll().then(function(email_list) {
          $scope.email_list = email_list;
        });
      };

      loadEmailLists();

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
