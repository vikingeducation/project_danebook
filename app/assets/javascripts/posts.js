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
    console.log(334343);
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

Posts.listToDelete();