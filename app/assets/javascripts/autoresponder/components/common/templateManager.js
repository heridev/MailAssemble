AutoresponderApp.factory('templateManager', function() {
  return {
    loadTemplate:  function (template_name) {
      var template;
      switch (template_name) {
        case "template_one":
          //lets add the redirect_to for already subscribed and thank you page elements
          template = "<form action='{{subscribe_url}}' id='embeded-subscribe-autoresponder' method='post' name='embeded_subscribe_autoresponder' novalidate='' target='_blank'>\n<label for='subscribe_email'>Email Address</label>\n<input name='subscribe_email' type='email' value=''>\n<label for='subscribe_name'>Full Name</label>\n<input name='subscribe_name_input' type='text' value=''>\n<input type='hidden' name='thank_you_page' value='{{thank_you_page}}'/>\n<input type='hidden' name='already_subscribed_page' value='{{already_subscribed_page}}'/><br>\n<input name='subscribe-submit' type='submit' value='Subscribe'>\n</form>";
          break;
        case "template_two":
          template = "template_two";
          break;
        default:
          template = "";
      }

      return template;
    }
  }
});
