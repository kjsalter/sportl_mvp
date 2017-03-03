jQuery(document).on 'turbolinks:load', ->
  posts = $('#posts')
  if $('#posts').length > 0
    posts_to_bottom = -> posts.scrollTop(posts.prop("scrollHeight"))

    posts_to_bottom()

    App.global_chat = App.cable.subscriptions.create {
        channel: "ChatRoomsChannel"
        chat_room_id: posts.data('chat-room-id')
      },
      connected: ->
        # Called when the subscription is ready for use on the server

      disconnected: ->
        # Called when the subscription has been terminated by the server

      received: (data) ->
        posts.append data['post']
        posts_to_bottom()

      send_post: (post, chat_room_id) ->
        @perform 'send_post', post: post, chat_room_id: chat_room_id


    $('#new_post').submit (e) ->
      $this = $(this)
      textarea = $this.find('#post_body')
      if $.trim(textarea.val()).length > 1
        App.global_chat.send_post textarea.val(), posts.data('chat-room-id')
        textarea.val('')
      e.preventDefault()
      return false
