$(document).ready(function(){

  //when on main newsfeed page
  if ($('#post-feed').length){

    $('#post-feed').on('click', '.single-post .comment-link', 
        function(event){
          $target = $(event.target)
          $commentForm = $target.parents('.single-post').find('.comment-form')
          $commentForm.slideToggle('fast');
          event.preventDefault();
        });

  };
});
