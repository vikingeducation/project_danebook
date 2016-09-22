var DB = DB || {};

DB.likes = (function($) {

  var _clearPostText = function() {
    $('#post_text').val("");
  };

  var updatePostLikes = function($post, likeHTML, countHTML) {
    $post.find('.post-like').html(likeHTML);
    $post.find('.post-like-count').html(countHTML);
  };

  var updateCommentLikes = function($comment, likeHTML) {
    console.log(likeHTML)
    $comment.find('.comment-like').html(likeHTML);
  };


  return {
    updatePostLikes:updatePostLikes,
    updateCommentLikes:updateCommentLikes
  };

})($);