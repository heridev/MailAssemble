AutoresponderApp
  .factory('SubscriberService', ['Restangular',
                                 function(
                                   Restangular
                                 ) {
    var model;

    model = 'api/v1/subscribers';

    return {
      create: function(params) {
        return Restangular.all(model).post(params);
      },

      validateEmailUnique: function(params) {
        return Restangular.all(model + '/validate_email_uniqueness').post(params);
      },

      validateEmailSubscriberUpdate: function(params) {
        return Restangular.all(model + '/validate_email').post(params);
      },

      findAll: function(params) {
        return Restangular.all(model).customGET('', params);
      },

      destroy: function(subscriberId, data) {
        return Restangular.one(model, subscriberId).remove(data);
      },

      findOne: function(subscriberId, extra_params) {
        return Restangular.one(model, subscriberId).get(extra_params);
      },

      update: function(params, subscriberId) {
        return Restangular.one(model, subscriberId).customPUT(params);
      },
    };
  }
]);
