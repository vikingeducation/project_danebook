var CommentModule = (function(){

  var getComments = function(targetID, targetType){
    
    return $('.'+targetType+'[data-id='+targetID+'] .comment-end-box .comment-section .comment-section').children();
  };

  var clearCommentForm = function(targetID, targetType){
    $('.'+targetType+'[data-id='+targetID+'] form textarea').val(" ");
  };

  var removeComment = function(targetID, targetType, commentID){
    $('.'+targetType+'[data-id='+targetID+'] .comment-section[data-id='+commentID+']').remove();
  };

  return {
    getComment:getComments,
    clearCommentForm:clearCommentForm,
    removeComment:removeComment
  };
})();