 
// var APP = APP || {};

// APP.postModel = (function() {
//   stub = {};

//   var posts = [];

//   var getPosts = function() {
//     return $.ajax({
//       url: '/posts',
//       contentType: 'application/json',
//       type: 'GET',
//       dataType: 'json',
//       success: buildPosts
//     })
//   };

//   var createPost = function(desc, user_id) {
//     var post = {
//       user_id: user_id,
//       description: desc
//     };

//     return $.ajax({
//       url: '/posts',
//       contentType: 'application/json',
//       type: 'POST',
//       dataType: 'json',
//       success: updatePosts,
//       data: function() {
//         console.log("i dunno what to do");
//       }
//     })
//   };

//   var buildPosts = function(response) {
//     posts = response;
//   };

//   var updatePosts = function(response) {
//     posts.push(response);
//   };

//   stub.init = function() {
//     return getPosts();
//   };

//   return stub;
// })();

// APP.postView = (function($) {
//   stub = {};

//   // var postPostListener = function(post) {
//   //   $('#post-submit').on('click', function(e) {
//   //     e.preventDefault();
//   //     var description = $('#post_description').val();
//   //     var user_id = $('h4[user-id]').attr('user-id');
//   //     APP.postController.createPost(description, user_id);
//   //   });
//   // }

//   var buildSinglePost = function(post) {
//     $post = $('');
//   }

//   var renderPosts = function(postsArr) {
//     for (var i in PostsArr) {
//       buildSinglePost(postsArr[i]);
//     }
//   };

//   stub.init = function () {
//     //postPostListener();
//   }

//   stub.render = function(postsArr) {
//     $('#comment-panels-box').empty();

//     renderPosts(postsArr)

//   };

//   return stub;
// })($);

// APP.postController = (function(Model, View) {
//   stub = {};

//   stub.init = function () {
//     var promise = Model.init();
//     promise.then(View.init());
//   };

//   stub.createPost = function(description, user_id) {
//     Model.createPost(description, user_id);

//   };

//   return stub;
// })(APP.postModel, APP.postView);

// $(document).ready(function() {
//   APP.postController.init();
// });