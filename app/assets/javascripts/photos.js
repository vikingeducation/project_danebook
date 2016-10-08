var APP = APP || {};

APP.photo = (function(){
  var stub = {};

  stub.init = function(){
    preventPhotoDelete();
  };

  var preventPhotoDelete = function() {
      $('form.button_to[data-remote="true"]').last().removeAttr("data-remote");
  };

  return stub;
})();
