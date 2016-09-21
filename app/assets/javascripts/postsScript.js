var DANEBOOK = DANEBOOK || {}

DANEBOOK.posts = {

  init: function(){
    DANEBOOK.posts.hideCommentBoxes();
    DANEBOOK.posts.setCommentBoxListener();
  },

  hideCommentBoxes: function() {
    $('.write-comment').hide();
  },

  setCommentBoxListener: function(){
    $(".comment-link").click(function(event) {
     $(event.target).parents('#post-feedback').next().children(".write-comment").toggle(500);
    });
  }

};


$(document).ready(function() {
  DANEBOOK.posts.init();
});