AutoresponderApp
  .controller('emailListSignupFormCtrl', [
    '$scope',
    '$sce',
    'findCurrentEmailListInParent',
    'Render',
    'Utils',
    function (
      $scope,
      $sce,
      findCurrentEmailListInParent,
      Render,
      Utils
    ) {

      var currentList = findCurrentEmailListInParent.plain();
      var subscribeUrl = "/api/v1/email_lists/subscribe/" + currentList.secure_key;
      var fullSubscribeUrl = Utils.httpProtocolUrlFor(subscribeUrl);

      $scope.subscribe_url = $sce.trustAsResourceUrl(fullSubscribeUrl);
      $scope.thank_you_page = currentList.thank_you_page_url;
      $scope.already_subscribed_page = currentList.already_subscribed_url;

      $scope.availablePublish = function() {
        return ($scope.email_list.thank_you_page_url && $scope.email_list.already_subscribed_url);
      }

      $scope.handlePublish = function() {
        if ($scope.availablePublish()) {
          // we are visiting a sibling called publish
          // because we are in the sibling called '.settings'
          $scope.$state.go('^.publish');
        } else {
          $scope.showNotificationRequiredFields();
        }
      }

      $scope.showNotificationRequiredFields = function() {
        Render.showGrowlNotification('warning', 'Before to publish the form you must select the custom urls');
      }
    }
  ])

