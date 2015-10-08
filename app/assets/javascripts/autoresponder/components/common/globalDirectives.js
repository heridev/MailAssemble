AutoresponderApp
   .directive('ngAutoExpand', function() {
     return {
       restrict: 'A',
       link: function( $scope, elem, attrs) {
         $(elem).val('hello');
         elem.bind('keyup', function($event) {
           var element = $event.target;

           $(element).height(0);
           var height = $(element)[0].scrollHeight;

           // 8 is for the padding
           if (height < 20) {
             height = 28;
           }
           $(element).height(height-8);
         });

         // Expand the textarea as soon as it is added to the DOM
         setTimeout( function() {
           var element = elem;

           $(element).height(0);
           var height = $(element)[0].scrollHeight;

           // 8 is for the padding
           if (height < 20) {
             height = 28;
           }
           $(element).height(height-8);
         }, 0)
       }
     };
   })
