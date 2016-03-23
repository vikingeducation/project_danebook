var CommentModule = ( function(){ 

  var getCommentForm = function(){
    return $(".new-comment-form");
  }

  var attachCommentListeners = function(){
    _showCommentFormListener();
  }

  var _showCommentFormListener = function(){

    $(".show-comment-form").click( function( event ){
      
      event.preventDefault();
      var $el = $( event.target );

      $($el.parents()[1].children[1]).show();
      $el.hide();
    });
  }

  var _hideCommentForm = function() {
    getCommentForm().hide();
    var tag = '<div class="show-comment-form"><a href="#"">Comment</a></div>' ;
    $(".post-comments").append(tag) ;
  }

  return {
    attachCommentListeners: attachCommentListeners,
    hideCommentForm: _hideCommentForm,
  }

})();

$( document ).ready( function(){  
  CommentModule.hideCommentForm();
  CommentModule.attachCommentListeners();
});