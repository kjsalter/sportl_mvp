class ChatRoomsController < ApplicationController
  def index
#    @chat_rooms = ChatRoom.all
    @users = User.all
    @chat_rooms = policy_scope(ChatRoom).includes(:posts).order("posts.created_at DESC")
    @sender_chatrooms = @chat_rooms.where(sender: current_user)
    @recipient_chatrooms = @chat_rooms.where(recipient: current_user)
    @sender_unread = []
    @recipient_unread = []
    @sender_chatrooms.each { |chat_room| @sender_unread << chat_room if chat_room.posts.where(sender_read: false).any? }
    @recipient_chatrooms.each { |chat_room| @recipient_unread << chat_room if chat_room.posts.where(recipient_read: false).any? }
  end

  def show
    @chat_room = ChatRoom.includes(:posts).find_by(id: params[:id])
    authorize @chat_room
    @post = Post.new
    if @chat_room.sender == current_user
      @chat_room.posts.each { |post| post.update(sender_read: true) }
    elsif @chat_room.recipient == current_user
      @chat_room.posts.each { |post| post.update(recipient_read: true) }
    end



  end


  def create
    if ChatRoom.where(sender_id: params[:sender_id]).where(recipient_id: params[:recipient_id]).any?
      @chat_room = ChatRoom.where(sender_id: params[:sender_id]).where(recipient_id: params[:recipient_id]).first
    elsif ChatRoom.where(sender_id: params[:recipient_id]).where(recipient_id: params[:sender_id]).any?
      @chat_room = ChatRoom.where(sender_id: params[:recipient_id]).where(recipient_id: params[:sender_id]).first
    else
      @chat_room = ChatRoom.new(chat_room_params)
    end
    authorize @chat_room
    @chat_room.save
    redirect_to chat_room_path(@chat_room)
  end

  private

  def chat_room_params
    params.permit(:sender_id, :recipient_id)
  end

end
