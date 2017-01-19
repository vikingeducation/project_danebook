var DANEBOOK = DANEBOOK || {}

DANEBOOK.Posts = (function($){
  var lastId = "last", userId, checking;

  var createElFromHTML = function createElFromHTML(html){
    var el = document.createElement("DIV");
    el.innerHTML = html;
    return el.firstChild
  }

  var checkNoPost = function checkNoPost(){
    var noPost = document.getElementById("no-posts");
    if(noPost)
      $(noPost).slideUp();
  }

  var insertPost = function(html){
    var el = createElFromHTML(html);
    el.style.display = "none"
    var timelineToInsert = document.getElementById("timeline"),
        newPostWrapper = document.getElementById("new_post_wrapper");
    checkNoPost();
    timelineToInsert.insertBefore(el, newPostWrapper.nextSibling);
    show(el)
    clearPostInput(newPostWrapper);
  }

  var appendPost = function(html){
    var el = createElFromHTML(html),
        timelineToInsert = document.getElementById("timeline");
    checkNoPost();
    el.style.display = "none"
    timelineToInsert.appendChild(el);
    show(el)
  }

  var show = function show(el){
    $(el).slideDown(250);
  }

  function contains(selector, text, wrapper) {
    var wrapper = wrapper || document,
        elements = wrapper.querySelectorAll(selector);
    return Array.prototype.filter.call(elements, function(element){
      return RegExp(text).test(element.textContent);
    });
  }

  var clearPostInput = function(wrapper){
    var inp = wrapper.getElementsByTagName("input")[0]
        ta  = wrapper.getElementsByTagName("textarea")[0]
    inp.value = null;
    ta.value = null;
  }

  var commentForm = function commentForm(postId, form){
    form.style.display = "none"
    var post = document.querySelector('.post[data-post-id="'+ postId +'"]'),
        footer = post.getElementsByClassName('post-footer')[0];
        commentLink = contains('a', 'Comment', post)[0];
        commentLink.style.pointerEvents = "none";
    footer.appendChild(form);
    show(form);
  }

  var showComments = function showComments(link){
    $(link).slideUp(0);
    var node = link.parentNode;
    while(!node.classList.contains("post")){
      node = node.parentNode
    }
    var comments = node.querySelector('.post-footer .comments')
    show(comments);
  }

  var getPosts = function getPosts(userId){
    $.ajax({
      url: '/users/'+ userId + '/posts?start_id=' + lastId
    }).then(function(){
      checking = false
    })
  }

  var setLastIndex = function setLastIndex(id){
    lastId = id;
  }

  var checkForTimeLine = function checkForTimeLine(){
    return document.getElementById('timeline');
  }

  var scrollListener = function scrollListener(){
    $(window).scroll(function(){
      if(!checkForTimeLine() || lastId === "end" || checking){
        return
      }
      checkScrollHeight();
    });
  }

  var checkScrollHeight = function checkScrollHeight() {
    if ($(window).scrollTop() >= $(document).height() - $(window).height() - 200){
      checking = true;
      getPosts(userId)
    }
  }

  var init = function init(timeline){
    lastId = "last"
    userId = timeline.getAttribute("data-user-id")
    getPosts(userId);
    scrollListener();
  };


  return {
    init: init,
    insert: insertPost,
    append: appendPost,
    showCommentForm: commentForm,
    showComments: showComments,
    getPosts: getPosts,
    setLastIndex: setLastIndex
  }
})($)
