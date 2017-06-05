var APP = APP || {}

APP.Main = (function() {
  var init = function() {
    _setCommentWidth();
    _listenForCommentToggle();
  }

  function _setCommentWidth() {
    // we add a width here to prevent that slide jump glitch
    $('[data-toggle-target=comments]').width($('.post').width());

  }

  function _listenForCommentToggle() {
    console.log('listen for comment toggle');
    $('a[data-toggle="comments"]').on('click', function() {
      console.log('comments clicked');
      var $post = $('article[data-post-id=' + $(this).data('post-id') + ']');
      $post.find('[data-toggle-target=comments]').slideToggle();
    })
  }


  return {
    init: init
  }

})();

$(document).on('turbolinks:load', function() {
  APP.Main.init();
});