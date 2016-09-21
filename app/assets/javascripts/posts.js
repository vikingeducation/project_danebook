var Posts = (function() {

  var getPost = function() {

    $("#new_post").submit(function(e) {
      e.preventDefault();

      var data = e.target
      var _$post = $('textarea[name="post[content]"]').val();

      $ajaxSubmitPost(_$post)
    })
  }

  var listToDelete = function(){
    $("body").on("click", ".delete-section", function(e) {
      e.preventDefault();
      var id = $(this).data("post-id");
      var $div = $(".col-md-12[data-post-id=" + id + "]");
      deleteThis($div);
    })
  }

  var deleteThis = function(thing) {
    thing.remove();
  }

  var ajaxSubmitPost = function(post) {
    $.ajax({
        url: "/posts",
        method: "POST",
        data: JSON.stringify({ post: post }),
        contentType: "application/json",
        dataType: "json",
        success: function() {
          console.log("DA")
        }
      });
    };

return {
  getPost: getPost,
  listToDelete: listToDelete,
  deleteThis: deleteThis
}

})();
$(document).ready(function() {
  Posts.listToDelete()
})
