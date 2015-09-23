/* States */
AutoresponderApp
  .config(['$stateProvider', '$urlRouterProvider', '$httpProvider',
    function ($stateProvider, $urlRouterProvider, $httpProvider) {
      // Use $urlRouterProvider to configure any redirects (when) and invalid urls (otherwise).
      $urlRouterProvider
        .when('/home', '/')
        .otherwise('/');

      // State Configurations
      $stateProvider
        .state("home", {
          url: "/",
          controller: 'formPermissionController',
          templateUrl: 'autoresponder/create_form.html',
        })

    }
  ]);


