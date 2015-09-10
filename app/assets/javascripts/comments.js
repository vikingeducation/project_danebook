var DANE = DANE || {}

DANE.Comments = (function() {

  var getCommentable = function (dataId, dataType) {
    return $("div[data-commentable-id='" + dataId + "'][data-commentable-type='" + dataType + "']");
  }

  var getComment = function (commentId) {
    return $("div[data-comment-id='" + commentId + "']");
  }

  return {
    getCommentable: getCommentable,
    getComment: getComment,
  }

})();