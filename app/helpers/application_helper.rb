module ApplicationHelper
  def params_for_event_index(args = {})
    hash_new = {missing_player: params[:missing_player], sports: params[:sports], start_time: params[:start], end_time: params[:end], location: params[:location], radius: params[:radius] }
    hash_new.merge(args)
  end


  def gravatar_for(user, opts = {})
    opts[:alt] = user.first_name
    image_tag "https://www.gravatar.com/avatar/#{Digest::MD5.hexdigest(user.email)}?s=#{opts.delete(:size) { 40 }}",
    opts
  end

  def levels_list
    levels = %w(Any 1-beginner 2 3 4 5-advanced)
    levels.map.with_index do |lvl, index|
      [lvl, index]
    end
  end

  def users_list
    usernames = []

    User.all.each do |user|
      usernames << user.username if user != current_user
    end

    return usernames
  end

  def party_size
    ['Party size', 1, 2, 3, 4, 5]
  end

  def sports_list
    Sport.joins(:events).pluck(:name)
  end

  def unread_messages
    chat_rooms = ChatRoom.all
    sender_chatrooms = chat_rooms.where(sender: current_user)
    recipient_chatrooms = chat_rooms.where(recipient: current_user)
    sender_unread = []
    recipient_unread = []
    sender_chatrooms.each { |chat_room| sender_unread << chat_room if chat_room.posts.where(sender_read: false).any? }
    recipient_chatrooms.each { |chat_room| recipient_unread << chat_room if chat_room.posts.where(recipient_read: false).any? }
    return sender_unread.count + recipient_unread.count
  end

end

