var DANEBOOK = DANEBOOK || {}

DANEBOOK.posts = {

  init: function(){
    DANEBOOK.posts.setCommentBoxListener();
  },

  setCommentBoxListener: function(){
    $("#all-previous-posts").on("click",".comment-link", function(event) {
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