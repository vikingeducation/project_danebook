$(document).ready(function(){

  slideCommentFormListener();
  
})

function slideCommentFormListener() {
  $(document).on('click', '.show-comment-form', function(e){
    e.preventDefault();
    var $target = $(e.target);
    slideCommentForm($target);
  });
}

function slideCommentForm($target) {
  var dataID = $target.data('id');
  var $form = $(".comment-form[data-id='" + dataID + "']");
  if ($form.css('display') == 'none') {
    $form.slideDown(300);
  } else {
    $form.slideUp(300);
  }
}