var PostModule = (function(){

  var getPosts = function(){
    return $('.post');
  };
  var clearPostForm = function(){
    //Doesn't work here, but works in the console
    $('#post_body').val(" ");
  };

  var removePost = function(){
    //How to get id info drom controller here?
    $('#post<%=@post.id%>').remove()
  };

  return {
    getPosts:getPosts,
    clearPostForm:clearPostForm,
    removePost:removePost
  };
})();