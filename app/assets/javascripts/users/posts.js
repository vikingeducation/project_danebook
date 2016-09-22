var DB = DB || {};

DB.posts = (function($) {

  var _clearPostText = function() {
    $('#post_text').val("");
  };

  var showNewPost = function(post) {
    var $post = $(post);
    _clearPostText();

    $post.hide();
    $('#post-box').after($post);
    $post.fadeIn(800);
  };

  var clearDeletedPost = function(postId) {
    $post = $('[data-id=' + postId + ']');
    $post.slideUp(800);
  };


  return {
    showNewPost:showNewPost,
    clearDeletedPost:clearDeletedPost
  };

})($);