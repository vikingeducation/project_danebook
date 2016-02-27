var DANE = DANE || {}

DANE.Comments = (function() {

  var init = function () {
    setListeners();
  }

  var setListeners = function() {
    $(document).on("click", ".comment-box", toggleCommentForm)
  }

  var toggleCommentForm = function(event) {
    event.preventDefault();
    var $toggler = $(event.target)
    var dataId = $toggler.attr("data-commentable-id")
    var dataType = $toggler.attr("data-commentable-type")
    var $form = $("form.new_comment[data-commentable-id='" + dataId + "'][data-commentable-type='" + dataType + "']");
    if (($form).is(":visible")) {
      $form.slideUp(500)
    } else {
      $form.slideDown(500)
    };
  }

  var getCommentable = function (dataId, dataType) {
    return $("div[data-commentable-id='" + dataId + "'][data-commentable-type='" + dataType + "']");
  }

  var getComment = function (commentId) {
    return $("div[data-comment-id='" + commentId + "']");
  }

  return {
    init: init,
    getCommentable: getCommentable,
    getComment: getComment,
  }

})();

$(document).ready(function() {
  DANE.Comments.init();
})