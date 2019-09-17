$(document).on("turbolinks:load", function() {
  function buildHTML(message){
  console.log(00);
    var html = `<div class="current-user__message">
                  <div class="current-user__message__content">
                  ${message.content}
                  </div>
                  <div class="current-user__message__time">
                  ${message.date}
                  </div>
                </div>`
    return html;
  }

  $('.dm-footer__input').on('submit', function(e){
    e.preventDefault();
    var formData = new FormData(this);
    var href = (window.location.href);
    $.ajax({
      url: href,
      type: "POST",
      data: formData,
      dataType: 'json',
      processData: false,
      contentType: false
    })
    .done(function(message){
      console.log(01);
      var html = buildHTML(message);
      $('.messages').append(html)
      $('.dm-footer__input')[0].reset()
      $('.messages').animate({scrollTop:$('.messages')[0].scrollHeight}, 'fast')
    })
    .fail(function(){
      alert('エラーが発生したためメッセージは送信できませんでした。');
    })
    .always(function(){
      $('.dm-footer__input__submit-btn').prop('disabled', false);
    })
  })

  var reloadMessages = function() {
    if (window.location.href.match(/\/rooms\/\d+\//)){
      last_message_id = $('.message:last').data("message-number");
      $.ajax({
        url: "api/messages",
        type: 'get',
        dataType: 'json',
        data: {id: last_message_id}
      })
      .done(function(messages) {
        var insertHTML = '';
        messages.forEach(function (message) {
          insertHTML = buildHTML(message);
          $('.messages').append(insertHTML);
          $('.messages').animate({scrollTop: $('.messages')[0].scrollHeight}, 'fast');
        })
      })
      .fail(function() {
        console.log('error');
      });
    }
  };
  setInterval(reloadMessages, 5000);
});