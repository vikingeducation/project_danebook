var CommentModule = (function() {

  var getPost = function(postId) {
    return $("div[data-post-id='" + postId + "']")
  };

  return {
    getPost
  }

})();