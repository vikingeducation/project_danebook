var DB = DB || {};

DB.ajaxAPI = (function($) {

  var sendPost = function(postText, successFn) {
    var options = {
      url: "/posts",
      data: {
        post: {
          text: postText
        }
      },
      success: successFn,
      error: function(e) { console.log(e); }
    };

    $.ajax(options);
  };


  return {
    sendPost:sendPost
  };


})($);