var clickListener = function(){
  $('[data-new-post-comment]').on('click', function(event){
    event.preventDefault();
    unHide(event.target);
    event.target.remove();
  });
};

var unHide = function(target){
  var targetID = $(target).data('new-post-comment');
  $('[data-new-post='+targetID+']').removeAttr('hidden').hide().slideDown('slow');
};

$(document).ready(function(){
  if ($('[data-page=posts-index]').length){
    clickListener();
  }
});