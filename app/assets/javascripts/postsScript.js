var DANEBOOK = DANEBOOK || {}

DANEBOOK.posts = {

  init: function(){
    DANEBOOK.posts.hideCommentBoxes();
    DANEBOOK.posts.setCommentBoxListener();
    // DANEBOOK.posts.setPostListener();
  },

  hideCommentBoxes: function() {
    $('.write-comment').hide();
  },

  setCommentBoxListener: function(){
    $(".comment-link").click(function(event) {
     $(event.target).parents('#post-feedback').next().children(".write-comment").toggle(500);
    });
  },

  setPostListener: function() {
    $('#post-submit-button').click(function(event){
      event.preventDefault();
      var postText = $("#post_body").val();
      DANEBOOK.ajax.sendPost(postText)
    })
  }

};


$(document).ready(function() {
  DANEBOOK.posts.init();
});