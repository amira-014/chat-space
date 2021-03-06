$(function() {
  var list = $(".chat-group-users");

  function appendUserList(user) {
    var userName =  `<li class="chat-group-user" data-id=${ user.id } data-name=${ user.name }>${ user.name }</li>`;
    var addButton = `<button type="button"class="chat-group-user__btn" id="add-btn">追加</button>`;
    var userList = $(userName).append(addButton);
    list.append(userList);
  }

  function addUserName(parent) {
    var memberList = $(".group-members");
    var memberListHTML = `
      <div class="group-member">
      <input type="hidden" name="group[user_ids][]" value="${userId}">
      <p>${userName}
      <button type="button"class="chat-group-user__btn" id="remove-btn" data-id="${userId}">削除</button></p></div>
      `;
    var userId = parent.data('id');
    var userName = parent.data('name');
    memberList.append(memberListHTML)
    $(parent).remove();
  }

  $("#user-search-field").on("keyup", function() {
    var input = $(this).val();

    $.ajax({
      type: 'GET',
      url: '/users/search',
      data: {
        user: input
      },
      dataType: 'json'
    })
    .done(function(data) {
      $(".chat-group-user").remove();
      if (data.users.length !== 0) {
        $.each(data.users, function(i, user) {
          appendUserList(user);
        });
      }
      if (data.users.length === 0) {
        list.append(`<li class="chat-group-user">一致するユーザーは見つかりませんでした</li>`);
      }
    })
    .fail(function(data) {
      $("#flash-message").append('<div class="alert alert-danger">検索に失敗しました</div>');
    });
  });

  $(".chat-group-users").on("click", "#add-btn", function(e) {
    e.preventDefault();
    var parent = $(this).parent()
    addUserName(parent)
  });


  $(".group-members").on("click", "#remove-btn", function() {
    var id = $(this).data('id');
    var parent = $(this).parents(".group-member");
    parent.remove();
  });
});
