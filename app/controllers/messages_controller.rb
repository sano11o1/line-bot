class MessagesController < ApplicationController

  def index
    @messages = Message.all
  end
  
  def new
    @message = Message.new
    render :new
  end

  def create
    @message = Message.new(messages_params)
    @line_client.push_message(@message.user.line_user_id, {type: 'text', text: @message.text})
    @message.save
    redirect_to messages_path
  end

  private
    def messages_params
      params.require(:message).permit(:text, :user_id)
    end
end