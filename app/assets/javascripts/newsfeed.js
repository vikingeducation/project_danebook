$(document).ready(function(){

  //when on main newsfeed page
  if ($('#post-feed').length){

    //Click the 'Comment' link and reveal a comment form
    $('#post-feed').on('click', '.comment-link',
        function(event){
          $parentPost = $(event.target).parents('.single-post')
          $parentPost.find('.comment-form').slideToggle('fast');
          event.preventDefault();
        });

  };
});
