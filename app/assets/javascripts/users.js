var APP = APP || {};

APP.comment = (function(){
  var stub = {};

  stub.init = function(){
    $('.section-footer').hide();
    commentListener();
  };

  var addCommentLink = function(){
    var $a = $('<a>')
          .addClass('goofy-btn like-class')
          .attr("data-com-btn", "true")
          .text("Comments");
    $('.com-box').append($a);
  };

  var commentListener = function(){
    $('.com-box').on('click', '[data-com-btn="true"]', function(e){
      console.log($(e.target).closest('.post-wrapper'));
      $(e.target).closest('.post-wrapper').next().slideToggle(500);
    });
  };

  return stub;
})();

$(document).ready(function(){
  APP.comment.init();
});
