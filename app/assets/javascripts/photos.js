var APP = APP || {};

APP.photo = (function(){
  var stub = {};

  stub.init = function(){
    removeRemote();
    photoClickListener();
  };

  var removeRemote = function(){
    $('.like-wrap .push-right form').removeAttr('data-remote');
  };

  var photoClickListener = function(){
    $('[data-target="#myModal"]').on('click', function(e){
      e.preventDefault();
    });
  };

  return stub;
})();
