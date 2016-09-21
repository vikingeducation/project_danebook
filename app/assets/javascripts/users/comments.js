var DB = DB || {};

DB.comments = (function($) {

  var init = function() {
    _setupListeners();
  };

  var _setupListeners = function(){

  };

  var _clearCommentText = function(postId) {
    $('[data-id=' + postId + ']').find('.comment-text').val("");
  };

  var showNewComment = function(comment, postId) {
    var $comment = $(comment);
    var $commentList = $('[data-id=' + postId + ']').find('.comment-list');
    _clearCommentText(postId);

    $comment.hide();
    $commentList.append($comment);
    $comment.fadeIn(800);
  };

  var clearDeletedComment = function(commentId) {
    $comment = $('[data-comment-id=' + commentId + ']');
    $comment.fadeOut(800);
  };


  return {
    init:init,
    showNewComment:showNewComment,
    clearDeletedComment:clearDeletedComment
  };

})($);