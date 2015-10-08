AutoresponderApp

  .directive(
    'ensureUniqueEmailByList',
    ['SubscriberService',
      function(SubscriberService) {

    return {
      require: 'ngModel',
      link: function($scope, ele, attrs, c) {
        function validateEmailUnique() {
          if(this.last) {
            var _data = {
              email_uuid: $scope.email_list.secure_key,
              subscriber_id: $scope.subscriber.id,
              email: $scope.subscriber.email
            }

            SubscriberService.validateEmailUnique(_data).then(function(list) {
              c.$setValidity('unique', true);
            }, function(errorResponse) {
              c.$setValidity('unique', false);
            });
          }
        }
        $scope.$watch(attrs.ngModel, validateEmailUnique);
      }
    }
  }])

