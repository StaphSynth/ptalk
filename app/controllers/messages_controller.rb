class MessagesController < ApplicationController
  before_action :message, only: %i[show edit update destroy]
  before_action :user

  def create
    message = Message.new(message_params)
    message.user = user
    if message.save
      ActionCable.server.broadcast 'messages',
        message: message.content,
        user: message.user.name
      head :ok
    else
      redirect_to channels_path
      flash[:error] = 'Oops, your message could not be sent. Try again later.'
    end
  end

  def edit
  end

  def update
    message.update_attributes(message_params)
    redirect_to action: :index
  end

  def destroy
    message.destroy
    redirect_to action: :index
  end

  private

  def message_params
    params.require(:message).permit(:content, :channel_id, :user_id)
  end

  def user
    @user ||= current_user
  end

  def message
    @message ||= Message.find(params[:id])
  end
end
