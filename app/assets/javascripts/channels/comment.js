var Comments = (function() {

  var findComment = function() {
    $("body").on("click", ".delete-comment", function(e) {
      var commentId = ($(this).data("comment-id"))
      deleteComment(commentId);
    })
  }

  var deleteComment = function(id) {
    $(".comment-show[data-comment-id=" + id + "]").remove();
  }

  return {
    findComment: findComment
  }

})();