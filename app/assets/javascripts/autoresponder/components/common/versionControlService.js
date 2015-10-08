AutoresponderApp
  .factory('versionControlService', ['Restangular',
                            function(
                              Restangular
                            ) {
    var model;

    model = 'api/v1/versions';

    return {
      undo: function(versionId) {
        var _params = {
          id: versionId
        }
        return Restangular.all(model + '/undo').post(_params);
      },

      handleRedirectState: function(version) {
        var state;

        switch (version.item_type) {
          case "Subscriber":
            state = 'email_list.details.subscribers.list';
          break;
          case "EmailList":
            state = 'email_list.details.subscribers.list';
          break;
          default:
            state = ''
        }

        return state;
      }
    };
  }
]);
