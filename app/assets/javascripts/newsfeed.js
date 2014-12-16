$(document).on('page:load', function(){

  //when on main newsfeed page
  if ($('#post-feed').length){

    $('#post-feed').on('click', '.comment-link', 
        function(event){
          $parentPost = $(event.target).parents('.single-post')
          $parentPost.find('.comment-form').slideToggle('fast');
          event.preventDefault();
        });

  };
});
