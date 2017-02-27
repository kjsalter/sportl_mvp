class MessagesController < ApplicationController
  before_action do
    @conversation = Conversation.find(params[:conversation_id])
    authorize @conversation
  end

  def index
    @user = current_user
    @messages = policy_scope(@conversation.messages).order(created_at: :desc)
    if @messages.length > 10
      @over_ten = true
      @messages = @messages[-10..-1]
    end
    if params[:read_option] == "all"
      @over_ten = false
      @messages = @conversation.messages
    end
    if @messages.last
      if @messages.last.user_id != current_user.id
        @messages.last.read = true;
      end
    end

  @message = @conversation.messages.new
  authorize @messages
  end


  def new
    @message = @conversation.messages.new
    authorize @message
  end


  def create
    @message = @conversation.messages.new(message_params)
    authorize @message
    @message.user = current_user

    if @message.save
      respond_to do |format|
        format.html { redirect_to conversation_messages_path(@conversation) }
        format.js  # <-- will render `app/views/reviews/create.js.erb`
      end
    else
      respond_to do |format|
        format.html { render 'messages/index'  }
        format.js  # <-- idem
      end
    end

    end

private
 def message_params
  params.require(:message).permit(:body, :user_id)
 end

end
