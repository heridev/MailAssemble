"use strict";
var AutoresponderApp = angular.module('AutoresponderApp', [
  'templates',
  'ui.router',
  'infinite-scroll',
  'angular-growl',
  'ngDialog',
  'xeditable',
  'ui.sortable',
  'restangular',
]);

/* Run Block */
AutoresponderApp.run(
  [ '$rootScope', '$state', '$stateParams',
    function ($rootScope, $state, $stateParams) {
      $rootScope.$state = $state;
      $rootScope.$stateParams = $stateParams;
      $rootScope.appVer = 'v1';
    }
]
);

AutoresponderApp
  .config([
      'growlProvider',
      function (growlProvider) {
        growlProvider.globalReversedOrder(true);
        growlProvider.globalDisableIcons(true);
        growlProvider.globalTimeToLive(2000);
      }
  ]);

