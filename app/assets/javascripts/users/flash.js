var DB = DB || {};

DB.flash = (function($) {

  var init = function() {
    _setupListeners();
  };

  var _setupListeners = function(){
    $('#flash-messages').bind("DOMSubtreeModified", _hideFlashes);
  };

  var _hideFlashes = function() {
    setTimeout(function() {
      $('#flash-messages').slideUp(1000, function() {
        $('#flash-messages').html("");
      });
    }, 3000);
  };

  var showFlashes = function(flashes) {
    console.log("Flash appears!")
    var $flashes = $(flashes);
    $flashes.hide();
    $("#flash-messages").html($flashes);
    $flashes.slideDown(400);
  };


  return {
    init:init,
    showFlashes:showFlashes
  };

})($);