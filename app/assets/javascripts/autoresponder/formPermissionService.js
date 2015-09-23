AutoresponderApp
  .factory('formPermissionService', ['Restangular',
                            function(
                              Restangular
                            ) {
    var model;

    model = 'api/v1/form_permissions';

    return {
      create: function(params) {
        return Restangular.all(model).post(params);
      },
    };
  }
]);

