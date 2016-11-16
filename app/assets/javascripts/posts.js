$(document).ready(function(){
  APP.PostModule.init();
});

var APP = APP || {};

APP.PostModule = (function(){
  var init = function(){
    setupListeners();
  };

  var setupListeners = function(){
    $(".comment-button").click(showCommentBox);
  };

  var showCommentBox = function(e){
    e.preventDefault();
    var parentId = $(e.target).attr('data-id');
    $(".com-form[data-id="+parentId+"]").slideToggle();
  };

  return{
    init: init
  };

})()
