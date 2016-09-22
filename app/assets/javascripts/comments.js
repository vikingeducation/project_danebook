var Comments = (function() {

  var findComment = function() {
    $("body").on("click", ".delete-comment", function(e) {
      var commentId = ($(this).data("comment-id"))
      deleteComment(commentId);
    })
  }

  var findLastComment = function () {
    $("body").on("click", ".comment-section", function(e) {
      var postId = ($(this).data("post-id"));
      var lastComment = $(".comment-show[data-post-id=" + postId + "]").last()
      //console.log(lastComment);
    })
  }

  var deleteComment = function(id) {
    $(".comment-show[data-comment-id=" + id + "]").remove();
  }

  return {
    findComment: findComment,
    findLastComment: findLastComment
  }

})();