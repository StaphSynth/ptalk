class ChannelsController < ApplicationController
  before_action :require_login
  before_action :channel, only: %i[show edit update destroy]

  def index
    @channels = Channel.all
  end

  def show
    @messages = channel.messages
    @message = Message.new
  end

  def new
    @channel = Channel.new
  end

  def edit
  end

  def create
    new_params = channel_params.merge({ user_id: current_user.id })
    @channel = Channel.new(new_params)

    if @channel.save
      redirect_to channel_path(@channel)
    else
      render :new
    end
  end

  def update
    respond_to do |format|
      if channel.update(channel_params)
        format.html { redirect_to channel, notice: 'Channel was successfully updated.' }
        format.json { render :show, status: :ok, location: channel }
      else
        format.html { render :edit }
        format.json { render json: channel.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    channel.destroy
    respond_to do |format|
      format.html { redirect_to channels_url, notice: 'Channel was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private

  def channel
    @channel ||= Channel.find(params[:id])
  end

  def channel_params
    params.require(:channel).permit(:id, :public, :name)
  end
end
