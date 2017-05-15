$(function() {
  function buildHTML(message) {
    var user = message.name;
    var date = message.created_at;
    var body = message.body;

    var userClass = 'message-list__message__post-user-name';
    var dateClass = 'message-list__message__posted-date';
    var bodyClass = 'message-list__message__message-text';

    function creteHtmlView(class, content){
      return `<li class= "${class}">${content}</li>`;
    }

    var message_user = createHtmlView(userClass, user);
    var message_date = createHtmlView(dateClass, date);
    var message_text = createHtmlView(bodyClass, body);

    var html = $('<ul class="message-list__message">').append(message_user, message_date, message_text);

   return html;
  }

  $('#js-form').on('submit', function(e) {
    e.preventDefault();
    var formData = new FormData($(this).get(0));
    var group_id = $('.group_id').attr('value');
    var url = '/groups/' + group_id + '/messages.json';
    $.ajax({
      type: 'POST',
      url: url,
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(data) {
      var html = buildHTML(data);
      var group_url = '/groups/' + group_id + '/messages';
      $('.message-list').append(html);
      $('a[href="' + group_url + '"]').find('.groups__group-list__group__last-message').html(data.body);
      $('.create-message__input-form').val('');
      $('input').removeAttr("disabled");
    })
    .fail(function() {
      alert('error');
    });
  });
});
