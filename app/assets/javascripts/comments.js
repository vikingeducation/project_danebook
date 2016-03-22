$(document).ready(function() {
  // Event listeners for sliding down comment form
  $("a.comment-link").on("click", function(e) {
    e.preventDefault();
    var $el = $(e.target);
    var form = $("[data-commentform='" + $el.attr("data-formid") + "']");
    form.slideDown(1000);
  });
});
