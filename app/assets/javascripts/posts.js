// var AJAX = AJAX || {}

// AJAX.POSTS = (function ($) {

//   var addNewPostToPage = function(response) {
//     console.log(response);


//   }

//   var useAJAX = function(e) {
//     var userID = $("input[name='user_id']").val();
//     var formData = $(e.target).serializeArray();

//     $.post({
//       url: "/users/" + userID + "/posts.json",
//       dataType: "json", 
//       data: formData,
//       success: addNewPostToPage
//     })
//   }

//   var addPostFormEventListener = function() {
//     $("form[data-form='AJAX']").submit(function(e) {
//       e.preventDefault();
//       useAJAX(e);
//     })
//   }

//   return {
//     init: function() {
//       addPostFormEventListener();
//     }
//   }
// })($);

// $(document).ready(function() {
//   // add event listener to form with id of "ajax_post_form"
//     // prevents default submit
//     // instead submits ajax request to posts#create
//     // posts#create returns the new post as a JSON object
//   // success callback on ajax method places new post in DOM and displays flash message
//   AJAX.POSTS.init();
// });

