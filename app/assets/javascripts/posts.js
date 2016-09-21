// # Place all the behaviors and hooks related to the matching controller here.
// # All this logic will automatically be available in application.js.
// # You can use CoffeeScript in this file: http://coffeescript.org/


var Posts = (function() {

  var init = function() {
    if($('body').data('controller-id') === 'posts#index'){
      _hideCommentForms();
      _commentFormListener();
    }
  };

  var _hideCommentForms = function(){
    $('.new_comment').hide();
  };

  var _commentFormListener = function() {
    console.log('yo');
    $('.post-panel').on('click', '.comment-button', function(e) {
      var $target = $(e.target);
      var $parentPost = $target.closest('.post-panel');
      var $commentForm = $parentPost.find('.new_comment');
      if($commentForm.css('display') === 'none'){
        $commentForm.slideDown(500);
      } else {
        $commentForm.slideUp(500);
      }
    });
  };

  return {
    init: init
  };

})();

$(document).ready(function(){
  Posts.init();
});
