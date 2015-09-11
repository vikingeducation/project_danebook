$(document).ready(function(){

  slideCommentFormListener();
  
})

function slideCommentFormListener() {
  $(document).on('click', '.show-comment-form', function(){
    slideCommentForm();
  });
}

function slideCommentForm() {
  var $form = $('.comment-form')
  if ($form.css('display') == 'none') {
    $form.slideDown(300);
  } else {
    $form.slideUp(300);
  }
}