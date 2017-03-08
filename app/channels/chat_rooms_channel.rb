class ChatRoomsChannel < ApplicationCable::Channel
  def subscribed
    stream_from "chat_rooms_#{params['chat_room_id']}_channel"
  end

  def unsubscribed
    # Any cleanup needed when channel is unsubscribed
  end

  def send_post(data)
    is_sender = current_user == ChatRoom.find(data['chat_room_id']).sender
      current_user.posts.create!(body: data['post'], chat_room_id: data['chat_room_id'], sender_read: is_sender, recipient_read: !is_sender)
  end
end
