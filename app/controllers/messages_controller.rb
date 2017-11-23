class MessagesController < ApplicationController
  before_action :message, only: %i[show edit update destroy]
  before_action :user

  def index
    @messages = Message.all
    @message = Message.new
  end

  def show
  end

  def create
    @message = Message.new(message_params)
    @message.user = user
    @message.save!
    redirect_to action: :index
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
    params.require(:message).permit(:content)
  end

  def user
    @user ||= current_user
  end

  def message
    @message ||= Message.find(params[:id])
  end
end
