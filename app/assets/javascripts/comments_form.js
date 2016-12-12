var CommentModule = (function() {
  var init = function(){
    hideCommentForms();
    commentClickListener();
  }

  var hideCommentForms = function() {
    $('.simple_form.new_comment').hide();
  }

  var commentClickListener = function() {
    $('.row.timeline-heading').on("click", function(){
      $(this).find('.new_comment').slideDown(500);
    })
  }

  return {
    init: init,
  }
})();