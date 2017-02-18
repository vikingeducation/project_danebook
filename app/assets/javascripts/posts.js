var PostModule = (function() {

  var getPostsDiv = function() {
    return $("div[data-content='posts']")
  };

  return {
    getPostsDiv
  }

})();