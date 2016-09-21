var APP = APP || {};

APP.photo = (function(){
  var stub = {};

  stub.init = function(){
    removeRemote();
  };

  var removeRemote = function(){
    $('.like-wrap .push-right form').removeAttr('data-remote');
  };

  return stub;
})();
