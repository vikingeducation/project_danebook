var DANE = DANE || {}

DANE.Posts = (function() {

  var getPostsContainer = function () {
    return $("#new_post").parent();
  }

  var getPost = function (postId) {
    return $("article[data-post-id='" + postId + "']");
  }

  return {
    getPostsContainer: getPostsContainer,
    getPost: getPost,
  }

})();