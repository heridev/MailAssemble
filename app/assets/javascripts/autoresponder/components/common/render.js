AutoresponderApp.factory('Render', [
  'growl',
  function(growl) {
    return {
      showGrowlNotification:  function (type, message) {
        var config = {};

        switch (type) {
          case "success":
            growl.success(message, config);
            break;
          case "info":
            growl.info(message, config);
            break;
          case "warning":
            growl.warning(message, config);
            break;
          default:
            growl.error(message, config);
        }
      }
    }
}]);
