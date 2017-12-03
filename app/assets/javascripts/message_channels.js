$(document).on('turbolinks:load', function() {
  submitNewMessage();
});

function submitNewMessage() {
  $('#message_content').keydown(function(event) {
    if (event.keyCode == 13 && !event.shiftKey) {
      event.preventDefault();
      $('#post_message').click();
      $(this).val('');
     }
  });
}
