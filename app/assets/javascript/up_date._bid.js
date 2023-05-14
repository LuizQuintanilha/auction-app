$(document).on('ajax:success', 'form', function(event) {
  $('#last-bid-value').html(event.detail[2].responseText);
});