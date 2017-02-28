class ConversationsController < ApplicationController
  before_action :authenticate_user!

  def index
   @users = User.all
   @conversations = policy_scope(Conversation).order(created_at: :desc)
  end

  def create
    if Conversation.where(sender_id: params[:sender_id]).where(recipient_id: params[:recipient_id]).any?
      @conversation = Conversation.where(sender_id: params[:sender_id]).where(recipient_id: params[:recipient_id]).first
    elsif Conversation.where(sender_id: params[:recipient_id]).where(recipient_id: params[:sender_id]).any?
      @conversation = Conversation.where(sender_id: params[:recipient_id]).where(recipient_id: params[:sender_id]).first
    else
      @conversation = Conversation.new(conversation_params)
    end
    authorize @conversation
    @conversation.save
    redirect_to conversation_messages_path(@conversation)
  end

private

  def conversation_params
    params.permit(:sender_id, :recipient_id)
  end
end
