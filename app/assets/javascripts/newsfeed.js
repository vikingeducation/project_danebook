$(document).ready(function(){

  //when on main newsfeed page
  if ($('#newsfeed-index').length){

    $('#newsfeed-index').on('click', 
                            '#post-form input[type="submit"]', 
                            function(e){
                                console.log('clicked postform');
                              //submit ajax query for posting
                              e.preventDefault();
                            });

    $('#newsfeed-index').on('click', 
                            '.single-post .comment-link', 
                            function(e){
                              $target = $(e.target)
                              $commentForm = $target.parents('.single-post').find('.comment-form')
                              $commentForm.slideToggle('fast');
                              e.preventDefault();

                              //slideToggle comments
                            });



  };

});