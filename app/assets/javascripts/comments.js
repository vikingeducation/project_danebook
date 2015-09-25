var DANEBOOK = DANEBOOK || {}


DANEBOOK.CommentModule = (function () {

  function init() {
    _addListeners();
    $('.comment-form').hide();
  };

  function _addListeners() {
    $('#timeline, #photo-show, #newsfeed').on('click', '.toggle-comment', _toggleComment);
  };

  function _toggleComment() {
    var $wrapper = $( event.target.closest('[data-type]') );
    $wrapper.children('.comment-form, .comment-opener').toggle(250);
  };


  return {
    init: init,
  }

})();


$(document).on('page:change', function() {
  DANEBOOK.CommentModule.init();
})