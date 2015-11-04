AutoresponderApp
  .factory('FollowUpService', ['Restangular',
                                 function(
                                   Restangular
                                 ) {
    var model;

    model = 'api/v1/follow_ups';

    return {
      create: function(params) {
        return Restangular.all(model).post(params);
      },

      sort: function(params) {
        // this will send the params to the endpoint post api/v1/questions/sort
        return Restangular.all(model + '/sort').post(params);
      },

      findAll: function(params) {
        return Restangular.all(model).customGET('', params);
      },

      destroy: function(followUpId, data) {
        return Restangular.one(model, followUpId).remove(data);
      },

      destroySendWindow: function(followUpId, data) {
        return Restangular.one(model + '/destroy_send_window', followUpId).remove(data);
      },

      findOne: function(followUpId, extra_params) {
        return Restangular.one(model, followUpId).get(extra_params);
      },

      update: function(params, followUpId) {
        return Restangular.one(model, followUpId).customPUT(params);
      },
    };
  }
]);
