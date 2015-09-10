var PostModule = (function(){

  var getPostList = function(){
    return $("#post-list");
  };

  //erb runs before js, so this doesn't work unless you pass in processed erb string
  var displayFlash = function(){
    return $("#flash-messages").html("<%= j(render partial: 'shared/flash') %>").slideDown();
  };

  return {
    getPostList: getPostList,
    displayFlash: displayFlash
  };

})();
