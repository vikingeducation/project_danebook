var PostModule = (function(){

  var getPosts = function(){
    return $('.post');
  };
  var clearPostForm = function(){
    
    $('#post_body').val(" ");
  };

  var removePost = function(id){
    $('#post'+id).remove();
  };

  return {
    getPosts:getPosts,
    clearPostForm:clearPostForm,
    removePost:removePost
  };
})();



