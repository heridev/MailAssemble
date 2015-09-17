"use strict";
var AutoresponderApp = angular.module('AutoresponderApp', [
  'templates',
  'ui.router',
  'restangular',
]);

/* Run Block */
AutoresponderApp.run(
  [ '$rootScope',
    function ($rootScope) {
      $rootScope.appVer = 'v1';
    }
]
);

