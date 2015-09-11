// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require turbolinks
//= require_tree .

// Override the default behavior of showing an alert
// We could refactor this into smaller functions,
// but I want to avoid polluting any other name spaces.
$.rails.allowAction = function(link) {
  var previousDataConfirm,
      previousText;

  if (!link.attr('data-confirm')) return true;
  previousDataConfirm = link.attr('data-confirm');
  previousText = link.text();

  link.removeAttr('data-confirm');
  link.text(previousDataConfirm);

  (function(link){
    setTimeout(function(){
      link.off("click")
      link.attr('data-confirm', previousDataConfirm);
      link.text(previousText);
    }, 2000)
    return link.click(function(){
      link.removeAttr('data-confirm');
      return true;
    })
  })(link)

  return false;
};
