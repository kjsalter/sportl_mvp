class ChatRoomsController < ApplicationController
  skip_after_action :verify_authorized
  def index
#    @chat_rooms = ChatRoom.all
    @users = User.all
    @chat_rooms = policy_scope(ChatRoom).order(created_at: :desc)
  end

  def show
    @chat_room = ChatRoom.includes(:posts).find_by(id: params[:id])
    @post = Post.new
  end


  def new
    @chat_room = ChatRoom.new
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
