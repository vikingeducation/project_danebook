var DANEBOOK = DANEBOOK || {};

DANEBOOK.commentListener = function() {
  $('body').on('click', '.make_comment', function(e) {
    e.preventDefault();
    var formID = $(e.target).attr('data-form-id');
    $('#comment_form_' + formID).slideToggle();
  });
};

$(document).ready(function() {
  DANEBOOK.commentListener();
});

// $(window).load(function() {
//   DANEBOOK.commentListener();
//   DANEBOOK.showCommentLink();
// });
