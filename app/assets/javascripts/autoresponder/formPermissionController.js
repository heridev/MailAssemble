AutoresponderApp
  .controller('formPermissionController', [
    '$scope',
    'formPermissionService',
    '$location',
    function (
      $scope,
      formPermissionService
    ) {

      $scope.custom_form = {}

      $scope.createNewForm = function() {
        var _data;
        _data = {};

        _data.form_permission = $scope.custom_form;

        formPermissionService.create(_data).then(function(form) {

          $scope.custom_form = form;

          alert('The form was created successfully');
        }, function(errorResponse) {
          alert('an error occured');
        });
      };

    }
  ])
