// var already = false;
// $(function(){
//   already = true
//   var timeline = document.getElementById('timeline');
//   if(timeline){
//     DANEBOOK.Posts.getPosts(timeline.getAttribute("data-user-id"))
//   }
// });
$(document).on('turbolinks:load', function(){
  var timeline = document.getElementById('timeline');
  if(timeline){
    DANEBOOK.Posts.init(timeline)
  }
});
