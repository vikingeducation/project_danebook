var DANEBOOK = DANEBOOK || {}

DANEBOOK.Flashes = (function($){
  var createFlashWrapper = function createFlashWrapper(){
    var el = document.createElement('DIV');
    el.style.display = "none";
    return el
  }

  createFlash = function createFlash(status, msgs){
    var htmlStr = '<div class="alert alert-block alert-'+ status + '">'
    for(var i = 0; i < msgs.length; i++ ){
      htmlStr +='<p>'+ msgs[i] +'</p>';
    }
    return htmlStr += '</div>'
  }

  var removeFlash = function removeFlash(target, flash){
    setTimeout(function(){
      $(flash).slideUp(500, $(flash).remove)
    },2000);
  }

  var setFlash = function setFlash(target, msgs, status){
    var wrapper = createFlashWrapper();
    wrapper.innerHTML = createFlash(status, msgs);
    target.appendChild(wrapper);
    $(wrapper).slideDown(500, removeFlash(target, wrapper));
  }

  var addFlash = function(status, msgs, target){
    target = target || document.getElementById('flash-box')
    setFlash(target, msgs, status);
  }

  return addFlash;
})($)
