AutoresponderApp.factory('Utils', function() {
  return {
    // if you need to get if the url includes http or https
    httpProtocolUrlFor: function(url_params) {
      var domain, port;
      domain = window.location.protocol + "//" + window.location.hostname;
      port = window.location.port ? ":" + window.location.port : "";
      return domain + port + url_params;
    },

    isDefined: function(obj) {
      return angular.isDefined(obj) && obj !== null;
    },
  }
});
