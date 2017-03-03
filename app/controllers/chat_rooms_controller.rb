class ChatRoomsController < ApplicationController
  skip_after_action :verify_authorized
  def index
#    @chat_rooms = ChatRoom.all
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
    @chat_room = current_user.chat_rooms.build(chat_room_params)
    if @chat_room.save
      flash[:success] = 'Chat room added!'
      redirect_to chat_rooms_path
    else
      render 'new'
    end
  end

  private

  def chat_room_params
    params.require(:chat_room).permit(:title)
  end
end
