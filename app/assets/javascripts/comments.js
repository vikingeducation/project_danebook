var CommentModule = (function(){

  var getCommentParent = function(parent){
    return $('div[data-type=comments-'+parent+']');
  };

  return {
    getCommentParent: getCommentParent,
  };

})();
