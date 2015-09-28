AutoresponderApp

   .directive(
     'replaceTextareaValues',
     ['$compile', 'templateManager', '$timeout',
     function($compile, templateManager, $timeout) {

     var selectedTemplate = templateManager.loadTemplate('template_one');;

     return {
       restrict: 'A',
       templateUrl: 'autoresponder/components/email_lists/details/signup_forms/publish.html',
       scope: true,
       link: function($scope, elem, attrs) {

         // element included in the template
         var hiddenElem = $('#hidden');;
         $scope.previewer = '';

         function update() {

           if (selectedTemplate) {

             $compile(hiddenElem.html(selectedTemplate))($scope);

             $timeout( function(){
               $scope.previewer = hiddenElem.html();
             }, 0);
           }
         }

         $scope.$watch('template', update);
       }
     };
   }])
