var APP = APP || {};

APP.photo = (function(){
  var stub = {};

  stub.init = function(){
    removeRemote();
    photoClickListener();
  };

  return stub;
})();
