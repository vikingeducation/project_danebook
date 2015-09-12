// Override the default behavior of showing an alert
// We could refactor this into smaller functions,
// but I want to avoid polluting any other name spaces.
$.rails.allowAction = function(link) {
  var previousDataConfirm,
      previousText;

  // If the link does not have data-confirm, we don't need to do anything.
  if (!link.attr('data-confirm')) return true;

  // Store the previous values of our link in case they don't confirm.
  previousDataConfirm = link.attr('data-confirm');
  previousText = link.text();

  // Modify our link to remove data-confirm so the next time it's clicked
  // we just execute. Edit the text to be whatever was passed into confirm:
  link.removeAttr('data-confirm');
  link.text(previousDataConfirm);

  // After however long, just set our link back to before we clicked it.
  setTimeout(function(){
    link.attr('data-confirm', previousDataConfirm);
    link.text(previousText);
  }, 2000)

  return false;
};
