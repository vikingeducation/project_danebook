// render new post partial
var newPost = "<%= j(render :partial => 'post', :locals => { :post => @new_post }) %>";
var $newPost = $(newPost);

var $posts = $("div[data-content='posts']");

$newPost.prependTo($posts).hide().slideDown(750);

$('#post_body').val('');