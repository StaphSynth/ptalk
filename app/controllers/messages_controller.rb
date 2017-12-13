class MessagesController < ApplicationController
  before_action :message, only: %i[show edit update destroy]
  before_action :user

  def create
    message = Message.new(message_params)
    message.content = white_list.sanitize(message.content)
    message.user = user

    message.save
    ActionCable.server.broadcast 'messages',
      message: message.content,
      user: message.user.name
    head :ok
  end

  def edit
  end

  def update
    message.update_attributes(message_params)
  end

  def destroy
    message.destroy
  end

  private

  def message_params
    params.require(:message).permit(:content, :channel_id, :user_id)
  end

  def user
    @user ||= current_user
  end

  def white_list
    @white_list_sanitizer ||= Rails::Html::WhiteListSanitizer.new
  end

  def message
    @message ||= Message.find(params[:id])
  end
end
