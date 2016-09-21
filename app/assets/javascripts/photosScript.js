var DANEBOOK = DANEBOOK || {}

DANEBOOK.photos = {

  init: function(){
    DANEBOOK.photos.setCommentBoxListener();
  },

  setCommentBoxListener: function(){
    $("#photo-header-bar").on("click",".comment-link", function(event) {
     $(event.target).parents('#post-feedback').next().children(".write-comment").toggle(500);
    });
  }

};


$(document).ready(function() {
  DANEBOOK.photos.init();
});