AutoresponderApp
  .factory('EmailListService', ['Restangular',
                            function(
                              Restangular
                            ) {
    var model;

    model = 'api/v1/email_lists';

    return {
      findAll: function(params) {
        return Restangular.all(model).getList(params);
      },

      create: function(params) {
        return Restangular.all(model).post(params);
      },

      findOne: function(emailListId) {
        return Restangular.one(model, emailListId).get();
      },

      update: function(params, emailListId) {
        return Restangular.one(model, emailListId).customPUT(params);
      },

      destroy: function(emailListId) {
        return Restangular.one(model, emailListId).remove();
      },
    };
  }
]);

