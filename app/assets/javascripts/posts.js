

var expandComment = function() {
  $('.expand-comment').click(function(e) {

    var parentId = $(e.target).parent().data("pid")
    var itemToChange = '[data-pid=' + parentId + ']';
    $( itemToChange + ' .new-comment').toggle(800)

    if ($(itemToChange + ' .expand-comment').text() === "Hide") {
      $(itemToChange + ' .expand-comment').text("Comment")
    } else {
      $(itemToChange + ' .expand-comment').text("Hide")
    }
    
  })
}



$(document).ready(function() {
  expandComment();
})