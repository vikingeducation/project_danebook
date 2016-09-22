var DB = DB || {};

DB.comments = (function($) {

  var init = function() {
    _setupListeners();
  };

  var _setupListeners = function(){
    $('.timeline-right-column').on("click", ".comment-show", _showCommentBox);
    $('.timeline-right-column').on("click", ".comment-hide", function(e) {
      e.preventDefault();
      _hideCommentBox(e.target);
    });
  };

  var _clearCommentText = function(postId) {
    $('[data-id=' + postId + ']').find('.comment-text').val("");
  };

  var showNewComment = function(comment, postId) {
    var $comment = $(comment);
    var $commentList = $('[data-id=' + postId + ']').find('.comment-list');
    _clearCommentText(postId);
    _hideCommentBox($commentList);

    $comment.hide();
    $commentList.append($comment);
    $comment.fadeIn(800);
  };

  var clearDeletedComment = function(commentId) {
    $comment = $('[data-comment-id=' + commentId + ']');
    $comment.slideUp(200);
  };

  var _showCommentBox = function(e) {
    e.preventDefault();
    var $newComment = $(e.target).closest('.commentable').find('.new-comment');

    if ( $newComment.css('display') === 'none' ) {
      $newComment.slideDown(200);
    }
    else {
      _hideCommentBox(e.target);
    }

  };

  var _hideCommentBox = function(target) {
    var $newComment = $(target).closest('.commentable').find('.new-comment');
    $newComment.slideUp(200);
  };


  return {
    init:init,
    showNewComment:showNewComment,
    clearDeletedComment:clearDeletedComment
  };

})($);