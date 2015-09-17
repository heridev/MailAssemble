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
          template: '<h1>Welcome to our new autoresponder</h1>',
        })

    }
  ]);


